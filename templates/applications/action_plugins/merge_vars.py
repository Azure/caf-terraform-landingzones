#!/usr/bin/env python

"""
An Ansible action plugin to allow explicit merging of dict and list facts.

https://github.com/leapfrogonline/ansible-merge-vars/blob/master/LICENSE.md

"""

from ansible.plugins.action import ActionBase
from ansible.errors import AnsibleError
from ansible.utils.vars import isidentifier


# Funky import dance for Ansible backwards compatitility (not sure if we
# actually need to do this or not)
try:
    from __main__ import display
except ImportError:
    from ansible.utils.display import Display  # pylint: disable=ungrouped-imports
    display = Display()


class ActionModule(ActionBase):
    """
    Merge all variables in context with a certain suffix (lists or dicts only)
    and create a new variable that contains the result of this merge. These
    initial suffixed variables can be definied anywhere in the inventory, or by
    any other means; as long as they're in the context for the running play,
    they'll be merged.

    """
    def run(self, tmp=None, task_vars=None):
        suffix_to_merge = self._task.args.get('suffix_to_merge', '')
        merged_var_name = self._task.args.get('merged_var_name', '')
        dedup = self._task.args.get('dedup', True)
        expected_type = self._task.args.get('expected_type')
        recursive_dict_merge = bool(self._task.args.get('recursive_dict_merge', False))

        if 'cacheable' in self._task.args.keys():
            display.deprecated(
                "The `cacheable` option does not actually do anything, since Ansible 2.5. "
                "No matter what, the variable set by this plugin will be set in the fact "
                "cache if you have fact caching enabled.  To get rid of this warning, "
                "remove the `cacheable` argument from your merge_vars task.  This warning "
                "will be removed in a future version of this plugin."
            )

        # Validate args
        if expected_type not in ['dict', 'list']:
            raise AnsibleError("expected_type must be set ('dict' or 'list').")
        if not merged_var_name:
            raise AnsibleError("merged_var_name must be set")
        if not isidentifier(merged_var_name):
            raise AnsibleError("merged_var_name '%s' is not a valid identifier" % merged_var_name)
        if not suffix_to_merge.endswith('__to_merge'):
            raise AnsibleError("Merge suffix must end with '__to_merge', sorry!")

        keys = sorted([key for key in task_vars.keys()
                       if key.endswith(suffix_to_merge)])

        display.v("Merging vars in this order: {}".format(keys))

        # We need to render any jinja in the merged var now, because once it
        # leaves this plugin, ansible will cleanse it by turning any jinja tags
        # into comments.
        # And we need it done before merging the variables,
        # in case any structured data is specified with templates.
        merge_vals = [self._templar.template(task_vars[key]) for key in keys]

        # Dispatch based on type that we're merging
        if merge_vals == []:
            if expected_type == 'list':
                merged = []
            else:
                merged = {}
        elif isinstance(merge_vals[0], list):
            merged = merge_list(merge_vals, dedup)
        elif isinstance(merge_vals[0], dict):
            merged = merge_dict(merge_vals, dedup, recursive_dict_merge)
        else:
            raise AnsibleError(
                "Don't know how to merge variables of type: {}".format(type(merge_vals[0]))
            )

        return {
            'ansible_facts': {merged_var_name: merged},
            'changed': False,
        }


def merge_dict(merge_vals, dedup, recursive_dict_merge):
    """
    To merge dicts, just update one with the values of the next, etc.
    """
    check_type(merge_vals, dict)
    merged = {}
    for val in merge_vals:
        if not recursive_dict_merge:
            merged.update(val)
        else:
            # Recursive merging of dictionaries with overlapping keys:
            #   LISTS: merge with merge_list
            #   DICTS: recursively merge with merge_dict
            #   any other types: replace (same as usual behaviour)
            for key in val.keys():
                if not key in merged:
                    # first hit of the value - just assign
                    merged[key] = val[key]
                elif isinstance(merged[key], list):
                    merged[key] = merge_list([merged[key], val[key]], dedup)
                elif isinstance(merged[key], dict):
                    merged[key] = merge_dict([merged[key], val[key]], dedup, recursive_dict_merge)
                else:
                    merged[key] = val[key]
    return merged


def merge_list(merge_vals, dedup):
    """ To merge lists, just concat them. Dedup if wanted. """
    check_type(merge_vals, list)
    merged = flatten(merge_vals)
    if dedup:
        merged = deduplicate(merged)
    return merged


def check_type(mylist, _type):
    """ Ensure that all members of mylist are of type _type. """
    if not all(isinstance(item, _type) for item in mylist):
        raise AnsibleError("All values to merge must be of the same type, either dict or list")


def flatten(list_of_lists):
    """
    Flattens a list of lists:
        >>> flatten([[1, 2] [3, 4]])
        [1, 2, 3, 4]

    I wish Python had this in the standard lib :(
    """
    return list((x for y in list_of_lists for x in y))


def deduplicate(mylist):
    """
    Just brute force it. This lets us keep order, and lets us dedup unhashable
    things, like dicts. Hopefully you won't run into such big lists that
    this will ever be a performance issue.
    """
    deduped = []
    for item in mylist:
        if item not in deduped:
            deduped.append(item)
    return deduped
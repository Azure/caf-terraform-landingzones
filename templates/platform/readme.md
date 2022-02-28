
# Generate the terraform configuration files

To execute this step you need to login with one of the CAF maintainers accounts:
{% for maintainer in resources.platform_identity.caf_platform_maintainers %}
  - {{ maintainer }}
{% endfor %}

```bash
rover login -t {{ resources.platform_identity.tenant_name }}

rover ignite \
  --playbook {{ base_templates_folder }}/ansible/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{resource_template_folder}} \
  -e config_folder={{ config_folder }} \
  -e landingzones_folder={{ landingzones_folder }}

  ```

Get started with the [launchpad](./level0/launchpad)

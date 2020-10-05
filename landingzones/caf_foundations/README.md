Deploy the launchpad services in the level1 layer.

# This is currently a stub - pending refactoring! 

# Review the configuration file

```bash
cd /tf/caf

#  to deploy the CAF Foundations
rover -lz /tf/caf/landingzones/caf_foundations \
-level level1 \
-a apply

# to destroy the CAF Foundations
rover -lz /tf/caf/landingzones/caf_foundations \
-level level1 \
-a destroy
```

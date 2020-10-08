# CAF Foundations landing zone

## /!\ This is currently a stub - pending refactoring

# Using CAF foundations

During the previous the content of this landing zone is empty unless you specify a configuration file to enable it.

```bash
cd /tf/caf

#  to deploy the CAF Foundations in passthrough mode (recommended for now)
rover -lz /tf/caf/landingzones/caf_foundations \
-level level1 \
-a apply

#  to deploy the CAF Foundations with enteprise scale (experimental)
rover -lz /tf/caf/landingzones/caf_foundations \
-var-folder /tf/caf/landingzones/caf_foundations/scenarios/200 \
-level level1 \
-a apply

# to destroy the CAF Foundations
rover -lz /tf/caf/landingzones/caf_foundations \
-level level1 \
-a destroy
```

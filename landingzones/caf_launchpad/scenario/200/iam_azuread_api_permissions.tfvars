

azuread_api_permissions = {

  caf_launchpad_level0 = {
    active_directory_graph = {
      resource_app_id = "00000002-0000-0000-c000-000000000000"
      resource_access = {
        Application_ReadWrite_OwnedBy = {
          id   = "824c81eb-e3f8-4ee6-8f6d-de7f50d565b7"
          type = "Role"
        }
        Directory_ReadWrite_All = {
          id   = "78c8a3c8-a07e-4b9e-af1b-b5ccab50a175"
          type = "Role"
        }
      }
    }

    microsoft_graph = {
      resource_app_id = "00000003-0000-0000-c000-000000000000"
      resource_access = {
        AppRoleAssignment_ReadWrite_All = {
          id   = "06b708a9-e830-4db3-a914-8e69da51d44f"
          type = "Role"
        }
        DelegatedPermissionGrant_ReadWrite_All = {
          id   = "8e8e4742-1d95-4f68-9d56-6ee75648c72a"
          type = "Role"
        }
        GroupReadWriteAll = {
          id   = "62a82d76-70ea-41e2-9197-370581804d09"
          type = "Role"
        }
        RoleManagement_ReadWrite_Directory = {
          id   = "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8"
          type = "Role"
        }
      }
    }
  }

}

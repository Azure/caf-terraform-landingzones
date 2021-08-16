azuread_credential_policies = {
  default_policy = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    number  = true

    # Password Expiration date
    expire_in_days = 30
    rotation_key0 = {
      # Odd number
      days = 17
    }
    rotation_key1 = {
      # Even number
      days = 10
    }
  } //password_policy
}
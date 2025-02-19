terraform {
  required_providers {
    akeyless = {
      version = ">= 1.8.2"
      source  = "akeyless-community/akeyless"
    }
  }
}

provider "akeyless" {
  api_gateway_address = var.akeyless_gateway_url

  api_key_login {
    access_id = var.akeyless_access_id
    access_key = var.akeyless_access_key
  }
}

resource "akeyless_auth_method_api_key" "api_key" {
  name = "${var.akeyless_root_path}/api-key-by-terraform"
}

resource "akeyless_role" "role" {
  depends_on = [
    akeyless_auth_method_api_key.api_key
  ]
  name = "${var.akeyless_root_path}/access-role-by-terraform"

  rules {
    capability = ["read","list"]
    path = "${var.akeyless_root_path}/*"
    rule_type = "auth-method-rule"
  }
}

resource "akeyless_associate_role_auth_method" "role_to_auth_method" {
    depends_on = [
        akeyless_auth_method_api_key.api_key,
        akeyless_role.role
    ]
    am_name = "${var.akeyless_root_path}/api-key-by-terraform"
    role_name = "${var.akeyless_root_path}/access-role-by-terraform"
}

resource "akeyless_static_secret" "secret" {
  path = "${var.akeyless_root_path}/secret-by-terraform"
  value = "Secret was set from terraform"
}

data "akeyless_secret" "secret" {
  depends_on = [
    akeyless_static_secret.secret
  ]
  path = "${var.akeyless_root_path}/secret-by-terraform"
}

output "secret" {
  value = data.akeyless_secret.secret
  sensitive = true
}

output "auth_method" {
  value = akeyless_auth_method_api_key.api_key
  sensitive = true
}
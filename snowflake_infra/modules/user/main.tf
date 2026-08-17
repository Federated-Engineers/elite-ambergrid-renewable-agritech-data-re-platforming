resource "snowflake_user" "user" {
  name         = var.name
  login_name   = var.login_name
  password     = var.password
  email        = var.email
  comment      = var.comment
  display_name = var.display_name
  disabled     = var.disabled

  default_warehouse = var.default_warehouse
  default_role      = var.default_role

  must_change_password = var.must_change_password
  disable_mfa          = var.disable_mfa
}
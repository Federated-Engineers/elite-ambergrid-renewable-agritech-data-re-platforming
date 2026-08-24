resource "dbtcloud_snowflake_credential" "production" {
  project_id  = dbtcloud_project.ambergrid_project.id
  auth_type   = "password"
  num_threads = var.dbt_threads
  schema      = var.dbt_prod_schema
  role        = var.snowflake_prod_role
  user        = var.snowflake_dbt_cloud_user
  password    = data.aws_ssm_parameter.snowflake_dbt_cloud_password.value
}

resource "dbtcloud_snowflake_credential" "slim_ci" {
  project_id  = dbtcloud_project.ambergrid_project.id
  auth_type   = "password"
  num_threads = var.dbt_threads
  schema      = var.dbt_ci_schema
  role        = var.snowflake_ci_role
  user        = var.snowflake_dbt_ci_user
  password    = data.aws_ssm_parameter.snowflake_dbt_cloud_password.value
}

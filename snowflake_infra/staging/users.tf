module "dbt_user" {
  source     = "../modules/user"
  name       = "AG_DBT_DEV_USR"
  login_name = "AG_DBT_DEV_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password.value
  comment    = "Service user for dbt transformations in the dev environment"

  default_warehouse = module.ag_dev_wh.name
  default_role      = snowflake_account_role.dbt_dev_role.name
}

module "airflow_user" {
  source     = "../modules/user"
  name       = "AG_AIRFLOW_DEV_USR"
  login_name = "AG_AIRFLOW_DEV_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password.value
  comment    = "Service user for airflow ingestion in the dev environment"

  default_warehouse = module.ag_dev_wh.name
  default_role      = snowflake_account_role.airflow_dev_role.name
}

resource "snowflake_grant_account_role" "dbt_user_role" {
  role_name = snowflake_account_role.dbt_dev_role.name
  user_name = module.dbt_user.name
}

resource "snowflake_grant_account_role" "airflow_user_role" {
  role_name = snowflake_account_role.airflow_dev_role.name
  user_name = module.airflow_user.name
}
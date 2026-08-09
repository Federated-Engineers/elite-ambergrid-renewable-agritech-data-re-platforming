module "dbt_user" {
  source     = "../modules/user"
  name       = "AG_DBT_PROD_USR"
  login_name = "AG_DBT_PROD_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Service user for dbt transformations in the production environment"

  default_warehouse = module.etl_wh.name
  default_role      = snowflake_account_role.dbt_prod_role.name
}

module "airflow_user" {
  source     = "../modules/user"
  name       = "AG_AIRFLOW_PROD_USR"
  login_name = "AG_AIRFLOW_PROD_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Service user for airflow ingestion in the production environment"

  default_warehouse = module.etl_wh.name
  default_role      = snowflake_account_role.airflow_prod_role.name
}

module "data_eng_user" {
  source     = "../modules/user"
  name       = "AG_DATA_ENG_PROD_USR"
  login_name = "AG_DATA_ENG_PROD_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Data engineer user in the production environment"

  default_warehouse = module.data_eng_wh.name
  default_role      = snowflake_account_role.data_eng_prod_role.name

  must_change_password = "true"
  disable_mfa          = "false"
}

resource "snowflake_grant_account_role" "dbt_user_role" {
  role_name = snowflake_account_role.dbt_prod_role.name
  user_name = module.dbt_user.name
}

resource "snowflake_grant_account_role" "airflow_user_role" {
  role_name = snowflake_account_role.airflow_prod_role.name
  user_name = module.airflow_user.name
}

resource "snowflake_grant_account_role" "data_eng_user_role" {
  role_name = snowflake_account_role.data_eng_prod_role.name
  user_name = module.data_eng_user.name
}

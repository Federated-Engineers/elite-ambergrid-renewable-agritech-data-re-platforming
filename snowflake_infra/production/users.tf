module "dbt_user" {
  source     = "../modules/user"
  name       = "AMBERGRID_DBT_CLOUD_USR"
  login_name = "AMBERGRID_DBT_CLOUD_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Service user for dbt transformations in the production environment"

  default_warehouse = module.service_compute.name
  default_role      = snowflake_account_role.dbt_prod_role.name
}

module "airflow_user" {
  source     = "../modules/user"
  name       = "AMBERGRID_AIRFLOW_PROD_USR"
  login_name = "AMBERGRID_AIRFLOW_PROD_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Service user for airflow ingestion in the production environment"

  default_warehouse = module.service_compute.name
  default_role      = snowflake_account_role.airflow_prod_role.name
}

module "ojokayode" {
  source     = "../modules/user"
  name       = "ojokayode@ambergrid.com"
  login_name = "ojokayode@ambergrid.com"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Data engineer user in the production environment"

  default_warehouse = module.data_eng_compute.name
  default_role      = snowflake_account_role.data_eng_prod_role.name

  must_change_password = "true"
  disable_mfa          = "false"
}

module "dbt_ci_user" {
  source     = "../modules/user"
  name       = "AMBERGRID_DBT_CI_USR"
  login_name = "AMBERGRID_DBT_CI_USR"
  password   = data.aws_ssm_parameter.ambergrid_snowflake_password_prod.value
  comment    = "Service user for the dbt Cloud CI job in the dbt cloud CI environment"

  default_warehouse = module.service_compute.name
  default_role      = snowflake_account_role.dbt_ci_role.name
}


resource "snowflake_grant_account_role" "dbt_user_role" {
  role_name = snowflake_account_role.dbt_prod_role.name
  user_name = module.dbt_user.name
}

resource "snowflake_grant_account_role" "airflow_user_role" {
  role_name = snowflake_account_role.airflow_prod_role.name
  user_name = module.airflow_user.name
}

resource "snowflake_grant_account_role" "ojokayode_data_eng_role" {
  role_name = snowflake_account_role.data_eng_prod_role.name
  user_name = module.ojokayode.name
}

resource "snowflake_grant_account_role" "dbt_ci_user_role" {
  role_name = snowflake_account_role.dbt_ci_role.name
  user_name = module.dbt_ci_user.name
}

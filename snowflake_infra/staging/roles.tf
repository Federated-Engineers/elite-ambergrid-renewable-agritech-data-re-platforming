resource "snowflake_account_role" "dbt_dev_role" {
  name    = "AG_DBT_DEV_ROLE"
  comment = "Functional role for the dbt service user in development environment"
}

resource "snowflake_account_role" "airflow_dev_role" {
  name    = "AG_AIRFLOW_DEV_ROLE"
  comment = "Functional role for the airflow service user in development environment"
}
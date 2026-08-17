resource "snowflake_account_role" "dbt_dev_role" {
  name    = "AMBERGRID_DBT_CORE_ROLE"
  comment = "Functional role for the dbt service user in development environment"
}

resource "snowflake_account_role" "airflow_dev_role" {
  name    = "AMBERGRID_AIRFLOW_DEV_ROLE"
  comment = "Functional role for the airflow service user in development environment"
}
resource "snowflake_account_role" "platform_eng_prod_role" {
  name    = "AMBERGRID_PLATFORM_ENG_PROD_ROLE"
  comment = "Senior human role for production; inherits AMBERGRID_DATA_ENG_PROD_ROLE"
}

resource "snowflake_account_role" "data_eng_prod_role" {
  name    = "AMBERGRID_DATA_ENG_PROD_ROLE"
  comment = "Human role for data engineers working across the BRONZE, SILVER and GOLD schemas in production; rolls up to AMBERGRID_PLATFORM_ENG_PROD_ROLE"
}

resource "snowflake_account_role" "dbt_prod_role" {
  name    = "AMBERGRID_DBT_CLOUD_ROLE"
  comment = "Functional role for the dbt service user in production; rolls up to the system role"
}

resource "snowflake_account_role" "airflow_prod_role" {
  name    = "AMBERGRID_AIRFLOW_PROD_ROLE"
  comment = "Functional role for the airflow service user in production; rolls up to the system role"
}

resource "snowflake_account_role" "system_prod_role" {
  name    = "AMBERGRID_SYSTEM_PROD_ROLE"
  comment = "Parent role for the production service accounts; inherits AMBERGRID_DBT_CLOUD_ROLE and AMBERGRID_AIRFLOW_PROD_ROLE"
}

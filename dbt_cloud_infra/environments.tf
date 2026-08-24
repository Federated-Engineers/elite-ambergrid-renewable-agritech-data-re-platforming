resource "dbtcloud_environment" "production" {
  dbt_version     = var.dbt_version
  name            = "Production"
  project_id      = dbtcloud_project.ambergrid_project.id
  type            = "deployment"
  credential_id   = dbtcloud_snowflake_credential.production.credential_id
  deployment_type = "production"
  connection_id   = dbtcloud_global_connection.snowflake_connection.id
}

resource "dbtcloud_environment" "slim_ci" {
  dbt_version     = var.dbt_version
  name            = "Slim CI"
  project_id      = dbtcloud_project.ambergrid_project.id
  type            = "deployment"
  credential_id   = dbtcloud_snowflake_credential.slim_ci.credential_id
  deployment_type = "staging"
  connection_id   = dbtcloud_global_connection.snowflake_connection.id
}

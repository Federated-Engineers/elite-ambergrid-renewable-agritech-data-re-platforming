data "aws_ssm_parameter" "dbt_cloud_service_token" {
  name = "/production/elite/dbt_cloud/ambergrid/service_token"
}

data "aws_ssm_parameter" "snowflake_dbt_cloud_password" {
  name = "/production/forge/snowflake/lone-star-assurance/snowflake_password"
}

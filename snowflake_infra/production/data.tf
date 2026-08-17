data "aws_ssm_parameter" "ambergrid_snowflake_password_prod" {
  name = "/production/forge/snowflake/lone-star-assurance/snowflake_password"
}
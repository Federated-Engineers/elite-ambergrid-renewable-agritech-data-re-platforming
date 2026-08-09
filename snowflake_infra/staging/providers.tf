terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.19.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "snowflake" {
  organization_name = var.snowflake_organization_name
  account_name      = var.snowflake_account_name
  user              = var.snowflake_user
  role              = var.snowflake_role

  preview_features_enabled = [
    "snowflake_storage_integration_aws_resource",
    "snowflake_file_format_json_resource",
    "snowflake_table_resource",
    "snowflake_external_table_resource"
  ]
}

provider "aws" {
  region = "eu-central-1"
}
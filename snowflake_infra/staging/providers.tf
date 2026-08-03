terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.16"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
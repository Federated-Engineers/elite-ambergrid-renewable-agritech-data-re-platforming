terraform {
  required_providers {
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = "~> 1.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "dbtcloud" {
  host_url   = var.dbt_cloud_host_url
  account_id = var.dbt_cloud_account_id
  token      = data.aws_ssm_parameter.dbt_cloud_service_token.value
}

provider "aws" {
  region = "eu-central-1"
}

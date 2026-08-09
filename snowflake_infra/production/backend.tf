terraform {
  backend "s3" {
    bucket = "federated-engineers-production-elite-ambergrid-tfstate"
    key    = "ambergrid/production/terraform.tfstate"
    region = "eu-central-1"
  }
}
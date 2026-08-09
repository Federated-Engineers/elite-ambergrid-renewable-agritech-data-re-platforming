terraform {
  backend "s3" {
    bucket = "federated-engineers-production-elite-ambergrid-tfstate"
    key    = "ambergrid/staging/terraform.tfstate"
    region = "eu-central-1"
  }
}
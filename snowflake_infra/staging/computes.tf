module "service_compute" {
  source = "../modules/warehouse"

  name                = "AMBERGRID_SERVICE_COMPUTE_DEV"
  initially_suspended = true
  comment             = "Shared warehouse for the dbt and airflow service accounts"
}
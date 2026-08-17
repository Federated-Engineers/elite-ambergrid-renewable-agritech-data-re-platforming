module "service_compute" {
  source = "../modules/warehouse"

  name                = "AMBERGRID_SERVICE_COMPUTE_PROD"
  initially_suspended = true
  comment             = "Shared warehouse for the dbt and airflow service accounts"
}

module "data_eng_compute" {
  source = "../modules/warehouse"

  name                = "AMBERGRID_DATA_ENG_COMPUTE_PROD"
  initially_suspended = true
  comment             = "Warehouse used by the data engineer role"
}
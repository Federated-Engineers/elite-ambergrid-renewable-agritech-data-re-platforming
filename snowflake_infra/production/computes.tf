module "etl_wh" {
  source = "../modules/warehouse"

  name                = "AG_ETL_WH_PROD"
  initially_suspended = true
  comment             = "Shared warehouse for the dbt and airflow service accounts"
}

module "data_eng_wh" {
  source = "../modules/warehouse"

  name                = "AG_DATA_ENG_WH_PROD"
  initially_suspended = true
  comment             = "Warehouse used by the data engineer role"
}
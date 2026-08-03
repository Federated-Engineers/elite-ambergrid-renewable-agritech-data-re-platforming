module "ag_dev_wh" {
  source = "../modules/warehouse"

  name                = "AG_DEV_WH"
  initially_suspended = true
  comment             = "Warehouse provisioned for local development"
}
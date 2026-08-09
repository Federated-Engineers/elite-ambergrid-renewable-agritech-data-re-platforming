resource "snowflake_warehouse" "ambergrid_warehouse" {
  name                = var.name
  warehouse_size      = var.size
  initially_suspended = var.initially_suspended
  comment             = var.comment
}
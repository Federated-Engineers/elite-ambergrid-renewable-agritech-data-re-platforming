resource "snowflake_table" "postgres_bronze" {
  for_each = {
    PG_FERTILIZER_SALES_INVOICES = "fertilizer_sales_invoices"
    PG_FLEET_LOGISTICS_LOGS      = "fleet_logistics_logs"
    PG_GAS_GRID_INJECTION_DAILY  = "gas_grid_injection_daily"
    PG_PLANTS                    = "plants"
    PG_SUPPLIER_CONTRACTS        = "supplier_contracts"
    PG_SUPPLIERS                 = "suppliers"
  }

  name     = each.key
  database = snowflake_database.ambergrid_dev_db.name
  schema   = snowflake_schema.bronze.name
  comment  = "Bronze: ambergrid.${each.value}. Append only, one set of rows per snapshot date."

  column {
    name     = "RAW_RECORD"
    type     = "VARIANT"
    nullable = true
    comment  = "Source row as received, keyed by column name"
  }

  column {
    name     = "SOURCE_TABLE"
    type     = "VARCHAR"
    nullable = true
    comment  = "Source table in the ambergrid schema"
  }

  column {
    name     = "SNAPSHOT_DATE"
    type     = "DATE"
    nullable = true
    comment  = "Date the table was captured"
  }

  column {
    name     = "SOURCE_FILE_NAME"
    type     = "VARCHAR"
    nullable = true
    comment  = "METADATA$FILENAME"
  }

  column {
    name     = "FILE_ROW_NUMBER"
    type     = "NUMBER"
    nullable = true
    comment  = "METADATA$FILE_ROW_NUMBER"
  }

  column {
    name     = "FILE_LAST_MODIFIED"
    type     = "TIMESTAMP_NTZ"
    nullable = true
    comment  = "METADATA$FILE_LAST_MODIFIED"
  }

  column {
    name     = "FILE_CONTENT_KEY"
    type     = "VARCHAR"
    nullable = true
    comment  = "METADATA$FILE_CONTENT_KEY, file checksum for day over day change detection"
  }

  column {
    name     = "LOADED_AT"
    type     = "TIMESTAMP_LTZ"
    nullable = true
    comment  = "Load timestamp, supplied by COPY INTO"
  }
}

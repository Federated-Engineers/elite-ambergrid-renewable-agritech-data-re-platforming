resource "snowflake_table" "gsheet_bronze" {
  for_each = {
    GSHEET_NPK_LAB_BATCHES              = "NPK_Lab_Batches"
    GSHEET_SUBSIDY_GRANTS               = "Subsidy_Grants"
    GSHEET_FERTILIZER_PRICE_ADJUSTMENTS = "Fertilizer_Price_Adjustments"
    GSHEET_IMPURITY_WRITEOFFS           = "Impurity_WriteOffs"
  }

  name     = each.key
  database = snowflake_database.ambergrid_prod_db.name
  schema   = snowflake_schema.bronze.name
  comment  = "Bronze: ${each.value}. Append only, one set of rows per snapshot date."

  column {
    name     = "RAW_RECORD"
    type     = "VARIANT"
    nullable = true
    comment  = "Sheet row as received, keyed by header"
  }

  column {
    name     = "SHEET_ROW_NUMBER"
    type     = "NUMBER"
    nullable = true
    comment  = "Row number in the worksheet itself, header is row 1"
  }

  column {
    name     = "WORKSHEET_NAME"
    type     = "VARCHAR"
    nullable = true
    comment  = "Source tab name"
  }

  column {
    name     = "SNAPSHOT_DATE"
    type     = "DATE"
    nullable = true
    comment  = "Date the sheet was captured"
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

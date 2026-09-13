with

google_sheets_impurity_writeoffs as (

    select
        raw_record,
        sheet_row_number,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('google_sheets', 'impurity_writeoffs') }}

),

renamed as (

    select

        trim(raw_record:writeoff_id::varchar) as writeoff_id,
        trim(raw_record:plant_id::varchar) as plant_id,
        trim(raw_record:contaminant_type::varchar) as contaminant_type,
        trim(raw_record:inspector_name::varchar) as inspector_name,
        try_to_number(trim(raw_record:quantity_tons_written_off::varchar), 14, 3) as quantity_tons_written_off,
        try_to_number(trim(raw_record:estimated_loss_eur::varchar), 14, 2) as estimated_loss_eur,
        try_to_date(trim(raw_record:writeoff_date::varchar)) as writeoff_date,
        sheet_row_number::number(38, 0) as _sheet_row_number,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from google_sheets_impurity_writeoffs

)

select * from renamed

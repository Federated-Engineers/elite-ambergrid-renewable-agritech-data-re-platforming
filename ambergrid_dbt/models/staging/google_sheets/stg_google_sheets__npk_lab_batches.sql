with

google_sheets_npk_lab_batches as (

    select
        raw_record,
        sheet_row_number,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('google_sheets', 'npk_lab_batches') }}

),

renamed as (

    select

        trim(raw_record:batch_id::varchar) as batch_id,
        trim(raw_record:plant_id::varchar) as plant_id,
        trim(raw_record:batch_status::varchar) as batch_status,
        trim(raw_record:technician_name::varchar) as technician_name,
        trim(raw_record:notes::varchar) as notes,
        try_to_number(trim(raw_record:nitrogen_pct::varchar), 5, 2) as nitrogen_pct,
        try_to_number(trim(raw_record:phosphorus_pct::varchar), 5, 2) as phosphorus_pct,
        try_to_number(trim(raw_record:potassium_pct::varchar), 5, 2) as potassium_pct,
        try_to_date(trim(raw_record:sample_date::varchar)) as sample_date,
        sheet_row_number::number(38, 0) as _sheet_row_number,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from google_sheets_npk_lab_batches

)

select * from renamed

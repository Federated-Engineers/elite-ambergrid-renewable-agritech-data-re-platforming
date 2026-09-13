with

google_sheets_fertilizer_price_adjustments as (

    select
        raw_record,
        sheet_row_number,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('google_sheets', 'fertilizer_price_adjustments') }}

),

renamed as (

    select

        trim(raw_record:adjustment_id::varchar) as adjustment_id,
        trim(raw_record:product_type::varchar) as product_type,
        trim(raw_record:adjustment_reason::varchar) as adjustment_reason,
        trim(raw_record:approved_by::varchar) as approved_by,
        try_to_number(trim(raw_record:old_price_eur::varchar), 10, 2) as old_price_eur,
        try_to_number(trim(raw_record:new_price_eur::varchar), 10, 2) as new_price_eur,
        try_to_date(trim(raw_record:effective_date::varchar)) as effective_date,
        sheet_row_number::number(38, 0) as _sheet_row_number,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from google_sheets_fertilizer_price_adjustments

)

select * from renamed

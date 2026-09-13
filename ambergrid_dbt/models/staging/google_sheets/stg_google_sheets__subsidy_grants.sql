with

google_sheets_subsidy_grants as (

    select
        raw_record,
        sheet_row_number,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('google_sheets', 'subsidy_grants') }}

),

renamed as (

    select

        trim(raw_record:grant_id::varchar) as grant_id,
        trim(raw_record:plant_id::varchar) as plant_id,
        trim(raw_record:subsidy_type::varchar) as subsidy_type,
        trim(raw_record:granting_authority::varchar) as granting_authority,
        trim(raw_record:officer_name::varchar) as officer_name,
        trim(raw_record:approval_status::varchar) as approval_status,
        try_to_number(trim(raw_record:amount_eur::varchar), 14, 2) as amount_eur,
        try_to_date(trim(raw_record:grant_date::varchar)) as grant_date,
        sheet_row_number::number(38, 0) as _sheet_row_number,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from google_sheets_subsidy_grants

)

select * from renamed

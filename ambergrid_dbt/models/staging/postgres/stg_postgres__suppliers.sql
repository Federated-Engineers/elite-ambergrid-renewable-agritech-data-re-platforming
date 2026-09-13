with

postgres_suppliers as (

    select
        raw_record,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('postgres', 'suppliers') }}

),

renamed as (

    select

        raw_record:supplier_id::varchar as supplier_id,
        raw_record:company_name::varchar as company_name,
        raw_record:supplier_type::varchar as supplier_type,
        raw_record:contact_name::varchar as contact_name,
        raw_record:contact_email::varchar as contact_email,
        raw_record:contact_phone::varchar as contact_phone,
        raw_record:city::varchar as city,
        raw_record:country::varchar as country,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from postgres_suppliers

)

select * from renamed

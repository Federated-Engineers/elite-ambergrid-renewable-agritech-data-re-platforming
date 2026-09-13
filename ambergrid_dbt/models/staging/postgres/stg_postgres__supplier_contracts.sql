with

postgres_supplier_contracts as (

    select
        raw_record,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('postgres', 'supplier_contracts') }}

),

renamed as (

    select

        raw_record:contract_id::varchar as contract_id,
        raw_record:supplier_id::varchar as supplier_id,
        raw_record:plant_id::varchar as plant_id,
        raw_record:waste_type::varchar as waste_type,
        raw_record:status::varchar as contract_status,
        raw_record:price_per_ton_eur::number(10, 2) as price_per_ton_eur,
        raw_record:contract_start_date::date as contract_start_date,
        raw_record:contract_end_date::date as contract_end_date,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from postgres_supplier_contracts

)

select * from renamed

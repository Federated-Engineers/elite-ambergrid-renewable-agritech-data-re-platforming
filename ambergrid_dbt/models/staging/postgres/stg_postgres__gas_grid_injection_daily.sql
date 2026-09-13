with

postgres_gas_grid_injection_daily as (

    select
        raw_record,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('postgres', 'gas_grid_injection_daily') }}

),

renamed as (

    select

        raw_record:record_id::varchar as record_id,
        raw_record:plant_id::varchar as plant_id,
        raw_record:injection_date::date as injection_date,
        raw_record:biomethane_volume_nm3::number(14, 2) as biomethane_volume_nm3,
        raw_record:injection_pressure_bar::number(6, 2) as injection_pressure_bar,
        raw_record:revenue_eur::number(14, 2) as revenue_eur,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from postgres_gas_grid_injection_daily

)

select * from renamed

with

postgres_fleet_logistics_logs as (

    select
        raw_record,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('postgres', 'fleet_logistics_logs') }}

),

renamed as (

    select

        raw_record:pickup_id::varchar as pickup_id,
        raw_record:supplier_id::varchar as supplier_id,
        raw_record:plant_id::varchar as plant_id,
        raw_record:waste_type::varchar as waste_type,
        raw_record:status::varchar as pickup_status,
        raw_record:driver_name::varchar as driver_name,
        raw_record:vehicle_plate::varchar as vehicle_plate,
        raw_record:quantity_tons::number(14, 3) as quantity_tons,
        raw_record:distance_km::number(10, 2) as distance_km,
        raw_record:pickup_datetime::timestamp_tz as pickup_datetime,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from postgres_fleet_logistics_logs

)

select * from renamed

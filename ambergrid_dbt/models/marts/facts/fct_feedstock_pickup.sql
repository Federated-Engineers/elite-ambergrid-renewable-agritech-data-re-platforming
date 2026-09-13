with

stg_postgres__fleet_logistics_logs as (

    select
        pickup_id,
        supplier_id,
        plant_id as facility_id,
        waste_type,
        pickup_status,
        driver_name,
        vehicle_plate,
        quantity_tons,
        distance_km,
        pickup_datetime,
        is_current_in_source
    from {{ ref('stg_postgres__fleet_logistics_logs') }}

),

final as (

    select

        pickup_id,
        supplier_id,
        facility_id,
        waste_type,
        pickup_status,
        driver_name,
        vehicle_plate,
        quantity_tons,
        distance_km,
        pickup_datetime,
        date(pickup_datetime) as pickup_date,
        is_current_in_source

    from stg_postgres__fleet_logistics_logs

)

select * from final

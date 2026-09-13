with

stg_scada__telemetry as (

    select
        event_id as telemetry_id,
        plant_id as facility_id,
        bioreactor_id as bioreactor_unit,
        firmware_version,
        sensor_status,
        methane_purity_pct as methane_percentage,
        digestate_temperature_celsius as temperature_celsius,
        pressure_level_bar as pressure_bar,
        ambient_gas_leak_ppm,
        is_gas_leak_alarm_triggered as is_leak_alarm_active,
        reading_at as reading_timestamp,
        reading_date
    from {{ ref('stg_scada__telemetry') }}

)

select * from stg_scada__telemetry

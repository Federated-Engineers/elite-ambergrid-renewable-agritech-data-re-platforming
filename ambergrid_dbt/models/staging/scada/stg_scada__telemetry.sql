with

scada_telemetry as (

    select
        raw_record,
        plant_id,
        reading_date,
        source_file_name
    from {{ source('scada', 'telemetry') }}

),

renamed as (

    select

        raw_record:event_id::varchar as event_id,
        plant_id::varchar as plant_id,
        raw_record:bioreactor_id::varchar as bioreactor_id,
        raw_record:firmware_version::varchar as firmware_version,
        raw_record:sensor_status::varchar as sensor_status,
        raw_record:sensor_readings:methane_purity_pct::number(6, 2) as methane_purity_pct,
        raw_record:sensor_readings:digestate_temperature_celsius::number(6, 2) as digestate_temperature_celsius,
        raw_record:sensor_readings:pressure_level_bar::number(6, 3) as pressure_level_bar,
        raw_record:sensor_readings:ambient_gas_leak_ppm::number(8, 2) as ambient_gas_leak_ppm,
        raw_record:sensor_readings:gas_leak_alarm_triggered::boolean as is_gas_leak_alarm_triggered,
        raw_record:timestamp::timestamp_tz as reading_at,
        reading_date::date as reading_date,
        raw_record:plant_name::varchar as _payload_plant_name,
        source_file_name::varchar as _source_file_name

    from scada_telemetry

)

select * from renamed

with

postgres_plants as (

    select
        raw_record,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('postgres', 'plants') }}

),

renamed as (

    select

        raw_record:plant_id::varchar as plant_id,
        raw_record:plant_name::varchar as plant_name,
        raw_record:plant_type::varchar as plant_type,
        raw_record:city::varchar as city,
        raw_record:country::varchar as country,
        raw_record:capacity_tons_per_day::number(10, 2) as capacity_tons_per_day,
        raw_record:num_bioreactors::number(38, 0) as num_bioreactors,
        raw_record:commissioned_date::date as commissioned_date,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from postgres_plants

)

select * from renamed

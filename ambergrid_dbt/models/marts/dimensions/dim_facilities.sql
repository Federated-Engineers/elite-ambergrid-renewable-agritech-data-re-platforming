with

stg_postgres__plants as (

    select
        plant_id,
        plant_name,
        plant_type,
        city,
        country,
        capacity_tons_per_day,
        num_bioreactors,
        commissioned_date,
        is_current_in_source
    from {{ ref('stg_postgres__plants') }}

),

final as (

    select

        plant_id as facility_id,
        plant_name as facility_name,
        city as region_code,
        country,
        plant_type as bioreactor_type,
        capacity_tons_per_day as max_capacity_metric_tons,
        num_bioreactors,
        commissioned_date as commissioning_date,
        is_current_in_source

    from stg_postgres__plants

)

select * from final

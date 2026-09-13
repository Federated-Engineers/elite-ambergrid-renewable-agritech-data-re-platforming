select

    plant_id,
    injection_date,
    count(*) as records

from {{ ref('stg_postgres__gas_grid_injection_daily') }}

group by plant_id, injection_date
having count(*) > 1

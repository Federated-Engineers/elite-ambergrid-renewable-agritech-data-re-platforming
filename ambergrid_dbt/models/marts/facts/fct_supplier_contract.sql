with

stg_postgres__supplier_contracts as (

    select
        contract_id,
        supplier_id,
        plant_id as facility_id,
        waste_type,
        contract_status,
        price_per_ton_eur,
        contract_start_date,
        contract_end_date,
        is_current_in_source
    from {{ ref('stg_postgres__supplier_contracts') }}

)

select * from stg_postgres__supplier_contracts

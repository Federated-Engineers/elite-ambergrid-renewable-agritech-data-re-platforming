with

fct_feedstock_pickup as (

    select
        pickup_id,
        facility_id,
        supplier_id,
        waste_type,
        quantity_tons,
        pickup_datetime,
        pickup_date,
        is_current_in_source
    from {{ ref('fct_feedstock_pickup') }}

),

fct_supplier_contract as (

    select
        supplier_id,
        facility_id,
        waste_type,
        price_per_ton_eur,
        contract_start_date,
        contract_end_date
    from {{ ref('fct_supplier_contract') }}

),

fct_impurity_writeoff as (

    select
        writeoff_id,
        facility_id,
        quantity_tons_written_off,
        estimated_loss_eur,
        writeoff_date,
        is_current_in_source
    from {{ ref('fct_impurity_writeoff') }}

),

fct_subsidy_grant as (

    select
        grant_id,
        facility_id,
        amount_eur,
        grant_date,
        is_current_in_source
    from {{ ref('fct_subsidy_grant') }}

),

fct_npk_lab_batch as (

    select
        batch_id,
        facility_id,
        nitrogen_pct,
        sample_date,
        is_current_in_source
    from {{ ref('fct_npk_lab_batch') }}

),

pickups as (

    select

        pickup.pickup_id as transaction_id,
        pickup.facility_id,
        pickup.supplier_id,
        pickup.pickup_datetime as transaction_timestamp,
        'postgres_logistics' as source_system,
        pickup.quantity_tons as raw_weight_tons,
        null::number(14, 3) as impurity_writeoff_tons,
        null::number(5, 2) as nitrogen_purity_pct,
        round(pickup.quantity_tons * contract.price_per_ton_eur, 2) as gross_payment_eur,
        null::number(14, 2) as green_subsidy_grant_eur,
        round(pickup.quantity_tons * contract.price_per_ton_eur, 2) as net_cost_eur,
        pickup.is_current_in_source

    from fct_feedstock_pickup as pickup
    left join fct_supplier_contract as contract
        on
            pickup.supplier_id = contract.supplier_id
            and pickup.facility_id = contract.facility_id
            and pickup.waste_type = contract.waste_type
            and pickup.pickup_date between contract.contract_start_date and contract.contract_end_date

),

writeoffs as (

    select

        writeoff_id as transaction_id,
        facility_id,
        null::varchar as supplier_id,
        writeoff_date::timestamp_tz as transaction_timestamp,
        'google_sheets_lab' as source_system,
        null::number(14, 3) as raw_weight_tons,
        quantity_tons_written_off as impurity_writeoff_tons,
        null::number(5, 2) as nitrogen_purity_pct,
        null::number(14, 2) as gross_payment_eur,
        null::number(14, 2) as green_subsidy_grant_eur,
        estimated_loss_eur as net_cost_eur,
        is_current_in_source

    from fct_impurity_writeoff

),

grants as (

    -- A grant offsets cost, so it lands in net_cost_eur as a credit.
    select

        grant_id as transaction_id,
        facility_id,
        null::varchar as supplier_id,
        grant_date::timestamp_tz as transaction_timestamp,
        'google_sheets_lab' as source_system,
        null::number(14, 3) as raw_weight_tons,
        null::number(14, 3) as impurity_writeoff_tons,
        null::number(5, 2) as nitrogen_purity_pct,
        null::number(14, 2) as gross_payment_eur,
        amount_eur as green_subsidy_grant_eur,
        -1 * amount_eur as net_cost_eur,
        is_current_in_source

    from fct_subsidy_grant

),

lab_batches as (

    select

        batch_id as transaction_id,
        facility_id,
        null::varchar as supplier_id,
        sample_date::timestamp_tz as transaction_timestamp,
        'google_sheets_lab' as source_system,
        null::number(14, 3) as raw_weight_tons,
        null::number(14, 3) as impurity_writeoff_tons,
        nitrogen_pct as nitrogen_purity_pct,
        null::number(14, 2) as gross_payment_eur,
        null::number(14, 2) as green_subsidy_grant_eur,
        null::number(14, 2) as net_cost_eur,
        is_current_in_source

    from fct_npk_lab_batch

),

final as (

    select * from pickups
    union all
    select * from writeoffs
    union all
    select * from grants
    union all
    select * from lab_batches

)

select * from final

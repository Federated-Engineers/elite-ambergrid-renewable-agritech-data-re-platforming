with

fact_biomass_transactions as (

    select
        facility_id,
        transaction_timestamp,
        raw_weight_tons,
        net_cost_eur,
        green_subsidy_grant_eur,
        is_current_in_source
    from {{ ref('fact_biomass_transactions') }}

),

fact_scada_reactor_telemetry as (

    select
        facility_id,
        reading_date,
        methane_percentage
    from {{ ref('fact_scada_reactor_telemetry') }}

),

fct_gas_grid_injection_daily as (

    select
        facility_id,
        injection_date,
        revenue_eur,
        is_current_in_source
    from {{ ref('fct_gas_grid_injection_daily') }}

),

fct_fertilizer_sales_invoice as (

    select
        facility_id,
        invoice_date,
        total_amount_eur,
        is_current_in_source
    from {{ ref('fct_fertilizer_sales_invoice') }}

),

dim_facilities as (

    select
        facility_id,
        region_code
    from {{ ref('dim_facilities') }}

),

biomass_daily as (

    select
        facility_id,
        date(transaction_timestamp) as date_day,
        sum(raw_weight_tons) as total_biomass_processed_tons,
        sum(net_cost_eur) as total_net_cost_eur,
        sum(green_subsidy_grant_eur) as total_subsidy_revenue_eur
    from fact_biomass_transactions
    where is_current_in_source
    group by facility_id, date(transaction_timestamp)

),

telemetry_daily as (

    select
        facility_id,
        reading_date as date_day,
        avg(methane_percentage) as avg_methane_purity_pct
    from fact_scada_reactor_telemetry
    group by facility_id, reading_date

),

gas_revenue_daily as (

    select
        facility_id,
        injection_date as date_day,
        sum(revenue_eur) as total_gas_revenue_eur
    from fct_gas_grid_injection_daily
    where is_current_in_source
    group by facility_id, injection_date

),

fertilizer_revenue_daily as (

    select
        facility_id,
        invoice_date as date_day,
        sum(total_amount_eur) as total_fertilizer_revenue_eur
    from fct_fertilizer_sales_invoice
    where is_current_in_source
    group by facility_id, invoice_date

),

facility_days as (

    select
        facility_id,
        date_day
    from biomass_daily
    union distinct
    select
        facility_id,
        date_day
    from telemetry_daily
    union distinct
    select
        facility_id,
        date_day
    from gas_revenue_daily
    union distinct
    select
        facility_id,
        date_day
    from fertilizer_revenue_daily

),

combined as (

    select

        facility_days.date_day,
        facility_days.facility_id,
        dim_facilities.region_code,
        biomass_daily.total_biomass_processed_tons,
        telemetry_daily.avg_methane_purity_pct,
        biomass_daily.total_net_cost_eur,
        biomass_daily.total_subsidy_revenue_eur,
        gas_revenue_daily.total_gas_revenue_eur,
        fertilizer_revenue_daily.total_fertilizer_revenue_eur,
        coalesce(gas_revenue_daily.total_gas_revenue_eur, 0)
        + coalesce(fertilizer_revenue_daily.total_fertilizer_revenue_eur, 0) as total_revenue_eur

    from facility_days
    left join dim_facilities
        on facility_days.facility_id = dim_facilities.facility_id
    left join biomass_daily
        on
            facility_days.facility_id = biomass_daily.facility_id
            and facility_days.date_day = biomass_daily.date_day
    left join telemetry_daily
        on
            facility_days.facility_id = telemetry_daily.facility_id
            and facility_days.date_day = telemetry_daily.date_day
    left join gas_revenue_daily
        on
            facility_days.facility_id = gas_revenue_daily.facility_id
            and facility_days.date_day = gas_revenue_daily.date_day
    left join fertilizer_revenue_daily
        on
            facility_days.facility_id = fertilizer_revenue_daily.facility_id
            and facility_days.date_day = fertilizer_revenue_daily.date_day

),

final as (

    select

        combined.date_day,
        combined.facility_id,
        combined.region_code,
        combined.total_biomass_processed_tons,
        combined.avg_methane_purity_pct,
        combined.total_net_cost_eur,
        combined.total_subsidy_revenue_eur,
        combined.total_gas_revenue_eur,
        combined.total_fertilizer_revenue_eur,
        combined.total_revenue_eur,
        round(
            100 * (combined.total_revenue_eur - coalesce(combined.total_net_cost_eur, 0))
            / nullif(combined.total_revenue_eur, 0),
            2
        ) as net_profit_margin_percentage

    from combined

)

select * from final

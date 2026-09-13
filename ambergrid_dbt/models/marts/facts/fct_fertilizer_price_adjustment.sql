with

stg_google_sheets__fertilizer_price_adjustments as (

    select
        adjustment_id,
        product_type,
        adjustment_reason,
        approved_by,
        old_price_eur,
        new_price_eur,
        effective_date,
        is_current_in_source
    from {{ ref('stg_google_sheets__fertilizer_price_adjustments') }}

)

select * from stg_google_sheets__fertilizer_price_adjustments

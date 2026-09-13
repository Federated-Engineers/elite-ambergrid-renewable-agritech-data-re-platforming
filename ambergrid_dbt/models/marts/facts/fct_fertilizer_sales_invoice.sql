with

stg_postgres__fertilizer_sales_invoices as (

    select
        invoice_id,
        plant_id as facility_id,
        customer_name,
        product_type,
        payment_status,
        quantity_tons,
        unit_price_eur,
        total_amount_eur,
        invoice_date,
        due_date,
        is_current_in_source
    from {{ ref('stg_postgres__fertilizer_sales_invoices') }}

)

select * from stg_postgres__fertilizer_sales_invoices

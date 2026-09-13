with

postgres_fertilizer_sales_invoices as (

    select
        raw_record,
        snapshot_date,
        source_file_name,
        loaded_at
    from {{ source('postgres', 'fertilizer_sales_invoices') }}

),

renamed as (

    select

        raw_record:invoice_id::varchar as invoice_id,
        raw_record:plant_id::varchar as plant_id,
        raw_record:customer_name::varchar as customer_name,
        raw_record:product_type::varchar as product_type,
        raw_record:payment_status::varchar as payment_status,
        raw_record:quantity_tons::number(14, 3) as quantity_tons,
        raw_record:unit_price_eur::number(10, 2) as unit_price_eur,
        raw_record:total_amount_eur::number(14, 2) as total_amount_eur,
        raw_record:invoice_date::date as invoice_date,
        raw_record:due_date::date as due_date,
        snapshot_date::date as last_snapshot_date,
        snapshot_date = max(snapshot_date) over () as is_current_in_source,
        source_file_name::varchar as _source_file_name,
        loaded_at::timestamp_ltz as _last_modified_at

    from postgres_fertilizer_sales_invoices

)

select * from renamed

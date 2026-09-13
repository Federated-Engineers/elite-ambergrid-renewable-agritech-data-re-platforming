with

stg_google_sheets__npk_lab_batches as (

    select
        batch_id,
        plant_id as facility_id,
        batch_status,
        technician_name,
        notes,
        nitrogen_pct,
        phosphorus_pct,
        potassium_pct,
        sample_date,
        is_current_in_source
    from {{ ref('stg_google_sheets__npk_lab_batches') }}

)

select * from stg_google_sheets__npk_lab_batches

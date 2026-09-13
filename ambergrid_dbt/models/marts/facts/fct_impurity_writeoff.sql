with

stg_google_sheets__impurity_writeoffs as (

    select
        writeoff_id,
        plant_id as facility_id,
        contaminant_type,
        inspector_name,
        quantity_tons_written_off,
        estimated_loss_eur,
        writeoff_date,
        is_current_in_source
    from {{ ref('stg_google_sheets__impurity_writeoffs') }}

)

select * from stg_google_sheets__impurity_writeoffs

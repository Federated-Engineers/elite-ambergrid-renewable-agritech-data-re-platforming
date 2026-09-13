with

stg_google_sheets__subsidy_grants as (

    select
        grant_id,
        plant_id as facility_id,
        subsidy_type,
        granting_authority,
        officer_name,
        approval_status,
        amount_eur,
        grant_date,
        is_current_in_source
    from {{ ref('stg_google_sheets__subsidy_grants') }}

)

select * from stg_google_sheets__subsidy_grants

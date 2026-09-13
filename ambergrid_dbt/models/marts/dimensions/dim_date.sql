with

spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('2018-01-01')",
        end_date="to_date('2032-01-01')"
    ) }}

),

calendar as (

    select

        date_day::date as date_day,
        year(date_day) as year_number,
        quarter(date_day) as quarter_number,
        month(date_day) as month_number,
        monthname(date_day) as month_name,
        day(date_day) as day_of_month,
        dayname(date_day) as day_name,
        weekiso(date_day) as week_of_year,
        date_trunc('month', date_day)::date as month_start_date,
        last_day(date_day)::date as month_end_date,
        date_trunc('quarter', date_day)::date as quarter_start_date,
        date_trunc('year', date_day)::date as year_start_date,
        dayname(date_day) in ('Sat', 'Sun') as is_weekend

    from spine

)

select * from calendar

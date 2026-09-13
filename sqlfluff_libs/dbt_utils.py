def date_spine(datepart: str, start_date: str, end_date: str) -> str:
    """Stand in for dbt_utils.date_spine.

    The real macro returns a select with one row per datepart between the two
    dates, in a column named date_day.
    """

    return "select cast(null as date) as date_day"

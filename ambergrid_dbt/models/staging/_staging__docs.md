{% docs bronze_source_table %}
Table name in the ambergrid schema.
{% enddocs %}


{% docs bronze_snapshot_date %}
Date the row was last seen in the source.
{% enddocs %}


{% docs bronze_source_file_name %}
Staged file the row was loaded from.
{% enddocs %}


{% docs bronze_file_row_number %}
Row position within the staged file.
{% enddocs %}


{% docs bronze_file_last_modified %}
When the staged file was last written.
{% enddocs %}


{% docs bronze_file_content_key %}
Checksum of the staged file.
{% enddocs %}


{% docs bronze_loaded_at %}
When the merge last inserted or updated the row.
{% enddocs %}


{% docs stg_last_snapshot_date %}
Snapshot date of the most recent load that contained the row.
{% enddocs %}


{% docs stg_is_current_in_source %}
False once the row is removed upstream. The merge never deletes.
{% enddocs %}


{% docs stg_source_file_name %}
Staged file the row came from. Audit only.
{% enddocs %}


{% docs stg_last_modified_at %}
When the merge last changed the row. Audit only.
{% enddocs %}


{% docs bronze_worksheet_name %}
Source worksheet tab name.
{% enddocs %}


{% docs bronze_sheet_row_number %}
Row number in the worksheet itself, the header being row 1.
{% enddocs %}

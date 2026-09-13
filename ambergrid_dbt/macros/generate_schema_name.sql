{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set ci_targets = var('ci_targets', ['ci']) -%}

    {%- if custom_schema_name is none -%}

        {{ target.schema }}

    {%- elif target.name in ci_targets -%}

        {{ target.schema }}_{{ custom_schema_name | trim }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}

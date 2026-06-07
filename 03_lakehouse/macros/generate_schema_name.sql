{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {# 
    Migrated: replaced Databricks-specific target names ("databricks_cluster")
    with clickzetta equivalents ("prod").
    Original: target.name in ["prod", "databricks_cluster"]
    Migrated: target.name in ["prod", "clickzetta_prod"]
    #}
    {%- if target.name in ["prod", "clickzetta_prod"] -%}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}
    {%- else -%}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}
    {%- endif -%}
{%- endmacro %}

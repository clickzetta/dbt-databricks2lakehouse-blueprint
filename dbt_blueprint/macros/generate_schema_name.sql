{% macro generate_schema_name(custom_schema_name, node) -%}

    {# 
    Initialize the default schema from the targets schema configuration. 
    This value comes from the `schema` key in `profiles.yml`.
    #}

    {%- set default_schema = target.schema -%}
    
    {# 
    Check if the target environment is a production environment.
    Production environments include "prod" and "databricks_cluster".
    #}
    {%- if target.name in ["prod", "databricks_cluster"] -%}

        {# 
        Use the default schema if no custom schema name is provided.
        Otherwise, use the custom schema name directly.
        #}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}

    {# 
    For non-production environments (e.g., "dev", "test"), construct the schema name
    by appending the custom schema name to the default schema if provided.
    #}
    {%- else -%}

        {# 
        Use the default schema if no custom schema name is provided.
        Otherwise, append the custom schema name to the default schema using an underscore.
        #}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}
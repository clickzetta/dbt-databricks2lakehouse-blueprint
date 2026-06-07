-- Migrated: DATEDIFF(year, start, end) + DATEADD (Databricks SQL)
--        → YEAR() arithmetic (Lakehouse/ANSI SQL compatible)
-- Original Databricks version preserved in 01_source/macros/calculate_age.sql
{% macro calculate_age(date_of_birth, time_of_age) %}

YEAR({{ time_of_age }}) - YEAR({{ date_of_birth }})
- CASE
    WHEN DATE_FORMAT({{ time_of_age }}, 'MMdd') < DATE_FORMAT({{ date_of_birth }}, 'MMdd')
    THEN 1
    ELSE 0
  END

{% endmacro %}

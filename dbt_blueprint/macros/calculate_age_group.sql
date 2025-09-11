-- Macro to create age group buckets of users for anayltics

{% macro get_age_group(user_age) -%}
  CASE
    WHEN {{ user_age }} < 18 THEN '0-18'
    WHEN {{ user_age }} BETWEEN 18 AND 19 THEN '18-19'
    WHEN {{ user_age }} BETWEEN 20 AND 25 THEN '20-25'
    WHEN {{ user_age }} BETWEEN 25 AND 29 THEN '25-29'
    WHEN {{ user_age }} BETWEEN 30 AND 34 THEN '30-34'
    WHEN {{ user_age }} BETWEEN 35 AND 39 THEN '35-39'
    WHEN {{ user_age }} BETWEEN 40 AND 44 THEN '40-44'
    WHEN {{ user_age }} BETWEEN 45 AND 49 THEN '45-49'
    WHEN {{ user_age }} BETWEEN 50 AND 54 THEN '50-54'
    WHEN {{ user_age }} BETWEEN 55 AND 59 THEN '55-59'
    WHEN {{ user_age }} BETWEEN 60 AND 64 THEN '60-64'
    WHEN {{ user_age }} BETWEEN 65 AND 69 THEN '65-69'
    WHEN {{ user_age }} BETWEEN 70 AND 74 THEN '70-74'
    WHEN {{ user_age }} BETWEEN 75 AND 79 THEN '75-79'
    WHEN {{ user_age }} BETWEEN 80 AND 84 THEN '80-84'
    WHEN {{ user_age }} BETWEEN 85 AND 89 THEN '85-89'
    WHEN {{ user_age }} >= 90 THEN '90+'
  END
{%- endmacro %}

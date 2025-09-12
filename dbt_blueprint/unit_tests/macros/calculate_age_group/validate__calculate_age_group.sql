{# Make this model ephemeral so it doesnt create a table in the database #}

{{ config(materialized='ephemeral') }}

with dummy_source as (
    select * from {{ ref('test_source')}}
)

select
    {{ calculate_age_group('user_age') }} as calculated_age_group
from dummy_source
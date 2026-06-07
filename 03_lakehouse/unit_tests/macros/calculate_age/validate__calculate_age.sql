{{ config(materialized='ephemeral') }}

with dummy_source as (
    select * from {{ ref('test_source')}}
)

select 
    {{ calculate_age('date_of_birth', 'time_of_age') }} as calculated_age
from dummy_source

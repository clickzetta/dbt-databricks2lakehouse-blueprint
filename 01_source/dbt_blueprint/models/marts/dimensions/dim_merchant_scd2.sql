with merchant_scd2 as (
    select *
    from {{ ref('int_merchants') }}
)

select *
from merchant_scd2
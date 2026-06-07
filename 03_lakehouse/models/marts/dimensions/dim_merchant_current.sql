with current_merchants as (
    select
        *
    from {{ ref('dim_merchant_scd2') }}
    where is_current = true
)

select *
from current_merchants
with current_accounts as (
    select
        *
    from {{ ref('dim_account_scd2') }}
    where is_current = true
)

select *
from current_accounts
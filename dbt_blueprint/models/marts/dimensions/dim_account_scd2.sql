with account_scd2 as (
    select *
    from {{ ref('int_accounts') }}
)

select *
from account_scd2
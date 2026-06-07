with current_cards as (
    select
        *
    from {{ ref('dim_card_scd2') }}
    where is_current = true
)

select *
from current_cards
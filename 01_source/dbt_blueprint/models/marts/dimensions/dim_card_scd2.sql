with card_scd2 as (
    select *
    from {{ ref('int_cards') }}
)

select *
from card_scd2
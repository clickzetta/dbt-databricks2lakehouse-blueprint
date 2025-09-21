with tx as (
  select
      merchant_id,
      date(event_time) as event_date,
      transaction_amount,
      event_state
  from {{ ref('fact_transaction') }}
  where event_state = 'captured'
)

select
    merchant_id
    , event_date
    , count(*)                   as tx_count
    , sum(transaction_amount)    as tx_amount_sum
    , avg(transaction_amount)    as tx_amount_avg
from tx
group by merchant_id, event_date

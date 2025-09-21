{{ config(
  materialized='incremental',
  incremental_strategy='merge',
  unique_key=['merchant_id','event_date'],
  incremental_predicates=["event_date >= date_sub(current_date, {{ var('days_back', 14) }})"]
) }}

with tx as (
  select
      merchant_id,
      date(event_time) as event_date,
      transaction_amount,
      event_state
  from {{ ref('fact_transaction') }}
  where event_state = 'captured'
  {% if is_incremental() %}
    where date(event_ts) >= date_sub(current_date, {{ var('days_back', 14) }})
  {% endif %}
)

select
    merchant_id
    , event_date
    , count(*)                   as tx_count
    , sum(transaction_amount)    as tx_amount_sum
    , avg(transaction_amount)    as tx_amount_avg
from tx
group by merchant_id, event_date

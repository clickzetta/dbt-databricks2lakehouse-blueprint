{{ config(materialized='table') }}

with enriched_transactions as (
    select *
    from {{ ref('enriched_transactions') }}
)

select
    sender_user_id as user_id,
    count(*) as transaction_count,
    sum(transaction_amount) as total_transaction_amount,
    date(event_time) as aggregation_date
from enriched_transactions
where sender_card_status = 'active'
group by sender_user_id, date(event_time)
{{ config(materialized='table') }}

with transactions as (
    select *
    from {{ ref('fact_transaction') }}
),

users as (
    select
        *
    from {{ ref('dim_user_scd2__public') }}
    where is_current = true
),

cards as (
    select
        *
    from {{ ref('dim_card_scd2') }}
    where is_current = true
),

accounts as (
    select
        *
        , payment_source_id
        , status as account_status
        , provider as account_provider
    from {{ ref('dim_account_scd2') }}
    where is_current = true
),

enriched_transactions as (
    select
        transactions.*
        , cards.status as sender_card_status
        , cards.provider as sender_card_provider
        , accounts.account_status as receiver_account_status
        , accounts.account_provider as receiver_account_provider
    from transactions
    left join users as sender_user
        on transactions.sender_user_id = sender_user.user_id 
            and transactions.event_time >= sender_user.from_event_timestamp 
            and transactions.event_time < sender_user.to_event_timestamp
    left join users as receiver_user
        on transactions.receiver_user_id = receiver_user.user_id
            and transactions.event_time >= receiver_user.from_event_timestamp
            and transactions.event_time < receiver_user.to_event_timestamp
    left join cards
        on transactions.sender_payment_source_id = cards.payment_source_id
            and transactions.event_time >= cards.from_timestamp
            and transactions.event_time < cards.to_timestamp
    left join accounts
        on transactions.receiver_payment_source_id = accounts.payment_source_id
            and transactions.event_time >= accounts.from_timestamp
            and transactions.event_time < accounts.to_timestamp
)

select *
from enriched_transactions
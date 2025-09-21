{{ config(
    materialized = 'table'
) }}

with p2b_captured as (
    select
        transaction_event_id
        , 'p2b_captured' as transaction_type
        , sender_user_id
        , receiver_user_id
        , merchant_id
        , sender_payment_source_id
        , receiver_payment_source_id
        , country_code
        , currency_code
        , transaction_amount
        , message
        , event_time
        , recorded_time
    from {{ ref('stg_p2b_captured') }}
)

, p2b_failed as (
    select
        transaction_event_id
        , 'p2b_failed' as transaction_type
        , sender_user_id
        , receiver_user_id
        , merchant_id
        , sender_payment_source_id
        , receiver_payment_source_id
        , country_code
        , currency_code
        , transaction_amount
        , message
        , event_time
        , recorded_time
    from {{ ref('stg_p2b_failed') }}
)

, p2p_captured as (
    select
        transaction_event_id
        , 'p2p_captured' as transaction_type
        , sender_user_id
        , receiver_user_id
        , merchant_id
        , sender_payment_source_id
        , receiver_payment_source_id
        , country_code
        , currency_code
        , transaction_amount
        , message
        , event_time
        , recorded_time
    from {{ ref('stg_p2p_captured') }}
)

, p2p_failed as (
    select
        transaction_event_id
        , 'p2p_failed' as transaction_type
        , sender_user_id
        , receiver_user_id
        , merchant_id
        , sender_payment_source_id
        , receiver_payment_source_id
        , country_code
        , currency_code
        , transaction_amount
        , message
        , event_time
        , recorded_time
    from {{ ref('stg_p2p_failed') }}
)

, unioned_transactions as (
    select * from p2b_captured
    union all
    select * from p2b_failed
    union all
    select * from p2p_captured
    union all
    select * from p2p_failed
)

select *
from unioned_transactions
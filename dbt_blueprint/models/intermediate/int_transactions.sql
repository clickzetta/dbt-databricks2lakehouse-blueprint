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

, transactions_scd2 as (
    select
        transaction_event_id
        , transaction_type
        , sender_user_id
        , receiver_user_id
        , merchant_id
        , sender_payment_source_id
        , receiver_payment_source_id
        , country_code
        , currency_code
        , transaction_amount
        , message
        , event_time as from_event_timestamp
        , lead(event_time) over w as to_event_timestamp
        , recorded_time
    from unioned_transactions
    window w as (partition by transaction_event_id order by event_time)
)

, final_transactions as (
    select
        {{ dbt_utils.generate_surrogate_key(['transaction_event_id', 'from_event_timestamp', 'transaction_type']) }} as transaction_surrogate_key
        , transaction_event_id
        , transaction_type
        , sender_user_id
        , receiver_user_id
        , merchant_id
        , sender_payment_source_id
        , receiver_payment_source_id
        , country_code
        , currency_code
        , transaction_amount
        , message
        , from_event_timestamp
        , coalesce(to_event_timestamp, '9999-12-31 23:59:59') as to_event_timestamp
        , recorded_time
        , case 
            when to_event_timestamp is null then true
            else false
          end as is_current
    from transactions_scd2
)

select *
from final_transactions
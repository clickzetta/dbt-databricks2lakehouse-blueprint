with p2b_captured_source as (
    select
        CAST(transactionId             AS STRING)    as transaction_event_id,
        CAST(sender_user_id            AS STRING)    as sender_user_id,
        CAST(receiver_user_id          AS STRING)    as receiver_user_id,
        CAST(merchant_id               AS STRING)    as merchant_id,
        CAST(sender_payment_source_id  AS STRING)    as sender_payment_source_id,
        CAST(receiver_payment_source_id AS STRING)   as receiver_payment_source_id,
        CAST(country_code              AS STRING)    as country_code,
        CAST(currency_code             AS STRING)    as currency_code,
        CAST(amount                    AS DOUBLE)    as transaction_amount,
        CAST(message                   AS STRING)    as message,
        CAST(event_time                AS TIMESTAMP) as event_time,
        CAST(recorded_time             AS TIMESTAMP) as recorded_time
    from {{ source('transactions', 'raw_p2b_captured_events') }}
)

select *
from p2b_captured_source

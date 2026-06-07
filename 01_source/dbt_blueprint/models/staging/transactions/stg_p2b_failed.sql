with p2b_failed_source as (
    select
        transaction_event_id       :: string    as transaction_event_id,
        sender_user_id             :: string    as sender_user_id,
        receiver_user_id           :: string    as receiver_user_id,
        merchant_id                :: string    as merchant_id,
        sender_payment_source_id   :: string    as sender_payment_source_id,
        receiver_payment_source_id :: string    as receiver_payment_source_id,
        country_code               :: string    as country_code,
        currency_code              :: string    as currency_code,
        amount                     :: double    as transaction_amount,
        message                    :: string    as message,
        event_time                 :: timestamp as event_time,
        recorded_time              :: timestamp as recorded_time
    from {{ source('transactions', 'raw_p2b_failed_events') }}
)

select *
from p2b_failed_source
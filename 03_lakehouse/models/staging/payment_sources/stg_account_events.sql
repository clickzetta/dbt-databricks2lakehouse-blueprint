with account_events_source as (
    select
        CAST(accountId    AS STRING)    as payment_source_id,
        CAST(userId       AS STRING)    as user_id,
        CAST(status       AS STRING)    as status,
        CAST(bic          AS STRING)    as bic,
        CAST(bankName     AS STRING)    as bank_name,
        CAST(countryCode  AS STRING)    as country_code,
        CAST(accountType  AS STRING)    as account_type,
        CAST(provider     AS STRING)    as provider,
        CAST(createdTime  AS TIMESTAMP) as created_time,
        CAST(updatedTime  AS TIMESTAMP) as updated_time,
        CAST(recordedTime AS TIMESTAMP) as recorded_time
    from {{ source('payment_sources', 'account_events') }}
)

select *
from account_events_source

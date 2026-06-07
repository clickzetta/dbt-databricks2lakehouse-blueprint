with card_events_source as (
    select
        CAST(cardId         AS STRING)    as payment_source_id,
        CAST(userId         AS STRING)    as user_id,
        CAST(status         AS STRING)    as status,
        CAST(brand          AS STRING)    as brand,
        CAST(network        AS STRING)    as network,
        CAST(bin6           AS BIGINT)    as bin6,
        CAST(last4          AS BIGINT)    as last4,
        CAST(expiryMonth    AS BIGINT)    as expiry_month,
        CAST(expiryYear     AS BIGINT)    as expiry_year,
        CAST(issuerCountry  AS STRING)    as issuer_country,
        CAST(tokenized      AS BOOLEAN)   as tokenized,
        CAST(provider       AS STRING)    as provider,
        CAST(createdTime    AS TIMESTAMP) as created_time,
        CAST(updatedTime    AS TIMESTAMP) as updated_time,
        CAST(recordedTime   AS TIMESTAMP) as recorded_time
    from {{ source('payment_sources', 'card_events') }}
)

select *
from card_events_source

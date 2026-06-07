with card_events_source as (
    select
        cardId        :: string    as payment_source_id,
        userId        :: string    as user_id,
        status        :: string    as status,
        brand         :: string    as brand,
        network       :: string    as network,
        bin6          :: bigint    as bin6,
        last4         :: bigint    as last4,
        expiryMonth   :: bigint    as expiry_month,
        expiryYear    :: bigint    as expiry_year,
        issuerCountry :: string    as issuer_country,
        tokenized     :: boolean   as tokenized,
        provider      :: string    as provider,
        createdTime   :: timestamp as created_time,
        updatedTime   :: timestamp as updated_time,
        recordedTime  :: timestamp as recorded_time
    from {{ source('payment_sources', 'card_events') }}
)

select *
from card_events_source

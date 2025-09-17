with card_events_source as (
    select
        payment_source_id :: string    as payment_source_id,
        user_id           :: string    as user_id,
        status            :: string    as status,
        brand             :: string    as brand,
        network           :: string    as network,
        bin6              :: bigint    as bin6,
        last4             :: bigint    as last4,
        expiry_month      :: bigint    as expiry_month,
        expiry_year       :: bigint    as expiry_year,
        issuer_country    :: string    as issuer_country,
        tokenized         :: boolean   as tokenized,
        provider          :: string    as provider,
        created_time      :: timestamp as created_time,
        updated_time      :: timestamp as updated_time,
        recorded_time     :: timestamp as recorded_time
    from {{ source('payment_sources', 'raw_card_events') }}
)

select *
from card_events_source
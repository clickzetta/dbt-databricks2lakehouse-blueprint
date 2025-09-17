with account_events_source as (
    select
        payment_source_id :: string    as payment_source_id,
        user_id           :: string    as user_id,
        status            :: string    as status,
        bic               :: string    as bic,
        bank_name         :: string    as bank_name,
        country_code      :: string    as country_code,
        account_type      :: string    as account_type,
        provider          :: string    as provider,
        created_time      :: timestamp as created_time,
        updated_time      :: timestamp as updated_time,
        recorded_time     :: timestamp as recorded_time
    from {{ source('payment_sources', 'raw_account_events') }}
)

select *
from account_events_source
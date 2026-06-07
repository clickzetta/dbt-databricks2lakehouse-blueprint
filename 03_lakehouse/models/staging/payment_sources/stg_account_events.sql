with account_events_source as (
    select
        accountId    :: string    as payment_source_id,
        userId       :: string    as user_id,
        status       :: string    as status,
        bic          :: string    as bic,
        bankName     :: string    as bank_name,
        countryCode  :: string    as country_code,
        accountType  :: string    as account_type,
        provider     :: string    as provider,
        createdTime  :: timestamp as created_time,
        updatedTime  :: timestamp as updated_time,
        recordedTime :: timestamp as recorded_time
    from {{ source('payment_sources', 'account_events') }}
)

select *
from account_events_source

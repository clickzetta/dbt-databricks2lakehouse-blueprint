with merchant_source as (
    select
        merchantId      :: string     as merchant_id,
        orgNo           :: int        as organization_number,
        merchantName    :: string     as merchant_name,
        countryCode     :: string     as country_code,
        statusType      :: string     as status_type,
        createdTime     :: timestamp  as created_time,
        updatedTime     :: timestamp  as updated_time,
        recordedTime    :: timestamp  as recorded_time
    from {{ source('merchants', 'merchant_events') }}
)

select *
from merchant_source

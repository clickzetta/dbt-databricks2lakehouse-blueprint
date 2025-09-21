with merchant_source as (
    select
        -- Renaming and casting columns from the source table. Standardize name and use proper data types. 
        merchantId      :: string        as merchant_id,
        orgNo           :: int        as organization_number,
        companyName     :: string     as merchant_name,
        countryCode     :: string     as country_code,
        statusType      :: string     as status_type,
        createdTime     :: timestamp  as created_time,
        updatedTime     :: timestamp  as updated_time,
        recordedTime    :: timestamp  as recorded_time

    from {{ source('merchants', 'merchants_dk_no') }}
)

select *
from merchant_source
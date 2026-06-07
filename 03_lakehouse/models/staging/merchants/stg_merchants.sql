with merchant_source as (
    select
        CAST(merchantId   AS STRING)    as merchant_id,
        CAST(orgNo        AS INT)       as organization_number,
        CAST(merchantName AS STRING)    as merchant_name,
        CAST(countryCode  AS STRING)    as country_code,
        CAST(statusType   AS STRING)    as status_type,
        CAST(createdTime  AS TIMESTAMP) as created_time,
        CAST(updatedTime  AS TIMESTAMP) as updated_time,
        CAST(recordedTime AS TIMESTAMP) as recorded_time
    from {{ source('merchants', 'merchant_events') }}
)

select *
from merchant_source

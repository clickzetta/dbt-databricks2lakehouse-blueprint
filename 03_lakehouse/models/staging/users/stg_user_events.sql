with source_user_events as (
    select
        -- Migrated: :: cast syntax → CAST() for Lakehouse compatibility
        CAST(userId      AS STRING)    as user_id,
        CAST(phoneNumber AS BIGINT)    as phone_number,
        CAST(firstName   AS STRING)    as first_name,
        CAST(lastName    AS STRING)    as last_name,
        CAST(dateOfBirth AS DATE)      as date_of_birth,
        CAST(address     AS STRING)    as address,
        CAST(countryCode AS STRING)    as country_code,
        CAST(status      AS STRING)    as status,
        CAST(eventTime   AS TIMESTAMP) as event_time,
        CAST(recordedTime AS TIMESTAMP) as recorded_time
    from {{ source('users', 'user_events') }}
)

select *
from source_user_events

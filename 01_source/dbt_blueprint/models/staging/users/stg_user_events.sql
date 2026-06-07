with source_user_events as (
    select 
        -- Renaming and casting columns from the source table. Standardize name and use proper data types. 
        userId          :: string      as user_id,
        phoneNumber     :: int         as phone_number,
        firstName       :: string      as first_name,
        lastName        :: string      as last_name,
        dateOfBirth     :: date        as date_of_birth,
        address         :: string      as address,
        countryCode     :: string      as country_code,
        status          :: string      as status,
        eventTime       :: timestamp   as event_time,
        recordedTime    :: timestamp   as recorded_time

    from {{ source('users', 'user_events') }}    
)

select *
from source_user_events

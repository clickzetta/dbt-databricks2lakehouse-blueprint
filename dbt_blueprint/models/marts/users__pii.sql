with users as (
    select 
        user_surrogate_key
        , user_id
        , phone_number
        , first_name
        , last_name
        , date_of_birth
        , age
        , age_group
        , address
        , country_code
        , status
        , from_event_timestamp
        , to_event_timestamp
    from {{ ref('int_users') }}
)

select *
from {{ ref('int_users') }}
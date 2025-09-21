with users as (
    select
        user_surrogate_key 
        , user_id
        , CONCAT(SUBSTRING(phone_number, 1, 3), '****', SUBSTRING(phone_number, -2)) AS phone_number_masked
        , first_name
        , last_name
        , age
        , age_group
        , country_code
        , status
        , from_event_timestamp
        , to_event_timestamp
    from {{ ref('int_users') }}
)

select * except (age)
from users
where age >= 18
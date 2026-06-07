with users as (
    select
        user_surrogate_key
        , user_id
        , CONCAT(SUBSTRING(CAST(phone_number AS STRING), 1, 3), '****', RIGHT(CAST(phone_number AS STRING), 2)) AS phone_number_masked
        , first_name
        , last_name
        , age
        , age_group
        , country_code
        , status
        , from_event_timestamp
        , to_event_timestamp
        , is_current
    from {{ ref('int_users') }}
)

-- SELECT * EXCEPT (age) is supported by both Databricks and Lakehouse — no change needed
select * except (age)
from users
where age >= 18

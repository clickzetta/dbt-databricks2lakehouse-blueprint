{{ config(
    materialized = 'table'
) }}

with users as (
    select 
        user_id
        , phone_number
        , first_name
        , last_name
        , date_of_birth
        , {{ calculate_age('date_of_birth', 'getdate()') }} as age
        , {{ calculate_age_group('age') }} as age_group
        , address
        , country_code
        , status
        , event_time
        , recorded_time
    from {{ ref('stg_user_events') }}
)

, users_scd2 as (
    select 
        user_id
        , phone_number
        , first_name
        , last_name
        , date_of_birth
        , age
        , age_group
        , address
        , country_code
        , status
        , event_time as from_event_timestamp
        , lead(event_time) over w as to_event_timestamp
        , recorded_time
    from users
    window w as (partition by user_id order by event_time)
)

, final_users as (
    select 
        {{ dbt_utils.generate_surrogate_key(['user_id', 'from_event_timestamp', 'status']) }} as user_surrogate_key
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
        , coalesce(to_event_timestamp, '9999-12-31 23:59:59') as to_event_timestamp
        , recorded_time
        , case 
            when to_event_timestamp is null then true
            else false
          end as is_current
    from users_scd2
)

select *
from final_users
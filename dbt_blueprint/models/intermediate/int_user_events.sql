with users as (
    select *
    from {{ ref('stg_user_events') }}
)

select 
    user_id
    , first_name
    , last_name

from users
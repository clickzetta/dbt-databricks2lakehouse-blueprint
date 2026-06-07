with current_public_users as (
    select
        user_surrogate_key 
        , user_id
        , phone_number_masked
        , first_name
        , last_name
        , age_group
        , country_code
        , status
    from {{ ref('dim_user_scd2__public') }}
    where is_current = true
)

select *
from current_public_users
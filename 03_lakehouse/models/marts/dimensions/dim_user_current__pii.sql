with current_pii_users as (
    select
        user_surrogate_key 
        , user_id
        , phone_number
        , date_of_birth
        , first_name
        , last_name
        , age_group
        , country_code
        , status
    from {{ ref('dim_user_scd2__pii') }}
    where is_current = true
)

select *
from current_pii_users
{{ config(
    materialized = 'table'
) }}
-- add incremental materialization

with accounts as (
    select
        payment_source_id
        , user_id
        , status
        , bic
        , bank_name
        , country_code
        , account_type
        , provider
        , created_time
        , updated_time
        , recorded_time
    from {{ ref('stg_account_events') }}
)

-- Add dedup for accounts with identical timestamps

, accounts_scd2 as (
    select
        payment_source_id
        , user_id
        , status
        , bic
        , bank_name
        , country_code
        , account_type
        , provider
        , created_time
        , updated_time
        , recorded_time as from_timestamp
        , lead(recorded_time) over w as to_timestamp
    from accounts
    window w as (partition by payment_source_id order by recorded_time)
)

, final_accounts as (
    select
        {{ dbt_utils.generate_surrogate_key(['payment_source_id', 'from_timestamp', 'status']) }} as account_surrogate_key
        , payment_source_id
        , user_id
        , status
        , bic
        , bank_name
        , country_code
        , account_type
        , provider
        , created_time
        , updated_time
        , from_timestamp
        , coalesce(to_timestamp, '9999-12-31 23:59:59') as to_timestamp
        , case 
            when to_timestamp is null then true
            else false
          end as is_current
    from accounts_scd2
)

select *
from final_accounts
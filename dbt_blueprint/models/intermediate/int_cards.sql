{{ config(
    materialized = 'table'
) }}

with cards as (
    select
        payment_source_id
        , user_id
        , status
        , brand
        , network
        , bin6
        , last4
        , expiry_month
        , expiry_year
        , issuer_country
        , tokenized
        , provider
        , created_time
        , updated_time
        , recorded_time
    from {{ ref('stg_card_events') }}
)

, cards_scd2 as (
    select
        payment_source_id
        , user_id
        , status
        , brand
        , network
        , bin6
        , last4
        , expiry_month
        , expiry_year
        , issuer_country
        , tokenized
        , provider
        , created_time
        , updated_time
        , recorded_time as from_timestamp
        , lead(recorded_time) over w as to_timestamp
    from cards
    window w as (partition by payment_source_id order by recorded_time)
)

, final_cards as (
    select
        {{ dbt_utils.generate_surrogate_key(['payment_source_id', 'from_timestamp', 'status']) }} as card_surrogate_key
        , payment_source_id
        , user_id
        , status
        , brand
        , network
        , bin6
        , last4
        , expiry_month
        , expiry_year
        , issuer_country
        , tokenized
        , provider
        , created_time
        , updated_time
        , from_timestamp
        , coalesce(to_timestamp, '9999-12-31 23:59:59') as to_timestamp
        , case 
            when to_timestamp is null then true
            else false
          end as is_current
    from cards_scd2
)

select *
from final_cards
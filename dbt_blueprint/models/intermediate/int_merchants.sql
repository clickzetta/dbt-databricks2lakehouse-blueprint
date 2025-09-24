with merchants as (
    select
        merchant_id
        , organization_number
        , merchant_name
        , country_code as merchant_country_code
        , status_type
        , created_time
        , updated_time
        , recorded_time
    from {{ ref('stg_merchants') }}
)

, industry_codes as (
    select
        organization_number
        , industry_code
        , country_code as industry_country_code
        , industry_name
    from {{ ref('stg_industry_codes') }}
)

, merchants_with_industry_codes as (
    select
        merchants.merchant_id
        , merchants.organization_number
        , merchants.merchant_name
        , merchants.merchant_country_code
        , industry_codes.industry_code
        , industry_codes.industry_name
        , industry_codes.industry_country_code
        , merchants.status_type
        , merchants.created_time
        , merchants.updated_time
        , merchants.recorded_time
    from merchants
    left join industry_codes
    on merchants.organization_number = industry_codes.organization_number
)

, merchants_scd2 as (
    select
        merchant_id
        , organization_number
        , merchant_name
        , merchant_country_code
        , industry_code
        , industry_name
        , industry_country_code
        , status_type
        , recorded_time as from_recorded_timestamp
        , lead(recorded_time) over w as to_recorded_timestamp
        , created_time
        , updated_time
    from merchants_with_industry_codes
    window w as (partition by merchant_id order by recorded_time)
)

, final_merchants as (
    select
        {{ dbt_utils.generate_surrogate_key(['merchant_id', 'from_recorded_timestamp', 'status_type']) }} as merchant_surrogate_key
        , merchant_id
        , organization_number
        , merchant_name
        , merchant_country_code
        , industry_code
        , industry_name
        , industry_country_code
        , status_type
        , from_recorded_timestamp
        , coalesce(to_recorded_timestamp, '9999-12-31 23:59:59') as to_recorded_timestamp
        , created_time
        , updated_time
        , case
            when to_recorded_timestamp is null then true
            else false
          end as is_current
    from merchants_scd2
)

select *
from final_merchants
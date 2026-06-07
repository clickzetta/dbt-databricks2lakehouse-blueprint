with industry_code_source as (
    select
        CAST(orgNo        AS INT)    as organization_number,
        CAST(code         AS STRING) as industry_code,
        CAST(countryCode  AS STRING) as country_code,
        CAST(industryName AS STRING) as industry_name
    from {{ source('merchants', 'industry_codes') }}
)

select *
from industry_code_source

with industry_code_source as (
    select
        orgNo        :: int    as organization_number,
        code         :: string as industry_code,
        countryCode  :: string as country_code,
        industryName :: string as industry_name
    from {{ source('merchants', 'industry_codes') }}
)

select *
from industry_code_source

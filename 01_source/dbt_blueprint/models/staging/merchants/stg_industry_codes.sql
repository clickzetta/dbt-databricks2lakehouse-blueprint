with industry_code_source as (
    select
        -- casting orgNo and code to int (bigInt in source) 
        orgNo         :: int    as organization_number,
        code          :: int    as industry_code,
        countryCode   :: string as country_code,
        industryName  :: string as industry_name

    from {{ source('industry_codes', 'industry_codes') }}
)

select *
from industry_code_source
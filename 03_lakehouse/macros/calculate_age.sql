-- This macro calculates the age of something based on 
-- date of birth : date when entity was created
-- time of age : time at which to calculate the age
{% macro calculate_age(date_of_birth, time_of_age) %}

DATEDIFF(year, {{ date_of_birth }}, {{ time_of_age }}) 
+ CASE 
    WHEN 
        (DATEADD(year, 
            DATEDIFF(year, {{ date_of_birth }}, {{ time_of_age }}), 
            {{ date_of_birth }}
        )
        > {{ time_of_age }}) 
        THEN - 1 
        ELSE 0 
    END

{% endmacro %}
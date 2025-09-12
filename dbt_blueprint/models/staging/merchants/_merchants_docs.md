# We use markdown in all staging folders to enable doc blocks reference downstream to staging, intermediate, and mart doc files.
# Doing it this way means that we only have one place to maintain our column description.

# staging table description

{% docs merchants_table_description %}
This table contains staging data for merchants. It standardizes and renames columns for downstream usability.

**Primary key**: `merchant_id`
{% enddocs %}

{% docs merchant_id %}
(PK) Unique identifier for the merchant.
{% enddocs %}


{% docs merchant_name %}
Name of the merchant company.
{% enddocs %}

{% docs merchant_country_code %}
Country code where the merchant operates.
{% enddocs %}

{% docs status_type %}
Status type of the merchant (e.g., active, inactive).
{% enddocs %}

{% docs created_time %}
Timestamp when the merchant record was created.
{% enddocs %}

{% docs updated_time %}
Timestamp when the merchant record was last updated.
{% enddocs %}

{% docs merchant_recorded_time %}
Timestamp when the merchant record was recorded.
{% enddocs %}



# industry table description

{% docs industry_codes_table_description %}
This table contains staging data for industry codes. It standardizes and renames columns for downstream usability.

**Primary key**: `organization_number`, `industry_code`
{% enddocs %}

{% docs organization_number %}
Organization number associated with the industry code.
{% enddocs %}

{% docs industry_code %}
Industry code representing the merchant's industry.
{% enddocs %}

{% docs industry_country_code %}
Country code where the industry code applies.
{% enddocs %}

{% docs industry_name %}
Name of the industry associated with the industry code.
{% enddocs %}
# We use markdown in all staging folders to enable doc blocks reference downstream to staging, intermediate, and mart doc files.
# Doing it this way means that we only have one place to maintain our column description.

# staging table description

{% docs user_events_table_description %}
This table contains staging data for user events. It contains PII data.

**Primary key**: `user_id`
{% enddocs %}

{% docs user_id %}
(PK) Unique ID for identifying a user. Renamed from customer_id.
{% enddocs %}

{% docs phone_number %}
Phone number of the user.
{% enddocs %}

{% docs first_name %}
First name of the user.
{% enddocs %}

{% docs last_name %}
Last name of the user.
{% enddocs %}

{% docs address %}
Address of the user.
{% enddocs %}

{% docs country_code %}
Country code associated with the user.
{% enddocs %}

{% docs status %}
Current status of the user.
{% enddocs %}

{% docs event_time %}
Timestamp of the event occurrence.
{% enddocs %}

{% docs recorded_time %}
Timestamp when the event was recorded.
{% enddocs %}
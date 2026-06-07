# We use markdown in all staging folders to enable doc blocks reference downstream to staging, intermediate, and mart doc files.
# Doing it this way means that we only have one place to maintain our column description.

# staging table description

{% docs account_events_table_description %}
This table contains staging data for account payment events.

**Primary key**: `payment_source_id`
{% enddocs %}

{% docs card_events_table_description %}
This table contains staging data for card payment events.

**Primary key**: `payment_source_id`
{% enddocs %}

# Column descriptions

{% docs payment_source_id %}
(PK) Unique identifier for the payment source.
{% enddocs %}

{% docs payment_source_user_id %}
Unique identifier for the user associated with the payment source.
{% enddocs %}

{% docs payment_source_status %}
Current status of the payment source (e.g., active, inactive).
{% enddocs %}

{% docs payment_source_bic %}
Bank Identifier Code (BIC) for the account payment source.
{% enddocs %}

{% docs payment_source_bank_name %}
Name of the bank associated with the account payment source.
{% enddocs %}

{% docs payment_source_country_code %}
Country code associated with the payment source.
{% enddocs %}

{% docs payment_source_account_type %}
Type of the account (e.g., savings, checking).
{% enddocs %}

{% docs payment_source_provider %}
Provider of the payment source (e.g., Visa, Mastercard, bank name).
{% enddocs %}

{% docs payment_source_created_time %}
Timestamp when the payment source record was created.
{% enddocs %}

{% docs payment_source_updated_time %}
Timestamp when the payment source record was last updated.
{% enddocs %}

{% docs payment_source_recorded_time %}
Timestamp when the payment source record was recorded.
{% enddocs %}

{% docs payment_source_brand %}
Brand of the card (e.g., Visa, Mastercard).
{% enddocs %}

{% docs payment_source_network %}
Network of the card (e.g., Visa, Mastercard, Amex).
{% enddocs %}

{% docs payment_source_bin6 %}
First 6 digits of the card number (Bank Identification Number).
{% enddocs %}

{% docs payment_source_last4 %}
Last 4 digits of the card number.
{% enddocs %}

{% docs payment_source_expiry_month %}
Expiration month of the card.
{% enddocs %}

{% docs payment_source_expiry_year %}
Expiration year of the card.
{% enddocs %}

{% docs payment_source_issuer_country %}
Country where the card was issued.
{% enddocs %}

{% docs payment_source_tokenized %}
Indicates whether the card is tokenized (true/false).
{% enddocs %}
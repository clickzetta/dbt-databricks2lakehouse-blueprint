# We use markdown in all staging folders to enable doc blocks reference downstream to staging, intermediate, and mart doc files.
# Doing it this way means that we only have one place to maintain our column description.

# staging table description

{% docs p2b_captured_table_description %}
This table contains staging data for P2B captured transaction events.

**Primary key**: `transaction_event_id`
{% enddocs %}

{% docs p2b_failed_table_description %}
This table contains staging data for P2B failed transaction events.

**Primary key**: `transaction_event_id`
{% enddocs %}

{% docs p2p_captured_table_description %}
This table contains staging data for P2P captured transaction events.

**Primary key**: `transaction_event_id`
{% enddocs %}

{% docs p2p_failed_table_description %}
This table contains staging data for P2P failed transaction events.

**Primary key**: `transaction_event_id`
{% enddocs %}

# Column descriptions

{% docs transaction_event_id %}
(PK) Unique identifier for the transaction event.
{% enddocs %}

{% docs transaction_sender_user_id %}
Unique identifier for the sender of the transaction.
{% enddocs %}

{% docs transaction_receiver_user_id %}
Unique identifier for the receiver of the transaction.
{% enddocs %}

{% docs transaction_merchant_id %}
Unique identifier for the merchant involved in the transaction.
{% enddocs %}

{% docs transaction_sender_payment_source_id %}
Unique identifier for the sender's payment source.
{% enddocs %}

{% docs transaction_receiver_payment_source_id %}
Unique identifier for the receiver's payment source.
{% enddocs %}

{% docs transaction_country_code %}
Country code associated with the transaction.
{% enddocs %}

{% docs transaction_currency_code %}
Currency code used in the transaction.
{% enddocs %}

{% docs transaction_transaction_amount %}
The amount involved in the transaction.
{% enddocs %}

{% docs transaction_message %}
Message or note associated with the transaction.
{% enddocs %}

{% docs transaction_event_time %}
Timestamp of when the transaction event occurred.
{% enddocs %}

{% docs transaction_recorded_time %}
Timestamp of when the transaction event was recorded.
{% enddocs %}
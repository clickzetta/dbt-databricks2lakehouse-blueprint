select 
  transaction_uid
  , event_domain
  , event_state
  , event_time
  , recorded_time
from {{ ref('int_transactions') }}
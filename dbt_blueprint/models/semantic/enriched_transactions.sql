

with transactions as (
    select *
    from {{ ref('int_transactions') }}
    where recorded_time >= (select max(recorded_time) from {{ this }})

),

users as (
    select
        user_id
    from {{ ref('int_users') }}
    where is_current = true
),

cards as (
    select
        payment_source_id
        , status as card_status
        , provider as card_provider
    from {{ ref('int_cards') }}
    where is_current = true
),

accounts as (
    select
        payment_source_id
        , status as account_status
        , provider as account_provider
    from {{ ref('int_accounts') }}
    where is_current = true
),

enriched_transactions as (
    select
        transactions.*
        , cards.card_status as sender_card_status
        , cards.card_provider as sender_card_provider
        , accounts.account_status as receiver_account_status
        , accounts.account_provider as receiver_account_provider
    from transactions
    left join users as sender_user
        on transactions.sender_user_id = sender_user.user_id
    left join users as receiver_user
        on transactions.receiver_user_id = receiver_user.user_id
    left join cards
        on transactions.sender_payment_source_id = cards.payment_source_id
    left join accounts
        on transactions.receiver_payment_source_id = accounts.payment_source_id
)

select *
from enriched_transactions
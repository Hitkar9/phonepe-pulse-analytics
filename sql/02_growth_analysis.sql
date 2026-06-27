USE phonepe_pulse;

-- QUERY 6: Total transactions by year
SELECT
    year,
    SUM(transaction_count)          AS total_transactions,
    ROUND(SUM(transaction_amount)/10000000, 2) AS total_amount_crores
FROM agg_transactions
GROUP BY year
ORDER BY year;

-- QUERY 7: Year over year growth rate
WITH yearly AS (
    SELECT
        year,
        SUM(transaction_count) AS total_txn
    FROM agg_transactions
    GROUP BY year
)
SELECT
    year,
    total_txn,
    LAG(total_txn) OVER (ORDER BY year) AS prev_year_txn,
    ROUND(100.0 * (total_txn - LAG(total_txn) 
        OVER (ORDER BY year)) /
        LAG(total_txn) OVER (ORDER BY year), 2) AS yoy_growth_pct
FROM yearly;


-- QUERY 8: Top 10 states by total transactions
SELECT TOP 10
    state,
    SUM(transaction_count) AS total_transactions,
    ROUND(SUM(transaction_amount)/10000000, 2) AS amount_crores
FROM agg_transactions
GROUP BY state
ORDER BY total_transactions DESC;


-- QUERY 9: Payment type breakdown
SELECT
    transaction_type,
    SUM(transaction_count) AS total_transactions,
    ROUND(100.0 * SUM(transaction_count) /
        SUM(SUM(transaction_count)) OVER(), 2) AS percentage
FROM agg_transactions
GROUP BY transaction_type
ORDER BY total_transactions DESC;


-- QUERY 10: Top 10 device brands
SELECT TOP 10
    device_brand,
    SUM(user_count) AS total_users,
    ROUND(100.0 * SUM(user_count) /
        SUM(SUM(user_count)) OVER(), 2) AS market_share_pct
FROM agg_users
GROUP BY device_brand
ORDER BY total_users DESC;

-- QUERY 11: State wise user engagement
SELECT TOP 10
    state,
    SUM(registered_users) AS total_registered,
    SUM(app_opens) AS total_app_opens,
    ROUND(1.0 * SUM(app_opens) /
        NULLIF(SUM(registered_users), 0), 2) AS engagement_ratio
FROM map_users
GROUP BY state
ORDER BY engagement_ratio DESC;

-- QUERY 12: Underpenetrated states
SELECT
    state,
    SUM(transaction_count) AS total_transactions,
    RANK() OVER (ORDER BY SUM(transaction_count) ASC) 
        AS penetration_rank
FROM agg_transactions
GROUP BY state
ORDER BY total_transactions ASC;
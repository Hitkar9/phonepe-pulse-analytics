USE phonepe_pulse;

-- QUERY 13: User funnel analysis
SELECT
    COUNT(*) AS total_users,
    SUM(kyc_completed) AS kyc_completed,
    SUM(bank_linked) AS bank_linked,
    COUNT(first_txn_date) AS first_transaction,
    ROUND(100.0 * SUM(kyc_completed) / COUNT(*), 2) 
        AS kyc_rate,
    ROUND(100.0 * SUM(bank_linked) / COUNT(*), 2) 
        AS bank_link_rate,
    ROUND(100.0 * COUNT(first_txn_date) / COUNT(*), 2) 
        AS activation_rate
FROM users;

-- QUERY 14: Funnel drop off at each stage
SELECT
    'Step 1: Installed' AS funnel_stage,
    COUNT(*) AS users,
    100.00 AS percentage
FROM users
UNION ALL
SELECT
    'Step 2: KYC Done',
    SUM(kyc_completed),
    ROUND(100.0 * SUM(kyc_completed) / COUNT(*), 2)
FROM users
UNION ALL
SELECT
    'Step 3: Bank Linked',
    SUM(bank_linked),
    ROUND(100.0 * SUM(bank_linked) / COUNT(*), 2)
FROM users
UNION ALL
SELECT
    'Step 4: First Transaction',
    COUNT(first_txn_date),
    ROUND(100.0 * COUNT(first_txn_date) / COUNT(*), 2)
FROM users;

-- QUERY 15: DAU - Daily Active Users (last 30 days)
SELECT
    CAST(transaction_date AS DATE) AS txn_day,
    COUNT(DISTINCT user_id) AS daily_active_users
FROM transactions
WHERE transaction_date >= DATEADD(DAY, -30, 
    (SELECT MAX(transaction_date) FROM transactions))
GROUP BY CAST(transaction_date AS DATE)
ORDER BY txn_day;



-- QUERY 16: MAU - Monthly Active Users
SELECT
    FORMAT(transaction_date, 'yyyy-MM') AS month,
    COUNT(DISTINCT user_id) AS monthly_active_users
FROM transactions
GROUP BY FORMAT(transaction_date, 'yyyy-MM')
ORDER BY month;

-- QUERY 17: Stickiness ratio DAU/MAU
WITH dau AS (
    SELECT
        CAST(transaction_date AS DATE) AS txn_date,
        COUNT(DISTINCT user_id) AS daily_users
    FROM transactions
    GROUP BY CAST(transaction_date AS DATE)
),
mau AS (
    SELECT
        FORMAT(transaction_date, 'yyyy-MM') AS month,
        COUNT(DISTINCT user_id) AS monthly_users
    FROM transactions
    GROUP BY FORMAT(transaction_date, 'yyyy-MM')
)
SELECT
    m.month,
    m.monthly_users AS mau,
    ROUND(AVG(d.daily_users * 1.0), 0) AS avg_dau,
    ROUND(100.0 * AVG(d.daily_users * 1.0) / 
        m.monthly_users, 2) AS stickiness_pct
FROM mau m
JOIN dau d ON FORMAT(d.txn_date, 'yyyy-MM') = m.month
GROUP BY m.month, m.monthly_users
ORDER BY m.month;

-- QUERY 18: Retention rate Day 7 and Day 30
WITH user_activity AS (
    SELECT
        u.user_id,
        u.first_txn_date,
        MIN(t.transaction_date) AS second_txn_date
    FROM users u
    JOIN transactions t 
        ON u.user_id = t.user_id
        AND t.transaction_date > u.first_txn_date
    WHERE u.first_txn_date IS NOT NULL
    GROUP BY u.user_id, u.first_txn_date
)
SELECT
    COUNT(*) AS activated_users,
    SUM(CASE WHEN DATEDIFF(DAY, first_txn_date, 
        second_txn_date) <= 7 THEN 1 ELSE 0 END) 
        AS day7_retained,
    SUM(CASE WHEN DATEDIFF(DAY, first_txn_date, 
        second_txn_date) <= 30 THEN 1 ELSE 0 END) 
        AS day30_retained,
    ROUND(100.0 * SUM(CASE WHEN DATEDIFF(DAY, 
        first_txn_date, second_txn_date) <= 7 
        THEN 1 ELSE 0 END) / COUNT(*), 2) 
        AS day7_retention_pct,
    ROUND(100.0 * SUM(CASE WHEN DATEDIFF(DAY, 
        first_txn_date, second_txn_date) <= 30 
        THEN 1 ELSE 0 END) / COUNT(*), 2) 
        AS day30_retention_pct
FROM user_activity;
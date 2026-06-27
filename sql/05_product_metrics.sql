USE phonepe_pulse;

-- QUERY 25: ARPU - Average Revenue Per User
SELECT
    ROUND(SUM(transaction_amount) / 
        COUNT(DISTINCT user_id), 2) AS arpu
FROM transactions;

-- QUERY 26: ARPU by state
SELECT TOP 10
    u.state,
    COUNT(DISTINCT t.user_id) AS active_users,
    ROUND(SUM(t.transaction_amount) / 
        COUNT(DISTINCT t.user_id), 2) AS arpu
FROM transactions t
JOIN users u ON t.user_id = u.user_id
GROUP BY u.state
ORDER BY arpu DESC;

-- QUERY 27: Transaction success rate by month
SELECT
    FORMAT(transaction_date, 'yyyy-MM') AS month,
    COUNT(*) AS total_txns,
    SUM(CASE WHEN transaction_status = 'Success' 
        THEN 1 ELSE 0 END) AS successful,
    ROUND(100.0 * SUM(CASE WHEN transaction_status = 'Success' 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate_pct
FROM transactions
GROUP BY FORMAT(transaction_date, 'yyyy-MM')
ORDER BY month;

-- QUERY 28: Power users top 10%
WITH user_txn_count AS (
    SELECT
        user_id,
        COUNT(*) AS txn_count,
        SUM(transaction_amount) AS total_spent,
        NTILE(10) OVER (ORDER BY COUNT(*) DESC) AS decile
    FROM transactions
    GROUP BY user_id
)
SELECT
    decile,
    COUNT(*) AS users,
    ROUND(AVG(txn_count), 0) AS avg_transactions,
    ROUND(AVG(total_spent), 2) AS avg_spent
FROM user_txn_count
GROUP BY decile
ORDER BY decile;



USE phonepe_pulse;

-- QUERY 29: Complete user journey analysis
WITH user_journey AS (
    SELECT
        u.user_id,
        u.state,
        u.device_brand,
        u.cashback_given,
        u.kyc_completed,
        u.bank_linked,
        u.first_txn_date,
        u.churn_date,
        COUNT(t.transaction_id) AS total_transactions,
        ROUND(SUM(t.transaction_amount), 2) AS total_spent,
        ROUND(AVG(t.transaction_amount), 2) AS avg_txn_amount,
        MAX(t.transaction_date) AS last_active_date
    FROM users u
    LEFT JOIN transactions t ON u.user_id = t.user_id
    GROUP BY u.user_id, u.state, u.device_brand,
             u.cashback_given, u.kyc_completed,
             u.bank_linked, u.first_txn_date, u.churn_date
),
user_segments AS (
    SELECT *,
        CASE
            WHEN total_transactions >= 20 THEN 'Power User'
            WHEN total_transactions >= 5 THEN 'Regular User'
            WHEN total_transactions >= 1 THEN 'Occasional User'
            ELSE 'Inactive'
        END AS user_segment
    FROM user_journey
)
SELECT
    user_segment,
    COUNT(*) AS total_users,
    ROUND(AVG(total_transactions), 1) AS avg_transactions,
    ROUND(AVG(total_spent), 2) AS avg_spent,
    ROUND(100.0 * SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate,
    ROUND(100.0 * SUM(cashback_given) / COUNT(*), 2) 
        AS cashback_pct
FROM user_segments
GROUP BY user_segment
ORDER BY avg_transactions DESC;s
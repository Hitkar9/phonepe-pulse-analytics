USE phonepe_pulse;

-- QUERY 19: Cohort analysis
SELECT
    FORMAT(u.signup_date, 'yyyy-MM') AS cohort_month,
    FORMAT(t.transaction_date, 'yyyy-MM') AS activity_month,
    COUNT(DISTINCT t.user_id) AS active_users
FROM users u
JOIN transactions t ON u.user_id = t.user_id
GROUP BY 
    FORMAT(u.signup_date, 'yyyy-MM'),
    FORMAT(t.transaction_date, 'yyyy-MM')
ORDER BY cohort_month, activity_month;

-- QUERY 20: Churn rate overall
SELECT
    COUNT(*) AS total_users,
    SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) AS churned_users,
    ROUND(100.0 * SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM users;

-- QUERY 21: Churn rate by state
SELECT TOP 10
    state,
    COUNT(*) AS total_users,
    SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM users
GROUP BY state
ORDER BY churn_rate_pct DESC;


-- QUERY 22: Cashback impact on retention
SELECT
    u.cashback_given,
    COUNT(DISTINCT u.user_id) AS total_users,
    SUM(CASE WHEN u.churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN u.churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(100.0 * SUM(CASE WHEN u.churn_date IS NULL 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_rate_pct
FROM users u
GROUP BY u.cashback_given;

-- QUERY 23: Cashback impact on transactions
SELECT
    u.cashback_given,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(AVG(t.transaction_amount), 2) AS avg_txn_amount,
    ROUND(AVG(t.cashback_amount), 2) AS avg_cashback
FROM users u
JOIN transactions t ON u.user_id = t.user_id
GROUP BY u.cashback_given;

-- QUERY 24: Churn rate by device brand
SELECT
    u.device_brand,
    COUNT(*) AS total_users,
    SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN churn_date IS NOT NULL 
        THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM users u
GROUP BY u.device_brand
ORDER BY churn_rate_pct DESC;
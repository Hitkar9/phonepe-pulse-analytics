USE phonepe_pulse;

-- QUERY 1: Row count of all tables
SELECT 'agg_transactions' AS table_name, COUNT(*) AS row_count FROM agg_transactions
UNION ALL
SELECT 'agg_users', COUNT(*) FROM agg_users
UNION ALL
SELECT 'map_transactions', COUNT(*) FROM map_transactions
UNION ALL
SELECT 'map_users', COUNT(*) FROM map_users
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions;


-- QUERY 2: Date range of our data
SELECT
    MIN(year) AS start_year,
    MAX(year) AS end_year,
    COUNT(DISTINCT state) AS total_states,
    COUNT(DISTINCT transaction_type) AS payment_types
FROM agg_transactions;


-- QUERY 3: NULL check on users table
SELECT
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS null_user_id,
    SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS null_signup,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN kyc_completed IS NULL THEN 1 ELSE 0 END) AS null_kyc,
    SUM(CASE WHEN bank_linked IS NULL THEN 1 ELSE 0 END) AS null_bank,
    SUM(CASE WHEN first_txn_date IS NULL THEN 1 ELSE 0 END) AS null_first_txn
FROM users;

-- QUERY 4: Transaction amount statistics
SELECT
    COUNT(*)                            AS total_transactions,
    ROUND(MIN(transaction_amount), 2)   AS min_amount,
    ROUND(MAX(transaction_amount), 2)   AS max_amount,
    ROUND(AVG(transaction_amount), 2)   AS avg_amount,
    ROUND(STDEV(transaction_amount), 2) AS std_amount
FROM transactions;


-- QUERY 5: Transaction status breakdown
SELECT
    transaction_status,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) / 
        SUM(COUNT(*)) OVER(), 2) AS percentage
FROM transactions
GROUP BY transaction_status;
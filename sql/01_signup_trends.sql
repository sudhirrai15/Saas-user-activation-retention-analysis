-- Analyze signup volume by month and week to understand top-of-funnel trends.

WITH monthly_signups AS (
    SELECT
        DATE_TRUNC('month', signup_date) AS signup_month,
        COUNT(DISTINCT user_id) AS total_signups
    FROM users
    GROUP BY 1
),
weekly_signups AS (
    SELECT
        DATE_TRUNC('week', signup_date) AS signup_week,
        COUNT(DISTINCT user_id) AS total_signups
    FROM users
    GROUP BY 1
)

SELECT
    signup_month,
    total_signups
FROM monthly_signups
ORDER BY signup_month;

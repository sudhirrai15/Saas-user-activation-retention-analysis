-- Pull top-line executive metrics for dashboard cards or summary reporting.

WITH activation_status AS (
    SELECT
        u.user_id,
        CASE
            WHEN MIN(CASE WHEN e.event_name = 'workspace_created' THEN e.event_date END) <= u.signup_date + INTERVAL '7 day'
             AND MIN(CASE WHEN e.event_name = 'first_report_created' THEN e.event_date END) <= u.signup_date + INTERVAL '7 day'
            THEN 1
            ELSE 0
        END AS is_activated
    FROM users u
    LEFT JOIN events e
        ON u.user_id = e.user_id
    GROUP BY u.user_id, u.signup_date
),
day7_retention AS (
    SELECT DISTINCT
        u.user_id,
        1 AS retained_day7
    FROM users u
    JOIN events e
        ON u.user_id = e.user_id
    WHERE e.event_date >= u.signup_date + INTERVAL '7 day'
      AND e.event_date < u.signup_date + INTERVAL '8 day'
),
day30_retention AS (
    SELECT DISTINCT
        u.user_id,
        1 AS retained_day30
    FROM users u
    JOIN events e
        ON u.user_id = e.user_id
    WHERE e.event_date >= u.signup_date + INTERVAL '30 day'
      AND e.event_date < u.signup_date + INTERVAL '31 day'
),
paid_conversion AS (
    SELECT
        user_id,
        CASE WHEN converted_to_paid = 1 THEN 1 ELSE 0 END AS converted_to_paid,
        monthly_revenue
    FROM subscriptions
)

SELECT
    COUNT(DISTINCT u.user_id) AS total_signups,
    SUM(a.is_activated) AS activated_users,
    ROUND(100.0 * SUM(a.is_activated) / COUNT(DISTINCT u.user_id), 2) AS activation_rate_pct,
    SUM(COALESCE(d7.retained_day7, 0)) AS retained_users_day7,
    ROUND(100.0 * SUM(COALESCE(d7.retained_day7, 0)) / COUNT(DISTINCT u.user_id), 2) AS day7_retention_pct,
    SUM(COALESCE(d30.retained_day30, 0)) AS retained_users_day30,
    ROUND(100.0 * SUM(COALESCE(d30.retained_day30, 0)) / COUNT(DISTINCT u.user_id), 2) AS day30_retention_pct,
    SUM(COALESCE(p.converted_to_paid, 0)) AS paid_conversions,
    ROUND(100.0 * SUM(COALESCE(p.converted_to_paid, 0)) / COUNT(DISTINCT u.user_id), 2) AS trial_to_paid_conversion_pct,
    ROUND(AVG(CASE WHEN p.converted_to_paid = 1 THEN p.monthly_revenue END), 2) AS avg_converted_user_mrr
FROM users u
LEFT JOIN activation_status a
    ON u.user_id = a.user_id
LEFT JOIN day7_retention d7
    ON u.user_id = d7.user_id
LEFT JOIN day30_retention d30
    ON u.user_id = d30.user_id
LEFT JOIN paid_conversion p
    ON u.user_id = p.user_id;

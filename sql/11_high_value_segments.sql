-- Identify segments that combine strong retention and strong revenue potential.

WITH day30_retention AS (
    SELECT DISTINCT
        u.user_id,
        1 AS retained_day30
    FROM users u
    JOIN events e
        ON u.user_id = e.user_id
    WHERE e.event_date >= u.signup_date + INTERVAL '30 day'
      AND e.event_date < u.signup_date + INTERVAL '31 day'
),
segment_metrics AS (
    SELECT
        u.acquisition_channel,
        u.plan_type,
        u.company_size,
        COUNT(DISTINCT u.user_id) AS total_users,
        SUM(COALESCE(r.retained_day30, 0)) AS retained_users_day30,
        ROUND(100.0 * SUM(COALESCE(r.retained_day30, 0)) / COUNT(DISTINCT u.user_id), 2) AS day30_retention_pct,
        SUM(CASE WHEN s.converted_to_paid = 1 THEN 1 ELSE 0 END) AS paid_conversions,
        ROUND(100.0 * SUM(CASE WHEN s.converted_to_paid = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT u.user_id), 2) AS paid_conversion_pct,
        ROUND(AVG(CASE WHEN s.converted_to_paid = 1 THEN s.monthly_revenue END), 2) AS avg_monthly_revenue
    FROM users u
    LEFT JOIN day30_retention r
        ON u.user_id = r.user_id
    LEFT JOIN subscriptions s
        ON u.user_id = s.user_id
    GROUP BY u.acquisition_channel, u.plan_type, u.company_size
)

SELECT
    acquisition_channel,
    plan_type,
    company_size,
    total_users,
    day30_retention_pct,
    paid_conversion_pct,
    avg_monthly_revenue
FROM segment_metrics
WHERE total_users >= 20
ORDER BY day30_retention_pct DESC, paid_conversion_pct DESC, avg_monthly_revenue DESC;

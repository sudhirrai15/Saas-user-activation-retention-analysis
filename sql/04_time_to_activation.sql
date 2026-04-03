-- Measure how long it takes users to activate after signup.

WITH activation_events AS (
    SELECT
        u.user_id,
        u.signup_date,
        MIN(CASE WHEN e.event_name = 'workspace_created' THEN e.event_date END) AS workspace_created_date,
        MIN(CASE WHEN e.event_name = 'first_report_created' THEN e.event_date END) AS first_report_created_date
    FROM users u
    LEFT JOIN events e
        ON u.user_id = e.user_id
    GROUP BY u.user_id, u.signup_date
),
activated_users AS (
    SELECT
        user_id,
        signup_date,
        GREATEST(workspace_created_date, first_report_created_date) AS activation_date
    FROM activation_events
    WHERE workspace_created_date IS NOT NULL
      AND first_report_created_date IS NOT NULL
      AND workspace_created_date <= signup_date + INTERVAL '7 day'
      AND first_report_created_date <= signup_date + INTERVAL '7 day'
)

SELECT
    ROUND(AVG(activation_date - signup_date), 2) AS avg_days_to_activate,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (activation_date - signup_date)) AS median_days_to_activate,
    MIN(activation_date - signup_date) AS min_days_to_activate,
    MAX(activation_date - signup_date) AS max_days_to_activate
FROM activated_users;

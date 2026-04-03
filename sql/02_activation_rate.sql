-- Define activated users as those who complete both workspace_created
-- and first_report_created within 7 days of signup.
-- ------------------------------------------------------------------------------

WITH signup_base AS (
    SELECT
        u.user_id,
        u.signup_date,
        u.acquisition_channel,
        u.device_type,
        u.country,
        u.plan_type
    FROM users u
),
activation_events AS (
    SELECT
        e.user_id,
        MIN(CASE WHEN e.event_name = 'workspace_created' THEN e.event_date END) AS workspace_created_date,
        MIN(CASE WHEN e.event_name = 'first_report_created' THEN e.event_date END) AS first_report_created_date
    FROM events e
    GROUP BY e.user_id
),
activation_status AS (
    SELECT
        s.user_id,
        s.signup_date,
        s.acquisition_channel,
        s.device_type,
        s.country,
        s.plan_type,
        a.workspace_created_date,
        a.first_report_created_date,
        CASE
            WHEN a.workspace_created_date IS NOT NULL
             AND a.first_report_created_date IS NOT NULL
             AND a.workspace_created_date <= s.signup_date + INTERVAL '7 day'
             AND a.first_report_created_date <= s.signup_date + INTERVAL '7 day'
            THEN 1
            ELSE 0
        END AS is_activated
    FROM signup_base s
    LEFT JOIN activation_events a
        ON s.user_id = a.user_id
)

SELECT
    COUNT(DISTINCT user_id) AS total_signups,
    SUM(is_activated) AS activated_users,
    ROUND(100.0 * SUM(is_activated) / COUNT(DISTINCT user_id), 2) AS activation_rate_pct
FROM activation_status;

-- ---------------------------------------------------------------------------------------
-- To break activation rate out by channel:
-- ---------------------------------------------------------------------------------------
WITH signup_base AS (
    SELECT
        u.user_id,
        u.signup_date,
        u.acquisition_channel
    FROM users u
),
activation_events AS (
    SELECT
        e.user_id,
        MIN(CASE WHEN e.event_name = 'workspace_created' THEN e.event_date END) AS workspace_created_date,
        MIN(CASE WHEN e.event_name = 'first_report_created' THEN e.event_date END) AS first_report_created_date
    FROM events e
    GROUP BY e.user_id
),
activation_status AS (
    SELECT
        s.user_id,
        s.acquisition_channel,
        CASE
            WHEN a.workspace_created_date IS NOT NULL
             AND a.first_report_created_date IS NOT NULL
             AND a.workspace_created_date <= s.signup_date + INTERVAL '7 day'
             AND a.first_report_created_date <= s.signup_date + INTERVAL '7 day'
            THEN 1
            ELSE 0
        END AS is_activated
    FROM signup_base s
    LEFT JOIN activation_events a
        ON s.user_id = a.user_id
)

SELECT
    acquisition_channel,
    COUNT(DISTINCT user_id) AS total_signups,
    SUM(is_activated) AS activated_users,
    ROUND(100.0 * SUM(is_activated) / COUNT(DISTINCT user_id), 2) AS activation_rate_pct
FROM activation_status
GROUP BY acquisition_channel
ORDER BY activation_rate_pct DESC;


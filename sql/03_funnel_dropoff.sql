-- Measure conversion through key onboarding milestones.

WITH signup_users AS (
    SELECT
        user_id,
        signup_date
    FROM users
),
user_funnel_flags AS (
    SELECT
        u.user_id,
        1 AS signed_up,
        MAX(CASE WHEN e.event_name = 'email_verified' THEN 1 ELSE 0 END) AS email_verified,
        MAX(CASE WHEN e.event_name = 'workspace_created' THEN 1 ELSE 0 END) AS workspace_created,
        MAX(CASE WHEN e.event_name = 'first_report_created' THEN 1 ELSE 0 END) AS first_report_created,
        MAX(CASE WHEN e.event_name = 'login' THEN 1 ELSE 0 END) AS logged_in
    FROM signup_users u
    LEFT JOIN events e
        ON u.user_id = e.user_id
    GROUP BY u.user_id
),
funnel_counts AS (
    SELECT
        COUNT(DISTINCT user_id) AS signed_up_users,
        SUM(email_verified) AS email_verified_users,
        SUM(workspace_created) AS workspace_created_users,
        SUM(first_report_created) AS first_report_created_users,
        SUM(logged_in) AS logged_in_users
    FROM user_funnel_flags
)

SELECT
    'Signed Up' AS funnel_stage,
    signed_up_users AS users_at_stage,
    100.0 AS pct_of_signups
FROM funnel_counts

UNION ALL

SELECT
    'Email Verified' AS funnel_stage,
    email_verified_users AS users_at_stage,
    ROUND(100.0 * email_verified_users / signed_up_users, 2) AS pct_of_signups
FROM funnel_counts

UNION ALL

SELECT
    'Workspace Created' AS funnel_stage,
    workspace_created_users AS users_at_stage,
    ROUND(100.0 * workspace_created_users / signed_up_users, 2) AS pct_of_signups
FROM funnel_counts

UNION ALL

SELECT
    'First Report Created' AS funnel_stage,
    first_report_created_users AS users_at_stage,
    ROUND(100.0 * first_report_created_users / signed_up_users, 2) AS pct_of_signups
FROM funnel_counts

UNION ALL

SELECT
    'Logged In' AS funnel_stage,
    logged_in_users AS users_at_stage,
    ROUND(100.0 * logged_in_users / signed_up_users, 2) AS pct_of_signups
FROM funnel_counts;

-- ------------------------------------------------------------------------------
--  If you want to see stage-to-stage drop-off more explicitly, use this version:
-- -------------------------------------------------------------------------------

WITH signup_users AS (
    SELECT user_id
    FROM users
),
user_funnel_flags AS (
    SELECT
        u.user_id,
        1 AS signed_up,
        MAX(CASE WHEN e.event_name = 'email_verified' THEN 1 ELSE 0 END) AS email_verified,
        MAX(CASE WHEN e.event_name = 'workspace_created' THEN 1 ELSE 0 END) AS workspace_created,
        MAX(CASE WHEN e.event_name = 'first_report_created' THEN 1 ELSE 0 END) AS first_report_created
    FROM signup_users u
    LEFT JOIN events e
        ON u.user_id = e.user_id
    GROUP BY u.user_id
),
funnel_counts AS (
    SELECT 'Signed Up' AS stage, COUNT(*) AS users_at_stage FROM user_funnel_flags
    UNION ALL
    SELECT 'Email Verified', SUM(email_verified) FROM user_funnel_flags
    UNION ALL
    SELECT 'Workspace Created', SUM(workspace_created) FROM user_funnel_flags
    UNION ALL
    SELECT 'First Report Created', SUM(first_report_created) FROM user_funnel_flags
),
ordered_funnel AS (
    SELECT
        stage,
        users_at_stage,
        LAG(users_at_stage) OVER (ORDER BY
            CASE stage
                WHEN 'Signed Up' THEN 1
                WHEN 'Email Verified' THEN 2
                WHEN 'Workspace Created' THEN 3
                WHEN 'First Report Created' THEN 4
            END
        ) AS prior_stage_users
    FROM funnel_counts
)

SELECT
    stage,
    users_at_stage,
    prior_stage_users,
    CASE
        WHEN prior_stage_users IS NULL THEN NULL
        ELSE ROUND(100.0 * users_at_stage / prior_stage_users, 2)
    END AS conversion_from_prior_stage_pct,
    CASE
        WHEN prior_stage_users IS NULL THEN NULL
        ELSE ROUND(100.0 * (prior_stage_users - users_at_stage) / prior_stage_users, 2)
    END AS dropoff_from_prior_stage_pct
FROM ordered_funnel
ORDER BY
    CASE stage
        WHEN 'Signed Up' THEN 1
        WHEN 'Email Verified' THEN 2
        WHEN 'Workspace Created' THEN 3
        WHEN 'First Report Created' THEN 4
    END;


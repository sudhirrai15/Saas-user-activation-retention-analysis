-- Analyze trial-to-paid conversion across segments.

SELECT
    u.plan_type,
    u.acquisition_channel,
    u.company_size,
    COUNT(DISTINCT u.user_id) AS total_trial_users,
    SUM(CASE WHEN s.converted_to_paid = 1 THEN 1 ELSE 0 END) AS converted_users,
    ROUND(
        100.0 * SUM(CASE WHEN s.converted_to_paid = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT u.user_id),
        2
    ) AS trial_to_paid_conversion_pct,
    ROUND(AVG(CASE WHEN s.converted_to_paid = 1 THEN s.monthly_revenue END), 2) AS avg_monthly_revenue_after_conversion
FROM users u
JOIN subscriptions s
    ON u.user_id = s.user_id
WHERE u.plan_type IN ('trial', 'free_trial')
GROUP BY u.plan_type, u.acquisition_channel, u.company_size
ORDER BY trial_to_paid_conversion_pct DESC, avg_monthly_revenue_after_conversion DESC;

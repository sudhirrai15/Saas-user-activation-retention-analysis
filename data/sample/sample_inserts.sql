-- Sample users rows
INSERT INTO users (user_id, signup_date, country, region, device_type, acquisition_channel, plan_type, company_size, industry) VALUES
(1, '2025-01-03', 'United States', 'North America', 'Desktop', 'Organic Search', 'trial', 'Mid-Market', 'SaaS'),
(2, '2025-01-05', 'United States', 'North America', 'Mobile', 'Paid Social', 'trial', 'SMB', 'E-commerce'),
(3, '2025-01-07', 'India', 'APAC', 'Desktop', 'Referral', 'free_trial', 'Enterprise', 'Technology'),
(4, '2025-01-10', 'United Kingdom', 'EMEA', 'Desktop', 'Organic Search', 'trial', 'SMB', 'Finance'),
(5, '2025-01-14', 'Canada', 'North America', 'Mobile', 'Paid Search', 'trial', 'Mid-Market', 'Healthcare'),
(6, '2025-01-18', 'Germany', 'EMEA', 'Desktop', 'Referral', 'free_trial', 'Enterprise', 'Manufacturing'),
(7, '2025-01-21', 'United States', 'North America', 'Desktop', 'Paid Social', 'trial', 'SMB', 'SaaS'),
(8, '2025-01-25', 'Australia', 'APAC', 'Mobile', 'Organic Search', 'trial', 'Mid-Market', 'Retail');


-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Sample events rows

INSERT INTO events (event_id, user_id, event_date, event_name, session_id, feature_name) VALUES
(101, 1, '2025-01-03', 'signup_completed', 's1', NULL),
(102, 1, '2025-01-04', 'email_verified', 's2', NULL),
(103, 1, '2025-01-04', 'workspace_created', 's2', NULL),
(104, 1, '2025-01-05', 'first_report_created', 's3', 'Reporting'),
(105, 1, '2025-02-02', 'login', 's4', NULL),

(106, 2, '2025-01-05', 'signup_completed', 's5', NULL),
(107, 2, '2025-01-06', 'email_verified', 's6', NULL),
(108, 2, '2025-01-11', 'workspace_created', 's7', NULL),

(109, 3, '2025-01-07', 'signup_completed', 's8', NULL),
(110, 3, '2025-01-08', 'email_verified', 's9', NULL),
(111, 3, '2025-01-08', 'workspace_created', 's9', NULL),
(112, 3, '2025-01-09', 'first_report_created', 's10', 'Reporting'),
(113, 3, '2025-02-06', 'login', 's11', NULL),

(114, 4, '2025-01-10', 'signup_completed', 's12', NULL),
(115, 4, '2025-01-12', 'email_verified', 's13', NULL),
(116, 4, '2025-01-13', 'workspace_created', 's13', NULL),
(117, 4, '2025-01-14', 'first_report_created', 's14', 'Dashboard'),
(118, 4, '2025-02-09', 'login', 's15', NULL),

(119, 5, '2025-01-14', 'signup_completed', 's16', NULL),
(120, 5, '2025-01-15', 'email_verified', 's17', NULL),

(121, 6, '2025-01-18', 'signup_completed', 's18', NULL),
(122, 6, '2025-01-19', 'email_verified', 's19', NULL),
(123, 6, '2025-01-20', 'workspace_created', 's19', NULL),
(124, 6, '2025-01-22', 'first_report_created', 's20', 'Integration'),
(125, 6, '2025-02-18', 'login', 's21', NULL),

(126, 7, '2025-01-21', 'signup_completed', 's22', NULL),
(127, 7, '2025-01-25', 'email_verified', 's23', NULL),
(128, 7, '2025-01-28', 'workspace_created', 's24', NULL),

(129, 8, '2025-01-25', 'signup_completed', 's25', NULL),
(130, 8, '2025-01-26', 'email_verified', 's26', NULL),
(131, 8, '2025-01-27', 'workspace_created', 's26', NULL),
(132, 8, '2025-01-28', 'first_report_created', 's27', 'Dashboard'),
(133, 8, '2025-02-24', 'login', 's28', NULL);

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Sample subscriptions rows

INSERT INTO subscriptions (user_id, trial_start_date, trial_end_date, converted_to_paid, conversion_date, monthly_revenue) VALUES
(1, '2025-01-03', '2025-01-17', 1, '2025-01-18', 120.00),
(2, '2025-01-05', '2025-01-19', 0, NULL, NULL),
(3, '2025-01-07', '2025-01-21', 1, '2025-01-22', 400.00),
(4, '2025-01-10', '2025-01-24', 1, '2025-01-25', 95.00),
(5, '2025-01-14', '2025-01-28', 0, NULL, NULL),
(6, '2025-01-18', '2025-02-01', 1, '2025-02-02', 550.00),
(7, '2025-01-21', '2025-02-04', 0, NULL, NULL),
(8, '2025-01-25', '2025-02-08', 1, '2025-02-09', 180.00);


-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Sample marketing_spend rows

INSERT INTO marketing_spend (acquisition_channel, month, spend, campaign_type) VALUES
('Organic Search', '2025-01-01', 5000.00, 'SEO'),
('Paid Social', '2025-01-01', 12000.00, 'Awareness'),
('Referral', '2025-01-01', 3000.00, 'Referral Program'),
('Paid Search', '2025-01-01', 8000.00, 'Performance');

-- ---------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------

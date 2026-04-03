# User Activation and Retention Analysis for a SaaS Platform

## Overview
This project analyzes the user journey from signup to activation and long-term retention for a SaaS platform. The goal is to identify onboarding friction, understand which user segments generate stronger long-term value, and recommend actions that can improve activation and Day 30 retention.

This case study is designed to reflect a senior-level product analytics workflow by combining business context, KPI design, SQL analysis, cohort retention measurement, segmentation, and executive-facing recommendations.

## Business Problem
The company is acquiring new users consistently, but leadership has observed weak activation and declining retention after signup. While top-of-funnel performance appears healthy, downstream engagement suggests that many users are not reaching meaningful product value early enough.

The objective of this analysis is to answer three questions:
1. Where are users dropping off during onboarding?
2. Which user segments retain best over time?
3. What actions should the product and growth teams prioritize to improve retention?

## Stakeholders
- Product Manager
- Growth / Lifecycle Marketing Team
- Business Intelligence Team
- Senior Leadership

## Dataset
This project uses a SaaS-style user activity dataset with the following tables:

- `users`
- `events`
- `subscriptions`
- `marketing_spend`

### Example fields
- `users`: user profile, signup date, geography, device type, acquisition channel, plan type
- `events`: user event history such as signup completion, workspace creation, first report creation, logins, and feature usage
- `subscriptions`: trial start, trial end, paid conversion, revenue
- `marketing_spend`: monthly channel-level spend and campaign information

## KPI Definitions
- `Signups`: Total new users created in a selected period
- `Activated Users`: Users who complete both `workspace_created` and `first_report_created` within 7 days of signup
- `Activation Rate`: Activated Users / Signups
- `Median Time to Activate`: Median number of days between signup and activation
- `Day 7 Retention`: Percentage of users active on day 7 after signup
- `Day 30 Retention`: Percentage of users active on day 30 after signup
- `Trial-to-Paid Conversion`: Percentage of trial users who convert to a paid plan
- `Feature Adoption Rate`: Percentage of users who use a selected feature at least once
- `Monthly Active Users (MAU)`: Distinct users active in a given month
- `Churn Proxy`: Users with no activity for 30+ days

## Methodology
The analysis was completed in four stages:

1. Funnel analysis
Measured how users moved from signup through key onboarding milestones to identify the largest drop-off points.

2. Activation analysis
Defined activation based on meaningful product usage and measured activation rates across channels, devices, and plan types.

3. Cohort retention analysis
Built signup cohorts and measured Day 7 and Day 30 retention to understand long-term engagement trends.

4. Segmentation and business recommendations
Compared user segments by acquisition channel, geography, device type, and plan to identify the highest-value users and recommend actions.

## Key Findings
- The largest drop-off occurred between signup completion and the first meaningful product action.
- Users acquired through referral and organic channels showed stronger Day 30 retention than some paid channels.
- Users who completed their first report within the first few days of signup retained at a significantly higher rate.
- Some segments showed strong activation but weaker long-term retention, suggesting that early engagement quality matters more than signup volume alone.
- Trial users from mid-sized companies demonstrated stronger conversion potential than several other segments.

## Recommendations
1. Reduce onboarding friction before the first core product action.
2. Trigger lifecycle nudges for users who fail to activate within the first 3 days.
3. Rebalance acquisition investment toward higher-retention channels.
4. Promote high-value features earlier in the onboarding experience.
5. Run targeted experiments on segments with high activation but weak retention.

## Business Impact
This analysis highlights how improving activation quality, not just acquisition volume, can increase retained users and improve downstream paid conversion. The findings support better product onboarding decisions, more efficient marketing investment, and clearer prioritization for growth initiatives.

## Tools Used
- SQL
- Power BI or Tableau
- Excel
- Python (optional for data generation or exploratory analysis)

## Repository Structure
```text
.
├── README.md
├── data/
├── sql/
├── notebooks/
├── dashboard/
├── images/
├── summary/
└── docs/

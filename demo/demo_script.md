# Clinical Trial Site Operations

**APJ - Multi-site Trial Portfolio**
Use case: Enrollment tracking and risk-based site monitoring

> Site operations for 40 trial sites in a fictional trial portfolio across 5 APJ markets: dynamic tables, a holdout-evaluated important-deviation classifier, an enrollment forecast and grounded AI answers. Synthetic, site-level data only; no patient records.

## Why Snowflake

- **Dynamic tables** reconcile enrollment against plan, screen failures, monitoring signals, important deviations and monitoring visit compliance from RAW site data, with checks in `run_core.py`
- **Important-deviation classification** gives a holdout-evaluated next-7-day probability per site
- **Enrollment forecast** projects 14 days of portfolio enrollment with prediction intervals, for recruitment planning
- **Grounded AI**: the Cortex Agent (Analyst over a semantic view, plus Search over SOPs) shows its SQL and SOP citations
- **Live visit records**: a native simulator (Snowflake only) or Firehose, S3 and Snowpipe (AWS build), then an alert and email

## What is built

| | |
|---|---|
| Dimension table | `RAW.SITES` (40 rows) |
| Fact table | `RAW.SITE_DAILY` (3,600 site-days, 90 days) |
| Curated layer | `CURATED.KPI_SUMMARY`, `PERFORMANCE_SUMMARY`, `SIGNAL_SUMMARY`, `TREND_ANALYSIS` |
| ML | `ML.DEVIATION_RISK_SCORES`, `ML.DEVIATION_RISK_HOLDOUT_METRICS`, `ML.ENROLLMENT_FORECAST`, `ML.QUERY_RATE_ANOMALIES` |

Markets: Singapore, Sydney, Seoul, Tokyo, Taipei.
Therapeutic areas: Oncology, Cardiology, Respiratory, Neurology, Metabolic.

## KPI cards (live from `CURATED.KPI_SUMMARY`; no fallback values)

| Card | Value from the seeded data |
|---|---|
| Enrollment vs Plan | 90.7% |
| Participants Enrolled | 5,109 |
| Screen Failure Rate | 27.5% |
| Signal Confirmation Rate | 27.8% |
| Monitoring Signals | 593 |
| Important Deviations | 165 |
| CAPAs Opened | 83 |
| Monitoring Visit Compliance | 76.8% |
| Sites Active | 40 |
| Essential Document Coverage | 60.0% |
| Essential Documents Pending | 24 |

Values are synthetic. A rebuild reproduces them because the data is HASH-seeded; dates are relative to the build day.

## Demo flow

1. Executive Cockpit: KPIs, daily enrollment against monitoring signals, signals and important deviations by signal type, site table
2. Predictive: holdout metrics, risk bands, 14-day enrollment forecast, data query rate anomalies
3. Site Monitoring: monitoring visit compliance, essential document coverage and pending documents, monitoring compliance against important deviations, then generate the action memo
4. Live Visits: run `CALL APP.SIMULATE_VISITS(20)` (Snowflake only) or `python aws/publish_visits.py --count 20` (AWS build). Then run `EXECUTE ALERT APP.LIVE_VISIT_ALERT` and show the alert log and email.
5. Ask AI: the Cortex Agent answers metric questions through the semantic view and cites SOPs from Cortex Search. The SQL is shown.
6. QuickSight (AWS build): the same Snowflake tables through DIRECT_QUERY
7. Architecture: both builds side by side

## Talking points

- The portfolio is at 90.7% of its 90-day enrollment plan, and 6 sites are below 80% of plan.
- About one monitoring signal in four is confirmed as an important deviation (27.8%). Visit window signals produce the most important deviations. Regional EDC outage signals hit every site in a market at once and are never confirmed.
- The risk model is evaluated on a time-based holdout: precision 0.44 and recall 0.29 at 0.5, against a 0.23 base rate. Present it as triage for monitoring effort, not a verdict on a site.
- Regional EDC outages are excluded from model training, because they are not site-driven.
- This is operational data only. It makes no clinical, safety or efficacy claims and contains no patient records.

## Business impact

Use only the sourced references in `README.md` (Business Impact).

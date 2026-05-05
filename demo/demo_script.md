# Demo Script: Clinical Trial Operations Intelligence
## 4-Minute Recorded Walkthrough
**Format**: Screen recording with voiceover
**Target**: AWS Summit booth / customer meeting / social share

---

## The Story

A VP of Clinical Operations at AsiaPharma discovers their flagship Phase III cardiovascular trial (CARDIO-PREVENT-301) is critically behind schedule. 12 weeks in, only 988 patients enrolled against a target of 3,400. At this rate, they'll miss their FDA submission window. Using the Clinical Trials Intelligence platform, they investigate site performance, match eligible patients, and forecast completion — all from a single Snowflake-powered dashboard.

---

## Two Personas

| Persona | Tool | What they care about |
|---|---|---|
| **VP Clinical Ops** | Streamlit in Snowflake | Enrollment velocity, site ROI, patient matching, forecast |
| **Medical Director** | Amazon QuickSight + Amazon Q | Portfolio view, site comparison, strategic decisions |

---

## What's Built

| Layer | Component | Detail |
|---|---|---|
| **RAW** | 8 tables | 50 trials, 15 sites, 10K patients, 5K enrollments, 20K visits, 2K AEs, 500 criteria, 100 protocols |
| **CURATED** | 3 Dynamic Tables | SITE_PERFORMANCE, PATIENT_ELIGIBILITY, ENROLLMENT_FORECAST_DAILY |
| **AI** | Cortex Search + Agent | Protocol search (100 docs), Cortex Agent (SI) |
| **ML** | FORECAST | Enrollment prediction by trial (24 series, 2160 results) |
| **AWS** | Comprehend Medical + S3 + QuickSight | Entity extraction from criteria, document ingestion, executive analytics |

---

## Narrative Arc: Crisis → Investigation → Discovery → Prediction → Action

---

## Script

### [0:00–0:15] THE CRISIS (Show: Streamlit app, KPI cards)

> "CARDIO-PREVENT-301. Phase III cardiovascular trial. Target enrollment: 3,400 patients across 15 sites in Asia-Pacific. We're 12 weeks in — and we've enrolled 988. That's 29%. At this pace, we miss our FDA submission window by 5 months. Let's investigate."

### [0:15–0:40] GEOSPATIAL MAP (Show: Trial Sites map)

> "15 sites across APJ. The map tells the story immediately — bubble size is enrolled patients, color is enrollment rate. Singapore General is that bright green dot — 93% of target. But look at Tan Tock Seng — barely visible. 15% enrollment, 40% screen-fail rate. One site is carrying the trial. One site is killing it."

### [0:40–1:05] SITE PERFORMANCE (Show: Expand Site Performance Deep Dive)

> "Horizontal bar chart — enrollment rate by site, colored by screen-fail percentage. SGH-001 at the top: 93% enrollment, 12% screen-fail. TTH-003 at the bottom: 15% enrollment, 40% screen-fail. That screen-fail rate tells me the eligibility criteria may be too strict for their patient population. Dynamic Tables refresh this every 5 minutes — no ETL pipelines to maintain."

### [1:05–1:30] PATIENT MATCHING (Show: Expand Patient Matching Engine)

> "Here's the opportunity. The platform matched 1,500+ patients with eligibility scores above 80 who haven't been approached yet. Country-appropriate names, chronic conditions mapped to trial criteria. Patient PAT-00142 — Lim Wei Ming, 62, atrial fibrillation, already on Apixaban. Perfect candidate for CARDIO-PREVENT-301. That's AI-powered patient recruitment — no manual chart review."

### [1:30–1:55] ENROLLMENT FORECAST (Show: Expand Enrollment Forecast)

> "Snowflake ML FORECAST — 14-day prediction for all 24 active trial-site combinations. No Python, no infrastructure. The model already learned that CARDIO-PREVENT-301 is decelerating. Without intervention, we miss target by month 8. But if we activate the matched patients and fix the screen-fail issue at TTH, the model recalculates."

### [1:55–2:20] PROTOCOL SEARCH (Show: Expand Protocol Knowledge Base)

> "Search 'BMI exclusion criteria' — Cortex Search across 100 protocol documents. Instantly surfaces the relevant section: BMI over 45 is excluded. TTH's population skews heavier. The protocol amendment from two weeks ago relaxed this to BMI 50 — but TTH may not have implemented it. That's your root cause."

### [2:20–2:45] AI ASSESSMENT (Show: Expand AI Triage Assessment)

> "One click — Cortex AI reads the trial metrics and generates a triage assessment. Status: AT RISK. Key findings: 29% enrollment, screen-fail concentrated at TTH, protocol amendment not propagated. Recommended actions: activate dormant site outreach, implement amended BMI criteria at TTH, initiate direct patient contact for the 1,500 matched candidates."

### [2:45–3:15] CORTEX ANALYST (Show: Expand Ask the Data)

> "The VP types: 'Which sites have enrollment rates below 30%?' — Cortex Analyst generates SQL against the Semantic View, returns the answer instantly. No BI developer needed. Any stakeholder can ask questions in plain English."

### [3:15–3:40] AMAZON Q (Show: Switch to QuickSight)

> "Different persona, same data. The Medical Director opens Amazon Q in QuickSight: 'Which country has the highest screen-fail rate?' — instant answer, grounded in live Snowflake data. Two personas, one governed platform, zero data copies."

### [3:40–4:00] CLOSE

> "From crisis detection to root cause in under 4 minutes. Dynamic Tables refresh every 5 minutes. ML predicts enrollment trajectory. Cortex Search surfaces protocol details. And Amazon Q gives executives self-service analytics. That's Clinical Trial Operations Intelligence — Snowflake and AWS, better together."

---

## Pre-Recording Checklist

- [ ] Open Streamlit: HEALTHCARE_CLINICAL_TRIALS.APP.CLINICAL_TRIALS_APP
- [ ] Set Phase filter to "Phase III" only
- [ ] Verify map shows sites with green/red color spread
- [ ] Verify KPIs show ~988 enrolled, ~11% screen-fail
- [ ] Test "Protocol Knowledge Base" search: "BMI exclusion"
- [ ] Test "AI Triage Assessment" button for CARDIO-PREVENT-301
- [ ] Open QuickSight: https://us-west-2.quicksight.aws.amazon.com/
- [ ] Test Q topic question: "Which site has the lowest enrollment rate?"

---

## Key Questions to Anticipate

1. **"How does the patient matching work?"** — Eligibility criteria are parsed, chronic conditions are cross-referenced. Comprehend Medical extracts structured entities (conditions, medications, procedures) from free-text criteria. Match score = weighted overlap.

2. **"Is this HIPAA compliant?"** — Synthetic data for demo. In production, Snowflake's governance (row access policies, masking, tags) controls PHI access. Data never leaves Snowflake's security perimeter.

3. **"How often does enrollment data refresh?"** — Dynamic Tables: 5-minute lag. In production with Snowpipe, new enrollments appear within 60 seconds.

4. **"Can this integrate with our CTMS?"** — Yes. Snowflake connects to any CTMS via APIs, file drops (S3), or direct database connectors. The RAW layer accepts any format.

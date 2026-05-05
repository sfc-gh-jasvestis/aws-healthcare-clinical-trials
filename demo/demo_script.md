# Demo Script: Clinical Trial Operations Intelligence
## 4-Minute Recorded Walkthrough
**Format**: Screen recording with voiceover
**Target**: Customer meetings / AWS Summit booth / social share

---

## The Story

A VP of Clinical Operations at AsiaPharma discovers their flagship Phase III cardiovascular trial (CARDIO-PREVENT-301) is critically behind schedule. 1,330 patients enrolled across 4 cardiovascular trials against a combined target well over 10,000. At this rate, they'll miss their FDA submission window. Using the Clinical Trials Intelligence platform, they investigate site performance, match eligible patients, and forecast completion — all from a single Snowflake-powered dashboard.

---

## Opening (before screen recording starts)

> "One of the biggest challenges in clinical trials is enrollment. 80% of trials fail to meet enrollment timelines, and every day of delay costs a pharma company between $600K and $8M in lost revenue. So we built something — let me show you what it looks like when you bring all your trial data into one governed platform and layer AI on top. This is a Phase III cardiovascular trial running across 15 sites in Asia-Pacific. It's behind schedule. Let's find out why — and what to do about it."

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
| **AWS** | Comprehend Medical + S3 + QuickSight | Entity extraction from criteria, document storage, executive analytics |

---

## Narrative Arc: Crisis → Investigation → Discovery → Prediction → Action

---

## Script

### [0:00–0:15] THE CRISIS (Show: Streamlit app, KPI cards — Phase III + Cardiovascular filter)

> "4 active Phase III cardiovascular trials, 15 sites across Asia-Pacific, 1,330 patients enrolled. But CARDIO-PREVENT-301 — our flagship — target is 3,400. We're at 1,052 — not even a third. Screen-fail rate at 8.2%. At this pace, we miss our FDA submission window. Let's find out where the problem is."

### [0:15–0:40] SITE MAP (Show: Trial Sites scatter map)

> "15 sites across APJ. The map tells the story immediately — bubble size is enrolled patients, color is enrollment rate. Singapore General is that dark green cluster — 88% enrollment. But look at Tan Tock Seng — small dot, 17% enrollment, 40% screen-fail rate. One site is carrying the trial. One site is killing it."

### [0:40–1:05] SITE PERFORMANCE (Show: Expand Site Performance Deep Dive)

> "Horizontal bar chart — enrollment rate by site, colored by screen-fail percentage. SGH-001 at the top: 88% enrollment, 6% screen-fail. TTH-003 at the bottom: 17% enrollment, 40% screen-fail. That screen-fail rate tells me the eligibility criteria may be too strict for their patient population. Dynamic Tables refresh this every 5 minutes — no ETL pipelines to maintain."

### [1:05–1:30] PATIENT MATCHING (Show: Expand Patient Matching Engine)

> "Here's the opportunity. The platform matched 881 patients with eligibility scores above 85 who haven't been approached yet. Country-appropriate names, chronic conditions mapped to trial criteria. Patient PAT-00060 — Wei Lee, 52, male, Singapore, atrial fibrillation with hypertension. Perfect candidate for CARDIO-PREVENT-301. That's AI-powered patient recruitment — no manual chart review."

### [1:30–1:55] ENROLLMENT FORECAST (Show: Expand Enrollment Forecast)

> "Snowflake ML FORECAST — cumulative enrollment projection for five trials. No Python, no infrastructure. CARDIO-PREVENT-301 ramps fastest — nearly 200 enrollments projected in the first 90 days. But the other four trials show slower, steadier growth over 2+ years. NEURO-AD-302 and CARDIO-AFIB-301 track to about 130 by mid-2028. Even with CARDIO-PREVENT-301's strong start, it needs sustained momentum. The matched patients and screen-fail fixes at TTH are how we maintain that trajectory."

### [1:55–2:20] PROTOCOL SEARCH (Show: Expand Protocol Knowledge Base)

> "Click 'AF prevention anticoagulation protocol' — Cortex Search across 100 protocol documents. Instantly surfaces the Protocol Synopsis and Amendment for CARDIO-PREVENT-301. The amendment shows age limit was raised from 75 to 80 and BMI relaxed from 40 to 45 — specifically because of screen-fail rates at APJ sites. If TTH hasn't implemented this amendment, that explains their 40% screen-fail. One search, root cause identified."

### [2:20–2:45] AI ASSESSMENT (Show: Expand AI Triage Assessment)

> "One click — Cortex AI reads the trial metrics and generates a triage assessment. Status: AT RISK. Key findings: only 31% enrolled — 1,052 of 3,400 — with 2,348 patients still needed. Screen-fail rate at 8.2% is acceptable overall, but we know from the site chart that TTH is dragging it up locally. Recommended actions: activate additional sites, implement enrollment incentives, conduct site performance review. That's an AI-generated action plan grounded in live data — no analyst needed."

### [2:45–3:15] CORTEX ANALYST (Show: Expand Ask the Data)

> "The VP types: 'Which sites have enrollment rates below 30%?' — Cortex Analyst generates SQL against the Semantic View, returns the answer instantly. No BI developer needed. Any stakeholder can ask questions in plain English."

### [3:15–3:40] AMAZON Q (Show: Switch to QuickSight)

> "Different persona, same data. The Medical Director opens the Clinical Trials dashboard in QuickSight — enrollment rates, screen-fail rates, all live from Snowflake. Then they ask Amazon Q: 'Which site has the highest screen-fail rate?' — instant answer: Tan Tock Seng, 40%. Same conclusion we reached, but from a completely different interface. Two personas, one governed platform, zero data copies."

### [3:40–4:00] CLOSE

> "From crisis detection to root cause in under 4 minutes. Dynamic Tables refresh every 5 minutes. ML predicts enrollment trajectory. Cortex Search surfaces protocol details. And Amazon Q gives executives self-service analytics — all grounded in live Snowflake data. That's Clinical Trial Operations Intelligence — Snowflake and AWS, better together."

---

## Pre-Recording Checklist

- [ ] Open Streamlit: HEALTHCARE_CLINICAL_TRIALS.APP.CLINICAL_TRIALS_APP
- [ ] Set Phase filter to "Phase III" and Therapeutic Area to "Cardiovascular"
- [ ] Verify map shows sites with green/red color spread
- [ ] Verify KPIs show 4 trials, 15 sites, ~1,330 enrolled, 8.2% screen-fail
- [ ] Test "Protocol Knowledge Base" search: "AF prevention anticoagulation protocol"
- [ ] Test "AI Triage Assessment" button for CARDIO-PREVENT-301
- [ ] Open QuickSight: https://us-west-2.quicksight.aws.amazon.com/sn/dashboards/hc-trials-dashboard
- [ ] Test Q topic question: "Which site has the highest screen-fail rate?"

---

## Key Questions to Anticipate

1. **"How does the patient matching work?"** — Eligibility criteria are parsed, chronic conditions are cross-referenced. Comprehend Medical extracts structured entities (conditions, medications, procedures) from free-text criteria. Match score = weighted overlap.

2. **"Is this HIPAA compliant?"** — Synthetic data for demo. In production, Snowflake's governance (row access policies, masking, tags) controls PHI access. Data never leaves Snowflake's security perimeter.

3. **"How often does enrollment data refresh?"** — Dynamic Tables: 5-minute lag. In production with Snowpipe, new enrollments appear within 60 seconds.

4. **"Can this integrate with our CTMS?"** — Yes. Snowflake connects to any CTMS via APIs, file drops (S3), or direct database connectors. The RAW layer accepts any format.

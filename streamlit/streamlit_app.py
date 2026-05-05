import streamlit as st
import pandas as pd
import json
import plotly.express as px
import _snowflake
from snowflake.snowpark.context import get_active_session

session = get_active_session()

st.set_page_config(page_title="Clinical Trial Operations", layout="wide", page_icon="🧬")

st.markdown("""
<style>
div[data-testid="stMetric"] {border: 1px solid #e0e0e0; border-radius: 12px; padding: 16px;}
div[data-testid="stMetric"] label {font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.1em;}
div[data-testid="stExpander"] {border: 1px solid #e0e0e0; border-radius: 8px; margin-bottom: 8px;}
.main-header {background: linear-gradient(135deg, #0d1b2a 0%, #1e5f8a 100%); padding: 1.5rem 2rem; border-radius: 12px; margin-bottom: 1.5rem;}
.main-header h2, .main-header p {color: white !important; margin: 0;}
.main-header h2 {font-size: 1.8rem; margin-bottom: 0.3rem;}
.main-header p {opacity: 0.85; font-size: 0.9rem;}
</style>
""", unsafe_allow_html=True)

st.markdown("""<div class="main-header"><h2>🧬 Clinical Trial Operations Intelligence</h2><p>Enrollment Analytics | Site Performance | Patient Matching | Protocol Search</p></div>""", unsafe_allow_html=True)

with st.sidebar:
    st.markdown("### Filters")
    phase_filter = st.multiselect("Phase", ["Phase I", "Phase II", "Phase III"], default=["Phase III"])
    area_filter = st.multiselect("Therapeutic Area", ["Cardiovascular", "Oncology", "Neurology", "Endocrine", "Respiratory", "Immunology"])
    st.divider()
    st.markdown("### Case Notes")
    st.code("""CARDIO-PREVENT-301
Phase III | Cardiovascular
Sponsor: AsiaPharma Inc
Target: 3,400 patients
Status: AT RISK""", language=None)

phase_clause = "','".join(phase_filter) if phase_filter else "Phase I','Phase II','Phase III"
area_clause = "','".join(area_filter) if area_filter else ""
area_sql = f"AND t.THERAPEUTIC_AREA IN ('{area_clause}')" if area_filter else ""

kpi = session.sql(f"""
    SELECT COUNT(DISTINCT e.TRIAL_ID) AS ACTIVE_TRIALS,
           COUNT(DISTINCT e.SITE_ID) AS ACTIVE_SITES,
           COUNT(CASE WHEN e.STATUS = 'ENROLLED' THEN 1 END) AS TOTAL_ENROLLED,
           COUNT(CASE WHEN e.STATUS = 'SCREEN_FAILED' THEN 1 END) AS SCREEN_FAILS,
           ROUND(COUNT(CASE WHEN e.STATUS = 'SCREEN_FAILED' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0), 1) AS SCREEN_FAIL_PCT
    FROM HEALTHCARE_CLINICAL_TRIALS.RAW.ENROLLMENTS e
    JOIN HEALTHCARE_CLINICAL_TRIALS.RAW.TRIALS t ON e.TRIAL_ID = t.TRIAL_ID
    WHERE t.PHASE IN ('{phase_clause}') {area_sql}
""").to_pandas()

c1, c2, c3, c4, c5 = st.columns(5)
if not kpi.empty:
    c1.metric("Active Trials", f"{kpi['ACTIVE_TRIALS'].iloc[0]}")
    c2.metric("Active Sites", f"{kpi['ACTIVE_SITES'].iloc[0]}")
    c3.metric("Total Enrolled", f"{kpi['TOTAL_ENROLLED'].iloc[0]:,}")
    c4.metric("Screen Fails", f"{kpi['SCREEN_FAILS'].iloc[0]:,}")
    c5.metric("Screen Fail %", f"{kpi['SCREEN_FAIL_PCT'].iloc[0]}%")

st.divider()

site_df = session.sql(f"""
    SELECT s.SITE_ID, s.NAME AS SITE_NAME, s.CITY, s.COUNTRY, s.LAT, s.LON,
           COUNT(CASE WHEN e.STATUS = 'ENROLLED' THEN 1 END) AS ENROLLED,
           COUNT(*) AS TOTAL_SCREENED,
           ROUND(COUNT(CASE WHEN e.STATUS = 'ENROLLED' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0), 1) AS ENROLLMENT_PCT,
           ROUND(COUNT(CASE WHEN e.STATUS = 'SCREEN_FAILED' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0), 1) AS SCREEN_FAIL_PCT
    FROM HEALTHCARE_CLINICAL_TRIALS.RAW.ENROLLMENTS e
    JOIN HEALTHCARE_CLINICAL_TRIALS.RAW.SITES s ON e.SITE_ID = s.SITE_ID
    JOIN HEALTHCARE_CLINICAL_TRIALS.RAW.TRIALS t ON e.TRIAL_ID = t.TRIAL_ID
    WHERE t.PHASE IN ('{phase_clause}') {area_sql}
    GROUP BY s.SITE_ID, s.NAME, s.CITY, s.COUNTRY, s.LAT, s.LON
    ORDER BY ENROLLMENT_PCT DESC
""").to_pandas()

if not site_df.empty:
    for col in ["LAT", "LON", "ENROLLED", "ENROLLMENT_PCT", "SCREEN_FAIL_PCT"]:
        site_df[col] = pd.to_numeric(site_df[col], errors="coerce")
    fig = px.scatter_mapbox(
        site_df, lat="LAT", lon="LON", size="ENROLLED",
        color="ENROLLMENT_PCT", color_continuous_scale="RdYlGn",
        hover_name="SITE_NAME", hover_data=["CITY", "COUNTRY", "ENROLLED", "ENROLLMENT_PCT", "SCREEN_FAIL_PCT"],
        mapbox_style="carto-darkmatter", zoom=2, center={"lat": 15, "lon": 110},
        title="Trial Sites — Enrollment Performance (size=enrolled, color=rate %)"
    )
    fig.update_layout(height=450, margin=dict(t=40, b=10, l=10, r=10))
    st.plotly_chart(fig, use_container_width=True)

with st.expander("📊 Site Performance Deep Dive", expanded=False):
    if not site_df.empty:
        fig_bar = px.bar(site_df.sort_values("ENROLLMENT_PCT", ascending=True),
                         x="ENROLLMENT_PCT", y="SITE_NAME", orientation="h",
                         color="SCREEN_FAIL_PCT", color_continuous_scale="OrRd",
                         title="Enrollment Rate by Site (color = screen-fail %)")
        fig_bar.update_layout(height=400, margin=dict(t=40, b=10))
        st.plotly_chart(fig_bar, use_container_width=True)

with st.expander("🔍 Patient Matching Engine", expanded=False):
    st.markdown("Patients with eligibility score >= 80 who haven't been approached for enrollment:")
    eligible = session.sql("""
        SELECT p.PATIENT_ID, p.FIRST_NAME || ' ' || p.LAST_NAME AS NAME,
               DATEDIFF('year', p.DOB, CURRENT_DATE()) AS AGE, p.GENDER, p.COUNTRY,
               p.CHRONIC_CONDITIONS, pe.ELIGIBILITY_SCORE
        FROM HEALTHCARE_CLINICAL_TRIALS.CURATED.PATIENT_ELIGIBILITY pe
        JOIN HEALTHCARE_CLINICAL_TRIALS.RAW.PATIENTS p ON pe.PATIENT_ID = p.PATIENT_ID
        WHERE pe.ELIGIBILITY_SCORE >= 80 AND pe.APPROACH_STATUS = 'NOT_APPROACHED'
        ORDER BY pe.ELIGIBILITY_SCORE DESC
        LIMIT 20
    """).to_pandas()
    if not eligible.empty:
        st.metric("High-Score Unapproached Patients", f"{len(eligible)}+ (showing top 20)")
        st.dataframe(eligible, use_container_width=True)

with st.expander("📈 Enrollment Forecast", expanded=False):
    forecast = session.sql("""
        SELECT SERIES AS TRIAL, TS AS FORECAST_DATE, ROUND(FORECAST, 0) AS PREDICTED_ENROLLMENTS
        FROM HEALTHCARE_CLINICAL_TRIALS.ML.ENROLLMENT_FORECAST_RESULTS
        ORDER BY SERIES, TS
    """).to_pandas()
    if not forecast.empty:
        forecast["PREDICTED_ENROLLMENTS"] = pd.to_numeric(forecast["PREDICTED_ENROLLMENTS"], errors="coerce")
        fig_fc = px.line(forecast, x="FORECAST_DATE", y="PREDICTED_ENROLLMENTS", color="TRIAL",
                         title="14-Day Enrollment Forecast by Trial (Snowflake ML)")
        fig_fc.update_layout(height=350, margin=dict(t=40, b=10))
        st.plotly_chart(fig_fc, use_container_width=True)

with st.expander("📚 Protocol Knowledge Base (Cortex Search)", expanded=False):
    st.markdown("Search trial protocols and eligibility criteria:")
    samples = ["heart failure inclusion criteria", "exclusion criteria BMI", "informed consent withdrawal process"]
    cols = st.columns(3)
    selected = None
    for i, s in enumerate(samples):
        with cols[i]:
            if st.button(s, key=f"s_{i}", use_container_width=True):
                selected = s
    query = st.text_input("Or type your search:", placeholder="e.g., anticoagulation therapy requirements") or selected
    if query:
        with st.spinner("Searching protocols..."):
            try:
                safe_q = query.replace("'", "''").replace('"', '\\"')
                raw = session.sql(f"""
                    SELECT SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
                        'HEALTHCARE_CLINICAL_TRIALS.SEARCH.PROTOCOL_SEARCH',
                        '{{"query": "{safe_q}", "columns": ["CONTENT", "TITLE", "CATEGORY"], "limit": 5}}'
                    ) AS RESULTS
                """).collect()[0][0]
                results = json.loads(raw) if isinstance(raw, str) else raw
                for r in results.get("results", []):
                    st.markdown(f"**{r.get('TITLE', 'Document')}** ({r.get('CATEGORY', '')})")
                    st.caption(r.get("CONTENT", "")[:300] + "...")
                    st.divider()
            except Exception as e:
                st.error(f"Search error: {e}")

with st.expander("🤖 AI Triage Assessment", expanded=False):
    trial_id = st.selectbox("Select Trial", ["CARDIO-PREVENT-301", "ONCO-BREAST-201", "NEURO-ALZH-102"])
    if st.button("Generate AI Assessment", type="primary"):
        with st.spinner("Cortex AI analyzing trial status..."):
            try:
                trial_data = session.sql(f"""
                    SELECT t.TITLE, t.PHASE, t.TARGET_ENROLLMENT, t.THERAPEUTIC_AREA,
                           COUNT(CASE WHEN e.STATUS='ENROLLED' THEN 1 END) AS ENROLLED,
                           ROUND(COUNT(CASE WHEN e.STATUS='SCREEN_FAILED' THEN 1 END)*100.0/NULLIF(COUNT(*),0),1) AS SCREEN_FAIL_PCT
                    FROM HEALTHCARE_CLINICAL_TRIALS.RAW.TRIALS t
                    LEFT JOIN HEALTHCARE_CLINICAL_TRIALS.RAW.ENROLLMENTS e ON t.TRIAL_ID = e.TRIAL_ID
                    WHERE t.TRIAL_ID = '{trial_id}'
                    GROUP BY t.TITLE, t.PHASE, t.TARGET_ENROLLMENT, t.THERAPEUTIC_AREA
                """).to_pandas()
                if not trial_data.empty:
                    row = trial_data.iloc[0]
                    prompt = f"You are a clinical operations analyst. Assess this trial: {row['TITLE']} ({row['PHASE']}), {row['THERAPEUTIC_AREA']}. Target: {row['TARGET_ENROLLMENT']} patients. Currently enrolled: {row['ENROLLED']}. Screen-fail rate: {row['SCREEN_FAIL_PCT']}%. Provide: 1) Status (ON_TRACK/AT_RISK/CRITICAL), 2) Key findings (3 bullets), 3) Recommended actions (3 bullets). Be concise."
                    safe = prompt.replace("'", "''")
                    result = session.sql(f"SELECT SNOWFLAKE.CORTEX.COMPLETE('claude-sonnet-4-5', '{safe}')").collect()[0][0]
                    answer = str(result).replace('\\$', '$')
                    st.markdown(answer)
            except Exception as e:
                st.error(f"AI error: {e}")

with st.expander("💬 Ask the Data (Cortex Analyst)", expanded=False):
    st.markdown("Ask natural language questions about clinical trial data:")
    sample_qs = ["Which sites have the lowest enrollment rate?", "What is the screen-fail rate by therapeutic area?", "How many patients are enrolled in Phase III trials?"]
    sel_q = st.selectbox("Sample questions:", [""] + sample_qs)
    user_q = st.text_input("Or type your question:") or sel_q
    if user_q:
        with st.spinner("Cortex Analyst generating SQL..."):
            try:
                request_body = {
                    "messages": [{"role": "user", "content": [{"type": "text", "text": user_q}]}],
                    "semantic_view": "HEALTHCARE_CLINICAL_TRIALS.AI.CLINICAL_TRIALS_SEMANTIC_VIEW"
                }
                resp = _snowflake.send_snow_api_request("POST", "/api/v2/cortex/analyst/message", {}, {}, request_body, None, 30000)
                parsed = json.loads(resp["content"])
                if resp["status"] < 400:
                    for block in parsed.get("message", {}).get("content", []):
                        if block.get("type") == "text":
                            st.markdown(block.get("text", ""))
                        elif block.get("type") == "sql":
                            sql = block.get("statement", "")
                            with st.expander("Generated SQL", expanded=False):
                                st.code(sql, language="sql")
                            try:
                                answer_df = session.sql(sql).to_pandas()
                                st.dataframe(answer_df, use_container_width=True)
                            except Exception as sql_err:
                                st.warning(f"SQL execution error: {sql_err}")
                else:
                    st.error(f"Analyst error: {parsed.get('message', 'Unknown')}")
            except Exception as e:
                st.error(f"Error: {e}")

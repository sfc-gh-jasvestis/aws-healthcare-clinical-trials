------------------------------------------------------------------------
-- Clinical Trial Operations: Cortex Agent for Snowflake Intelligence
------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;
USE DATABASE HEALTHCARE_CLINICAL_TRIALS;
USE SCHEMA APP;

CREATE OR REPLACE CORTEX AGENT CLINICAL_TRIALS_AGENT
  COMMENT = 'Clinical trial operations assistant for enrollment tracking, site performance, and protocol questions'
  SEMANTIC_VIEWS = ('HEALTHCARE_CLINICAL_TRIALS.APP.CLINICAL_TRIALS_SEMANTIC')
  CORTEX_SEARCH_SERVICES = ('HEALTHCARE_CLINICAL_TRIALS.SEARCH.PROTOCOL_SEARCH')
  INSTRUCTIONS = 'You are a clinical trial operations assistant. Help users understand enrollment progress, site performance metrics, patient eligibility, and protocol details. When asked about enrollment targets, always compare current enrollment against the target and express as a percentage. For site performance, highlight both top performers and underperformers. When discussing protocols, search the protocol documents for specific details. Key context: The hero trial is CARDIO-PREVENT-301 (Phase III Cardiovascular) with a target of 3400 patients, currently at approximately 31% enrollment. Top-performing site is SGH (Singapore General Hospital) and underperforming site is TTSH (Tan Tock Seng Hospital).';

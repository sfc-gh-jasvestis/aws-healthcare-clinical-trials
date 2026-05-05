------------------------------------------------------------------------
-- Clinical Trial Operations: Cortex Search Service
------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;
USE DATABASE HEALTHCARE_CLINICAL_TRIALS;
USE SCHEMA SEARCH;

CREATE OR REPLACE CORTEX SEARCH SERVICE PROTOCOL_SEARCH
  ON CONTENT
  ATTRIBUTES TRIAL_ID, DOCUMENT_TYPE, TITLE
  WAREHOUSE = COMPUTE_WH
  TARGET_LAG = '1 hour'
AS (
    SELECT
        DOCUMENT_ID,
        TRIAL_ID,
        DOCUMENT_TYPE,
        TITLE,
        CONTENT,
        VERSION,
        EFFECTIVE_DATE
    FROM RAW.PROTOCOL_DOCUMENTS
);

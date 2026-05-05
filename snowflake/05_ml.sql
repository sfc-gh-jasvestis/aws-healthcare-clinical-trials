------------------------------------------------------------------------
-- Clinical Trial Operations: ML Forecast Model
------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;
USE DATABASE HEALTHCARE_CLINICAL_TRIALS;
USE SCHEMA ML;

------------------------------------------------------------------------
-- View for ML input (daily enrollment time series by trial)
------------------------------------------------------------------------
CREATE OR REPLACE VIEW ENROLLMENT_TIMESERIES AS
SELECT
    TRIAL_ID,
    FORECAST_DATE,
    DAILY_ENROLLMENTS
FROM CURATED.ENROLLMENT_FORECAST_DAILY
WHERE FORECAST_DATE IS NOT NULL
ORDER BY TRIAL_ID, FORECAST_DATE;

------------------------------------------------------------------------
-- Forecast model: predict enrollment 90 days out per trial
------------------------------------------------------------------------
CREATE OR REPLACE SNOWFLAKE.ML.FORECAST ENROLLMENT_FORECAST_MODEL(
    INPUT_DATA => SYSTEM$REFERENCE('VIEW', 'ENROLLMENT_TIMESERIES'),
    SERIES_COLNAME => 'TRIAL_ID',
    TIMESTAMP_COLNAME => 'FORECAST_DATE',
    TARGET_COLNAME => 'DAILY_ENROLLMENTS',
    CONFIG_OBJECT => {'ON_ERROR': 'SKIP'}
);

------------------------------------------------------------------------
-- Results table: store forecast output
------------------------------------------------------------------------
CREATE OR REPLACE TABLE ENROLLMENT_FORECAST_RESULTS AS
SELECT *
FROM TABLE(ENROLLMENT_FORECAST_MODEL!FORECAST(
    FORECASTING_PERIODS => 90,
    CONFIG_OBJECT => {'prediction_interval': 0.95}
));

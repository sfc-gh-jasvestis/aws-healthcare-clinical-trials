------------------------------------------------------------------------
-- Clinical Trial Operations: Semantic View
------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;
USE DATABASE HEALTHCARE_CLINICAL_TRIALS;
USE SCHEMA APP;

CREATE OR REPLACE SEMANTIC VIEW CLINICAL_TRIALS_SEMANTIC
  COMMENT = 'Semantic model for clinical trial operations analytics'
AS
  TABLES (
    RAW.TRIALS AS TRIALS
      PRIMARY KEY (TRIAL_ID)
      WITH COLUMNS (
        TRIAL_ID COMMENT 'Unique trial identifier',
        TRIAL_NAME COMMENT 'Full name of the clinical trial',
        PHASE COMMENT 'Trial phase (Phase I, II, III)',
        THERAPEUTIC_AREA COMMENT 'Disease category (Cardiovascular, Oncology, etc.)',
        INDICATION COMMENT 'Specific disease indication',
        SPONSOR COMMENT 'Sponsoring pharmaceutical company',
        STATUS COMMENT 'Current trial status',
        TARGET_ENROLLMENT COMMENT 'Target number of patients to enroll',
        START_DATE COMMENT 'Trial start date',
        EXPECTED_END_DATE COMMENT 'Expected completion date'
      ),
    RAW.SITES AS SITES
      PRIMARY KEY (SITE_ID)
      WITH COLUMNS (
        SITE_ID COMMENT 'Unique site identifier',
        SITE_NAME COMMENT 'Research site name',
        HOSPITAL_NAME COMMENT 'Hospital name',
        CITY COMMENT 'City location',
        COUNTRY COMMENT 'Country',
        PI_NAME COMMENT 'Principal investigator name'
      ),
    RAW.ENROLLMENTS AS ENROLLMENTS
      PRIMARY KEY (ENROLLMENT_ID)
      WITH COLUMNS (
        ENROLLMENT_ID COMMENT 'Unique enrollment identifier',
        PATIENT_ID COMMENT 'Patient identifier',
        TRIAL_ID COMMENT 'Trial identifier' REFERENCES TRIALS(TRIAL_ID),
        SITE_ID COMMENT 'Site identifier' REFERENCES SITES(SITE_ID),
        ENROLLMENT_DATE COMMENT 'Date patient enrolled',
        STATUS COMMENT 'Enrollment status: ENROLLED, SCREEN_FAILED, WITHDRAWN, COMPLETED',
        SCREEN_RESULT COMMENT 'Screening outcome: PASSED or FAILED'
      ),
    CURATED.SITE_PERFORMANCE AS SITE_PERFORMANCE
      PRIMARY KEY (SITE_ID)
      WITH COLUMNS (
        SITE_ID COMMENT 'Site identifier' REFERENCES SITES(SITE_ID),
        SITE_NAME COMMENT 'Site name',
        TOTAL_ENROLLMENTS COMMENT 'Total enrollment attempts at site',
        ACTIVE_ENROLLMENTS COMMENT 'Currently enrolled patients at site',
        ENROLLMENT_RATE COMMENT 'Percentage of enrollments that are active',
        SCREEN_FAIL_RATE COMMENT 'Percentage of screen failures',
        MONTHLY_ENROLLMENT_RATE COMMENT 'Average monthly enrollment rate'
      )
  )
  RELATIONSHIPS (
    ENROLLMENTS(TRIAL_ID) REFERENCES TRIALS(TRIAL_ID),
    ENROLLMENTS(SITE_ID) REFERENCES SITES(SITE_ID),
    SITE_PERFORMANCE(SITE_ID) REFERENCES SITES(SITE_ID)
  )
  METRICS (
    TOTAL_ENROLLED AS COUNT(ENROLLMENTS.ENROLLMENT_ID)
      WHERE ENROLLMENTS.STATUS = 'ENROLLED'
      COMMENT 'Total number of enrolled patients',
    TOTAL_SCREEN_FAILURES AS COUNT(ENROLLMENTS.ENROLLMENT_ID)
      WHERE ENROLLMENTS.STATUS = 'SCREEN_FAILED'
      COMMENT 'Total number of screen failures',
    AVG_ENROLLMENT_RATE AS AVG(SITE_PERFORMANCE.ENROLLMENT_RATE)
      COMMENT 'Average enrollment rate across sites',
    ENROLLMENT_VS_TARGET AS
      COUNT(ENROLLMENTS.ENROLLMENT_ID) WHERE ENROLLMENTS.STATUS = 'ENROLLED'
      COMMENT 'Enrollment count for measuring against targets'
  );

------------------------------------------------------------------------
-- Clinical Trial Operations: Integrations
-- S3 Storage Integration, Comprehend Medical EAI, UDF
------------------------------------------------------------------------

USE ROLE ACCOUNTADMIN;
USE DATABASE HEALTHCARE_CLINICAL_TRIALS;
USE SCHEMA RAW;

------------------------------------------------------------------------
-- Storage Integration (references shared integration)
------------------------------------------------------------------------
-- HEALTHCARE_DEMOS_S3_INTEGRATION already created at account level
-- pointing to s3://sg-healthcare-demos-2026/

------------------------------------------------------------------------
-- External Access Integration: AWS Comprehend Medical
------------------------------------------------------------------------
CREATE OR REPLACE NETWORK RULE COMPREHEND_MEDICAL_RULE
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('comprehendmedical.us-west-2.amazonaws.com');

CREATE OR REPLACE SECRET HEALTHCARE_CLINICAL_TRIALS.RAW.AWS_COMPREHEND_CREDENTIALS
  TYPE = GENERIC_STRING
  SECRET_STRING = '{"aws_access_key_id": "<PLACEHOLDER>", "aws_secret_access_key": "<PLACEHOLDER>"}';

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION COMPREHEND_MEDICAL_EAI
  ALLOWED_NETWORK_RULES = (COMPREHEND_MEDICAL_RULE)
  ALLOWED_AUTHENTICATION_SECRETS = (HEALTHCARE_CLINICAL_TRIALS.RAW.AWS_COMPREHEND_CREDENTIALS)
  ENABLED = TRUE;

------------------------------------------------------------------------
-- UDF: Extract Medical Entities via Comprehend Medical
------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION HEALTHCARE_CLINICAL_TRIALS.AI.EXTRACT_MEDICAL_ENTITIES(text_input VARCHAR)
RETURNS VARIANT
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('boto3', 'snowflake-snowpark-python')
HANDLER = 'extract_entities'
EXTERNAL_ACCESS_INTEGRATIONS = (COMPREHEND_MEDICAL_EAI)
SECRETS = ('aws_creds' = HEALTHCARE_CLINICAL_TRIALS.RAW.AWS_COMPREHEND_CREDENTIALS)
AS
$$
import json
import boto3
import _snowflake

def extract_entities(text_input):
    creds = json.loads(_snowflake.get_generic_secret_string('aws_creds'))
    client = boto3.client(
        'comprehendmedical',
        region_name='us-west-2',
        aws_access_key_id=creds['aws_access_key_id'],
        aws_secret_access_key=creds['aws_secret_access_key']
    )
    response = client.detect_entities_v2(Text=text_input[:20000])
    entities = []
    for entity in response.get('Entities', []):
        entities.append({
            'text': entity['Text'],
            'category': entity['Category'],
            'type': entity['Type'],
            'score': entity['Score'],
            'traits': [t['Name'] for t in entity.get('Traits', [])]
        })
    return entities
$$;

------------------------------------------------------------------------
-- S3 Stage
------------------------------------------------------------------------
CREATE OR REPLACE STAGE HEALTHCARE_CLINICAL_TRIALS.RAW.CLINICAL_TRIALS_STAGE
  STORAGE_INTEGRATION = HEALTHCARE_DEMOS_S3_INTEGRATION
  URL = 's3://sg-healthcare-demos-2026/clinical-trials/'
  FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

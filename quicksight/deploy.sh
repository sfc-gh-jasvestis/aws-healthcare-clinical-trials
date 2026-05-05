#!/bin/bash
########################################################################
# QuickSight Deployment: Clinical Trial Operations
# Creates datasets and Q topic for healthcare-snowflake-ds data source
########################################################################

set -euo pipefail

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-west-2"
DATA_SOURCE_ID="healthcare-snowflake-ds"
NAMESPACE="default"

echo "=== Deploying QuickSight resources for Clinical Trials ==="

# Dataset 1: Trial Sites Performance
echo "Creating dataset: hc-trials-sites..."
aws quicksight create-data-set \
  --aws-account-id "$AWS_ACCOUNT_ID" \
  --data-set-id "hc-trials-sites" \
  --name "Healthcare - Clinical Trial Sites" \
  --import-mode DIRECT_QUERY \
  --physical-table-map '{
    "TrialSites": {
      "CustomSql": {
        "DataSourceArn": "arn:aws:quicksight:'$REGION':'$AWS_ACCOUNT_ID':datasource/'$DATA_SOURCE_ID'",
        "Name": "trial_sites",
        "SqlQuery": "SELECT sp.*, t.TRIAL_NAME, t.PHASE, t.THERAPEUTIC_AREA, t.TARGET_ENROLLMENT FROM HEALTHCARE_CLINICAL_TRIALS.CURATED.SITE_PERFORMANCE sp LEFT JOIN HEALTHCARE_CLINICAL_TRIALS.RAW.TRIALS t ON 1=1 WHERE t.TRIAL_ID = '\''CARDIO-PREVENT-301'\''",
        "Columns": [
          {"Name": "SITE_ID", "Type": "STRING"},
          {"Name": "SITE_NAME", "Type": "STRING"},
          {"Name": "HOSPITAL_NAME", "Type": "STRING"},
          {"Name": "CITY", "Type": "STRING"},
          {"Name": "COUNTRY", "Type": "STRING"},
          {"Name": "LATITUDE", "Type": "DECIMAL"},
          {"Name": "LONGITUDE", "Type": "DECIMAL"},
          {"Name": "TOTAL_ENROLLMENTS", "Type": "INTEGER"},
          {"Name": "ACTIVE_ENROLLMENTS", "Type": "INTEGER"},
          {"Name": "ENROLLMENT_RATE", "Type": "DECIMAL"},
          {"Name": "SCREEN_FAIL_RATE", "Type": "DECIMAL"},
          {"Name": "MONTHLY_ENROLLMENT_RATE", "Type": "DECIMAL"},
          {"Name": "TRIAL_NAME", "Type": "STRING"},
          {"Name": "PHASE", "Type": "STRING"},
          {"Name": "THERAPEUTIC_AREA", "Type": "STRING"},
          {"Name": "TARGET_ENROLLMENT", "Type": "INTEGER"}
        ]
      }
    }
  }' \
  --permissions '[{
    "Principal": "arn:aws:quicksight:'$REGION':'$AWS_ACCOUNT_ID':user/'$NAMESPACE'/QUICKSIGHT_HEALTHCARE_SVC",
    "Actions": ["quicksight:DescribeDataSet","quicksight:DescribeDataSetPermissions","quicksight:PassDataSet","quicksight:DescribeIngestion","quicksight:ListIngestions"]
  }]' \
  --region "$REGION"

# Dataset 2: Enrollment Forecast
echo "Creating dataset: hc-trials-forecast..."
aws quicksight create-data-set \
  --aws-account-id "$AWS_ACCOUNT_ID" \
  --data-set-id "hc-trials-forecast" \
  --name "Healthcare - Enrollment Forecast" \
  --import-mode DIRECT_QUERY \
  --physical-table-map '{
    "Forecast": {
      "CustomSql": {
        "DataSourceArn": "arn:aws:quicksight:'$REGION':'$AWS_ACCOUNT_ID':datasource/'$DATA_SOURCE_ID'",
        "Name": "enrollment_forecast",
        "SqlQuery": "SELECT * FROM HEALTHCARE_CLINICAL_TRIALS.ML.ENROLLMENT_FORECAST_RESULTS",
        "Columns": [
          {"Name": "TRIAL_ID", "Type": "STRING"},
          {"Name": "TS", "Type": "DATETIME"},
          {"Name": "FORECAST", "Type": "DECIMAL"},
          {"Name": "LOWER_BOUND", "Type": "DECIMAL"},
          {"Name": "UPPER_BOUND", "Type": "DECIMAL"}
        ]
      }
    }
  }' \
  --permissions '[{
    "Principal": "arn:aws:quicksight:'$REGION':'$AWS_ACCOUNT_ID':user/'$NAMESPACE'/QUICKSIGHT_HEALTHCARE_SVC",
    "Actions": ["quicksight:DescribeDataSet","quicksight:DescribeDataSetPermissions","quicksight:PassDataSet","quicksight:DescribeIngestion","quicksight:ListIngestions"]
  }]' \
  --region "$REGION"

# Q Topic
echo "Creating Q topic: hc-clinical-trials-q..."
aws quicksight create-topic \
  --aws-account-id "$AWS_ACCOUNT_ID" \
  --topic-id "hc-clinical-trials-q" \
  --topic '{
    "Name": "Clinical Trial Operations",
    "Description": "Ask questions about clinical trial enrollment, site performance, and forecasts",
    "DataSets": [
      {
        "DatasetArn": "arn:aws:quicksight:'$REGION':'$AWS_ACCOUNT_ID':dataset/hc-trials-sites",
        "DatasetName": "Healthcare - Clinical Trial Sites"
      },
      {
        "DatasetArn": "arn:aws:quicksight:'$REGION':'$AWS_ACCOUNT_ID':dataset/hc-trials-forecast",
        "DatasetName": "Healthcare - Enrollment Forecast"
      }
    ]
  }' \
  --region "$REGION"

echo "=== QuickSight deployment complete ==="
echo "Datasets: hc-trials-sites, hc-trials-forecast"
echo "Q Topic: hc-clinical-trials-q"

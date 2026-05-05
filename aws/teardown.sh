#!/bin/bash
########################################################################
# Teardown: Remove all AWS resources for Clinical Trial Operations demo
########################################################################

set -euo pipefail

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-west-2"

echo "=== Tearing down Clinical Trials AWS resources ==="

# Delete Q Topic
echo "Deleting Q topic..."
aws quicksight delete-topic \
  --aws-account-id "$AWS_ACCOUNT_ID" \
  --topic-id "hc-clinical-trials-q" \
  --region "$REGION" 2>/dev/null || echo "  Q topic not found, skipping"

# Delete Datasets
echo "Deleting datasets..."
aws quicksight delete-data-set \
  --aws-account-id "$AWS_ACCOUNT_ID" \
  --data-set-id "hc-trials-sites" \
  --region "$REGION" 2>/dev/null || echo "  Dataset hc-trials-sites not found, skipping"

aws quicksight delete-data-set \
  --aws-account-id "$AWS_ACCOUNT_ID" \
  --data-set-id "hc-trials-forecast" \
  --region "$REGION" 2>/dev/null || echo "  Dataset hc-trials-forecast not found, skipping"

# Clear Snowflake secret (set to placeholder)
echo "Resetting Snowflake secret to placeholder..."
cat <<'SQL'
-- Run in Snowflake to reset the secret:
USE ROLE ACCOUNTADMIN;
ALTER SECRET HEALTHCARE_CLINICAL_TRIALS.RAW.AWS_COMPREHEND_CREDENTIALS
  SET SECRET_STRING = '{"aws_access_key_id": "<PLACEHOLDER>", "aws_secret_access_key": "<PLACEHOLDER>"}';
SQL

echo ""
echo "=== AWS teardown complete ==="
echo ""
echo "To fully remove Snowflake resources, run:"
echo "  USE ROLE ACCOUNTADMIN;"
echo "  DROP DATABASE IF EXISTS HEALTHCARE_CLINICAL_TRIALS CASCADE;"

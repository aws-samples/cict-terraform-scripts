#/bin/bash

echo ""
echo "[INFO] ------- Executing  Checkov Script -------"

echo ""
echo "[INFO] ------- Entering ${BASE_PATH}/${dir} directory -------"
cd ${BASE_PATH}/${dir}

echo ""
echo "[INFO] ------- Running Checkov command -------"
# checkov -f tf.json --repo-root-for-plan-enrichment $PWD -s   
checkov -f tf.json --repo-root-for-plan-enrichment $PWD --framework terraform_plan --hard-fail-on HARD_FAIL_ON
checkov -f tf.json --repo-root-for-plan-enrichment $PWD --output junitxml 
checkov -f tf.json --repo-root-for-plan-enrichment $PWD --output junitxml > checkov_results.xml

echo "[INFO] ------- Exiting ------- "
echo ""
echo "------- ------- ------- ------- ------- ------- "
#!/bin/bash
set -e

# Run terratest
echo ""
echo "[INFO] ------- Running Terratest -------"

echo ""
echo "[INFO] ------- Downloding GO modules -------"
echo ""

go get -v "github.com/gruntwork-io/terratest/modules/aws" \
  "github.com/gruntwork-io/terratest/modules/terraform" \
  "github.com/stretchr/testify/assert" \
  "strings" \
  "testing" \
  "fmt" \
  "github.com/gruntwork-io/terratest/modules/random" 

echo "[INFO] TIMESTAMP: " 
date
echo ""

mkdir -p ${BASE_PATH}/${dir}/test/reports

go test ${BASE_PATH}/${dir}/test/cict_test.go -timeout 10m -v | tee ${BASE_PATH}/${dir}/test/reports/test_output.log
retcode=${PIPESTATUS[0]}

echo "[INFO] ------- Creating Logs -------"
terratest_log_parser -testlog ${BASE_PATH}/${dir}/test/reports/test_output.log -outputdir ${BASE_PATH}/${dir}/test/reports

echo ""
echo "[INFO] ------- Exiting ------- "
echo ""
echo "------- ------- ------- ------- ------- ------- "

exit ${retcode}
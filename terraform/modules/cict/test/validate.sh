#/bin/bash

set -e

echo ""
echo "[INFO] ------- Executing  Terraform Validate Script -------"

echo ""
echo "[INFO] ------- Entering ${BASE_PATH}/${dir} directory -------"
cd ${BASE_PATH}/${dir}

echo ""
echo "[INFO] ------- Running terraform fmt command -------"
echo ""
terraform fmt -diff -recursive -write=false

#- Exit with non-zero status code -#
#terraform fmt -diff -recursive -write=false -check

echo ""
echo "[INFO] ------- Initializing Terraform  -------"
echo ""
terraform init

echo ""
echo "[INFO] ------- Validating Terraform scripts -------"
echo ""

terraform validate

terraform validate -json

terraform validate -json > validate.json

echo ""
echo "[INFO] ------- Creating Terraform Plan in JSON for Checkov  -------"
echo ""
terraform plan -out tf.plan
terraform show -json tf.plan | jq '.' > tf.json

# terraform show -json tf.plan  > tf.json 

echo ""
echo "[INFO] ------- tf.json created for checkov -------"

echo "[INFO] ------- Exiting ------- "
echo ""
echo "------- ------- ------- ------- ------- ------- "
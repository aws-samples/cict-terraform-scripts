#/bin/bash

set -e

echo ""
echo "[INFO] ------- Executing  TF-LINT Script -------"

echo ""
echo "[INFO] ------- Entering ${BASE_PATH}/${dir} directory -------"
cd ${BASE_PATH}/${dir}

cat .tflint.hcl

echo ""
echo "[INFO] ------- Running tflint --init command ------- "
echo ""
tflint --init

echo ""
echo "[INFO] ------- Running tflint command ------- "
echo ""

#-ERROR-#
tflint  --force
tflint  --force --format=junit  > tflint.xml 

#-PASS-#
# tflint  --force --var-file=inventories/variables.tfvars 
# tflint  --force --var-file=inventories/variables.tfvars  --format=junit > tflint.xml

echo "[INFO] ------- Exiting ------- "
echo ""
echo "------- ------- ------- ------- ------- ------- "
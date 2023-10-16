#!/bin/bash

set -e

echo ""
echo "[INFO] ------- Executing: ${BASE_PATH}/terratest.sh Script-------"
echo ""

# Run terratest
for dir in $(find ${BASE_PATH} -maxdepth 1 -mindepth 1 -type d -printf '%f\n'); do
  if [[ -f "${BASE_PATH}/${dir}/test/terratest.sh" ]]; then
    export dir=${dir}
    echo "[INFO] ------- Printing dir variable value: ${dir} -------"
    ls -la
    ./${BASE_PATH}/${dir}/test/terratest.sh
  fi
done
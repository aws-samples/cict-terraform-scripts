#/bin/bash

rm *.out

DELETE_ALL=${1}

TFVARS_FILE="inventories/variables.tfvars"

export AWS_SDK_LOAD_CONFIG="true"

terraform init -input=false
terraform validate
retcode=$?
if [[  $retcode != 0 ]]; then 
    exit $retcode
fi

if [[ -z ${DELETE_ALL} ]]; then
    continue 
elif [[ ${DELETE_ALL^^} == "destroy" ]]; then
    terraform output | grep -i S3_bucket
    read -p "Confirm that you have empty the S3 bucket"
    echo "[INFO] destroy all"
    terraform destroy -var-file ${TFVARS_FILE}
    exit 0
else 
    echo "[ERROR] Value not recognised"
    echo "[ERROR] ./run_terraform.sh [destroy]"
    exit 1
fi

echo "terraform plan -var-file ${TFVARS_FILE} -out plan.out"
terraform plan -var-file ${TFVARS_FILE} -out plan.out
retcode=$?
if [[  $retcode != 0 ]]; then 
    exit $retcode
fi

read -p "Do you want to apply? Yes/No: " answer

if [[ ${answer^^} == "YES" ]]; then
    terraform apply plan.out
    retcode=$?
    if [[ $retcode != 0 ]]; then
        echo "[ERROR] Missing AWS credentials variables"
    fi
else
    echo "Exiting..."
    exit 0
fi

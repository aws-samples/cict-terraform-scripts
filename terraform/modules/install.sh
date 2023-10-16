#!/bin/bash

set -e

eval $(ssh-agent)
echo "SSH_AUTH_SOCK ${SSH_AUTH_SOCK}"
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
cd /tmp
echo "Installing Terraform"
curl -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && mv terraform /usr/bin
terraform --version
echo "Installing Terratest Log Parser"
curl --location --silent --fail --show-error -o terratest_log_parser https://github.com/gruntwork-io/terratest/releases/download/v0.13.13/terratest_log_parser_linux_amd64
chmod +x terratest_log_parser
mv terratest_log_parser /usr/local/bin
terratest_log_parser --version

# Addition for tflint
echo "Installing tflint"
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash


# Addition for checkov 

echo "Installing Checkov"
#yes | pip3 install --upgrade pip
#yes | pip3 install --upgrade setuptools 
yes | pip3 install checkov
cd -

# Adding Tree #
# sudo apt-get install tree jq -y 
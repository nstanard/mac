#!/bin/bash

# AWS CLI IS AVAILABLE THROUGH BREW
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html#cliv2-mac-install-cmd-current-user
# AWS - analyst-ng
AWS_PACKAGE="AWSCLIV2.pkg"
AWS_DOWNLOAD_LINK="https://awscli.amazonaws.com/$AWS_PACKAGE"
echo ""
read -p "Would you like to configure AWS-CLI for Analyst-NG? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  # sudo curl -o "/tmp/${AWS_DOWNLOAD_LINK##*/}" "$AWS_DOWNLOAD_LINK"
  # sudo installer -pkg "/tmp/$AWS_PACKAGE" -target /
  echo "use output=json and region=us-east-1"
  aws configure
fi

#!/bin/bash

echo ""
read -p "Would you like to copy the configs over to /opt/configs for Analyst-NG? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  sudo tar -xf "$LAPTOP_REPO/analyst.conf/configs.tar.gz" -C "/opt/" --strip-components=1
fi

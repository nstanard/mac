#!/bin/bash

echo ""
read -p "Would you like to configure node/npm for analyst-ng? (node@10.17.0 and npm@6.9.0) [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  sudo n 10.17.0;
  sudo npm i -g npm@6.9.0;
fi

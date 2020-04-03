#!/bin/bash

hostname=$(hostname -f)
echo ""
read -p "Would you like to output the default hosts file to the console? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  echo ""
  echo ""
  echo "##"
  echo "# Host Database"
  echo "# localhost is used to configure the loopback interface"
  echo "# when the system is booting.  Do not change this entry."
  echo "##"
  echo ""
  echo "127.0.0.1               dev.eds.com localhost"
  echo "127.0.0.1               1.dev.eds.com localhost"
  echo "127.0.0.1               2.dev.eds.com localhost"
  echo "127.0.0.1               3.dev.eds.com localhost"
  echo "255.255.255.255         broadcasthost"
  echo "::1                     localhost $hostname"
  echo ""
  echo "127.0.0.1               localhost app.sparkpost.test api.sparkpost.test"
  echo ""
  echo ""
  echo "Copy this to /etc/hosts!"
  echo ""
fi

#!/bin/bash

echo ""
read -p "Would you like to move the bouncy castle jar to the jetty lib/ext directory? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then

BOUNCY_CASTLE_VERSION="1.58"
echo "Moving bouncy castle jar"
sudo cp "$LAPTOP_REPO/analyst.conf/bcprov-ext-jdk15on-1.62.jar" "$jetty_dir/lib/ext"
# could prompt if user wants to fetch from the url
# "https://repo1.maven.org/maven2/org/bouncycastle/bcprov-ext-jdk15on/${BOUNCY_CASTLE_VERSION}/bcprov-ext-jdk15on-${BOUNCY_CASTLE_VERSION}.jar > bcprov-ext-jdk15on-${BOUNCY_CASTLE_VERSION}.jar"
# or output into action required area

fi

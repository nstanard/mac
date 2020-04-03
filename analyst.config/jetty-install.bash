#!/bin/bash

export JETTY_DOWNLOAD_LINK="https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.26.v20200117/jetty-distribution-9.4.26.v20200117.tar.gz"
echo ""
read -p "Would you like to install jetty 9.4.26 for Analyst-NG? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  sudo curl -o "/tmp/${JETTY_DOWNLOAD_LINK##*/}" "$JETTY_DOWNLOAD_LINK"
  echo -n "Extracting the archive... "
  ARCHIVE_PATH="/tmp/${JETTY_DOWNLOAD_LINK##*/}"
  mkdir -p "$UTILS/jetty"
  sudo tar -xf $ARCHIVE_PATH -C "$UTILS/jetty"
  jetty_dir=$(find $UTILS/jetty -mindepth 1 -maxdepth 1 -type d)
  jetty_version_folder=$(basename $jetty_dir)
  sudo chown $USER "$UTILS/jetty/$jetty_version_folder"
  echo "OK"
fi
bash "$LAPTOP_REPO/analyst.conf/configure-jetty.bash" jettypath="$UTILS/jetty/$jetty_version_folder" repo=$SP_REPOS
jetty_dir=$(find $UTILS/jetty -mindepth 1 -maxdepth 1 -type d)


# jetty classpath and project files - requires analyst-ng repo downloaded
echo ""
read -p "Would you like to copy the jetty .classpath and .project files from Analyst-NG to jetty? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  cd $jetty_dir && cp $SP_REPOS/analyst-ng/source/config/jetty/dot.project .project && cp $SP_REPOS/analyst-ng/source/config/jetty/dot.classpath .classpath
  jetty_version=$(basename $jetty_dir)
  sed -i '' "s/REPLACETHIS/${jetty_version/jetty-distribution-/}/g" "$jetty_dir/.classpath"
  sed -i '' "s/asm-5.0.1.jar/asm-7.2.jar/g" "$jetty_dir/.classpath"
  sed -i '' "s/asm-commons-5.0.1.jar/asm-commons-7.2.jar/g" "$jetty_dir/.classpath"
  sed -i '' "s/javax.annotation-api-1.2.jar/javax.annotation-api-1.3.jar/g" "$jetty_dir/.classpath"
  echo "${RED}Action Required${NC}: If the .classpath file still has a reference to jetty-alpn-client-VERSION.jar - delete that line."
  echo "If JRebel IS NOT installed in Eclipse; edit the the $jetty_dir/.project to disable the JRebel build command. (comment jrebel xml block out)"
fi

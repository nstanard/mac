#!/bin/bash

# 5.0.5 - Works.
# 5.1.4 - Has warnings about MariaDB...
# 5.2.4 - BREAKS - Could not create connection to database server. Attempted reconnect 3 times. Giving up.
export FLYWAY_DOWNLOAD_LINK="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/5.0.5/flyway-commandline-5.0.5-macosx-x64.tar.gz"
echo ""
read -p "Would you like to install flyway 5.0.5 for Analyst-NG? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  sudo curl -o "/tmp/${FLYWAY_DOWNLOAD_LINK##*/}" "$FLYWAY_DOWNLOAD_LINK"
  echo -n "Extracting the archive... "
  ARCHIVE_PATH="/tmp/${FLYWAY_DOWNLOAD_LINK##*/}"
  mkdir -p "$UTILS/flyway"
  sudo tar -xf $ARCHIVE_PATH -C "$UTILS/flyway"
  flyway_dir=$(find $UTILS/flyway -mindepth 1 -maxdepth 1 -type d)
  sudo chown -R $USER "$flyway_dir"
  echo "OK"
fi

echo ""
read -p "Would you like to set the Flyway configuration file? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  sed -i '' 's/# flyway.user=/flyway.user=root/g' "$flyway_dir/conf/flyway.conf"
  sed -i '' 's/# flyway.password=/flyway.password=/g' "$flyway_dir/conf/flyway.conf"
  sed -i '' 's/# flyway.placeholderReplacement=/flyway.placeholderReplacement=false/g' "$flyway_dir/conf/flyway.conf"
fi

echo ""
read -p "Would you like to create the database schemas for analsyt-ng? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  mysql_dir=$(find /usr/local/Cellar/mysql@5.6 -mindepth 1 -maxdepth 1 -type d)
  mysql -u root --password='' <<< 'CREATE DATABASE IF NOT EXISTS evun;'
  mysql -u root --password='' <<< 'CREATE DATABASE IF NOT EXISTS analyst;'
  mysql -u root --password='' <<< 'CREATE DATABASE IF NOT EXISTS analystFlywayDev;'
  mysql -u root --password='' <<< 'CREATE DATABASE IF NOT EXISTS boxbe;'
  mysql -u root --password='' <<< 'CREATE DATABASE IF NOT EXISTS boxbe_counts;'
  mysql -u root --password='' <<< 'CREATE DATABASE IF NOT EXISTS boxbeflywaydev;'
fi

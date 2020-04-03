#!/bin/bash

#  https://github.com/SparkPost/analyst-ng/blob/develop-analyst/source/scripts-sysops/docker/eds-base/Dockerfile#L10
export REDIS_DOWNLOAD_LINK="http://download.redis.io/releases/redis-3.2.4.tar.gz"
echo ""
read -p "Would you like to install redis 3.2.4 for Analyst-NG? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  sudo curl -o "/tmp/${REDIS_DOWNLOAD_LINK##*/}" "$REDIS_DOWNLOAD_LINK"
  echo -n "Extracting the archive... "
  ARCHIVE_PATH="/tmp/${REDIS_DOWNLOAD_LINK##*/}"
  mkdir -p "$UTILS/redis"
  sudo tar -xf $ARCHIVE_PATH -C "$UTILS/redis"
  redis_dir=$(find $UTILS/redis -mindepth 1 -maxdepth 1 -type d)
  redis_version_folder=$(basename $redis_dir)
  sudo chown $USER "$UTILS/redis/$redis_version_folder"
  echo "OK"
fi

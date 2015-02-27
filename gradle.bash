#!/bin/bash

# This add gradle functionality to your repo (for use with the gradle wrapper)
# If you don't want to use this functionality and would rather install gradle stand-alone
# Check the <REPO_BASE>/gradle/wrapper/gradle-wrapper.properties file for which version we are using

function gradle() {
    currentPath=$(pwd)
    # cmdPath=expr "currentPath" : '^\(.*source\/[a-z-]*\)'
    # [[ "$cmdPath" == "" ]] && cmdPath=`expr "currentPath" : '^\(.*analyst-ng\/[a-z-]*\)'`

    # while [[ "currentPath" != "" && ! -e "currentPath/gradlew" ]]; do
    #     path=${path%/*}
    # done
    # [[ $cmdPath = "" ]] && cmdPath="currentPath"

    # if [[ "currentPath" != "" && "$cmdPath" != "" ]]; then
    #     echo "Building from: $cmdPath"
    #     pushd "$cmdPath"
    #     eval "${path}/gradlew $@"
    #     popd
    # fi
}

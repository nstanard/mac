#!/bin/bash

# based on https://github.com/AdamScheller/UbuntuJavaInstaller
VERSION=11.0.5.10.2
NAME=amazon-corretto-11.jdk
CORRETTO_DOCUMENTATION_WEBSITE=https://docs.aws.amazon.com/corretto/index.html
CORRETTO_DOWNLOAD_LINK="https://corretto.aws/downloads/resources/${VERSION}/amazon-corretto-${VERSION}-macosx-x64.tar.gz"

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            profile)              profile=${VALUE} ;;
            *)
    esac    
done

# echo "PROFILE: $profile"

export JDK_LOCATION="/Library/Java/JavaVirtualMachines/$NAME/Contents/Home"

echo ""
read -p "Would you like to install Java? (requires sudo) [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then

# Start of the script
echo
echo Amazon Corretto Installer
echo

# Verify download link was provided and download
if [ -z "$CORRETTO_DOWNLOAD_LINK" ]; 
    then
        display_usage
        exit 1
    else
        echo "Downloading Corretto from $CORRETTO_DOWNLOAD_LINK to /tmp/"
        sudo curl -o "/tmp/${CORRETTO_DOWNLOAD_LINK##*/}" "$CORRETTO_DOWNLOAD_LINK"
        ARCHIVE_PATH="/tmp/${CORRETTO_DOWNLOAD_LINK##*/}"
fi

# Does the file exist?
if [ ! -f $ARCHIVE_PATH ]; then
   echo "Could not find the downloaded file: $ARCHIVE_PATH"
   echo
   exit 1
fi

# Is the file a valid archive?
echo -n "Validating the archive file... "
gunzip -t $ARCHIVE_PATH 2>> /dev/null
if [ $? -ne 0  ]; then
   echo "FAILED"
   echo
   echo "The downloaded file is not a valid .tar.gz archive: $ARCHIVE_PATH"
   echo
   echo "Ensure the download link is still valid from the Amazon Corretto website:"
   echo $CORRETTO_DOCUMENTATION_WEBSITE
   echo
   exit 1
fi

# All checks are done at this point
# Begin Java installation

# Extract the archive
echo -n "Extracting the archive... "
mkdir -p /Library/Java/JavaVirtualMachines
sudo tar -xf $ARCHIVE_PATH -C /Library/Java/JavaVirtualMachines
echo "OK"

# Verify and exit installation
echo -n "Verifying Java installation... "
JAVA_CHECK=`java -version 2>&1`
INSTALLED_VERSION=`egrep -o [0-9.]+ <<< $ARCHIVE_PATH | head -1`
if [[ "$JAVA_CHECK" == *"OpenJDK Runtime Environment Corretto"* ]]; then
   echo "OK"
   echo
   echo "Java is successfully installed!"
   echo
   java -version
   echo
   exit 0
else
   echo "FAILED"
   echo
   echo "Java installation failed!"
   echo
   exit 1
fi

fi

# Happening in dot-profile.bash now
# if [ "$SET_UP_PROFILE" = true ]; 
#     then
#     echo -n "Updating $profile ... "
#     cat >> $profile <<-EOF
# export JAVA_HOME=$JDK_LOCATION
# EOF
#     echo "OK"
# fi

# export JRE_HOME=$JDK_LOCATION/jre

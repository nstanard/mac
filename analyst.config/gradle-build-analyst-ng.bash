#!/bin/bash

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            repo)              repo=${VALUE} ;;
            *)
    esac    
done

# echo "REPO: $repo"

echo ""
read -p "Would you like to configure gradle for analyst-ng? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  cd "$repo/analyst-ng";
  ./gradlew clean build -x test eclipse
fi

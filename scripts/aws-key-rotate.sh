#!/bin/bash

# https://confluence.int.messagesystems.com/display/SCOM/AWS+Access+Key+Rotation
# todo: test this and add it to the mac script...
PROFILE=($(cat ~/.aws/credentials | sed 's/#.*//g' | awk 'NR>1{print $1}' RS=[ FS=] | tr ' ' '\n'))
for UPDATE in "${PROFILE[@]}"; do
        aws-rotate-key -y -profile $UPDATE
done

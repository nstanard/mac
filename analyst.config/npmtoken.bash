#!/bin/bash

if [ ! $NPM_TOKEN ]; then 
  echo ""
  read -p "Please enter your NPM token for analyst-ng: " NPM_TOKEN
  echo ""

  export NPM_TOKEN=$NPM_TOKEN
fi

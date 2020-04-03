#!/bin/bash

echo ""
read -p "Would you like to clone the SparkPost Analyst-NG repo? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  if [ ! -d "$SP_REPOS/analyst-ng" ]; then 
    cd $SP_REPOS; git clone git@github.com:SparkPost/analyst-ng.git; 
  fi

  # TODO: Add to analyst-ng/.git/config
  # fetch = +refs/pull/*/head:refs/remotes/upstream/pr/*
  # pushurl = do_not_push

  # TODO: Add eslint pre-commit hook
  # https://gist.github.com/nstanard/90ca92a2674093295060921f4f6d9050

  #TODO: Add the commit-msg hook for jira tags
  # https://gist.github.com/nstanard/70548079aad99f846fd344b19d013dad

  echo ""
  echo "Cloned from SparkPost. Create a fork and update the .git/config! (pushurl = do_not_push)"
fi

echo ""
read -p "Would you like to clone the SparkPost EA-Configs repo? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  if [ ! -d "$SP_REPOS/ea-configs" ]; then 
    cd $SP_REPOS; git clone git@github.com:SparkPost/ea-configs.git; 
  fi
fi

echo ""
read -p "Would you like to clone the SparkPost 2web2ui repo? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  if [ ! -d "$SP_REPOS/2web2ui" ]; then 
    cd $SP_REPOS; git clone git@github.com:SparkPost/2web2ui.git; 
  fi
fi

echo ""
read -p "Would you like to clone the SparkPost matchbox repo? [Y/n]: " response
response=${response:-y}
if [ "$response" = "y" ]; then
  if [ ! -d "$SP_REPOS/matchbox" ]; then 
    cd $SP_REPOS; git clone git@github.com:SparkPost/matchbox.git; 
  fi
fi

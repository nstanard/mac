#!/bin/bash

# https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github

gh repo list $1 --source --no-archived --limit 1000 | while read -r repo _; do
  gh repo clone "$repo"
done

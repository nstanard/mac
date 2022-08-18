# https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github
gh repo list myorgname --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done

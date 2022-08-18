gh repo list myorgname --limit 1000 | while read -r repo _; do
  gh repo clone "$repo" "$repo"
done

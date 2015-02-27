#!/bin/bash

append_to_file() {
  local file="$1"
  local text="$2"

  if ! grep -qs "^$text$" "$file"; then
    printf "\\n%s\\n" "$text" >> "$file"
  fi
}

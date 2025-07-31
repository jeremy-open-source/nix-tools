#!/usr/bin/env bash

# Script to collect all text file contents into a single file for GPT upload

set -euo pipefail

DIR="${1:-.}"              # Defaults to current directory
OUTPUT_FILE="gpt_upload.txt"  # Output file

> "$OUTPUT_FILE"  # Truncate output file if it exists

while IFS= read -r -d '' FILE; do
  # Only process regular files that are text
  if [[ -f "$FILE" && $(file --mime "$FILE") == *text/* ]]; then
    {
      echo "${FILE}"
      echo '```'
      cat "$FILE"
      echo '```'
      echo
    } >> "$OUTPUT_FILE"
  fi
done < <(
  find "$DIR" \( -name ".git" -o -name ".idea" \) -type d -prune -o -type f -print0
)

echo "✅ All text file contents written to '$OUTPUT_FILE'."

#!/usr/bin/env bash

# Script for use with AI

set -euo pipefail

DIR="${1:-.}"  # Defaults to current directory if no argument is given
OUTPUT=""

while IFS= read -r -d '' FILE; do
  # Only process regular files
  if [[ -f "$FILE" && $(file --mime "$FILE") == *text/* ]]; then
    OUTPUT+="${FILE}\n\`\`\`\n$(cat "$FILE")\n\`\`\`\n\n"
  fi
done < <(
  find "$DIR" \( -name ".git" -o -name ".idea" \) -type d -prune -o -type f -print0
)

# Copy to clipboard using xclip (requires `xclip` to be installed)
echo -e "$OUTPUT" | xclip -selection clipboard

echo "✅ All text file contents copied to clipboard."

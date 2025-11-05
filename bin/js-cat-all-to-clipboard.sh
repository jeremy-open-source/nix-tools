#!/usr/bin/env bash

# Script for use with AI
# Copies the contents of all files to the clipboard.
# - Text files show their contents.
# - Binary files are marked as "(binary file ignored)".
# - Files with specific ignored extensions are marked as "(contents ignored)".

set -euo pipefail

DIR="${1:-.}"  # Defaults to current directory if no argument is given
OUTPUT=""

# === CONFIGURATION ============================================================
# Add extensions (without the dot) to this list to ignore contents but still show the file path
IGNORE_EXTENSIONS=("log" "lock" "bin" "exe" "png" "jpg" "zip" "gz" "stl" "step")
# ==============================================================================

# Convert the ignore list to a lookup-friendly pattern
IGNORE_PATTERN="\\."
for ext in "${IGNORE_EXTENSIONS[@]}"; do
  IGNORE_PATTERN+="(${ext})|"
done
IGNORE_PATTERN="${IGNORE_PATTERN%|}" # Remove trailing '|'

# Process files
while IFS= read -r -d '' FILE; do
  BASENAME=$(basename "$FILE")

  # 1. If file matches ignored extension, mark as "(contents ignored)"
  if [[ "$BASENAME" =~ $IGNORE_PATTERN$ ]]; then
    OUTPUT+="${FILE}\n\`\`\`\n(contents ignored)\n\`\`\`\n\n"
    continue
  fi

  # 2. Check MIME type for binary or text
  MIME_TYPE=$(file --mime-type -b "$FILE")

  if [[ "$MIME_TYPE" == text/* ]]; then
    # Normal text file, include contents
    OUTPUT+="${FILE}\n\`\`\`\n$(cat "$FILE")\n\`\`\`\n\n"
  else
    # Non-text file, show a placeholder
    OUTPUT+="${FILE}\n\`\`\`\n(binary file ignored)\n\`\`\`\n\n"
  fi
done < <(
  find "$DIR" \
    \( -name '.git' -o -name '.idea' -o -name '.vagrant' \) -type d -prune -o \
    -type f -print0
)

# Copy to clipboard using xclip (requires `xclip` to be installed)
echo -e "$OUTPUT" | xclip -selection clipboard

echo "✅ All files processed. Ignored and binary files marked appropriately."

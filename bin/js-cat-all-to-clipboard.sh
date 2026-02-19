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
# Add folder names to skip entirely during file discovery
IGNORE_FOLDERS=(".git" ".terraform" ".vagrant" ".idea")
# ==============================================================================

# Returns success if file extension is in IGNORE_EXTENSIONS
is_ignored_extension() {
  local file_basename="${1##*/}"
  local file_ext="${file_basename##*.}"

  # No dot/no extension
  if [[ "$file_basename" == "$file_ext" ]]; then
    return 1
  fi

  local ext
  for ext in "${IGNORE_EXTENSIONS[@]}"; do
    if [[ "$file_ext" == "$ext" ]]; then
      return 0
    fi
  done

  return 1
}

# Process files
# Build a safe dynamic find expression for ignored folders
FIND_PRUNE_EXPR=()
for folder in "${IGNORE_FOLDERS[@]}"; do
  if ((${#FIND_PRUNE_EXPR[@]})); then
    FIND_PRUNE_EXPR+=(-o)
  fi
  FIND_PRUNE_EXPR+=(-name "$folder")
done

while IFS= read -r -d '' FILE; do
  # 1. If file matches ignored extension, mark as "(contents ignored)"
  if is_ignored_extension "$FILE"; then
    printf -v OUTPUT '%s%s\n```\n(contents ignored)\n```\n\n' "$OUTPUT" "$FILE"
    continue
  fi

  # 2. Check MIME type for binary or text
  MIME_TYPE=$(file --mime-type -b "$FILE")

  if [[ "$MIME_TYPE" == text/* ]]; then
    printf -v OUTPUT '%s%s\n```\n%s\n```\n\n' "$OUTPUT" "$FILE" "$(cat "$FILE")"
  else
    printf -v OUTPUT '%s%s\n```\n(binary file ignored)\n```\n\n' "$OUTPUT" "$FILE"
  fi

done < <(
  find "$DIR" \
    \( -type d \( "${FIND_PRUNE_EXPR[@]}" \) -prune \) -o \
    -type f -print0
)

# Copy to clipboard using xclip (requires `xclip` to be installed)
printf '%s' "$OUTPUT" | xclip -selection clipboard

echo "✅ All files processed. Ignored and binary files marked appropriately."

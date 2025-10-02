#!/usr/bin/env bash
set -euo pipefail

# detect-usb.sh — compare lsusb before/after plugging a device
# Usage:
#   ./detect-usb.sh                  # manual: press Enter after plugging in
#   ./detect-usb.sh --wait 20        # auto: wait up to 20s for a change
#   ./detect-usb.sh --wait           # auto: wait up to 60s (default)

WAIT_MODE=0
TIMEOUT=60

if [[ "${1:-}" == "--wait" ]]; then
  WAIT_MODE=1
  TIMEOUT="${2:-60}"
fi

# Take baseline
baseline="$(lsusb || true)"
echo "Baseline captured. Current devices:"
echo "$baseline"
echo
if (( WAIT_MODE == 0 )); then
  read -r -p "Now plug in (or remove) the USB device, then press Enter..."
else
  echo "Waiting (up to ${TIMEOUT}s) for any lsusb change..."
  start_ts=$(date +%s)
  while :; do
    now="$(lsusb || true)"
    if ! diff -q <(echo "$baseline" | sort) <(echo "$now" | sort) >/dev/null; then
      break
    fi
    sleep 0.5
    if (( $(date +%s) - start_ts >= TIMEOUT )); then
      echo "No change detected within ${TIMEOUT}s."
      exit 1
    fi
  done
fi

# Capture after state
after="$(lsusb || true)"

# Compute differences
added=$(comm -13 <(echo "$baseline" | sort) <(echo "$after" | sort) || true)
removed=$(comm -23 <(echo "$baseline" | sort) <(echo "$after" | sort) || true)

echo
echo "===== CHANGES DETECTED ====="
if [[ -n "$added" ]]; then
  echo "Added:"
  echo "$added"
else
  echo "Added: (none)"
fi
echo
if [[ -n "$removed" ]]; then
  echo "Removed:"
  echo "$removed"
else
  echo "Removed: (none)"
fi

# Helpful hint: show kernel paths for new devices (if any)
if command -v lsusb >/dev/null && command -v awk >/dev/null; then
  echo
  echo "Details for newly added device(s):"
  if [[ -n "$added" ]]; then
    # Try to extract first device ID to show verbose info
    while read -r line; do
      [[ -z "$line" ]] && continue
      bus=$(awk '{print $2}' <<<"$line")
      dev=$(awk '{print $4}' <<<"$line" | tr -d :)
      if [[ -n "$bus" && -n "$dev" ]]; then
        echo
        echo ">>> Bus $bus Device $dev"
        # -v needs sudo on many systems; fall back gracefully
        if lsusb -s "${bus}:${dev}" -v >/dev/null 2>&1; then
          lsusb -s "${bus}:${dev}" -v | sed 's/^/    /'
        else
          echo "    (Run with sudo to see verbose descriptors: sudo lsusb -s ${bus}:${dev} -v)"
        fi
      fi
    done <<<"$added"
  else
    echo "  (no new devices)"
  fi
fi

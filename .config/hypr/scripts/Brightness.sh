#!/usr/bin/env bash
# Brightness.sh - change brightness using brightnessctl (prefers amdgpu device)
# --incl  -> increase brightness by 10% (per occurrence)
# --decl  -> decrease brightness by 10% (per occurrence)

set -euo pipefail

PROG="$(basename "$0")"
STEP=10        # percent per flag occurrence
MIN=1
MAX=100

usage(){
  cat <<EOF
Usage: $PROG [--incl] [--decl] [--help]
  --incl    increase brightness by ${STEP}% (each occurrence)
  --decl    decrease brightness by ${STEP}% (each occurrence)
  --help    show this help
Examples:
  $PROG --incl
  $PROG --decl --decl
EOF
}

# check brightnessctl
if ! command -v brightnessctl >/dev/null 2>&1; then
  echo "Error: brightnessctl not installed. Install with: pacman -S brightnessctl" >&2
  exit 2
fi

# no args -> usage
if [ $# -eq 0 ]; then
  usage
  exit 0
fi

inc_count=0
dec_count=0


while [ $# -gt 0 ]; do
  case "$1" in
    --incl|--inc) inc_count=$((inc_count+1)); shift ;;
    --decl|--dec) dec_count=$((dec_count+1)); shift ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 3 ;;
  esac
done

if [ $inc_count -eq 0 ] && [ $dec_count -eq 0 ]; then
  usage
  exit 0
fi

# try to pick an amdgpu backlight device, else leave device empty for default
device="$(brightnessctl -l 2>/dev/null | awk -F"'" '/amdgpu/{print $2; exit}')"
device_arg=()
if [ -n "$device" ]; then
  device_arg=( -d "$device" )
fi

# get current and max (integers)
cur="$(brightnessctl "${device_arg[@]}" g 2>/dev/null || true)"
max="$(brightnessctl "${device_arg[@]}" m 2>/dev/null || true)"

if [ -z "$cur" ] || [ -z "$max" ]; then
  echo "Error: unable to read brightness values. Check permissions (maybe run with sudo or add your user to the video group)." >&2
  exit 4
fi

# Calculate current percent (integer floor)
percent=$(( (cur * 100) / max ))

# Calculate total change
delta=$(( (inc_count - dec_count) * STEP ))
new_percent=$(( percent + delta ))

# Clamp to [MIN, MAX]
if [ "$new_percent" -lt "$MIN" ]; then
  new_percent=$MIN
fi
if [ "$new_percent" -gt "$MAX" ]; then
  new_percent=$MAX
fi

# Apply new brightness
if ! brightnessctl "${device_arg[@]}" set "${new_percent}%"; then
  echo "Error: failed to set brightness. Try with sudo or check permissions." >&2
  exit 5
fi

device_label="${device:-(default)}"
change_label=$(( new_percent - percent ))
if [ "$change_label" -ge 0 ]; then change_symbol="+"; else change_symbol=""; fi

printf "Device: %s\nBrightness: %d%% -> %d%% (%s%d%%)\n" \
  "$device_label" "$percent" "$new_percent" "$change_symbol" "$change_label"

exit 0


#!/usr/bin/env bash
# theme-switcher.sh
# Browse ./style/*.css (relative to this script), preview with fzf, apply chosen one to ./style.css and restart waybar.
set -euo pipefail

# ---- Config ----
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STYLE_DIR="$SCRIPT_DIR/style"      # directory containing theme files
STYLE_CSS="$SCRIPT_DIR/style.css"  # destination css used by waybar
WAYBAR_CMD="waybar"                # command to launch waybar (adjust if you use a custom launcher)
# -----------------

# Ensure fzf exists (you said you have it)
if ! command -v fzf >/dev/null 2>&1; then
  echo "Error: fzf not found in PATH. Install or fix PATH." >&2
  exit 2
fi

# sanity checks
if [ ! -d "$STYLE_DIR" ]; then
  echo "Error: style directory not found at: $STYLE_DIR" >&2
  exit 3
fi

# Use bash globbing safely to get css files (no find/printf weirdness)
shopt -s nullglob
css_files=( "$STYLE_DIR"/*.css )
shopt -u nullglob

if [ ${#css_files[@]} -eq 0 ]; then
  echo "No .css files found in $STYLE_DIR" >&2
  exit 4
fi

# Turn absolute paths into basenames for display and selection
mapfile -t files < <(for f in "${css_files[@]}"; do basename "$f"; done)

# Temporary helper script to apply theme (avoids fragile quoting inside fzf)
tmp_apply="$(mktemp -t waybar-theme-apply.XXXXXX)"
cat >"$tmp_apply" <<'EOF'
#!/usr/bin/env bash
set -e
SCRIPT_DIR="$1"    # passed by main script
STYLE_CSS="$2"     # passed by main script
WAYBAR_CMD="$3"    # passed by main script
fname="$4"         # basename of theme file
if [ -z "$fname" ]; then
  exit 1
fi
src="$SCRIPT_DIR/style/$fname"
if [ ! -f "$src" ]; then
  echo "Source file not found: $src" >&2
  exit 2
fi
cp -- "$src" "$STYLE_CSS"
# restart waybar (best-effort)
killall waybar >/dev/null 2>&1 || true
nohup "$WAYBAR_CMD" >/dev/null 2>&1 &
echo "Applied: $fname -> $STYLE_CSS"
EOF
chmod +x "$tmp_apply"

# Run fzf with preview. Enter applies and exits; Ctrl-p applies without exiting
# --- robust fzf loop (handles spaces/newlines in filenames) ---
while true; do
  # show fzf and capture the selection (safe for spaces)
  selection="$(printf '%s\n' "${files[@]}" | fzf \
    --prompt "Theme> " \
    --preview "sed -n '1,400p' \"$STYLE_DIR/{}\"" \
    --preview-window=right:65%:wrap \
  )" || selection=""

  # if nothing selected (Esc/Ctrl-C), exit loop
  if [ -z "$selection" ]; then
    echo "No selection. Exiting."
    break
  fi

  # apply the chosen theme (selection contains spaces safely)
  src="$STYLE_DIR/$selection"
  if [ ! -f "$src" ]; then
    echo "Selected file not found: $src" >&2
    continue
  fi

  cp -- "$src" "$STYLE_CSS"
  echo "Applied: $selection -> $STYLE_CSS"

  # restart waybar (best effort)
  killall waybar >/dev/null 2>&1 || true
  nohup "$WAYBAR_CMD" >/dev/null 2>&1 &

  # loop continues: fzf will reopen so you can preview/apply more themes;
  # press Ctrl-C to kill the script entirely.
done


# cleanup
rm -f "$tmp_apply"
exit 0


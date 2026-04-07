#!/usr/bin/env bash
# Raise, Cycle, or Spawn - niri helper script
# Behavior:
#   - No windows of app_id exist -> spawn the app
#   - One window exists -> focus it
#   - Multiple windows exist -> cycle to next one

set -euo pipefail

raise_or_cycle() {
    local app_id="$1"
    local tmp
    tmp="$(mktemp)"
    trap 'rm -f "$tmp"' EXIT

    niri msg --json windows >"$tmp"

    # Get all window IDs matching the app
    mapfile -t ids < <(jq -r --arg app "$app_id" \
        '.[] | select(.app_id == $app) | .id' <"$tmp")

    ((${#ids[@]})) || return 1

    # Find currently focused window and cycle to next
    local focused
    focused="$(jq -r '.[] | select(.is_focused) | .id' <"$tmp")"

    local next_idx=0
    for ((i = 0; i < ${#ids[@]} - 1; i++)); do
        if [[ "${ids[$i]}" == "$focused" ]]; then
            next_idx=$((i + 1))
            break
        fi
    done

    niri msg action focus-window --id "${ids[$next_idx]}"
    exit 0
}

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <app_id> [command]" >&2
    exit 2
fi

app_id="$1"
if [[ $# -gt 1 ]]; then
    cmd="$2"
else
    cmd="$1"
fi

if raise_or_cycle "$app_id"; then
    exit 0
fi

niri msg action spawn -- "$cmd"

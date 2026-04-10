#!/usr/bin/env bash
# Raise, Cycle, or Spawn - generic window manager helper
# Usage: raise-cycle-or-spawn <wm> <app_id> [command]
# wm: niri, mango, kde

set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <wm> <app_id> [command]" >&2
    exit 2
fi

wm="$1"
app_id="$2"
cmd="${3:-"$2"}"

raise_or_cycle() {
    case "$wm" in
        niri)
            local tmp
            tmp="$(mktemp)"
            trap 'rm -f "$tmp"' EXIT
            niri msg --json windows >"$tmp"
            mapfile -t ids < <(jq -r --arg app "$app_id" '.[] | select(.app_id == $app) | .id' <"$tmp")
            ((${#ids[@]})) || return 1
            focused="$(jq -r '.[] | select(.is_focused) | .id' <"$tmp")"
            local next_idx=0
            for ((i = 0; i < ${#ids[@]} - 1; i++)); do
                if [[ "${ids[$i]}" == "$focused" ]]; then
                    next_idx=$((i + 1))
                    break
                fi
            done
            niri msg action focus-window --id "${ids[$next_idx]}"
            ;;
        mango)
            local tmp
            tmp="$(mktemp)"
            trap 'rm -f "$tmp"' EXIT
            swaymsg -t get_tree >"$tmp"
            ids=$(jq -r --arg app "$app_id" '.. | objects | select(.app_id? == $app) | .id' <"$tmp")
            [[ -z "$ids" ]] && return 1
            mapfile -t id_array <<< "$ids"
            if ((${#id_array[@]} == 1)); then
                swaymsg "[id=${id_array[0]}] focus"
                exit 0
            fi
            focused=$(jq -r '.. | objects | select(.focused?) | .id' <"$tmp")
            next_idx=0
            for ((i = 0; i < ${#id_array[@]} - 1; i++)); do
                if [[ "${id_array[$i]}" == "$focused" ]]; then
                    next_idx=$((i + 1))
                    break
                fi
            done
            swaymsg "[id=${id_array[$next_idx]}] focus"
            ;;
        kde)
            qdbus org.kde.KWin /WindowManager org.kde.KWin.activateWindowForClient "$(qdbus org.kde.KWin | grep -i "$app_id" | head -1)"
            ;;
        *)
            echo "Unknown window manager: $wm" >&2
            return 1
            ;;
    esac
}

if raise_or_cycle; then
    exit 0
fi

exec $cmd
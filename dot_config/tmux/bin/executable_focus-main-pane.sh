#!/usr/bin/env sh
# After switching sessions, focus the first non-sidebar pane.
# Called from the client-session-changed hook in tmux.conf.
main=$(tmux list-panes -F "#{pane_id} #{pane_title}" 2>/dev/null \
  | awk '$2 != "opensessions-sidebar" { print $1; exit }')
[ -n "$main" ] && tmux select-pane -t "$main"

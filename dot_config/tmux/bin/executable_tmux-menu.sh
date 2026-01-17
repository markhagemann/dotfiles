#!/usr/bin/env bash

# Taken from https://www.youtube.com/watch?v=JN4Zbs0ypwM

{
	tmux list-sessions -F '#S' | grep -v '^_popup_' | while read -r session; do
		echo "SESSION:$session"
		# tmux list-windows -t "$session" -F 'WINDOW:#I #W'
	  tmux list-windows -t "$session" -F 'WINDOW:#S:#I #W'
	done
} | sed 's/^SESSION:/▼ /' | sed 's/^WINDOW:/  ⦿ /' |
	fzf --reverse |
	awk '{
  if ($1 == "▼") {
    print $2
  } else if ($1 == "⦿") {
    print $2
  }
}' |
	xargs tmux switch-client -t

#!/bin/bash

history_file="$HOME/.zsh_history"

if [ ! -f "$history_file" ]; then
  notify-send "Error" "History file not found: $history_file"
  exit 1
fi

selected_command=$(sed -E 's/^[^;]*;//' "$HOME/.zsh_history" | sort | uniq | rofi -dmenu -show drun -show-icons -theme gruvbox-dark-hard -p "History command")

if [ -n "$selected_command" ]; then
  echo -n "$selected_command" | xclip -selection clipboard
  notify-send "Command copied" "$selected_command"
fi

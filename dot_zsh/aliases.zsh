#!/usr/bin/env zsh

alias ls='ls --color=auto'
alias mkignore="~/.bin/curl_gitignore.sh "

# Alias para Doom Emacs
if [ -f "$HOME/.emacs.d/bin/doom" ]; then
    alias doom="$HOME/.emacs.d/bin/doom"
fi

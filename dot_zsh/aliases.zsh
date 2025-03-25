#!/usr/bin/env zsh

alias ls='ls --color=auto'
alias mkignore="~/.bin/curl_gitignore.sh "
alias v='vim'


if (( $+commands[nvim] )); then
    alias vim="nvim"
fi
# Alias para Doom Emacs
if [ -f "$HOME/.emacs.d/bin/doom" ]; then
    alias doom="$HOME/.emacs.d/bin/doom"
fi

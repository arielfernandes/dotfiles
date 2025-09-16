#!/usr/bin/env zsh

alias ls='ls --color=auto'
alias mkignore="~/.bin/curl_gitignore.sh "
alias v='vim'

#uv
alias uvr='uv run'
alias uvp='uv run python'

#python
alias pyignore='curl -fLo .gitignore https://www.toptal.com/developers/gitignore/api/python'


#Chezmoi
alias chz='chezmoi'

# Alias git
alias g=git
alias gadd='git add'
alias gstatus='git status'
alias gpush='git push'
alias gswitch='git switch'


if (( $+commands[nvim] )); then
    alias vim="nvim"
fi
# Alias para Doom Emacs
if [ -f "$HOME/.emacs.d/bin/doom" ]; then
    alias doom="$HOME/.emacs.d/bin/doom"
fi


if [ -f "/opt/HP_Prime_Virtual_Calculator-x86_64.AppImage" ]; then
	alias HP_Prime="/opt/HP_Prime_Virtual_Calculator-x86_64.AppImage"
fi

if [ -f "$HOME/Documents/scripts/concat_task/main.py" ]; then
	branch() {
	  (cd "$HOME/Documents/scripts/concat_task" && uv run python main.py "$@")
	}
fi

if [ -f "$HOME/Documents/scripts/cli_llm/cli_llm.py" ]; then
	llm() {
	  (cd "$HOME/Documents/scripts/cli_llm" && uv run python cli_llm.py "$@")
	}
fi


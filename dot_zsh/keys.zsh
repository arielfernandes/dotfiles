#bindkey -v
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey ' ' magic-space
bindkey "^F" forward-word
bindkey "^B" backward-word
bindkey '^[[Z' reverse-menu-complete
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char
bindkey '^W' backward-kill-word
bindkey '^ ' autosuggest-accept

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "\e[1;2C" forward-word
bindkey "\e[1;2D" backward-word

bindkey "\e[1;6C" forward-word
bindkey "\e[1;6D" backward-word

bindkey "\e[1;4C" forward-word
bindkey "\e[1;4D" backward-word





# Widgets customizados
custom-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N custom-backward-delete-word
bindkey '^W' custom-backward-delete-word

custom-edit-command-line() {
    export CUSTOM_EDITOR=nvim
    zle edit-command-line;
    unset CUSTOM_EDITOR
}
zle -N custom-edit-command-line
bindkey -M vicmd v custom-edit-command-line

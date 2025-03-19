# General init file
# Configurações de histórico
HISTSIZE=10000                  # Número de comandos no histórico da memória
SAVEHIST=10000                  # Número de comandos a salvar no arquivo de histórico
HISTFILE=~/.zsh_history          # Caminho do arquivo de histórico

# Escrever o histórico no arquivo imediatamente
setopt INC_APPEND_HISTORY        # Aplica o histórico imediatamente
setopt SHARE_HISTORY             # Compartilha o histórico entre múltiplos terminais
setopt HIST_IGNORE_ALL_DUPS     # Ignora duplicatas no histórico
setopt HIST_FIND_NO_DUPS        # Não mostra duplicatas ao buscar
setopt HIST_REDUCE_BLANKS      # Remove espaços em branco no início e fim dos comandos
setopt HIST_IGNORE_SPACE       # Ignora comandos que começam com um espaço
setopt HIST_EXPIRE_DUPS_FIRST  # Exclui duplicatas primeiro ao salvar o histórico

# Previne o histórico de ser truncado quando o terminal é fechado
setopt APPEND_HISTORY           # Garante que o histórico será apenas adicionado, não sobrescrito

# Configura a frequência de gravação do histórico
export HIST_STAMPS="yyyy-mm-dd"

setopt autocd
setopt extendedglob
setopt NO_NOMATCH
setopt CORRECT

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

# Print a carriage return just before printing a prompt in the line editor
# and try to preserve a partial line.
setopt promptcr promptsp

# disable keyboard beep
unsetopt BEEP

## Tmux
_tmux_autostart(){
    if [[ "$TMUX_AUTOSTART" == "true" && -z "$TMUX" ]]; then
        tmux attach || tmux new
        exit 0
    fi
}

_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_tmux_autostart _fix_cursor)

# setup custom completion path
fpath=($HOME/.zsh/completions $fpath)

autoload -Uz compinit

# navidate completion
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

profzsh() {
	shell=${1-$SHELL}
	ZPROF=true $shell -i -c exit
}

autoload edit-command-line
zle -N edit-command-line

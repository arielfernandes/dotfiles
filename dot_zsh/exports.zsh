export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

export PATH="$HOME/.local/bin:$PATH"

export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --color=fg:#d0d0d0,hl:#5fafff,fg+:white,hl+:white
"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

if [ -f /opt/SimulIDE_1.1.0-SR1_Lin64/simulide ]; then
    export PATH=$PATH:/opt/SimulIDE_1.1.0-SR1_Lin64/simulide
fi

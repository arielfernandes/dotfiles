export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# Configurações do fzf (não precisa mais do source manual)
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --color=fg:#d0d0d0,hl:#5fafff,fg+:white,hl+:white
"

# Use 'fd' para busca rápida
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'


export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/opt/SimulIDE_1.1.0-SR1_Lin64/simulide



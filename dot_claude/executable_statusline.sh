#!/usr/bin/env bash
# Status line para o Claude Code. Lê o JSON da sessão via stdin e imprime uma linha.
# Requer: jq

input=$(cat)

DIM=$'\033[2m'; RESET=$'\033[0m'
CYAN=$'\033[36m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; MAGENTA=$'\033[35m'

# Um único jq extrai todos os campos, separados por \x1f (preserva campos vazios).
IFS=$'\x1f' read -r model dir pct cost < <(
  jq -r '
    [ (.model.display_name // "?"),
      (.workspace.current_dir // .cwd // ""),
      ( .context_window.used_percentage
        // ( if (.context_window.total_input_tokens and .context_window.context_window_size)
             then .context_window.total_input_tokens * 100 / .context_window.context_window_size
             else null end )
        | if . == null then "" else round end ),
      (.cost.total_cost_usd // "")
    ] | map(tostring) | join("\u001f")
  ' <<<"$input" 2>/dev/null
)

[ -z "$dir" ] && dir=$PWD
parts=("${CYAN}[${model:-?}]${RESET}" "$(basename "$dir")")

# Branch do git, com * se houver alterações não commitadas
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
if [ -n "$branch" ]; then
  [ -n "$(git -C "$dir" status --porcelain -uno 2>/dev/null)" ] && branch+="*"
  parts+=("${MAGENTA}${branch}${RESET}")
fi

# Uso do contexto, com cor por faixa
if [ -n "$pct" ]; then
  if   [ "$pct" -lt 50 ]; then color=$GREEN
  elif [ "$pct" -lt 80 ]; then color=$YELLOW
  else color=$RED; fi
  parts+=("${color}ctx ${pct}%${RESET}")
fi

# Custo da sessão
if [ -n "$cost" ] && [ "$cost" != "0" ]; then
  parts+=("${DIM}\$$(LC_NUMERIC=C printf '%.2f' "$cost")${RESET}")
fi

# Alerta se o settings.json estiver com JSON inválido
cfg="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/settings.json"
if [ -f "$cfg" ] && ! jq -e . "$cfg" >/dev/null 2>&1; then
  parts+=("${RED}settings.json INVÁLIDO${RESET}")
fi

out=""
for p in "${parts[@]}"; do
  [ -n "$out" ] && out+=" ${DIM}|${RESET} "
  out+="$p"
done
printf '%s\n' "$out"

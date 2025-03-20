#!/bin/bash

# Obter a carga média de CPU (em %)
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1 "%"}')

# Obter a porcentagem de uso da CPU
CPU_PERCENT=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Definir a cor padrão (verde)
COLOR="#A3BE8C"

# Verificar o nível de uso da CPU e ajustar a cor
if [ $(echo "$CPU_PERCENT > 90" | bc) -eq 1 ]; then
    COLOR="#FF0000"  # Vermelho (Acima de 90%)
elif [ $(echo "$CPU_PERCENT > 70" | bc) -eq 1 ]; then
    COLOR="#FF8000"  # Laranja (Acima de 70%)
fi

# Exibir a informação com a cor
echo -e "CPU: $CPU_LOAD \x01$COLOR\x01"


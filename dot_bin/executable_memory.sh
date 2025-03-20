#!/bin/bash

# Obter o uso de memória e total em GB
MEMORY_USED=$(free -h | grep Mem | awk '{print $3}')
MEMORY_TOTAL=$(free -h | grep Mem | awk '{print $2}')

# Obter a porcentagem de memória usada
MEMORY_PERCENT=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | awk '{printf "%.0f", $1}')

# Definir a cor padrão (verde)
COLOR="#A3BE8C"

# Verificar o nível de uso de memória e ajustar a cor
if [ $MEMORY_PERCENT -ge 90 ]; then
    COLOR="#FF0000"  # Vermelho (Acima de 90%)
elif [ $MEMORY_PERCENT -ge 70 ]; then
    COLOR="#FF8000"  # Laranja (Acima de 70%)
fi

# Exibir a informação com a cor
echo -e "\x01$COLOR\x01 Mem: $MEMORY_USED / $MEMORY_TOTAL"


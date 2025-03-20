#!/bin/bash

# Obter o status da bateria
BAT=$(acpi -b | grep -E -o '[0-9][0-9]?%')

# Extrair o valor numérico da bateria
BATTERY_LEVEL=${BAT%?}

# Definir a cor padrão (verde)
COLOR="#A3BE8C"

# Verificar nível de bateria e ajustar a cor
if [ $BATTERY_LEVEL -le 5 ]; then
    COLOR="#FF0000"  # Vermelho (Urgente)
elif [ $BATTERY_LEVEL -le 20 ]; then
    COLOR="#FF8000"  # Laranja
fi

# Exibir a informação com a cor
echo -e "BAT: $BATTERY_LEVEL% \x01$COLOR\x01"


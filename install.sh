#!/data/data/com.termux/files/usr/bin/bash

clear

# Instalar zsh se necessário
pkg install -y zsh >/dev/null 2>&1

echo "======================================"
echo "     TERMUX PROMPT INSTALLER"
echo "======================================"
echo

read -p "Nome do prompt: " PROMPT_NAME

echo
echo "Escolha uma cor:"
echo "1) Azul"
echo "2) Verde"
echo "3) Vermelho"
echo "4) Ciano"
echo "5) Amarelo"
echo "6) Magenta"
echo "7) Branco"
echo

read -p "Opção: " COR

case $COR in
1) COLOR="blue" ;;
2) COLOR="green" ;;
3) COLOR="red" ;;
4) COLOR="cyan" ;;
5) COLOR="yellow" ;;
6) COLOR="magenta" ;;
7) COLOR="white" ;;
*) COLOR="cyan" ;;
esac

cp ~/.zshrc ~/.zshrc.bak 2>/dev/null

cat > ~/.zshrc << EOF
autoload -Uz colors && colors

PROMPT='%F{$COLOR}[$PROMPT_NAME]-%f%F{green}[%~]%f
%F{green}>>>%f '

[[ \$- == *i* ]] && echo "\$(date '+%I:%M:%S %p | %Y-%b-%a - %d')"
EOF

chsh -s zsh >/dev/null 2>&1

echo
echo "======================================"
echo " Instalação concluída!"
echo "======================================"
echo
echo "Execute:"
echo
echo "source ~/.zshrc"
echo
echo "ou feche e abra o Termux."

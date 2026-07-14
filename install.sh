#!/data/data/com.termux/files/usr/bin/bash

clear

pkg install -y figlet zsh >/dev/null 2>&1

rm -f $PREFIX/etc/motd $PREFIX/etc/motd.sh 2>/dev/null
rm -f $PREFIX/var/log/motd 2>/dev/null

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
NC='\033[0m'

CORES=("" "31" "32" "31" "36" "33" "35" "37")
NOMES_CORES=("" "Vermelho" "Verde" "Azul" "Ciano" "Amarelo" "Magenta" "Branco")
NOMES_ZSH=("" "red" "green" "blue" "cyan" "yellow" "magenta" "white")

mostrar_cores() {
  echo -e "  ┌──────────────────────────────────┐"
  for i in {1..7}; do
    echo -e "  │ \033[1;${CORES[$i]}m██▓▒░ ${NOMES_CORES[$i]}\033[0m│"
  done
  echo -e "  └──────────────────────────────────┘"
}

escolher_cor() {
  local label=$1 var_name=$2 opcao
  while true; do
    echo -e "\n  ${WHITE}═══════════════════════════════════${NC}"
    echo -e "   $label"
    echo -e "  ${WHITE}═══════════════════════════════════${NC}"
    mostrar_cores
    echo
    read -p "  Opção (1-7): " opcao
    if [[ "$opcao" =~ ^[1-7]$ ]]; then
      eval "$var_name=\${NOMES_ZSH[$opcao]}"
      local num="${CORES[$opcao]}"
      echo -e "\n  → Cor escolhida: \033[1;${num}m${NOMES_CORES[$opcao]}${NC}"
      sleep 1
      break
    fi
  done
}

echo -e "${RED}"
cat << "EOBANNER"

  ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗
  ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝
     ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝
     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗
     ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝

EOBANNER

echo -e "${NC}"

echo -e "  ${WHITE}╔══════════════════════════════════════╗${NC}"
echo -e "  ${WHITE}║${NC}  ${GREEN}BEM-VINDO AO TERMUX PROMPT INSTALLER${NC}  ${WHITE}║${NC}"
echo -e "  ${WHITE}║${NC}       ${CYAN}Personalize seu terminal${NC}        ${WHITE}║${NC}"
echo -e "  ${WHITE}╚══════════════════════════════════════╝${NC}"
echo

read -p "  $(echo -e "${WHITE}Nome para o banner: ${NC}")" PROMPT_NAME

echo -e "\n  ${WHITE}─────────────────────────────────────${NC}"
echo -e "  ${CYAN}COR DO BANNER${NC}   (banners e destaques)"
echo -e "  ${WHITE}─────────────────────────────────────${NC}"

escolher_cor "Escolha a cor do banner" NAME_COLOR

echo -e "\n  ${WHITE}─────────────────────────────────────${NC}"
echo -e "  ${CYAN}COR DOS TEXTOS${NC} (caminho e seta)"
echo -e "  ${WHITE}─────────────────────────────────────${NC}"

escolher_cor "Escolha a cor dos textos" TEXT_COLOR

COR_NUM=0
for i in "${!NOMES_ZSH[@]}"; do
  if [[ "${NOMES_ZSH[$i]}" == "$NAME_COLOR" ]]; then
    COR_NUM="${CORES[$i]}"
    break
  fi
done

TEXT_COR_NUM=0
for i in "${!NOMES_ZSH[@]}"; do
  if [[ "${NOMES_ZSH[$i]}" == "$TEXT_COLOR" ]]; then
    TEXT_COR_NUM="${CORES[$i]}"
    break
  fi
done

TAMANHO=${#PROMPT_NAME}
if [ "$TAMANHO" -le 5 ]; then
  FONTE="big"
elif [ "$TAMANHO" -le 10 ]; then
  FONTE="standard"
else
  FONTE="small"
fi

BANNER_TEXT=$(figlet -f "$FONTE" "$PROMPT_NAME" 2>/dev/null || figlet "$PROMPT_NAME" 2>/dev/null)

clear
echo
echo -e "\033[1;${COR_NUM}m${BANNER_TEXT}\033[0m"
echo
echo -e "  ${WHITE}╔══════════════════════════════════════╗${NC}"
echo -e "  ${WHITE}║${NC}         ${GREEN}PREVIEW DO SEU PROMPT${NC}        ${WHITE}║${NC}"
echo -e "  ${WHITE}╚══════════════════════════════════════╝${NC}"
echo
echo -e "  ${WHITE}┌─────────────────────────────────────┐${NC}"
echo -e "  │ \033[1;${COR_NUM}m$PROMPT_NAME\033[0m                                   │"
echo -e "  │ \033[1;${COR_NUM}m┌──(\033[1;32muser\033[1;${COR_NUM}m㉿\033[1;33mhost\033[1;${COR_NUM}m)-[\033[1;${TEXT_COR_NUM}m~/termux\033[1;${COR_NUM}m]\033[0m   │"
echo -e "  │ \033[1;${COR_NUM}m└─# \033[0m                                        │"
echo -e "  ${WHITE}└─────────────────────────────────────┘${NC}"
echo
echo -e "  ${WHITE}─────────────────────────────────────${NC}"
echo

read -p "  Confirmar instalação? (S/n): " CONFIRMAR
CONFIRMAR="${CONFIRMAR:-S}"

if [[ ! "$CONFIRMAR" =~ ^[Ss]$ ]]; then
  echo -e "\n  \033[1;31m✖\033[0m Instalação cancelada."
  exit 0
fi

cp ~/.zshrc ~/.zshrc.bak 2>/dev/null

BANNER_ESC=${BANNER_TEXT//\\/\\\\}

cat > ~/.zshrc << ZSHRC
autoload -Uz colors && colors

BANNER='${BANNER_ESC}'

[[ \$- == *i* ]] && echo -e "\033[1;${COR_NUM}m\$BANNER\033[0m"
[[ \$- == *i* ]] && echo
[[ \$- == *i* ]] && echo -e "\033[1;${COR_NUM}m───────────────────────────────────────────────\033[0m"
[[ \$- == *i* ]] && echo -e " Host    : \$HOST"
[[ \$- == *i* ]] && echo -e " User    : \$USER"
[[ \$- == *i* ]] && echo -e " System  : \$(uname -o) \$(uname -m)"
[[ \$- == *i* ]] && echo -e " Kernel  : \$(uname -r)"
[[ \$- == *i* ]] && echo -e " Date    : \$(date '+%d/%m/%Y %H:%M:%S')"
[[ \$- == *i* ]] && echo -e " History : \$#history comandos"
[[ \$- == *i* ]] && echo -e "\033[1;${COR_NUM}m───────────────────────────────────────────────\033[0m"
[[ \$- == *i* ]] && echo

[ -f ~/.frases_hacker ] && {
    [[ \$- == *i* ]] && echo -e "\033[1;${TEXT_COR_NUM}m\$(shuf -n 1 ~/.frases_hacker)\033[0m"
    [[ \$- == *i* ]] && echo
}

PROMPT='%F{$NAME_COLOR}┌──(%F{green}%n%F{$NAME_COLOR}㉿%F{yellow}%m%F{$NAME_COLOR})-[%F{$TEXT_COLOR}%~%F{$NAME_COLOR}]
%F{$NAME_COLOR}└─#%f '
ZSHRC

chsh -s zsh >/dev/null 2>&1

clear
echo
echo -e "\033[1;${COR_NUM}m${BANNER_TEXT}\033[0m"
echo
echo -e "  ${WHITE}╔══════════════════════════════════════╗${NC}"
echo -e "  ${WHITE}║${NC}     ${GREEN}✅ INSTALAÇÃO CONCLUÍDA${NC}        ${WHITE}║${NC}"
echo -e "  ${WHITE}╚══════════════════════════════════════╝${NC}"
echo
echo -e "  ${CYAN}Para ativar:${NC}"
echo
echo -e "    ${WHITE}exec zsh${NC}"
echo
echo -e "  ${CYAN}Ou feche e abra o Termux.${NC}"
echo

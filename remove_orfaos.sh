#!/bin/env bash
# Script que lista pacotes desnecessários no Arch Linux
# Normalmente dependências não mais usadas


# Executar com sudo
if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa ser executado com sudo:"
  echo "sudo $0"
  exit 1
fi

# Listar pacotes órfãos
orfaos=$(pacman -Qdtq)

# Verifica se há pacotes órfãos
if [[ -z "$orfaos" ]]; then
  echo "Nenhum pacote órfão encontrado."
  exit 0
fi

echo "Pacotes órfãos detectados:"
echo "$orfaos"
echo

# Itera sobre cada pacote
for pkt in $orfaos; do
## Se quiser ver informações do pacote antes habilite:
#  echo "---------------------------------------------------"
#  echo "🔍 Informações sobre o pacote: $pkt"
#  pacman -Qi "$pkt"
#  echo
  read -p "Deseja remover este pacote: $pkt'? [s/N]: " escolha

  if [[ "$escolha" == "s" || "$escolha" == "S" ]]; then
    sudo pacman -Rns "$pkt"
  else
    echo "⏭️  Ignorando $pkt"
  fi
  echo
done

echo "✅ Concluído."


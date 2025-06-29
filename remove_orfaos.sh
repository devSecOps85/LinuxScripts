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

echo "---------------------------------------------------"
  echo "🔍 Verificando dependências de: $pkt"
  
  dependentes=$(pactree -r "$pkt" | sed '1d')  # Remove a primeira linha (o próprio pacote)

  if [[ -z "$dependentes" ]]; then
    echo " Nenhum pacote depende de '$pkt'."
    read -p "Deseja remover este pacote? [s/N]: " escolha
    if [[ "$escolha" == "s" || "$escolha" == "S" ]]; then
      sudo pacman -R "$pkt"
    else
      echo "⏭  Ignorando $pkt"
    fi
  else
    echo " Outros pacotes dependem de '$pkt':"
    echo "$dependentes"
    echo " Não será removido."
  fi
  echo
done

echo " Concluído."


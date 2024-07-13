#!/bin/bash

#############################################
#
# QuarentenaZero.sh - Script para criar planilha de quarentenas
#
# Autor: Matheus Silvano
# Data Criação: 13/07/2024
#
# Descrição: Cria uma planilha com os arquivos que caíram em quarentena no dia de hoje, e informa os CNPJs dos arquivos que utilizam o layout SE
#
# Exemplo de uso: ./QuarentenaZero.sh (Para permissão: chmod +x QuarentenaZero.sh)
#
#######################################################

# Cria uma variavel com os diretorios
DIRS=(".QUARENTENA/mailbox" "OPERADORAS.SEMRELACIONAMENTO/sent")

# Cria uma variavel para a planilha
PLANILHA="planilha-quarentena0.csv"

# Cria uma variavel para a data de hoje
DATA_HOJE=$(date +%Y-%m-%d)

# Cria um cabeçalho para a planilha
echo "Nome do Arquivo,CNPJ" > $PLANILHA

# Cria uma função para extrair o CNPJ dos arquivos (funciona apenas com os Layout SE)
extrair_cnpj() {
    local arquivo=$1
    cnpj=$(grep -oP '(?<=CV0)\d{14}' "$arquivo" | head -1) # Considera 14 dígitos após o campo CV0
    if [ -z "$cnpj" ]; then
        echo "CNPJ não encontrado"
    else
        echo "$cnpj"
    fi
}

# Verifica arquivos em cada diretório
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Encontra arquivos que chegaram hoje
        arquivos=$(find "$DIR" -type f -newermt "$DATA_HOJE 00:00:00" ! -newermt "$DATA_HOJE 23:59:59")
        
        for arquivo in $arquivos; do
            nome_arquivo=$(basename "$arquivo")
            cnpj=$(extrair_cnpj "$arquivo")
            echo "$nome_arquivo,$cnpj" >> $PLANILHA
        done
    fi
done

# Dá um retorno
echo "Planilha criada: $PLANILHA"



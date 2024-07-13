# Automação de Geração de Planilha CSV - Quarentena Zero

Este repositório contém um script em Shell para automatizar a tarefa de coleta de arquivos de diretórios específicos e a criação de uma planilha CSV com informações extraídas desses arquivos.

## Descrição
O script busca arquivos que chegaram hoje nos diretórios especificados, cria uma planilha CSV com as nomenclaturas desses arquivos e extrai um CNPJ (14 dígitos após "CV0") de cada arquivo.

## Uso

### 1. Script Shell
  - Salvar o script como QuarentenaZero.sh

### 2. Permissões
  - Certifique-se de que o script possui permissão de execução:
  - chmod +x criar_planilha.sh

### 3. Agendar com o cron
  - crontab -e
  - 0 18 * * * /caminho/para/o/seu/script/criar_planilha.sh

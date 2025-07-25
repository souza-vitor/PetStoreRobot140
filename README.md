# PetStoreRobot140

Este projeto automatiza testes para a API PetStore utilizando Robot Framework. Foram criados testes para os endpoints de pets, loja e usuários, incluindo cenários de criação, deleção e manipulação de dados via arquivos CSV e JSON.

## Ferramentas Utilizadas
- **Robot Framework**: Framework principal para automação dos testes.
- **Python**: Utilizado para variáveis e recursos customizados.
- **Bibliotecas do Robot Framework**: RequestsLibrary, CSVLibrary, entre outras.
- **Arquivos de dados**: CSV e JSON para Data Driven Testing (DDT).

## Estrutura do Projeto
- `__tests__/`: Testes automatizados em Robot Framework.
- `fixtures/csv/`: Dados de entrada em formato CSV.
- `fixtures/json/`: Dados de entrada em formato JSON.
- `resources/variables.py`: Variáveis e funções customizadas em Python.

## Como Rodar Localmente
1. **Pré-requisitos**:
   - Python 3.12 ou superior instalado
   - Instalar o Robot Framework e bibliotecas necessárias:
     ```powershell
     pip install robotframework robotframework-requests robotframework-csvlibrary
     ```
2. **Executar os testes**:
   - Navegue até a pasta do projeto:
     ```powershell
     cd c:\Iterasys\PetStoreRobot140
     ```
   - Execute os testes:
     ```powershell
     robot __tests__
     ```

Os resultados dos testes serão exibidos no terminal e os relatórios gerados na pasta de saída padrão do Robot Framework.

## Observações
- Os dados de teste podem ser alterados nos arquivos CSV e JSON em `fixtures/`.
- O arquivo `variables.py` pode ser customizado para adicionar variáveis ou funções específicas.
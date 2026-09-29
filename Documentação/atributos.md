# Atributos

## 1. Pessoa

- Telefone
- Email
- CPF
- Nome (composto por: Primeiro Nome e Sobrenome)

## 2. Cliente

- ID_Cliente
- CPF
- Data.nasc (Data de Nascimento)

## 3. Funcionário

- ID_Funcionario (ou ID_Funcionanog)
- CPF
- Comissão
- Cargo

## 4. Agendar

- ID_Agendar
- ID_Cliente
- ID_Atendimento
- Hora
- Data
- Status

## 5. Atendimento

- ID_Atendimento
- ID_Funcionario
- ID_Anamnese
- ID_Avaliação
- ID_Agendar

## 6. Anamnese

- ID_Anamnese
- ID_Atendimento
- Medicamentos
- Histórico
- OBS

## 7. Avaliação

- ID_Avaliação
- Queixa Principal
- OBS

## 8. Procedimento

- ID_Procedimento
- Nome
- Duração
- Descrição
- Preço Base

## 9. Executa (Tabela Associativa / Relacionamento)

- ID_Executa
- ID_Atendimento
- ID_Procedimento

## 10. Pagamento

- ID_Pagamento
- Forma_Pag (Forma de Pagamento)
- Hora
- Data
- Valor total
- Status

## 11. Conta a Receber

- ID_Conta_Receber
- Descrição
- Valor
- Data_Vencimento
- Status

## 12. Conta a Pagar

- ID_Conta_Pagar
- Descrição
- Valor
- Data_Vencimento
- Status

## 13. Fluxo de Caixa

- ID_Fluxo
- Data
- Tipo (Entrada/Saída)
- Descrição
- Valor
- Saldo
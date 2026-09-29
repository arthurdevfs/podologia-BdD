# Projeto ERP — PODOLOGIA TATUAPE

## 1. Identificação da equipe

* Arthur Alves de Souza Rocha — RGM: 47606762
* Bruna Santos Dias — RGM: 48293237
* Davi de Almeida Pereira — RGM: 47488891
* Eduardo de Abreu — RGM: 47478497
* Guilherme Jussek Nogueira — RGM: 47392657
* Henry Soave Bailer — RGM: 46977244
* Julia Lindsay da Silva — RGM: 47396407
* Nicolas Gabriel Parris Reis — RGM: 47646691
* Paulo Alexandre Ferreira Martins — RGM: 48606341
* Sabrina Hadassa Gomes de Andrade — RGM: 47817593
* Yasmin da Silva Pinheiro — RGM: 49842013

## 2. Caracterização da empresa

- **Nome:** PODOLOGIA TATUAPE
- **Segmento:** Serviço
- **Porte:** Microempresa
- **Atividade principal:** Podologia

A empresa oferece tratamentos para:
- Unhas encravadas
- Calos e calosidades
- Fissuras e rachaduras
- Micoses e frieiras
- Verrugas plantares
- Corte técnico
- Cuidados especiais

## 3. Justificativa da escolha

Escolhemos a empresa por conta da oportunidade. Identificamos que a empresa tem dificuldades com administração de clientes, horários e podólogas. Com base nessas informações, projetamos uma solução para essa empresa através da modelagem de banco de dados.

## 4. Problemas identificados

* Controle de agendamentos feito manualmente;
* Possibilidade de conflito de horários;
* Dificuldade no controle dos clientes;
* Dificuldade no controle dos funcionários;
* Necessidade de organizar os atendimentos;
* Necessidade de registrar o histórico dos clientes;
* Necessidade de controlar os procedimentos realizados;
* Necessidade de registrar os pagamentos.

## 5. Processos de negócio

### Agendamento
Cliente → Agendar → Atendimento → Pagamento

### Atendimento
Cliente → Avaliação → Anamnese → Atendimento → Procedimento

### Cadastro do cliente
Cliente → Cadastro

### Realização do procedimento
Cliente → Atendimento → Funcionário → Procedimento

### Pagamento
Cliente → Atendimento → Procedimento → Pagamento → Registro do pagamento

### Avaliação
Cliente → Avaliação → Queixa principal → Observações → Atendimento

### Controle financeiro
Conta a Receber → Fluxo de Caixa
Conta a Pagar → Fluxo de Caixa

### Controle do fluxo de caixa
Conta a Receber + Conta a Pagar → Fluxo de Caixa → Saldo

## 6. Requisitos funcionais

### Usuários

* **RF01** – O sistema deverá permitir que usuários autorizados acessem o sistema por meio de e-mail e senha.
* **RF02** – O sistema deverá permitir a recuperação de senha.
* **RF03** – O sistema deverá permitir que usuários autorizados cadastrem, alterem e desativem usuários e suas permissões de acesso.

### Clientes

* **RF04** – O sistema deverá permitir cadastrar clientes.
* **RF05** – O sistema deverá permitir pesquisar clientes pelo nome ou CPF.
* **RF06** – O sistema deverá permitir atualizar os dados cadastrais dos clientes.

### Profissionais

* **RF07** – O sistema deverá permitir cadastrar, consultar e atualizar os dados dos profissionais.
* **RF08** – O sistema deverá permitir consultar a agenda dos profissionais.

### Agendamento

* **RF09** – O sistema deverá permitir realizar, alterar e cancelar agendamentos.
* **RF10** – O sistema deverá permitir consultar os horários disponíveis.
* **RF11** – O sistema deverá verificar a disponibilidade do profissional antes de confirmar um agendamento.
* **RF12** – O sistema deverá permitir enviar lembretes aos clientes antes do atendimento.

### Anamnese e atendimento

* **RF13** – O sistema deverá permitir registrar o check-in do cliente.
* **RF14** – O sistema deverá permitir preencher e consultar a anamnese do cliente.
* **RF15** – O sistema deverá permitir registrar o atendimento realizado pelo profissional.
* **RF16** – O sistema deverá permitir registrar os procedimentos realizados e suas observações.
* **RF17** – O sistema deverá calcular e registrar o valor total do atendimento.

### Pagamento e retorno

* **RF18** – O sistema deverá permitir registrar o pagamento, sua forma e seu status.
* **RF19** – O sistema deverá permitir finalizar o atendimento e registrar a necessidade de retorno.

### Consultas e estoque

* **RF20** – O sistema deverá permitir consultar o histórico de atendimentos e gerar relatórios por período, status ou profissional.


## 7. Requisitos não funcionais

* **RNF01 – Segurança:** somente usuários autorizados poderão acessar as informações do sistema.
* **RNF02 – Privacidade:** os dados pessoais e informações dos clientes deverão ser mantidos em sigilo.
* **RNF03 – Usabilidade:** o sistema deverá possuir uma interface simples e fácil de utilizar pelos funcionários.
* **RNF04 – Desempenho:** o sistema deverá apresentar as informações e realizar as operações em tempo adequado.
* **RNF05 – Integridade:** o sistema deverá manter os dados cadastrados corretos e evitar registros inconsistentes.
* **RNF06 – Disponibilidade:** o sistema deverá estar disponível durante o horário de funcionamento da empresa.
* **RNF07 – Backup:** os dados deverão possuir cópias de segurança para evitar perda de informações.
* **RNF08 – Controle de acesso:** cada usuário deverá acessar somente as funcionalidades e informações necessárias para sua função.


## 8. Regras de negócio

* **RN1** – Uma pessoa pode ser cadastrada como cliente ou funcionário, de acordo com sua função no sistema.
* **RN2** – Cada cliente deve possuir um cadastro único, identificado pelo seu ID e CPF.
* **RN3** – Um cliente pode realizar vários agendamentos, porém cada agendamento pertence a apenas um cliente.
* **RN4** – Cada agendamento deve estar associado a um único atendimento, contendo data, hora e status.
* **RN5** – Um atendimento deve possuir uma anamnese, contendo informações sobre o cliente, histórico, medicamentos e observações.
* **RN6** – Um atendimento pode incluir um ou mais procedimentos, e cada procedimento possui nome, duração, descrição e preço base.
* **RN7** – Cada atendimento deve ser realizado por um funcionário, sendo necessário registrar qual funcionário foi responsável pelo atendimento.
* **RN8** – Um atendimento pode gerar um pagamento, que deve registrar forma de pagamento, valor, data, hora e status.
* **RN9** – Todo atendimento deve possuir uma avaliação prévia, na qual serão registradas a queixa principal e as observações necessárias antes da realização do procedimento.
* **RN10** – O status do agendamento deve indicar a situação do atendimento, permitindo diferenciar, por exemplo, agendamentos pendentes, realizados ou cancelados.
* **RN11** – Toda conta a receber deve ser registrada no Fluxo de Caixa como uma entrada financeira, contendo valor, data e status da movimentação.
* **RN12** – Toda conta a pagar deve ser registrada no Fluxo de Caixa como uma saída financeira, contendo valor, data e status da movimentação.


## 9. Restrições e políticas organizacionais

* Os dados dos clientes devem ser mantidos em sigilo.
* Somente usuários autorizados podem acessar as informações.
* Cada cliente deve possuir um cadastro único.
* O CPF não deve ser duplicado entre clientes.
* Os registros dos atendimentos devem ser armazenados corretamente.
* As informações de avaliação devem ser registradas antes do atendimento.
* O status de Agendar deve representar corretamente a situação do atendimento.
* As informações de pagamento devem estar relacionadas ao atendimento correspondente.


## 10. Fluxogramas

[Fluxograma principal](Documentação/Fluxogramas/)


## 11. Entidades

- Pessoa
- Cliente
- Funcionário
- Agendar
- Atendimento
- Anamnese
- Avaliação
- Procedimento
- Executa
- Pagamento
- Conta a Receber
- Conta a Pagar
- Fluxo de Caixa


## 12. Atributos

Os atributos das entidades estão documentados no arquivo abaixo:

[Atributos](Documentação/atributos.md)


## 13. Relacionamentos

- Pessoa — é — Cliente
- Pessoa — pode ser — Funcionário
- Cliente — Agendar — Atendimento
- Atendimento — possui — Anamnese
- Avaliação — gera — Atendimento
- Atendimento — Executa — Procedimento
- Atendimento — tem — Pagamento
- Conta a Receber — gera — Fluxo de Caixa
- Conta a Pagar — gera — Fluxo de Caixa


## 14. Cardinalidades

Em desenvolvimento.


## 15. Dicionário de dados conceitual

O dicionário de dados conceitual está disponível na pasta abaixo:

[Dicionário de Dados](Documentação/Dicionário/)


## 16. DER

[Diagrama Entidade-Relacionamento](Documentação/DER/)


## 17. Justificativas técnicas

### Cliente e Agendar

Foi definida a cardinalidade 1:N entre Cliente e Agendar, pois um cliente pode realizar vários agendamentos ao longo do tempo, sendo necessário manter o histórico desses registros.

### Agendar e Atendimento

Foi utilizada Agendar como entidade associativa entre Cliente e Atendimento, pois o agendamento precisa armazenar informações próprias, como data, hora e status, permitindo controlar os horários e a situação dos atendimentos.

### Atendimento e Funcionário

Foi definido que cada Atendimento deve estar relacionado a um Funcionário, pois é necessário identificar o profissional responsável por cada atendimento realizado.

### Atendimento e Anamnese

Foi realizado o relacionamento entre Atendimento e Anamnese, pois as informações da anamnese são necessárias para registrar o histórico do cliente, incluindo medicamentos, histórico e observações.

### Atendimento e Avaliação

Foi definida a cardinalidade 1:1 entre Atendimento e Avaliação, pois cada atendimento possui uma avaliação prévia. A avaliação ocorre antes do atendimento e registra informações como queixa principal e observações.

### Atendimento e Procedimento

Foi utilizada a entidade associativa Executa para relacionar Atendimento e Procedimento, pois um atendimento pode possuir vários procedimentos e um mesmo procedimento pode ser realizado em diferentes atendimentos. Dessa forma, é possível registrar quais procedimentos foram executados em cada atendimento.

### Atendimento e Pagamento

Foi realizado o relacionamento entre Atendimento e Pagamento, pois o pagamento precisa estar vinculado ao atendimento correspondente, permitindo controlar informações como forma de pagamento, valor, data, hora e status.

### Pessoa, Cliente e Funcionário

Foi decidido manter Pessoa separada de Cliente e Funcionário, pois Pessoa armazena informações gerais, enquanto Cliente e Funcionário possuem informações específicas. Essa organização evita a repetição desnecessária de dados.

### Utilização de Agendar

Foi utilizada Agendar em vez de criar uma entidade chamada “Agendamento”, pois, no modelo da equipe, Agendar representa a associação entre Cliente e Atendimento e possui atributos próprios, como data, hora e status.

### Utilização de Executa

Foi utilizada Executa para relacionar Atendimento e Procedimento, pois existe uma relação de muitos para muitos: um atendimento pode possuir vários procedimentos e um procedimento pode estar presente em diferentes atendimentos. Isso permite registrar corretamente os procedimentos realizados em cada atendimento.

### Conta a Receber e Fluxo de Caixa

Foi realizado o relacionamento entre Conta a Receber e Fluxo de Caixa, pois os valores a receber representam entradas financeiras que devem ser registradas no fluxo de caixa, permitindo acompanhar as movimentações financeiras da empresa.

### Conta a Pagar e Fluxo de Caixa

Foi realizado o relacionamento entre Conta a Pagar e Fluxo de Caixa, pois os valores a pagar representam saídas financeiras que devem ser registradas no fluxo de caixa, permitindo controlar as despesas e movimentações da empresa.

### Utilização do Fluxo de Caixa

Foi utilizada a entidade Fluxo de Caixa para registrar as movimentações financeiras da empresa, contendo informações como data, tipo de movimentação, descrição, valor e saldo.


## 18. Conclusão

Com o desenvolvimento deste projeto, conseguimos entender melhor como funciona a modelagem de dados na prática, principalmente a importância de conhecer o funcionamento da empresa antes de pensar na estrutura do banco de dados. Ao analisar a PODOLOGIA TATUAPE, tivemos que identificar os problemas, entender os processos e pensar em quais informações realmente precisavam ser organizadas.

Durante esse processo, aprendemos a trabalhar com entidades, atributos, relacionamentos e regras de negócio, além de perceber como uma decisão em uma parte do modelo pode afetar as outras. O projeto também ajudou a desenvolver nosso raciocínio para transformar uma situação do mundo real em uma estrutura de dados mais organizada e que possa atender às necessidades da empresa.


## Documentos complementares

O Modelo Entidade-Relacionamento (MER) está disponível na pasta abaixo:

[Modelo Entidade-Relacionamento (MER)](Documentação/MER/)



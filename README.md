# Projeto ERP: Podologia Tatuapé

## Sumário

1. [Apresentação do projeto](#1-apresentação-do-projeto)
2. [Levantamento e modelagem conceitual](#2-levantamento-e-modelagem-conceitual)
3. [Evolução da modelagem](#3-evolução-da-modelagem)
4. [Modelo relacional lógico](#4-modelo-relacional-lógico)
5. [Chaves e relacionamentos](#5-chaves-e-relacionamentos)
6. [Normalização](#6-normalização)
7. [Restrições de integridade e regras de negócio](#7-restrições-de-integridade-e-regras-de-negócio)
8. [Dicionário de dados](#8-dicionário-de-dados)
9. [Implementação física e SQL](#9-implementação-física-e-sql)
10. [Massa de dados e testes](#10-massa-de-dados-e-testes)
11. [Consultas gerenciais](#11-consultas-gerenciais)
12. [Consultas de auditoria](#12-consultas-de-auditoria)
13. [Análise de dados, BI e Inteligência Artificial](#13-análise-de-dados-bi-e-inteligência-artificial)
14. [Documentação e evolução do projeto](#14-documentação-e-evolução-do-projeto)
15. [Conclusão](#15-conclusão)
16. [Documentos complementares](#16-documentos-complementares)

---

## 1. Apresentação do projeto

### 1.1. Identificação da equipe

- Arthur Alves de Souza Rocha, RGM: 47606762
- Bruna Santos Dias, RGM: 48293237
- Davi de Almeida Pereira, RGM: 47488891
- Eduardo de Abreu, RGM: 47478497
- Guilherme Jussek Nogueira, RGM: 47392657
- Henry Soave Bailer, RGM: 46977244
- Julia Lindsay da Silva, RGM: 47396407
- Nicolas Gabriel Parris Reis, RGM: 47646691
- Paulo Alexandre Ferreira Martins, RGM: 48606341
- Yasmin da Silva Pinheiro, RGM: 49842013

### 1.2. Contexto do projeto

O projeto ERP Podologia Tatuapé tem como objetivo desenvolver a modelagem e a estrutura de um banco de dados para apoiar o funcionamento de uma empresa fictícia do ramo de podologia.

A solução contempla informações relacionadas a clientes, funcionários, agendamentos, atendimentos, procedimentos, produtos, fornecedores, estoque e operações financeiras. Também considera o gerenciamento de usuários, perfis, permissões e comissões.

O banco de dados foi planejado para organizar as informações da empresa, estabelecer relações entre os registros e permitir consultas que apoiem o acompanhamento das atividades operacionais e gerenciais.

### 1.3. Objetivos

Os principais objetivos do projeto são:

- Levantar os requisitos e as regras de negócio da empresa.
- Desenvolver os modelos conceitual e lógico do banco de dados.
- Definir entidades, atributos, chaves e relacionamentos.
- Aplicar os conceitos de normalização e integridade dos dados.
- Implementar a estrutura do banco por meio de comandos SQL.
- Inserir dados fictícios para representar situações de uso do sistema.
- Desenvolver consultas gerenciais e de auditoria.
- Explorar possibilidades de análise de dados, Business Intelligence (BI) e Inteligência Artificial (IA).

### 1.4. Escopo

O sistema contempla cadastros, agendamentos, atendimentos, anamneses, avaliações, procedimentos, fornecedores, produtos, movimentações de estoque, contas a pagar e a receber, recebimentos, pagamentos e comissões.

A estrutura também contempla usuários, perfis e permissões de acesso, além de lembretes relacionados aos agendamentos.

O escopo acadêmico concentra-se na modelagem, na implementação do banco de dados e na análise das informações. As propostas de BI e IA são apresentadas como possibilidades de evolução, distintas das funcionalidades implementadas diretamente no banco.

### 1.5. Acesso às entregas

Os materiais do projeto estão organizados em duas entregas principais.

**Entrega 1: levantamento e modelagem**

- [Modelo Entidade-Relacionamento (MER)](Documenta%C3%A7%C3%A3o/MER/)
- [Diagrama Entidade-Relacionamento (DER)](Documenta%C3%A7%C3%A3o/DER/)
- [Dicionário de dados](Documenta%C3%A7%C3%A3o/Dicionario/)
- [Fluxogramas](Documenta%C3%A7%C3%A3o/Fluxogramas/)
- [Atributos do modelo](Documenta%C3%A7%C3%A3o/atributos.md)
- [Diários de bordo](Documenta%C3%A7%C3%A3o/Diarios%20de%20Bordo/)

**Entrega 2: implementação e consultas**

- [Imagens e registros visuais](Entrega%202/imagens/)
- [Scripts SQL](Entrega%202/scripts/)
- [Script completo do banco, dados e consultas](Entrega%202/scripts/script-completo-banco-massa-consultas.sql)
- [Exportação do banco de dados](Entrega%202/scripts/exportacao-banco-podologia-tatuape.sql)
- [Consultas adicionais](Entrega%202/scripts/consultas-adicionais-etapas-18-e-19.sql)

---

## 2. Levantamento e modelagem conceitual

### 2.1. Levantamento de requisitos

O levantamento de requisitos buscou identificar as informações necessárias para representar as atividades da Podologia Tatuapé e organizar os dados utilizados nos processos da empresa.

Entre os requisitos considerados estão:

- Registrar clientes e seus dados de identificação e contato.
- Cadastrar funcionários e suas informações.
- Gerenciar usuários, perfis e permissões de acesso.
- Organizar agendamentos e acompanhar seus estados.
- Registrar atendimentos, anamneses, avaliações e procedimentos.
- Controlar produtos, fornecedores e movimentações de estoque.
- Registrar contas a pagar, contas a receber, recebimentos e pagamentos.
- Acompanhar comissões relacionadas aos atendimentos.
- Disponibilizar consultas para análise operacional, financeira e auditoria.

Esses requisitos orientaram a identificação das entidades, a definição dos atributos e a construção dos relacionamentos do banco de dados.

### 2.2. Modelo conceitual

O modelo conceitual representa as principais entidades do negócio e os relacionamentos entre elas, sem depender diretamente dos detalhes de implementação de um sistema gerenciador de banco de dados.

A modelagem considera entidades relacionadas a pessoas, clientes, funcionários, agendamentos, atendimentos, procedimentos, fornecedores, produtos e movimentações financeiras.

A entidade `PESSOA` centraliza informações gerais de identificação. As entidades `CLIENTE` e `FUNCIONARIO` representam informações específicas de cada papel, permitindo relacionar os cadastros aos dados comuns da pessoa.

Essa organização favorece a separação entre informações compartilhadas e informações específicas de cada entidade, contribuindo para a estruturação dos dados e para a definição dos relacionamentos.

### 2.3. Representação visual do modelo conceitual

A imagem abaixo apresenta parte da modelagem conceitual desenvolvida para o projeto.

![Diagrama conceitual de pessoas, clientes e funcionários](Entrega%202/imagens/entrega-final-pagina-4-imagem-1.png)

### 2.4. Documentação do levantamento

Os materiais complementares do levantamento e da modelagem estão disponíveis na pasta [Documentação](Documenta%C3%A7%C3%A3o/), incluindo diagramas, dicionário de dados, fluxogramas, atributos e registros do desenvolvimento.

---

## 3. Evolução da modelagem

A modelagem foi desenvolvida progressivamente, partindo da identificação dos requisitos e das entidades necessárias para representar as atividades da empresa.

Inicialmente, foram definidas as principais entidades e suas relações. Em seguida, os atributos foram organizados e as chaves foram estabelecidas para identificar os registros e permitir as associações entre as tabelas.

O detalhamento da estrutura também considerou regras de negócio, restrições de integridade e necessidades relacionadas aos processos operacionais e financeiros.

A transformação da modelagem em uma estrutura implementável envolveu a definição das tabelas, dos tipos de dados, das chaves, das restrições e dos comandos SQL necessários à organização do banco.

Os diagramas, documentos e scripts disponíveis no repositório permitem consultar os materiais produzidos durante o desenvolvimento e compreender a organização da solução.

---

## 4. Modelo relacional lógico

### 4.1. Organização do modelo

O modelo relacional organiza os dados em tabelas, cada uma responsável por representar uma entidade ou associação do negócio.

As tabelas possuem atributos que descrevem as informações armazenadas e chaves que permitem identificar os registros e estabelecer relacionamentos.

O modelo relacional implementado no script completo contempla as seguintes 26 tabelas:

- `PESSOA`
- `TELEFONE_PESSOA`
- `CLIENTE`
- `FUNCIONARIO`
- `PERFIL`
- `PERMISSAO`
- `PERFIL_PERMISSAO`
- `USUARIO`
- `AGENDAMENTO`
- `LEMBRETE`
- `ATENDIMENTO`
- `ANAMNESE`
- `AVALIACAO`
- `PROCEDIMENTO`
- `EXECUTA`
- `FORNECEDOR`
- `PRODUTO`
- `PRODUTO_FORNECEDOR`
- `MOVIMENTACAO_ESTOQUE`
- `PROCEDIMENTO_PRODUTO`
- `CONTA_RECEBER`
- `RECEBIMENTO`
- `CONTA_PAGAR`
- `PAGAMENTO_CONTA_PAGAR`
- `FLUXO_CAIXA`
- `COMISSAO_ATENDIMENTO`

Essa estrutura abrange as principais áreas do negócio, desde os cadastros e o controle de acesso até as operações de atendimento, estoque e financeiro.

### 4.2. Representação visual do modelo relacional

Os diagramas a seguir apresentam partes do modelo relacional desenvolvido para o projeto.

![Diagrama do modelo relacional, parte 1](Entrega%202/imagens/entrega-final-pagina-5-imagem-1.png)

![Diagrama do modelo relacional, parte 2](Entrega%202/imagens/entrega-final-pagina-6-imagem-1.png)

![Diagrama do modelo relacional, parte 3](Entrega%202/imagens/entrega-final-pagina-7-imagem-1.png)

### 4.3. Organização das entidades

As entidades podem ser agrupadas de acordo com as áreas de negócio que representam:

- **Pessoas e cadastros:** identificação de pessoas, clientes, funcionários e telefones.
- **Acesso ao sistema:** usuários, perfis, permissões e suas associações.
- **Agendamento e atendimento:** agendamentos, lembretes, atendimentos, anamneses, avaliações e procedimentos.
- **Produtos e estoque:** fornecedores, produtos, associações entre produtos e fornecedores, utilização de produtos e movimentações de estoque.
- **Financeiro:** contas a pagar, contas a receber, recebimentos, pagamentos, fluxo de caixa e comissões.

Essa divisão facilita a compreensão das responsabilidades de cada grupo de tabelas e dos relacionamentos existentes no modelo.

---

## 5. Chaves e relacionamentos

### 5.1. Chaves primárias

A chave primária (*Primary Key* ou PK) identifica unicamente cada registro de uma tabela.

No modelo relacional, as chaves primárias permitem distinguir registros de pessoas, clientes, funcionários, agendamentos, atendimentos, produtos e demais entidades.

Uma chave primária deve garantir a identificação única de cada registro e não pode conter valores nulos.

### 5.2. Chaves estrangeiras

A chave estrangeira (*Foreign Key* ou FK) estabelece uma relação entre tabelas, permitindo que um registro faça referência a outro registro existente.

Por exemplo, um agendamento pode referenciar um cliente, enquanto um atendimento pode estar associado ao agendamento correspondente.

As chaves estrangeiras contribuem para a integridade referencial, evitando referências a registros inexistentes quando as restrições estão definidas e habilitadas.

### 5.3. Relacionamentos entre entidades

Os relacionamentos representam as associações entre os elementos do negócio.

Entre os exemplos considerados na modelagem estão:

- Pessoas associadas aos cadastros específicos de clientes ou funcionários.
- Clientes associados a agendamentos.
- Agendamentos relacionados aos atendimentos correspondentes.
- Atendimentos relacionados aos procedimentos realizados.
- Produtos associados a fornecedores.
- Procedimentos associados aos produtos utilizados.
- Contas financeiras relacionadas aos recebimentos e pagamentos.
- Perfis relacionados às permissões por meio de uma tabela associativa.

Essas relações permitem representar as associações existentes entre as informações e realizar consultas que envolvam diferentes áreas da empresa.

### 5.4. Relacionamentos muitos para muitos

Um relacionamento muitos para muitos (N:N) ocorre quando vários registros de uma entidade podem estar associados a vários registros de outra entidade.

No modelo relacional, esse tipo de relacionamento pode ser representado por uma tabela associativa.

A tabela `PERFIL_PERMISSAO`, por exemplo, associa perfis às permissões disponíveis. As tabelas `PRODUTO_FORNECEDOR` e `PROCEDIMENTO_PRODUTO` também representam associações entre entidades.

As tabelas associativas permitem registrar as combinações entre entidades de maneira estruturada, utilizando chaves para identificar as associações.

### 5.5. Importância dos relacionamentos

A definição adequada dos relacionamentos permite representar as regras de associação do negócio e consultar informações relacionadas em diferentes tabelas.

Quando combinados com chaves primárias, chaves estrangeiras e restrições apropriadas, os relacionamentos contribuem para a consistência dos dados e para a confiabilidade das consultas.

---

## 6. Normalização

A normalização é um processo de organização das tabelas que busca reduzir redundâncias e evitar anomalias de inserção, atualização e exclusão.

Sua análise considera a estrutura das relações, as chaves e as dependências funcionais entre os atributos.

### 6.1. Primeira Forma Normal (1FN)

A Primeira Forma Normal estabelece que os atributos devem conter valores atômicos, sem listas de valores agrupadas em uma mesma célula.

No projeto, a separação dos telefones em `TELEFONE_PESSOA` permite representar diferentes números associados a uma pessoa sem precisar criar colunas repetidas, como `telefone1`, `telefone2` e `telefone3`.

Essa organização também permite consultar os telefones de maneira independente dos demais atributos da pessoa.

### 6.2. Segunda Forma Normal (2FN)

A Segunda Forma Normal exige que a tabela esteja na Primeira Forma Normal e que cada atributo não chave dependa integralmente da chave primária, especialmente quando ela é composta.

Nas tabelas associativas, a análise deve considerar se os atributos dependem da combinação completa de chaves que identifica cada associação.

A identificação dessas dependências ajuda a determinar se os atributos estão organizados na relação adequada.

### 6.3. Terceira Forma Normal (3FN)

A Terceira Forma Normal busca evitar dependências transitivas inadequadas entre atributos não chave.

A separação das informações em entidades próprias pode reduzir a repetição de dados e facilitar a manutenção dos registros.

Por exemplo, a organização dos dados gerais em `PESSOA` e das informações específicas em `CLIENTE` e `FUNCIONARIO` permite distinguir os atributos comuns daqueles relacionados a cada papel.

A análise da 3FN deve considerar as dependências funcionais existentes em cada tabela e a relação entre seus atributos e suas chaves.

### 6.4. Benefícios da normalização

A normalização contribui para:

- Reduzir a repetição desnecessária de informações.
- Diminuir o risco de inconsistências durante atualizações.
- Facilitar a manutenção dos dados.
- Melhorar a organização das relações entre tabelas.
- Tornar as regras de integridade mais claras.
- Favorecer a evolução da estrutura do banco de dados.

A aplicação das formas normais está relacionada à análise das dependências funcionais e à organização dos atributos nas relações.

---

## 7. Restrições de integridade e regras de negócio

As restrições de integridade ajudam a garantir que os dados armazenados respeitem as condições definidas para o sistema.

### 7.1. Integridade de entidade

A integridade de entidade é garantida principalmente pelas chaves primárias, que identificam unicamente os registros de cada tabela e não admitem valores nulos.

### 7.2. Integridade referencial

A integridade referencial é mantida por meio das chaves estrangeiras, que relacionam registros de diferentes tabelas.

Quando uma chave estrangeira está ativa, ela impede a inserção de referências para registros inexistentes, de acordo com as regras definidas para a relação.

### 7.3. Regras de negócio consideradas

Entre as regras consideradas no projeto estão:

- Os cadastros de clientes e funcionários devem estar relacionados às informações gerais de pessoa.
- Os agendamentos permitem acompanhar os estados definidos para o processo.
- Os atendimentos registram informações relacionadas aos procedimentos realizados.
- Os produtos possuem informações utilizadas no controle de estoque.
- As contas a receber estão relacionadas aos recebimentos registrados.
- As contas a pagar estão relacionadas aos pagamentos registrados.
- O cálculo de comissões considera os atendimentos e os valores definidos pela regra de negócio.
- O fluxo de caixa reúne informações relacionadas às movimentações financeiras.

### 7.4. Regras consideradas na implementação

A implementação e a massa de dados contemplam regras específicas, entre elas:

- Os CPFs são armazenados somente com dígitos.
- A estrutura de contas a receber utiliza os estados definidos no banco implementado.
- Os recebimentos e pagamentos confirmados são considerados no contexto das movimentações de caixa, conforme os critérios estabelecidos.
- A comissão corresponde a 30% do valor executado por atendimento finalizado, de acordo com a regra definida no projeto.

Essas regras devem ser interpretadas em conjunto com as estruturas, as restrições e os comandos definidos nos scripts SQL.

---

## 8. Dicionário de dados

O dicionário de dados documenta as tabelas e seus atributos, descrevendo a finalidade das informações armazenadas e auxiliando na compreensão da estrutura do banco.

Esse material funciona como referência para consultar os atributos, compreender sua utilização e apoiar a manutenção e a evolução do banco de dados.

O dicionário está disponível na pasta:

[**Acessar o dicionário de dados**](Documenta%C3%A7%C3%A3o/Dicionario/)

A documentação complementar da modelagem também pode ser consultada no arquivo [atributos.md](Documenta%C3%A7%C3%A3o/atributos.md).

## 9. Implementação do Banco de Dados

A implementação física do banco de dados foi realizada em SQL, utilizando o SGBD MySQL. Nessa etapa, o modelo relacional foi transformado em estruturas que permitem armazenar, relacionar e consultar as informações do sistema.

O banco de dados utiliza a codificação `utf8mb4` e a collation `utf8mb4_unicode_ci`, permitindo o armazenamento adequado de caracteres especiais e acentuação.

A estrutura contempla 26 tabelas, com definição de chaves primárias (PK), chaves estrangeiras (FK), restrições de unicidade, valores padrão e demais regras de integridade necessárias para manter a consistência dos dados.

### Arquivos SQL

- [Script completo do banco de dados, massa de dados e consultas](scripts/script-completo-banco-massa-consultas.sql)
- [Script de exportação do banco de dados](scripts/exportacao-banco-podologia-tatuape.sql)
- [Consultas complementares](scripts/consultas-adicionais-etapas-18-e-19.sql)

**Registro da implementação:**

![Implementação do banco de dados](imagens/etapas-16-17-pagina-3-imagem-1.png)

O script principal reúne a criação da estrutura, a inserção dos dados e as consultas utilizadas no desenvolvimento do projeto. Para executá-lo em um ambiente com dados existentes, recomenda-se realizar previamente uma cópia de segurança, pois o script contém comandos de preparação do banco de dados.

## 10. Massa de Dados e Cenários de Teste

Para representar o funcionamento do sistema, foi criada uma massa de dados fictícia, distribuída entre as 26 tabelas do banco de dados, totalizando 324 registros.

Os dados foram elaborados para representar situações comuns à rotina de uma clínica de podologia, permitindo trabalhar com diferentes cenários e relacionamentos entre as informações.

Entre os cenários contemplados estão:

- Cadastro de clientes, funcionários e usuários.
- Agendamentos realizados, cancelados e com ausência do cliente.
- Atendimentos em andamento e finalizados.
- Registros de anamnese e avaliação.
- Procedimentos executados.
- Movimentações de entrada e saída de produtos.
- Controle de estoque e identificação de produtos com quantidade reduzida.
- Contas a receber e a pagar.
- Recebimentos parciais e pendentes.
- Controle de comissões relacionadas aos atendimentos.

A massa de dados possibilita explorar diferentes situações do negócio e utilizar as consultas para acompanhar informações operacionais e financeiras.

**Registro da massa de dados e dos testes:**

![Massa de dados e testes](imagens/etapas-16-17-pagina-4-imagem-1.png)

## 11. Consultas Gerenciais (G01 a G10)

Foram elaboradas consultas SQL com o objetivo de transformar os dados armazenados em informações úteis para o acompanhamento e a gestão da clínica.

As consultas principais estão organizadas da seguinte maneira:

| Consulta | Objetivo |
|---|---|
| G01 | Identificar os procedimentos mais realizados, seus valores e participação no faturamento. |
| G02 | Comparar os valores faturados e recebidos mensalmente. |
| G03 | Analisar a quantidade de atendimentos, o faturamento e o valor médio por podólogo. |
| G04 | Identificar os clientes com maior volume de gastos e consultar suas últimas visitas. |
| G05 | Analisar os atendimentos realizados, cancelados e as ausências dos clientes. |
| G06 | Consultar contas a receber em atraso. |
| G07 | Identificar produtos com estoque baixo e comparar preços de compra entre fornecedores. |
| G08 | Acompanhar entradas, saídas e saldo do fluxo de caixa mensal. |
| G09 | Identificar clientes sem atendimento há mais de 30 dias e sem agendamento futuro. |
| G10 | Consultar comissões pagas e pendentes por funcionário. |

Além das consultas principais, foram desenvolvidas consultas complementares para ampliar as possibilidades de análise, incluindo a distribuição dos recebimentos por forma de pagamento e o acompanhamento de cancelamentos e ausências.

**Objetivo das consultas:** facilitar a análise das informações do negócio, apoiando o acompanhamento financeiro, operacional e comercial da clínica.

## 12. Consultas de Auditoria e Integridade (A01 a A22)

Também foram desenvolvidas consultas voltadas à verificação da consistência dos dados e ao acompanhamento de possíveis divergências entre os registros relacionados.

As consultas de auditoria estão organizadas em 22 verificações:

| Consulta | Verificação |
|---|---|
| A01 | Configuração de perfis e permissões de acesso. |
| A02 | Pessoas cadastradas simultaneamente como clientes e funcionários. |
| A03 | Inconsistências relacionadas aos e-mails de login. |
| A04 | Atendimentos finalizados sem o registro de anamnese esperado. |
| A05 | Divergências entre os status de agendamentos e atendimentos. |
| A06 | Inconsistências relacionadas às datas dos registros. |
| A07 | Conferência dos valores das contas a receber. |
| A08 | Identificação de recebimentos acima dos valores previstos. |
| A09 | Verificação de vencimentos e status das contas a receber. |
| A10 | Conferência dos lançamentos do fluxo de caixa. |
| A11 | Identificação de estoque negativo. |
| A12 | Identificação de produtos abaixo da quantidade mínima. |
| A13 | Verificação dos lembretes cadastrados. |
| A14 | Identificação de clientes sem registro de anamnese. |
| A15 | Consulta de contas a receber em atraso. |
| A16 | Consulta de contas a pagar em atraso. |
| A17 | Conferência dos valores das comissões. |
| A18 | Identificação de atendimentos finalizados sem comissão correspondente. |
| A19 | Consulta de recebimentos pendentes. |
| A20 | Comparação entre recebimentos e lançamentos no fluxo de caixa. |
| A21 | Comparação entre pagamentos e lançamentos no fluxo de caixa. |
| A22 | Conferência do saldo acumulado do fluxo de caixa. |

Essas consultas permitem acompanhar diferentes aspectos da integridade das informações, contribuindo para a identificação de divergências e para a manutenção da consistência dos registros.

As consultas complementares também ampliam a análise de situações específicas, como atendimentos finalizados sem anamnese e contas a pagar vinculadas a fornecedores.

## 13. Business Intelligence (BI) e Inteligência Artificial (IA)

A estrutura do banco de dados também permite explorar possibilidades de utilização de Business Intelligence (BI) e Inteligência Artificial (IA) para apoiar a gestão da clínica.

### Possibilidades de aplicação de BI

A partir das informações armazenadas, podem ser desenvolvidos painéis gerenciais e indicadores para acompanhar:

- Faturamento mensal e evolução das receitas.
- Procedimentos mais realizados.
- Desempenho dos profissionais.
- Frequência e histórico dos clientes.
- Situação das contas a receber e a pagar.
- Movimentações financeiras.
- Níveis de estoque e necessidade de reposição.
- Cancelamentos e ausências em agendamentos.

### Possibilidades de aplicação de IA

Com uma base de dados organizada e um histórico suficiente de informações, podem ser exploradas aplicações de Inteligência Artificial, como:

- Previsão de demanda por procedimentos.
- Identificação de padrões de cancelamento e ausência.
- Estimativa de consumo de produtos.
- Apoio ao planejamento de compras e reposição de estoque.
- Identificação de padrões de comportamento dos clientes.

Essas aplicações representam possibilidades de evolução do sistema. Sua implementação dependeria de etapas adicionais de desenvolvimento, preparação dos dados e avaliação dos resultados.

O uso dessas tecnologias deve considerar a segurança das informações, a privacidade dos clientes e os princípios da Lei Geral de Proteção de Dados (LGPD).

## 14. Documentação e Evolução do Projeto

Durante o desenvolvimento, foram produzidos documentos para registrar as etapas de modelagem, estruturação e implementação do banco de dados.

A documentação complementar está disponível no diretório [`Documentação`](../Documenta%C3%A7%C3%A3o/), incluindo:

- **DER:** Diagrama Entidade-Relacionamento.
- **MER:** Modelo Entidade-Relacionamento.
- **Dicionário de Dados:** representação das tabelas e seus atributos.
- **Atributos:** descrição complementar dos campos.
- **Fluxogramas:** representação de processos e etapas do sistema.
- **Diários de Bordo:** registros do desenvolvimento do projeto.

Os documentos podem ser consultados para compreender a organização do banco de dados e acompanhar a evolução da solução.

## 15. Considerações Finais

O projeto ERP Podologia Tatuapé teve como objetivo desenvolver uma estrutura de banco de dados capaz de representar as principais atividades de uma clínica de podologia, contemplando desde o cadastro de clientes e funcionários até o controle de agendamentos, atendimentos, procedimentos, estoque e movimentações financeiras.

Ao longo do desenvolvimento, foram aplicados conceitos fundamentais de modelagem de dados, como entidades, atributos, relacionamentos, cardinalidades, chaves primárias e estrangeiras e normalização.

A implementação em SQL permitiu transformar o modelo relacional em uma estrutura funcional, acompanhada de uma massa de dados fictícia e de consultas voltadas à análise gerencial e à verificação da integridade das informações.

O resultado reúne os conhecimentos trabalhados durante a disciplina e apresenta uma base para futuras melhorias e ampliações, incluindo recursos de BI e Inteligência Artificial.
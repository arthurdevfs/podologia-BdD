
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

O projeto tem como objetivo desenvolver a modelagem e a estrutura de um banco de dados para apoiar o funcionamento de uma empresa fictícia de podologia, denominada **Podologia Tatuapé**.

A proposta considera as principais atividades da empresa, incluindo o cadastro de clientes e funcionários, o gerenciamento de agendamentos e atendimentos, o registro de procedimentos, o controle de produtos e estoque, a administração financeira e o acompanhamento de comissões.

O banco de dados foi planejado para organizar as informações, reduzir inconsistências e permitir a realização de consultas que apoiem as atividades operacionais e gerenciais.

### 1.3. Objetivos

Os principais objetivos são:

- Levantar os requisitos e as regras de negócio da empresa.
- Desenvolver os modelos conceitual e lógico do banco de dados.
- Aplicar os conceitos de chaves primárias e estrangeiras, relacionamentos e normalização.
- Implementar a estrutura física por meio de comandos SQL.
- Inserir dados fictícios para testar o funcionamento do banco.
- Desenvolver consultas gerenciais e de auditoria.
- Explorar possibilidades de análise de dados, Business Intelligence (BI) e Inteligência Artificial (IA).

### 1.4. Escopo

O sistema contempla cadastros, agendamentos, atendimentos, anamneses, avaliações, procedimentos, fornecedores, produtos, movimentações de estoque, contas a pagar e a receber, recebimentos, pagamentos e comissões.

A estrutura também considera usuários, perfis e permissões, além de lembretes relacionados aos agendamentos.

O projeto acadêmico concentra-se na modelagem, implementação e análise do banco de dados. As propostas de BI e IA são conceituais e não representam, por si só, a implementação de dashboards funcionais ou modelos preditivos.

---

## 2. Levantamento e modelagem conceitual

### 2.1. Levantamento de requisitos

O levantamento de requisitos buscou identificar as informações necessárias para representar as atividades da Podologia Tatuapé.

Entre as necessidades identificadas estão:

- Registrar clientes e seus dados de contato.
- Cadastrar funcionários e suas informações.
- Controlar usuários, perfis e permissões de acesso.
- Organizar agendamentos e seus respectivos estados.
- Registrar atendimentos, anamneses, avaliações e procedimentos realizados.
- Controlar produtos, fornecedores e movimentações de estoque.
- Registrar contas a pagar, contas a receber, recebimentos e pagamentos.
- Calcular e acompanhar comissões.
- Produzir consultas para análise e auditoria dos dados.

Esses requisitos orientaram a construção dos modelos e a definição das entidades e dos relacionamentos.

### 2.2. Modelo conceitual

O modelo conceitual representa as principais entidades do negócio e os relacionamentos entre elas, sem depender diretamente dos detalhes de implementação de um sistema gerenciador de banco de dados.

A modelagem considera, entre outras, as entidades relacionadas a pessoas, clientes, funcionários, agendamentos, atendimentos, procedimentos, produtos, fornecedores e movimentações financeiras.

A entidade `PESSOA` centraliza informações comuns, permitindo que clientes e funcionários compartilhem os atributos gerais de identificação. As entidades específicas representam os dados próprios de cada papel.

Essa organização evita repetir os mesmos dados básicos em diferentes cadastros e facilita a representação das relações entre as entidades.

### 2.3. Representação visual

A imagem abaixo apresenta parte da modelagem conceitual desenvolvida para o projeto.

![Diagrama conceitual de pessoas, clientes e funcionários](Entrega%202/imagens/entrega-final-pagina-4-imagem-1.png)

### 2.4. Documentação do levantamento

Os materiais complementares do levantamento e da modelagem podem ser consultados na pasta `Documentação`, que reúne os diagramas, os registros do desenvolvimento e outros documentos elaborados durante o projeto.

---

## 3. Evolução da modelagem

A modelagem do banco de dados foi desenvolvida de forma progressiva, acompanhando o detalhamento dos requisitos e a identificação das necessidades da empresa.

Inicialmente, foram identificadas as entidades e suas relações. Em seguida, os atributos foram organizados e as chaves foram definidas para permitir a identificação dos registros e a ligação entre as tabelas.

Com a evolução do projeto, foram detalhadas as regras de negócio, as restrições de integridade e as estruturas necessárias para representar os processos operacionais e financeiros.

A implementação física também exigiu adaptações em relação ao modelo lógico, de modo que algumas diferenças entre os modelos devem ser consideradas ao analisar a versão final do banco de dados.

A evolução foi documentada por meio de diagramas, dicionário de dados, scripts SQL e outros materiais organizados no repositório.

---

## 4. Modelo relacional lógico

### 4.1. Organização do modelo

O modelo relacional lógico organiza os dados em tabelas, cada uma responsável por representar uma entidade ou associação do negócio.

As tabelas possuem atributos que descrevem suas informações e chaves que permitem identificar registros e estabelecer relacionamentos.

O modelo lógico contempla as seguintes tabelas:

- `PESSOA`
- `TELEFONE_PESSOA`
- `CLIENTE`
- `FUNCIONARIO`
- `JORNADA_FUNCIONARIO`
- `USUARIO`
- `PERFIL`
- `PERMISSAO`
- `PERFIL_PERMISSAO`
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
- `PROCEDIMENTO_PRODUTO`
- `MOVIMENTACAO_ESTOQUE`
- `CONTA_RECEBER`
- `RECEBIMENTO`
- `CONTA_PAGAR`
- `PAGAMENTO_CONTA_PAGAR`
- `FLUXO_CAIXA`
- `COMISSAO`

### 4.2. Representação do modelo

Os diagramas abaixo apresentam partes do modelo relacional desenvolvido durante o projeto.

![Diagrama do modelo relacional, parte 1](Entrega%202/imagens/entrega-final-pagina-5-imagem-1.png)

![Diagrama do modelo relacional, parte 2](Entrega%202/imagens/entrega-final-pagina-6-imagem-1.png)

![Diagrama do modelo relacional, parte 3](Entrega%202/imagens/entrega-final-pagina-7-imagem-1.png)

### 4.3. Observação sobre o modelo lógico e a implementação

O modelo lógico documentado não corresponde integralmente à estrutura do banco implementado no script SQL final.

Entre as diferenças identificadas estão:

- O modelo lógico apresenta `COMISSAO`, enquanto a implementação utiliza `comissao_atendimento`.
- A tabela `JORNADA_FUNCIONARIO` aparece no modelo lógico, mas não está presente na implementação final identificada.
- Algumas estruturas e regras foram adaptadas durante a implementação física.

Por isso, o modelo lógico deve ser interpretado como a representação documentada do projeto, enquanto o script SQL representa a estrutura efetivamente definida para a implementação final.

---

## 5. Chaves e relacionamentos

### 5.1. Chaves primárias

A chave primária (Primary Key ou PK) identifica de forma única cada registro de uma tabela.

No modelo, as chaves primárias permitem distinguir registros de pessoas, clientes, funcionários, agendamentos, atendimentos, produtos e demais entidades.

A definição de uma chave primária impede que dois registros da mesma tabela compartilhem o mesmo identificador primário.

### 5.2. Chaves estrangeiras

A chave estrangeira (Foreign Key ou FK) estabelece uma relação entre tabelas e permite que um registro faça referência a outro registro existente.

Por exemplo, um agendamento pode fazer referência a um cliente, e um atendimento pode estar relacionado a um agendamento.

As chaves estrangeiras ajudam a manter a integridade referencial, evitando referências a registros inexistentes quando as restrições estão corretamente definidas e habilitadas.

### 5.3. Relacionamentos entre entidades

Os relacionamentos representam as associações existentes entre os elementos do negócio.

Entre os exemplos considerados na modelagem estão:

- Pessoas associadas a seus cadastros específicos de cliente ou funcionário.
- Clientes associados a agendamentos.
- Agendamentos relacionados aos atendimentos correspondentes.
- Atendimentos relacionados aos procedimentos realizados.
- Produtos associados a fornecedores.
- Procedimentos associados aos produtos utilizados.
- Contas financeiras relacionadas aos recebimentos e pagamentos.
- Perfis relacionados às permissões por meio de uma tabela associativa.

### 5.4. Relacionamentos muitos para muitos

Quando duas entidades possuem uma relação muitos para muitos (N:N), uma tabela associativa pode representar essa relação no modelo relacional.

A tabela `PERFIL_PERMISSAO`, por exemplo, associa perfis às permissões disponíveis. As tabelas `PRODUTO_FORNECEDOR` e `PROCEDIMENTO_PRODUTO` também representam associações entre entidades.

Essa solução permite registrar múltiplas associações sem armazenar listas de valores repetidos em uma única coluna.

---

## 6. Normalização

A normalização é um processo de organização das tabelas que busca reduzir redundâncias e evitar anomalias de inserção, atualização e exclusão.

### 6.1. Primeira Forma Normal (1FN)

A Primeira Forma Normal estabelece que os atributos devem conter valores atômicos, sem listas de valores agrupadas em uma mesma célula.

No projeto, a separação dos telefones em `TELEFONE_PESSOA` permite registrar mais de um telefone para uma pessoa sem criar colunas repetidas, como `telefone1`, `telefone2` e `telefone3`.

### 6.2. Segunda Forma Normal (2FN)

A Segunda Forma Normal exige que a tabela esteja na Primeira Forma Normal e que os atributos não chave dependam de toda a chave primária, especialmente quando ela é composta.

A análise das tabelas associativas deve considerar se seus atributos dependem da combinação completa de chaves que identifica cada associação.

### 6.3. Terceira Forma Normal (3FN)

A Terceira Forma Normal busca eliminar dependências transitivas inadequadas entre atributos não chave.

A separação de informações em entidades próprias ajuda a evitar que dados de uma entidade sejam repetidos desnecessariamente em tabelas de outras entidades.

Por exemplo, manter os dados gerais de pessoas em `PESSOA` e as informações específicas em `CLIENTE` e `FUNCIONARIO` favorece a organização dos atributos comuns e específicos.

### 6.4. Benefícios da normalização

A normalização contribui para:

- Reduzir a repetição desnecessária de informações.
- Diminuir o risco de inconsistências durante atualizações.
- Facilitar a manutenção dos dados.
- Melhorar a organização das relações entre as tabelas.
- Tornar as regras de integridade mais claras.

A análise das formas normais deve ser feita considerando as dependências funcionais e a estrutura efetivamente implementada, e não apenas os nomes das tabelas.

---

## 7. Restrições de integridade e regras de negócio

As restrições de integridade ajudam a garantir que os dados armazenados respeitem as condições definidas para o sistema.

### 7.1. Integridade de entidade

A integridade de entidade é garantida principalmente pelas chaves primárias, que identificam unicamente cada registro e não devem admitir valores nulos.

### 7.2. Integridade referencial

A integridade referencial é mantida por meio das chaves estrangeiras, que relacionam registros de diferentes tabelas.

Quando uma chave estrangeira está ativa, ela impede que sejam inseridas referências para registros inexistentes, conforme as regras definidas para a relação.

### 7.3. Regras de negócio consideradas

Entre as regras consideradas no projeto estão:

- O cadastro de clientes e funcionários deve estar relacionado às informações gerais de pessoa.
- Os agendamentos devem permitir acompanhar seus estados.
- Os atendimentos devem registrar os procedimentos realizados.
- Os produtos devem possuir informações que permitam controlar o estoque.
- As contas a receber devem estar relacionadas aos recebimentos correspondentes.
- As contas a pagar devem estar relacionadas aos pagamentos registrados.
- O cálculo de comissões deve considerar os atendimentos e os valores utilizados pela regra de negócio definida.
- O fluxo de caixa deve considerar os registros financeiros que efetivamente atendem aos critérios de movimentação estabelecidos.

### 7.4. Regras observadas na implementação

Na massa de dados e na implementação final, foram consideradas algumas adaptações específicas:

- Os CPFs são armazenados apenas com dígitos.
- O modelo de contas a receber não utiliza um estado `paga`; por isso, contas quitadas podem continuar com o estado `aberta` na estrutura implementada.
- Somente recebimentos e pagamentos confirmados geram movimentações de caixa.
- A comissão é calculada em 30% do valor executado por atendimento finalizado.

Essas regras devem ser interpretadas conforme a implementação existente, inclusive quando houver diferenças em relação ao modelo lógico inicial.

---

## 8. Dicionário de dados

O dicionário de dados documenta as tabelas e os atributos do banco, descrevendo a finalidade das informações armazenadas e auxiliando na compreensão da estrutura.

Ele funciona como referência para quem precisa consultar, manter ou evoluir o banco de dados.

O projeto possui materiais de documentação relacionados ao dicionário de dados, organizados na pasta `Documentação`, incluindo os arquivos de imagem correspondentes.

Os arquivos do dicionário podem ser consultados no diretório:

`Documentação/Dicionario/`



## 9. Implementação física e SQL

O projeto possui um script SQL para a criação do banco `podologia_tatuape`, com codificação `utf8mb4` e collation `utf8mb4_unicode_ci`.

O script completo mais recente reúne a criação das estruturas, a inserção de dados fictícios, as consultas gerenciais e as consultas de auditoria.

### 9.1. Estruturas implementadas

O script contém 26 tabelas:

| Área | Tabelas |
|---|---|
| Pessoas e acesso | `pessoa`, `telefone_pessoa`, `cliente`, `funcionario`, `perfil`, `permissao`, `perfil_permissao`, `usuario` |
| Agendamento e atendimento | `agendamento`, `lembrete`, `atendimento`, `anamnese`, `avaliacao`, `procedimento`, `executa` |
| Estoque | `fornecedor`, `produto`, `produto_fornecedor`, `movimentacao_estoque`, `procedimento_produto` |
| Financeiro e comissões | `conta_receber`, `recebimento`, `conta_pagar`, `pagamento_conta_pagar`, `fluxo_caixa`, `comissao_atendimento` |

### 9.2. Chaves e restrições

A implementação utiliza:

- Chaves primárias simples e compostas.
- Chaves estrangeiras para relacionar as tabelas.
- Restrições de unicidade.
- Restrições `CHECK` para validar valores e condições.
- Valores padrão para determinados atributos.
- Regras de exclusão em relacionamentos específicos.

Esses recursos ajudam a preservar a integridade referencial e a consistência dos registros.

### 9.3. Diferenças em relação ao modelo lógico

A implementação física não corresponde integralmente a todas as estruturas documentadas no modelo lógico.

Entre as diferenças estão:

- A tabela `JORNADA_FUNCIONARIO` aparece no modelo lógico documentado, mas não no script completo mais recente.
- O SQL utiliza `COMISSAO_ATENDIMENTO`, enquanto o modelo lógico apresenta `COMISSAO`.
- A tabela `FLUXO_CAIXA` do SQL guarda referências a recebimentos e pagamentos e uma descrição, sem armazenar diretamente valor e data da movimentação.
- Alguns atributos e relacionamentos financeiros possuem estruturas diferentes entre o modelo lógico e a implementação.

Essas diferenças são registradas para distinguir o modelo previsto da estrutura efetivamente representada pelo SQL, sem substituir ou modificar os arquivos técnicos.

### 9.4. Arquivos SQL

Os scripts completos estão disponíveis nos seguintes arquivos:

- **Script completo:** [script-completo-banco-massa-consultas.sql](Entrega%202/scripts/script-completo-banco-massa-consultas.sql), com a criação do banco, tabelas, massa de dados e consultas.
- **Exportação do banco:** [exportacao-banco-podologia-tatuape.sql](Entrega%202/scripts/exportacao-banco-podologia-tatuape.sql).
- **Consultas adicionais das Etapas 18 e 19:** [consultas-adicionais-etapas-18-e-19.sql](Entrega%202/scripts/consultas-adicionais-etapas-18-e-19.sql).

#### Registro visual da documentação SQL

A imagem abaixo foi extraída do PDF das etapas 16 e 17 e complementa a descrição da implementação.

![Captura do banco de dados presente no PDF das etapas 16 e 17](Entrega%202/imagens/etapas-16-17-pagina-3-imagem-1.png)

*Figura 5. Captura de tela incorporada ao PDF recebido. A imagem é apresentada como documentação visual, não como comprovação independente de que todo o script foi executado.*

> **Atenção:** o script utiliza `DROP DATABASE IF EXISTS podologia_tatuape` antes da criação do banco. Executá-lo pode apagar o banco existente com esse nome. A execução deve ser realizada somente em um ambiente apropriado, considerando esse comportamento.

---

## 10. Massa de dados e testes

O script SQL contém registros fictícios destinados a demonstrar cenários de uso do banco.

A massa de dados contempla pessoas, clientes, funcionários, usuários, agendamentos, atendimentos, procedimentos, fornecedores, produtos, movimentações de estoque e registros financeiros.

Na versão documentada da massa de dados, o script contém **324 registros distribuídos em 26 tabelas**. Os dados pessoais são fictícios e foram preparados para fins acadêmicos. O conjunto contempla diferentes cenários, como reagendamentos, faltas, atendimentos em andamento e finalizados, pagamentos parciais, contas vencidas, movimentações de estoque, produtos abaixo do mínimo e comissões.

### 10.1. Objetivos dos testes

O conjunto de dados e as consultas permitem examinar aspectos como:

- Relacionamentos entre tabelas.
- Consistência de registros associados.
- Compatibilidade entre situações de agendamentos e atendimentos.
- Valores de contas a receber e recebimentos.
- Valores de contas a pagar e pagamentos.
- Movimentações e saldo de estoque.
- Cálculos de comissões.
- Registros financeiros relacionados às operações.

### 10.2. Verificação dos resultados

O script apresenta comentários com resultados esperados para diversas consultas de auditoria, incluindo verificações que devem retornar zero registros e consultas informativas que identificam situações específicas.

Esses resultados esperados fazem parte da documentação do script. Sua confirmação depende da execução das consultas no ambiente do banco.

A imagem a seguir complementa o registro dos dados documentado nas etapas 16 e 17.

![Captura de dados no banco presente no PDF das etapas 16 e 17](Entrega%202/imagens/etapas-16-17-pagina-4-imagem-1.png)

*Figura 6. Captura de dados incorporada ao documento das etapas 16 e 17. Os resultados das consultas gerenciais e de auditoria devem ser confirmados no ambiente de execução.*

---

## 11. Consultas gerenciais

O script contém dez consultas gerenciais, identificadas como G01 a G10. Elas foram elaboradas para produzir informações úteis ao acompanhamento das atividades operacionais e financeiras da empresa.

| Código | Objetivo |
|---|---|
| G01 | Identificar os procedimentos mais realizados, seus valores e sua participação na receita. |
| G02 | Comparar valores faturados e recebidos por mês. |
| G03 | Apresentar indicadores de agendamentos, receita e valor médio por atendimento, agrupados por podólogo. |
| G04 | Identificar clientes com maiores gastos e suas últimas visitas. |
| G05 | Analisar a proporção de agendamentos realizados, cancelados e com ausência. |
| G06 | Identificar clientes com contas a receber vencidas e seus saldos pendentes. |
| G07 | Identificar produtos abaixo do estoque mínimo e comparar preços de compra de fornecedores. |
| G08 | Apresentar entradas, saídas e resultado líquido mensal do fluxo financeiro. |
| G09 | Identificar clientes sem atendimento há mais de 30 dias e sem agendamento futuro. |
| G10 | Comparar comissões pagas e pendentes por funcionário. |

As consultas relacionam informações operacionais e financeiras para apoiar o acompanhamento da empresa. Seus resultados dependem dos registros presentes no banco e dos critérios utilizados em cada consulta.

### 11.1. Consultas gerenciais complementares

O arquivo [consultas-adicionais-etapas-18-e-19.sql](Entrega%202/scripts/consultas-adicionais-etapas-18-e-19.sql) preserva as duas consultas gerenciais e as duas consultas de auditoria adicionais recebidas. A segunda consulta gerencial mantém o SQL original e precisa de revisão na condição de junção antes da execução.

A consulta de formas de pagamento apresenta quantidade, valor e participação percentual de cada modalidade nos recebimentos confirmados. Ela **não calcula taxas cobradas pelas operadoras**, pois o arquivo não contém campos de taxa; essa análise exigiria dados adicionais.

A consulta de cancelamentos e faltas tem como objetivo apoiar ações para reduzir horários perdidos. Antes de executá-la, é necessário revisar o vínculo entre `agendamento` e `cliente` utilizado no arquivo, pois a condição de junção registrada não corresponde ao relacionamento esperado entre essas tabelas.

A Etapa 20 interpreta as consultas em termos de possíveis decisões administrativas. O relatório esclarece que essa etapa é uma interpretação gerencial, não a implementação de um sistema de BI.

---

## 12. Consultas de auditoria

As consultas de auditoria, identificadas como A01 a A22, procuram situações que merecem verificação na consistência dos dados.

Elas auxiliam na identificação de possíveis divergências entre os registros operacionais, financeiros e de estoque.

| Código | Objetivo da verificação |
|---|---|
| A01 | Verificar a configuração de perfis e permissões. |
| A02 | Identificar pessoas que acumulam papéis de cliente e funcionário, conforme os critérios da consulta. |
| A03 | Verificar possíveis inconsistências nos e-mails utilizados para login. |
| A04 | Identificar atendimentos finalizados sem o registro esperado de anamnese. |
| A05 | Verificar incompatibilidades entre o estado do agendamento e o atendimento. |
| A06 | Examinar a consistência das datas de agendamento e atendimento. |
| A07 | Verificar valores registrados em contas a receber. |
| A08 | Identificar recebimentos acima do valor devido. |
| A09 | Examinar a compatibilidade entre vencimentos e estados das contas a receber. |
| A10 | Verificar registros relacionados ao fluxo de caixa. |
| A11 | Identificar possíveis saldos negativos de estoque. |
| A12 | Identificar produtos abaixo do estoque mínimo. |
| A13 | Verificar situações relacionadas aos lembretes. |
| A14 | Identificar clientes sem anamnese, conforme os critérios definidos. |
| A15 | Identificar contas a receber vencidas. |
| A16 | Identificar contas a pagar vencidas. |
| A17 | Verificar a consistência dos valores das comissões. |
| A18 | Identificar atendimentos finalizados sem a comissão esperada. |
| A19 | Identificar recebimentos pendentes. |
| A20 | Examinar a relação entre recebimentos e movimentações financeiras. |
| A21 | Examinar a relação entre pagamentos e movimentações financeiras. |
| A22 | Verificar o saldo acumulado relacionado às entradas e saídas financeiras. |

As consultas são instrumentos de verificação e não significam que todas as situações apontadas estejam necessariamente presentes no banco. O resultado de cada uma depende da massa de dados e das regras implementadas.

### 12.1. Consultas de auditoria complementares

O arquivo adicional das Etapas 18 e 19 inclui duas verificações:

- Atendimentos finalizados sem anamnese.
- Contas a pagar associadas a um fornecedor inexistente.

A segunda situação normalmente deve ser impedida por uma chave estrangeira ativa. A consulta pode ser útil para verificar a integridade dos dados, mas seu resultado depende das restrições e dos dados efetivamente existentes no ambiente.

Os resultados dessas quatro consultas adicionais não foram registrados na documentação disponível. Portanto, não se afirma que tenham sido executadas com sucesso nem se atribuem resultados específicos a elas.

---

## 13. Análise de dados, BI e Inteligência Artificial

A Etapa 21 apresenta uma proposta conceitual de utilização dos dados da Podologia Tatuapé para apoiar decisões administrativas.

O relatório considera o uso de indicadores gerenciais, ferramentas de Business Intelligence (BI) e possíveis aplicações de Inteligência Artificial (IA). As propostas são possibilidades de evolução do projeto, e não funcionalidades já implementadas.

### 13.1. Business Intelligence (BI)

Business Intelligence é o conjunto de processos e ferramentas utilizados para transformar dados em informações que apoiam a tomada de decisões.

No contexto da Podologia Tatuapé, os dados do banco poderiam ser organizados em indicadores e apresentados por meio de relatórios e dashboards.

Entre as possibilidades estão:

- Acompanhamento das entradas e saídas financeiras.
- Análise de agendamentos, cancelamentos e faltas.
- Identificação dos procedimentos mais realizados.
- Acompanhamento de contas a pagar e a receber.
- Monitoramento do consumo e da disponibilidade dos produtos.
- Análise do desempenho operacional da empresa.

Essas informações poderiam facilitar a identificação de tendências e apoiar o planejamento das atividades.

### 13.2. Indicadores estratégicos propostos

Os seguintes indicadores foram propostos na Etapa 21. Sua apresentação não significa que os valores tenham sido calculados ou validados nesta etapa.

| Indicador | Forma de análise | Finalidade |
|---|---|---|
| Recebimentos mensais | Soma dos recebimentos válidos por mês | Acompanhar entradas financeiras. |
| Pagamentos mensais | Soma dos pagamentos efetivos por mês | Monitorar despesas pagas. |
| Saldo do período | Entradas líquidas menos saídas líquidas | Avaliar a movimentação de caixa. |
| Taxa de faltas | Faltas ÷ agendamentos considerados × 100% | Identificar ausências. |
| Taxa de cancelamento | Cancelamentos ÷ agendamentos considerados × 100% | Monitorar cancelamentos. |
| Procedimentos mais realizados | Contagem ou soma das quantidades executadas | Identificar serviços de maior demanda. |
| Consumo de produtos | Soma das saídas por produto | Apoiar o controle de materiais. |
| Saldo de estoque | Entradas menos saídas | Acompanhar a disponibilidade. |

Os indicadores precisam utilizar critérios consistentes de período, situação dos registros e tratamento de cancelamentos e estornos.

### 13.3. Possibilidades de Inteligência Artificial (IA)

A IA poderia ampliar as análises ao identificar padrões e estimar situações futuras. Diferentemente do BI descritivo, que apresenta informações sobre eventos registrados, determinadas técnicas de IA podem apoiar previsões. As aplicações abaixo são possibilidades futuras e dependem de histórico suficiente, dados de qualidade e validação técnica.

#### Previsão de demanda por atendimentos

A demanda pode variar conforme os dias da semana, períodos do mês e tipos de procedimento. Um modelo de séries temporais ou aprendizado de máquina poderia utilizar histórico de agendamentos, datas, horários, procedimentos, situações e disponibilidade dos profissionais para estimar a quantidade de atendimentos esperada.

As estimativas poderiam apoiar o planejamento da agenda e a distribuição dos profissionais. A massa de dados fictícia criada para testes acadêmicos não é suficiente, por si só, para demonstrar a precisão de um modelo preditivo real.

#### Identificação de padrões de faltas e cancelamentos

Um modelo estatístico ou de aprendizado de máquina poderia estudar padrões relacionados a faltas e cancelamentos, considerando, quando disponíveis, dia da semana, horário, antecedência dos cancelamentos e histórico de comparecimento.

Os resultados poderiam apoiar estratégias de confirmação de consultas e organização da agenda. Não deveriam ser usados automaticamente para negar atendimento ou justificar tratamento discriminatório. Também seria necessário avaliar vieses, qualidade dos dados e proteção das informações pessoais.

#### Previsão de consumo e reposição de estoque

Um modelo poderia estimar o consumo futuro com base no histórico de movimentações, quantidade consumida por produto, procedimentos realizados, materiais previstos e datas das movimentações. Informações confiáveis sobre prazo de entrega e políticas de estoque poderiam apoiar recomendações de reposição.

O benefício esperado seria melhorar o planejamento de compras, reduzir desperdícios e diminuir o risco de indisponibilidade de materiais.

### 13.4. Proposta de integração entre banco de dados, BI e IA

Uma arquitetura futura poderia seguir este fluxo:

**Banco de dados relacional → Extração e tratamento dos dados → Indicadores e análises → Dashboards de BI → Modelos preditivos de IA → Apoio à decisão.**

Inicialmente, consultas SQL poderiam organizar os dados necessários aos indicadores. Em uma implementação futura, ferramentas como Power BI poderiam consumir conjuntos de dados preparados para apresentação visual. Para aplicações de IA, linguagens como Python e bibliotecas de análise de dados poderiam ser utilizadas na preparação, exploração e modelagem das informações.

A utilização dessas ferramentas é uma possibilidade de evolução e não uma funcionalidade implementada nesta entrega.

### 13.5. Qualidade, segurança e governança dos dados

A confiabilidade das análises depende da qualidade das informações armazenadas. A proposta da Etapa 21 destaca os seguintes cuidados:

- **Integridade dos dados:** relacionamentos, chaves e restrições devem evitar inconsistências que comprometam os indicadores.
- **Padronização:** datas, situações dos agendamentos e categorias de movimentação devem seguir critérios uniformes.
- **Rastreabilidade:** operações financeiras, alterações relevantes e estornos devem preservar informações suficientes para auditoria.
- **Privacidade:** dados pessoais e informações relacionadas à saúde devem receber proteção adequada, observando a Lei Geral de Proteção de Dados Pessoais (LGPD).
- **Controle de acesso:** usuários devem acessar apenas os dados necessários às suas atividades.
- **Validação analítica:** indicadores e previsões precisam ser verificados antes de orientar decisões administrativas.
- **Avaliação de modelos:** aplicações preditivas exigem avaliação de erros, vieses, atualização dos dados e limitações de interpretação.

### 13.6. Limitações da proposta

As aplicações de BI e IA apresentadas na Etapa 21 possuem caráter conceitual. O projeto dispõe de modelagem relacional, scripts SQL, massa de dados fictícia e consultas gerenciais, mas ainda há divergências entre versões dos scripts e aspectos de integração que precisam ser validados.

Por esse motivo, não se afirma que todos os indicadores tenham sido calculados, que as análises tenham sido executadas em uma plataforma de BI ou que modelos de IA tenham sido treinados, avaliados ou implantados. Uma aplicação real exigiria consolidar o banco, validar a integridade dos registros, reunir histórico operacional suficiente e realizar testes com critérios definidos.

---

## 14. Documentação e evolução do projeto

O repositório GitHub reúne a documentação e os materiais produzidos durante o desenvolvimento do projeto.

A pasta `Documentação/` contém materiais conceituais e complementares, incluindo diagramas, fluxogramas, dicionário de dados, atributos e diários de bordo. A Etapa 21 também apresenta possibilidades futuras de análise de dados, BI e IA, sem afirmar que dashboards ou modelos preditivos tenham sido implementados.

A documentação da evolução reúne as decisões de modelagem, o modelo relacional, as considerações sobre normalização e a implementação física do banco.

A manutenção da documentação permite acompanhar a evolução do projeto e consultar os materiais utilizados para representar os processos da empresa.

---

## 15. Conclusão

O projeto ERP Podologia Tatuapé permitiu trabalhar com diferentes etapas da modelagem de banco de dados, desde o levantamento dos problemas e requisitos do negócio até a organização das estruturas relacionais e a implementação SQL.

A evolução do projeto aborda o relacionamento entre entidades, o uso de chaves primárias e estrangeiras, a normalização, as restrições de integridade e a organização das informações operacionais e financeiras.

A implementação também contempla dados fictícios, consultas gerenciais e consultas de auditoria, oferecendo uma base para analisar informações e examinar a consistência dos registros.

O projeto evidencia a importância de documentar as decisões de modelagem e distinguir os requisitos e modelos previstos das estruturas efetivamente implementadas. Essa separação facilita a compreensão do banco, a análise dos resultados e a evolução futura da solução.

---

## 16. Documentos complementares

Os documentos da Entrega 1 estão organizados na pasta `Documentação/`, que contém o DER, o MER, os fluxogramas, o dicionário de dados, os diários de bordo e o arquivo `atributos.md`. Os materiais da Entrega 2 estão organizados na pasta `Entrega 2/`, que contém as subpastas `Imagens/` e `Scripts/`.

- **DER:** diagramas Entidade-Relacionamento, conforme os arquivos já existentes em `Documentação/DER/`.
- **MER:** modelo Entidade-Relacionamento, conforme os arquivos já existentes em `Documentação/MER/`.
- **Dicionário de dados:** documentação dos atributos e das tabelas, na pasta `Documentação/Dicionario/`.
- **Fluxogramas:** representação dos processos de negócio, na pasta `Documentação/Fluxogramas/`.
- **Atributos:** documentação dos atributos das entidades do modelo conceitual, no arquivo `Documentação/atributos.md`.
- **Diários de bordo:** registros das atividades desenvolvidas ao longo do projeto, na pasta `Documentação/Diarios de Bordo/`.
- **Script completo:** [script-completo-banco-massa-consultas.sql](Entrega%202/scripts/script-completo-banco-massa-consultas.sql).
- **Exportação do banco:** [exportacao-banco-podologia-tatuape.sql](Entrega%202/Scripts/exportacao-banco-podologia-tatuape.sql).
- **Consultas adicionais das Etapas 18 e 19:** [consultas-adicionais-etapas-18-e-19.sql](Entrega%202/Scripts/consultas-adicionais-etapas-18-e-19.sql).

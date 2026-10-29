-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 23/10/2026 às 01:11
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `podologia_tatuape`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamento`
--

CREATE TABLE `agendamento` (
  `id_agendamento` int(10) UNSIGNED NOT NULL,
  `id_cliente` int(10) UNSIGNED NOT NULL,
  `id_funcionario` int(10) UNSIGNED NOT NULL,
  `data_agendamento` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pendente'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `anamnese`
--

CREATE TABLE `anamnese` (
  `id_atendimento` int(10) UNSIGNED NOT NULL,
  `medicamentos` text DEFAULT NULL,
  `historico` text DEFAULT NULL,
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atendimento`
--

CREATE TABLE `atendimento` (
  `id_atendimento` int(10) UNSIGNED NOT NULL,
  `id_agendamento` int(10) UNSIGNED NOT NULL,
  `data_hora_checkin` datetime DEFAULT NULL,
  `data_hora_finalizacao` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'em_andamento',
  `retorno_necessario` tinyint(1) NOT NULL DEFAULT 0,
  `data_retorno_sugerida` date DEFAULT NULL,
  `observacoes` text DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `avaliacao`
--

CREATE TABLE `avaliacao` (
  `id_atendimento` int(10) UNSIGNED NOT NULL,
  `queixa_principal` varchar(500) NOT NULL,
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(10) UNSIGNED NOT NULL,
  `id_pessoa` int(10) UNSIGNED NOT NULL,
  `data_nascimento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `id_pessoa`, `data_nascimento`) VALUES
(1, 1, '2000-05-15');

-- --------------------------------------------------------

--
-- Estrutura para tabela `comissao`
--

CREATE TABLE `comissao` (
  `id_comissao` int(10) UNSIGNED NOT NULL,
  `id_funcionario` int(10) UNSIGNED NOT NULL,
  `id_atendimento` int(10) UNSIGNED NOT NULL,
  `valor_base` decimal(10,2) NOT NULL,
  `percentual` decimal(5,2) NOT NULL,
  `valor_comissao` decimal(10,2) NOT NULL,
  `data_comissao` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pendente'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `conta_pagar`
--

CREATE TABLE `conta_pagar` (
  `id_conta_pagar` int(10) UNSIGNED NOT NULL,
  `id_fornecedor` int(10) UNSIGNED DEFAULT NULL,
  `descricao` varchar(255) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_vencimento` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'aberta'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `conta_receber`
--

CREATE TABLE `conta_receber` (
  `id_conta_receber` int(10) UNSIGNED NOT NULL,
  `id_atendimento` int(10) UNSIGNED NOT NULL,
  `numero_parcela` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `descricao` varchar(255) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_vencimento` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'aberta'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `executa`
--

CREATE TABLE `executa` (
  `id_atendimento` int(10) UNSIGNED NOT NULL,
  `id_procedimento` int(10) UNSIGNED NOT NULL,
  `quantidade` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `valor_aplicado` decimal(10,2) NOT NULL,
  `observacoes` text DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fluxo_caixa`
--

CREATE TABLE `fluxo_caixa` (
  `id_fluxo` int(10) UNSIGNED NOT NULL,
  `id_recebimento` int(10) UNSIGNED DEFAULT NULL,
  `id_pagamento_conta` int(10) UNSIGNED DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `id_fornecedor` int(10) UNSIGNED NOT NULL,
  `nome` varchar(150) NOT NULL,
  `documento` varchar(20) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `id_funcionario` int(10) UNSIGNED NOT NULL,
  `id_pessoa` int(10) UNSIGNED NOT NULL,
  `cargo` varchar(80) NOT NULL,
  `comissao` decimal(5,2) NOT NULL DEFAULT 0.00,
  `salario` decimal(10,2) NOT NULL
) ;

--
-- Despejando dados para a tabela `funcionario`
--

INSERT INTO `funcionario` (`id_funcionario`, `id_pessoa`, `cargo`, `comissao`, `salario`) VALUES
(1, 2, 'Podologa', 10.00, 2800.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `lembrete`
--

CREATE TABLE `lembrete` (
  `id_lembrete` int(10) UNSIGNED NOT NULL,
  `id_agendamento` int(10) UNSIGNED NOT NULL,
  `data_hora_envio` datetime NOT NULL,
  `canal` varchar(20) NOT NULL,
  `status_envio` varchar(20) NOT NULL DEFAULT 'pendente'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `movimentacao_estoque`
--

CREATE TABLE `movimentacao_estoque` (
  `id_movimentacao` int(10) UNSIGNED NOT NULL,
  `id_produto` int(10) UNSIGNED NOT NULL,
  `id_fornecedor` int(10) UNSIGNED DEFAULT NULL,
  `tipo` varchar(10) NOT NULL,
  `quantidade` decimal(10,3) NOT NULL,
  `data_hora` datetime NOT NULL DEFAULT current_timestamp(),
  `motivo` varchar(255) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamento_conta_pagar`
--

CREATE TABLE `pagamento_conta_pagar` (
  `id_pagamento_conta` int(10) UNSIGNED NOT NULL,
  `id_conta_pagar` int(10) UNSIGNED NOT NULL,
  `forma_pagamento` varchar(20) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_hora_pagamento` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil`
--

CREATE TABLE `perfil` (
  `id_perfil` int(10) UNSIGNED NOT NULL,
  `nome` varchar(60) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil_permissao`
--

CREATE TABLE `perfil_permissao` (
  `id_perfil` int(10) UNSIGNED NOT NULL,
  `id_permissao` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissao`
--

CREATE TABLE `permissao` (
  `id_permissao` int(10) UNSIGNED NOT NULL,
  `codigo` varchar(80) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pessoa`
--

CREATE TABLE `pessoa` (
  `id_pessoa` int(10) UNSIGNED NOT NULL,
  `nome` varchar(80) NOT NULL,
  `sobrenome` varchar(120) NOT NULL,
  `cpf` char(11) NOT NULL,
  `email` varchar(254) DEFAULT NULL
) ;

--
-- Despejando dados para a tabela `pessoa`
--

INSERT INTO `pessoa` (`id_pessoa`, `nome`, `sobrenome`, `cpf`, `email`) VALUES
(1, 'Joao', 'Silva', '12345678901', 'joao.novo@email.com'),
(2, 'Maria', 'Souza', '98765432100', 'maria@email.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `procedimento`
--

CREATE TABLE `procedimento` (
  `id_procedimento` int(10) UNSIGNED NOT NULL,
  `nome` varchar(120) NOT NULL,
  `descricao` text DEFAULT NULL,
  `duracao_minutos` smallint(5) UNSIGNED NOT NULL,
  `preco_base` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `procedimento_produto`
--

CREATE TABLE `procedimento_produto` (
  `id_procedimento` int(10) UNSIGNED NOT NULL,
  `id_produto` int(10) UNSIGNED NOT NULL,
  `quantidade_padrao` decimal(10,3) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(10) UNSIGNED NOT NULL,
  `nome` varchar(120) NOT NULL,
  `descricao` text DEFAULT NULL,
  `unidade_medida` varchar(20) NOT NULL,
  `estoque_minimo` decimal(10,3) NOT NULL DEFAULT 0.000,
  `preco_venda` decimal(10,2) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto_fornecedor`
--

CREATE TABLE `produto_fornecedor` (
  `id_produto` int(10) UNSIGNED NOT NULL,
  `id_fornecedor` int(10) UNSIGNED NOT NULL,
  `preco_compra` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `recebimento`
--

CREATE TABLE `recebimento` (
  `id_recebimento` int(10) UNSIGNED NOT NULL,
  `id_conta_receber` int(10) UNSIGNED NOT NULL,
  `forma_pagamento` varchar(20) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_hora_recebimento` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'confirmado'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `telefone_pessoa`
--

CREATE TABLE `telefone_pessoa` (
  `id_pessoa` int(10) UNSIGNED NOT NULL,
  `numero` varchar(20) NOT NULL,
  `tipo` varchar(20) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(10) UNSIGNED NOT NULL,
  `id_funcionario` int(10) UNSIGNED NOT NULL,
  `id_perfil` int(10) UNSIGNED NOT NULL,
  `email_login` varchar(254) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `token_recuperacao` varchar(255) DEFAULT NULL,
  `token_expira_em` datetime DEFAULT NULL
) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamento`
--
ALTER TABLE `agendamento`
  ADD PRIMARY KEY (`id_agendamento`),
  ADD UNIQUE KEY `uq_agendamento_funcionario_horario` (`id_funcionario`,`data_agendamento`,`hora_inicio`),
  ADD KEY `fk_agendamento_cliente` (`id_cliente`);

--
-- Índices de tabela `anamnese`
--
ALTER TABLE `anamnese`
  ADD PRIMARY KEY (`id_atendimento`);

--
-- Índices de tabela `atendimento`
--
ALTER TABLE `atendimento`
  ADD PRIMARY KEY (`id_atendimento`),
  ADD UNIQUE KEY `uq_atendimento_agendamento` (`id_agendamento`);

--
-- Índices de tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD PRIMARY KEY (`id_atendimento`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `uq_cliente_pessoa` (`id_pessoa`);

--
-- Índices de tabela `comissao`
--
ALTER TABLE `comissao`
  ADD PRIMARY KEY (`id_comissao`),
  ADD KEY `fk_comissao_funcionario` (`id_funcionario`),
  ADD KEY `fk_comissao_atendimento` (`id_atendimento`);

--
-- Índices de tabela `conta_pagar`
--
ALTER TABLE `conta_pagar`
  ADD PRIMARY KEY (`id_conta_pagar`),
  ADD KEY `fk_cp_fornecedor` (`id_fornecedor`);

--
-- Índices de tabela `conta_receber`
--
ALTER TABLE `conta_receber`
  ADD PRIMARY KEY (`id_conta_receber`),
  ADD UNIQUE KEY `uq_conta_receber_parcela` (`id_atendimento`,`numero_parcela`);

--
-- Índices de tabela `executa`
--
ALTER TABLE `executa`
  ADD PRIMARY KEY (`id_atendimento`,`id_procedimento`),
  ADD KEY `fk_executa_procedimento` (`id_procedimento`);

--
-- Índices de tabela `fluxo_caixa`
--
ALTER TABLE `fluxo_caixa`
  ADD PRIMARY KEY (`id_fluxo`),
  ADD UNIQUE KEY `uq_fluxo_recebimento` (`id_recebimento`),
  ADD UNIQUE KEY `uq_fluxo_pagamento` (`id_pagamento_conta`);

--
-- Índices de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`id_fornecedor`),
  ADD UNIQUE KEY `uq_fornecedor_documento` (`documento`);

--
-- Índices de tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id_funcionario`),
  ADD UNIQUE KEY `uq_funcionario_pessoa` (`id_pessoa`);

--
-- Índices de tabela `lembrete`
--
ALTER TABLE `lembrete`
  ADD PRIMARY KEY (`id_lembrete`),
  ADD KEY `fk_lembrete_agendamento` (`id_agendamento`);

--
-- Índices de tabela `movimentacao_estoque`
--
ALTER TABLE `movimentacao_estoque`
  ADD PRIMARY KEY (`id_movimentacao`),
  ADD KEY `fk_me_produto` (`id_produto`),
  ADD KEY `fk_me_fornecedor` (`id_fornecedor`);

--
-- Índices de tabela `pagamento_conta_pagar`
--
ALTER TABLE `pagamento_conta_pagar`
  ADD PRIMARY KEY (`id_pagamento_conta`),
  ADD KEY `fk_pcp_conta` (`id_conta_pagar`);

--
-- Índices de tabela `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id_perfil`),
  ADD UNIQUE KEY `uq_perfil_nome` (`nome`);

--
-- Índices de tabela `perfil_permissao`
--
ALTER TABLE `perfil_permissao`
  ADD PRIMARY KEY (`id_perfil`,`id_permissao`),
  ADD KEY `fk_pp_permissao` (`id_permissao`);

--
-- Índices de tabela `permissao`
--
ALTER TABLE `permissao`
  ADD PRIMARY KEY (`id_permissao`),
  ADD UNIQUE KEY `uq_permissao_codigo` (`codigo`);

--
-- Índices de tabela `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`id_pessoa`),
  ADD UNIQUE KEY `uq_pessoa_cpf` (`cpf`),
  ADD UNIQUE KEY `uq_pessoa_email` (`email`);

--
-- Índices de tabela `procedimento`
--
ALTER TABLE `procedimento`
  ADD PRIMARY KEY (`id_procedimento`),
  ADD UNIQUE KEY `uq_procedimento_nome` (`nome`);

--
-- Índices de tabela `procedimento_produto`
--
ALTER TABLE `procedimento_produto`
  ADD PRIMARY KEY (`id_procedimento`,`id_produto`),
  ADD KEY `fk_pprod_produto` (`id_produto`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`),
  ADD UNIQUE KEY `uq_produto_nome` (`nome`);

--
-- Índices de tabela `produto_fornecedor`
--
ALTER TABLE `produto_fornecedor`
  ADD PRIMARY KEY (`id_produto`,`id_fornecedor`),
  ADD KEY `fk_pf_fornecedor` (`id_fornecedor`);

--
-- Índices de tabela `recebimento`
--
ALTER TABLE `recebimento`
  ADD PRIMARY KEY (`id_recebimento`),
  ADD KEY `fk_recebimento_conta` (`id_conta_receber`);

--
-- Índices de tabela `telefone_pessoa`
--
ALTER TABLE `telefone_pessoa`
  ADD PRIMARY KEY (`id_pessoa`,`numero`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `uq_usuario_funcionario` (`id_funcionario`),
  ADD UNIQUE KEY `uq_usuario_email` (`email_login`),
  ADD KEY `fk_usuario_perfil` (`id_perfil`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamento`
--
ALTER TABLE `agendamento`
  MODIFY `id_agendamento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atendimento`
--
ALTER TABLE `atendimento`
  MODIFY `id_atendimento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `comissao`
--
ALTER TABLE `comissao`
  MODIFY `id_comissao` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `conta_pagar`
--
ALTER TABLE `conta_pagar`
  MODIFY `id_conta_pagar` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `conta_receber`
--
ALTER TABLE `conta_receber`
  MODIFY `id_conta_receber` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fluxo_caixa`
--
ALTER TABLE `fluxo_caixa`
  MODIFY `id_fluxo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `id_fornecedor` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `id_funcionario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lembrete`
--
ALTER TABLE `lembrete`
  MODIFY `id_lembrete` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `movimentacao_estoque`
--
ALTER TABLE `movimentacao_estoque`
  MODIFY `id_movimentacao` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pagamento_conta_pagar`
--
ALTER TABLE `pagamento_conta_pagar`
  MODIFY `id_pagamento_conta` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id_perfil` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `permissao`
--
ALTER TABLE `permissao`
  MODIFY `id_permissao` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pessoa`
--
ALTER TABLE `pessoa`
  MODIFY `id_pessoa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `procedimento`
--
ALTER TABLE `procedimento`
  MODIFY `id_procedimento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `recebimento`
--
ALTER TABLE `recebimento`
  MODIFY `id_recebimento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamento`
--
ALTER TABLE `agendamento`
  ADD CONSTRAINT `fk_agendamento_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_agendamento_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `anamnese`
--
ALTER TABLE `anamnese`
  ADD CONSTRAINT `fk_anamnese_atendimento` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `atendimento`
--
ALTER TABLE `atendimento`
  ADD CONSTRAINT `fk_atendimento_agendamento` FOREIGN KEY (`id_agendamento`) REFERENCES `agendamento` (`id_agendamento`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD CONSTRAINT `fk_avaliacao_atendimento` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `comissao`
--
ALTER TABLE `comissao`
  ADD CONSTRAINT `fk_comissao_atendimento` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comissao_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `conta_pagar`
--
ALTER TABLE `conta_pagar`
  ADD CONSTRAINT `fk_cp_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `conta_receber`
--
ALTER TABLE `conta_receber`
  ADD CONSTRAINT `fk_cr_atendimento` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `executa`
--
ALTER TABLE `executa`
  ADD CONSTRAINT `fk_executa_atendimento` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_executa_procedimento` FOREIGN KEY (`id_procedimento`) REFERENCES `procedimento` (`id_procedimento`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `fluxo_caixa`
--
ALTER TABLE `fluxo_caixa`
  ADD CONSTRAINT `fk_fluxo_pagamento` FOREIGN KEY (`id_pagamento_conta`) REFERENCES `pagamento_conta_pagar` (`id_pagamento_conta`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fluxo_recebimento` FOREIGN KEY (`id_recebimento`) REFERENCES `recebimento` (`id_recebimento`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `fk_funcionario_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `lembrete`
--
ALTER TABLE `lembrete`
  ADD CONSTRAINT `fk_lembrete_agendamento` FOREIGN KEY (`id_agendamento`) REFERENCES `agendamento` (`id_agendamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `movimentacao_estoque`
--
ALTER TABLE `movimentacao_estoque`
  ADD CONSTRAINT `fk_me_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_me_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `pagamento_conta_pagar`
--
ALTER TABLE `pagamento_conta_pagar`
  ADD CONSTRAINT `fk_pcp_conta` FOREIGN KEY (`id_conta_pagar`) REFERENCES `conta_pagar` (`id_conta_pagar`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `perfil_permissao`
--
ALTER TABLE `perfil_permissao`
  ADD CONSTRAINT `fk_pp_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pp_permissao` FOREIGN KEY (`id_permissao`) REFERENCES `permissao` (`id_permissao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `procedimento_produto`
--
ALTER TABLE `procedimento_produto`
  ADD CONSTRAINT `fk_pprod_procedimento` FOREIGN KEY (`id_procedimento`) REFERENCES `procedimento` (`id_procedimento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pprod_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `produto_fornecedor`
--
ALTER TABLE `produto_fornecedor`
  ADD CONSTRAINT `fk_pf_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pf_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `recebimento`
--
ALTER TABLE `recebimento`
  ADD CONSTRAINT `fk_recebimento_conta` FOREIGN KEY (`id_conta_receber`) REFERENCES `conta_receber` (`id_conta_receber`) ON UPDATE CASCADE;

--
-- Restrições para tabelas `telefone_pessoa`
--
ALTER TABLE `telefone_pessoa`
  ADD CONSTRAINT `fk_telefone_pessoa_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuario_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `perfil` (`id_perfil`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

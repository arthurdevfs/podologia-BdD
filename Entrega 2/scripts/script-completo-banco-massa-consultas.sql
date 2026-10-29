-- Podologia Tatuapé: script completo (banco, massa de dados, consultas gerenciais e de auditoria)
-- Seções 1 e 2: executar uma vez, em sequência, em banco vazio (o DROP DATABASE apaga o banco anterior).
-- Seções 3 e 4: consultas de leitura, executar uma por vez. Dados 100% fictícios.

-- ======================================================
-- 1. BANCO E TABELAS
-- ======================================================
DROP DATABASE IF EXISTS podologia_tatuape;
CREATE DATABASE podologia_tatuape
 CHARACTER SET utf8mb4
 COLLATE utf8mb4_unicode_ci;
USE podologia_tatuape;

CREATE TABLE pessoa (
   id_pessoa INT UNSIGNED AUTO_INCREMENT,
   nome VARCHAR(80) NOT NULL,
   sobrenome VARCHAR(120) NOT NULL,
   cpf CHAR(11) NOT NULL,
   email VARCHAR(254) NULL,
   CONSTRAINT pk_pessoa PRIMARY KEY (id_pessoa),
   CONSTRAINT uq_pessoa_cpf UNIQUE (cpf),
   CONSTRAINT uq_pessoa_email UNIQUE (email),
   CONSTRAINT ck_pessoa_cpf CHECK (cpf REGEXP '^[0-9]{11}$')
) ENGINE=InnoDB;

CREATE TABLE telefone_pessoa (
   id_pessoa INT UNSIGNED NOT NULL,
   numero VARCHAR(20) NOT NULL,
   tipo VARCHAR(20) NOT NULL,
   CONSTRAINT pk_telefone_pessoa PRIMARY KEY (id_pessoa, numero),
   CONSTRAINT fk_telefone_pessoa_pessoa FOREIGN KEY (id_pessoa)
      REFERENCES pessoa(id_pessoa) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT ck_telefone_tipo CHECK (tipo IN ('celular','residencial','comercial','outro'))
) ENGINE=InnoDB;

CREATE TABLE cliente (
   id_cliente INT UNSIGNED AUTO_INCREMENT,
   id_pessoa INT UNSIGNED NOT NULL,
   data_nascimento DATE NOT NULL,
   CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
   CONSTRAINT uq_cliente_pessoa UNIQUE (id_pessoa),
   CONSTRAINT fk_cliente_pessoa FOREIGN KEY (id_pessoa)
      REFERENCES pessoa(id_pessoa) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE funcionario (
  id_funcionario INT UNSIGNED AUTO_INCREMENT,
  id_pessoa INT UNSIGNED NOT NULL,
  cargo VARCHAR(80) NOT NULL,
  comissao DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  salario DECIMAL(10,2) NOT NULL,
  CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario),

   CONSTRAINT uq_funcionario_pessoa UNIQUE (id_pessoa),
   CONSTRAINT fk_funcionario_pessoa FOREIGN KEY (id_pessoa)
     REFERENCES pessoa(id_pessoa) ON UPDATE CASCADE ON DELETE RESTRICT,
   CONSTRAINT ck_funcionario_comissao CHECK (comissao >= 0 AND comissao <= 100),
   CONSTRAINT ck_funcionario_salario CHECK (salario >= 0)
) ENGINE=InnoDB;

CREATE TABLE perfil (
   id_perfil INT UNSIGNED AUTO_INCREMENT,
   nome VARCHAR(60) NOT NULL,
   descricao VARCHAR(255) NULL,
   CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
   CONSTRAINT uq_perfil_nome UNIQUE (nome)
) ENGINE=InnoDB;

CREATE TABLE permissao (
   id_permissao INT UNSIGNED AUTO_INCREMENT,
   codigo VARCHAR(80) NOT NULL,
   descricao VARCHAR(255) NULL,
   CONSTRAINT pk_permissao PRIMARY KEY (id_permissao),
   CONSTRAINT uq_permissao_codigo UNIQUE (codigo)
) ENGINE=InnoDB;

CREATE TABLE perfil_permissao (
   id_perfil INT UNSIGNED NOT NULL,
   id_permissao INT UNSIGNED NOT NULL,
   CONSTRAINT pk_perfil_permissao PRIMARY KEY (id_perfil, id_permissao),
   CONSTRAINT fk_pp_perfil FOREIGN KEY (id_perfil)
      REFERENCES perfil(id_perfil) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_pp_permissao FOREIGN KEY (id_permissao)
      REFERENCES permissao(id_permissao) ON UPDATE CASCADE ON DELETE
CASCADE
) ENGINE=InnoDB;

CREATE TABLE usuario (
  id_usuario INT UNSIGNED AUTO_INCREMENT,
  id_funcionario INT UNSIGNED NOT NULL,
  id_perfil INT UNSIGNED NOT NULL,
  email_login VARCHAR(254) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  token_recuperacao VARCHAR(255) NULL,
  token_expira_em DATETIME NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT uq_usuario_funcionario UNIQUE (id_funcionario),
  CONSTRAINT uq_usuario_email UNIQUE (email_login),
  CONSTRAINT fk_usuario_funcionario FOREIGN KEY (id_funcionario)

     REFERENCES funcionario(id_funcionario) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil)
     REFERENCES perfil(id_perfil) ON UPDATE CASCADE ON DELETE RESTRICT,
   CONSTRAINT ck_usuario_token CHECK (
     (token_recuperacao IS NULL AND token_expira_em IS NULL)
     OR (token_recuperacao IS NOT NULL AND token_expira_em IS NOT NULL)
   )
) ENGINE=InnoDB;

CREATE TABLE agendamento (
   id_agendamento INT UNSIGNED AUTO_INCREMENT,
   id_cliente INT UNSIGNED NOT NULL,
   id_funcionario INT UNSIGNED NOT NULL,
   data_agendamento DATE NOT NULL,
   hora_inicio TIME NOT NULL,
   status VARCHAR(20) NOT NULL DEFAULT 'pendente',
   CONSTRAINT pk_agendamento PRIMARY KEY (id_agendamento),
   CONSTRAINT uq_agendamento_funcionario_horario
      UNIQUE (id_funcionario, data_agendamento, hora_inicio),
   CONSTRAINT fk_agendamento_cliente FOREIGN KEY (id_cliente)
      REFERENCES cliente(id_cliente) ON UPDATE CASCADE ON DELETE RESTRICT,
   CONSTRAINT fk_agendamento_funcionario FOREIGN KEY (id_funcionario)
      REFERENCES funcionario(id_funcionario) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_agendamento_status CHECK
      (status IN ('pendente','confirmado','realizado','cancelado','faltou'))
) ENGINE=InnoDB;

CREATE TABLE lembrete (
   id_lembrete INT UNSIGNED AUTO_INCREMENT,
   id_agendamento INT UNSIGNED NOT NULL,
   data_hora_envio DATETIME NOT NULL,
   canal VARCHAR(20) NOT NULL,
   status_envio VARCHAR(20) NOT NULL DEFAULT 'pendente',
   CONSTRAINT pk_lembrete PRIMARY KEY (id_lembrete),
   CONSTRAINT fk_lembrete_agendamento FOREIGN KEY (id_agendamento)
      REFERENCES agendamento(id_agendamento) ON UPDATE CASCADE ON DELETE
CASCADE,
   CONSTRAINT ck_lembrete_canal CHECK (canal IN ('email','sms','whatsapp')),
   CONSTRAINT ck_lembrete_status CHECK (status_envio IN
('pendente','enviado','falhou'))
) ENGINE=InnoDB;

CREATE TABLE atendimento (
  id_atendimento INT UNSIGNED AUTO_INCREMENT,
  id_agendamento INT UNSIGNED NOT NULL,

   data_hora_checkin DATETIME NULL,
   data_hora_finalizacao DATETIME NULL,
   status VARCHAR(20) NOT NULL DEFAULT 'em_andamento',
   retorno_necessario BOOLEAN NOT NULL DEFAULT FALSE,
   data_retorno_sugerida DATE NULL,
   observacoes TEXT NULL,
   CONSTRAINT pk_atendimento PRIMARY KEY (id_atendimento),
   CONSTRAINT uq_atendimento_agendamento UNIQUE (id_agendamento),
   CONSTRAINT fk_atendimento_agendamento FOREIGN KEY (id_agendamento)
      REFERENCES agendamento(id_agendamento) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_atendimento_status CHECK
      (status IN ('em_andamento','finalizado','cancelado')),
   CONSTRAINT ck_atendimento_datas CHECK
      (data_hora_finalizacao IS NULL OR data_hora_checkin IS NULL
       OR data_hora_finalizacao >= data_hora_checkin),
   CONSTRAINT ck_atendimento_retorno CHECK
      (retorno_necessario = TRUE OR data_retorno_sugerida IS NULL)
) ENGINE=InnoDB;

CREATE TABLE anamnese (
   id_atendimento INT UNSIGNED NOT NULL,
   medicamentos TEXT NULL,
   historico TEXT NULL,
   observacoes TEXT NULL,
   CONSTRAINT pk_anamnese PRIMARY KEY (id_atendimento),
   CONSTRAINT fk_anamnese_atendimento FOREIGN KEY (id_atendimento)
      REFERENCES atendimento(id_atendimento) ON UPDATE CASCADE ON DELETE
CASCADE
) ENGINE=InnoDB;

CREATE TABLE avaliacao (
   id_atendimento INT UNSIGNED NOT NULL,
   queixa_principal VARCHAR(500) NOT NULL,
   observacoes TEXT NULL,
   CONSTRAINT pk_avaliacao PRIMARY KEY (id_atendimento),
   CONSTRAINT fk_avaliacao_atendimento FOREIGN KEY (id_atendimento)
      REFERENCES atendimento(id_atendimento) ON UPDATE CASCADE ON DELETE
CASCADE
) ENGINE=InnoDB;

CREATE TABLE procedimento (
  id_procedimento INT UNSIGNED AUTO_INCREMENT,
  nome VARCHAR(120) NOT NULL,
  descricao TEXT NULL,
  duracao_minutos SMALLINT UNSIGNED NOT NULL,
  preco_base DECIMAL(10,2) NOT NULL,
  CONSTRAINT pk_procedimento PRIMARY KEY (id_procedimento),

   CONSTRAINT uq_procedimento_nome UNIQUE (nome),
   CONSTRAINT ck_procedimento_duracao CHECK (duracao_minutos > 0),
   CONSTRAINT ck_procedimento_preco CHECK (preco_base >= 0)
) ENGINE=InnoDB;

CREATE TABLE executa (
   id_atendimento INT UNSIGNED NOT NULL,
   id_procedimento INT UNSIGNED NOT NULL,
   quantidade SMALLINT UNSIGNED NOT NULL DEFAULT 1,
   valor_aplicado DECIMAL(10,2) NOT NULL,
   observacoes TEXT NULL,
   CONSTRAINT pk_executa PRIMARY KEY (id_atendimento, id_procedimento),
   CONSTRAINT fk_executa_atendimento FOREIGN KEY (id_atendimento)
      REFERENCES atendimento(id_atendimento) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT fk_executa_procedimento FOREIGN KEY (id_procedimento)
      REFERENCES procedimento(id_procedimento) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_executa_quantidade CHECK (quantidade > 0),
   CONSTRAINT ck_executa_valor CHECK (valor_aplicado >= 0)
) ENGINE=InnoDB;

CREATE TABLE fornecedor (
   id_fornecedor INT UNSIGNED AUTO_INCREMENT,
   nome VARCHAR(150) NOT NULL,
   documento VARCHAR(20) NULL,
   telefone VARCHAR(20) NULL,
   email VARCHAR(254) NULL,
   CONSTRAINT pk_fornecedor PRIMARY KEY (id_fornecedor),
   CONSTRAINT uq_fornecedor_documento UNIQUE (documento)
) ENGINE=InnoDB;

CREATE TABLE produto (
   id_produto INT UNSIGNED AUTO_INCREMENT,
   nome VARCHAR(120) NOT NULL,
   descricao TEXT NULL,
   unidade_medida VARCHAR(20) NOT NULL,
   estoque_minimo DECIMAL(10,3) NOT NULL DEFAULT 0,
   preco_venda DECIMAL(10,2) NULL,
   CONSTRAINT pk_produto PRIMARY KEY (id_produto),
   CONSTRAINT uq_produto_nome UNIQUE (nome),
   CONSTRAINT ck_produto_estoque_minimo CHECK (estoque_minimo >= 0),
   CONSTRAINT ck_produto_preco CHECK (preco_venda IS NULL OR preco_venda >= 0)
) ENGINE=InnoDB;

CREATE TABLE produto_fornecedor (
  id_produto INT UNSIGNED NOT NULL,
  id_fornecedor INT UNSIGNED NOT NULL,

   preco_compra DECIMAL(10,2) NOT NULL,
   CONSTRAINT pk_produto_fornecedor PRIMARY KEY (id_produto, id_fornecedor),
   CONSTRAINT fk_pf_produto FOREIGN KEY (id_produto)
     REFERENCES produto(id_produto) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_pf_fornecedor FOREIGN KEY (id_fornecedor)
     REFERENCES fornecedor(id_fornecedor) ON UPDATE CASCADE ON DELETE
CASCADE,
   CONSTRAINT ck_pf_preco CHECK (preco_compra >= 0)
) ENGINE=InnoDB;

CREATE TABLE movimentacao_estoque (
   id_movimentacao INT UNSIGNED AUTO_INCREMENT,
   id_produto INT UNSIGNED NOT NULL,
   id_fornecedor INT UNSIGNED NULL,
   tipo VARCHAR(10) NOT NULL,
   quantidade DECIMAL(10,3) NOT NULL,
   data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   motivo VARCHAR(255) NULL,
   CONSTRAINT pk_movimentacao_estoque PRIMARY KEY (id_movimentacao),
   CONSTRAINT fk_me_produto FOREIGN KEY (id_produto)
      REFERENCES produto(id_produto) ON UPDATE CASCADE ON DELETE RESTRICT,
   CONSTRAINT fk_me_fornecedor FOREIGN KEY (id_fornecedor)
      REFERENCES fornecedor(id_fornecedor) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_me_tipo CHECK (tipo IN ('entrada','saida')),
   CONSTRAINT ck_me_quantidade CHECK (quantidade > 0)
) ENGINE=InnoDB;

CREATE TABLE procedimento_produto (
   id_procedimento INT UNSIGNED NOT NULL,
   id_produto INT UNSIGNED NOT NULL,
   quantidade_padrao DECIMAL(10,3) NOT NULL,
   CONSTRAINT pk_procedimento_produto PRIMARY KEY (id_procedimento, id_produto),
   CONSTRAINT fk_pprod_procedimento FOREIGN KEY (id_procedimento)
      REFERENCES procedimento(id_procedimento) ON UPDATE CASCADE ON DELETE
CASCADE,
   CONSTRAINT fk_pprod_produto FOREIGN KEY (id_produto)
      REFERENCES produto(id_produto) ON UPDATE CASCADE ON DELETE RESTRICT,
   CONSTRAINT ck_pprod_quantidade CHECK (quantidade_padrao > 0)
) ENGINE=InnoDB;

CREATE TABLE conta_receber (
  id_conta_receber INT UNSIGNED AUTO_INCREMENT,
  id_atendimento INT UNSIGNED NOT NULL,
  numero_parcela SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  descricao VARCHAR(255) NULL,
  valor DECIMAL(10,2) NOT NULL,

   data_vencimento DATE NOT NULL,
   status VARCHAR(20) NOT NULL DEFAULT 'aberta',
   CONSTRAINT pk_conta_receber PRIMARY KEY (id_conta_receber),
   CONSTRAINT uq_conta_receber_parcela UNIQUE (id_atendimento, numero_parcela),
   CONSTRAINT fk_cr_atendimento FOREIGN KEY (id_atendimento)
      REFERENCES atendimento(id_atendimento) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_cr_parcela CHECK (numero_parcela > 0),
   CONSTRAINT ck_cr_valor CHECK (valor > 0),
   CONSTRAINT ck_cr_status CHECK (status IN ('aberta','vencida','cancelada'))
) ENGINE=InnoDB;

CREATE TABLE recebimento (
   id_recebimento INT UNSIGNED AUTO_INCREMENT,
   id_conta_receber INT UNSIGNED NOT NULL,
   forma_pagamento VARCHAR(20) NOT NULL,
   valor DECIMAL(10,2) NOT NULL,
   data_hora_recebimento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   status VARCHAR(20) NOT NULL DEFAULT 'confirmado',
   CONSTRAINT pk_recebimento PRIMARY KEY (id_recebimento),
   CONSTRAINT fk_recebimento_conta FOREIGN KEY (id_conta_receber)
      REFERENCES conta_receber(id_conta_receber) ON UPDATE CASCADE ON
DELETE RESTRICT,
   CONSTRAINT ck_recebimento_forma CHECK
      (forma_pagamento IN ('dinheiro','pix','debito','credito','transferencia')),
   CONSTRAINT ck_recebimento_valor CHECK (valor > 0),
   CONSTRAINT ck_recebimento_status CHECK (status IN
('confirmado','estornado','pendente'))
) ENGINE=InnoDB;

CREATE TABLE conta_pagar (
   id_conta_pagar INT UNSIGNED AUTO_INCREMENT,
   id_fornecedor INT UNSIGNED NULL,
   descricao VARCHAR(255) NOT NULL,
   valor DECIMAL(10,2) NOT NULL,
   data_vencimento DATE NOT NULL,
   status VARCHAR(20) NOT NULL DEFAULT 'aberta',
   CONSTRAINT pk_conta_pagar PRIMARY KEY (id_conta_pagar),
   CONSTRAINT fk_cp_fornecedor FOREIGN KEY (id_fornecedor)
      REFERENCES fornecedor(id_fornecedor) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_cp_valor CHECK (valor > 0),
   CONSTRAINT ck_cp_status CHECK (status IN ('aberta','vencida','cancelada'))
) ENGINE=InnoDB;

CREATE TABLE pagamento_conta_pagar (
  id_pagamento_conta INT UNSIGNED AUTO_INCREMENT,
  id_conta_pagar INT UNSIGNED NOT NULL,

   forma_pagamento VARCHAR(20) NOT NULL,
   valor DECIMAL(10,2) NOT NULL,
   data_hora_pagamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT pk_pagamento_conta_pagar PRIMARY KEY (id_pagamento_conta),
   CONSTRAINT fk_pcp_conta FOREIGN KEY (id_conta_pagar)
      REFERENCES conta_pagar(id_conta_pagar) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT ck_pcp_forma CHECK
      (forma_pagamento IN ('dinheiro','pix','debito','credito','transferencia')),
   CONSTRAINT ck_pcp_valor CHECK (valor > 0)
) ENGINE=InnoDB;

CREATE TABLE fluxo_caixa (
   id_fluxo INT UNSIGNED AUTO_INCREMENT,
   id_recebimento INT UNSIGNED NULL,
   id_pagamento_conta INT UNSIGNED NULL,
   descricao VARCHAR(255) NULL,
   CONSTRAINT pk_fluxo_caixa PRIMARY KEY (id_fluxo),
   CONSTRAINT uq_fluxo_recebimento UNIQUE (id_recebimento),
   CONSTRAINT uq_fluxo_pagamento UNIQUE (id_pagamento_conta),
   CONSTRAINT fk_fluxo_recebimento FOREIGN KEY (id_recebimento)
      REFERENCES recebimento(id_recebimento) ON UPDATE CASCADE ON DELETE
RESTRICT,
   CONSTRAINT fk_fluxo_pagamento FOREIGN KEY (id_pagamento_conta)
      REFERENCES pagamento_conta_pagar(id_pagamento_conta) ON UPDATE
CASCADE ON DELETE RESTRICT,
   CONSTRAINT ck_fluxo_origem CHECK (
      (id_recebimento IS NOT NULL AND id_pagamento_conta IS NULL)
      OR (id_recebimento IS NULL AND id_pagamento_conta IS NOT NULL)
   )
) ENGINE=InnoDB;

CREATE TABLE comissao_atendimento (
    id_comissao INT UNSIGNED AUTO_INCREMENT,
    id_atendimento INT UNSIGNED NOT NULL,
    id_funcionario INT UNSIGNED NOT NULL,
    percentual_aplicado DECIMAL(5,2) NOT NULL,
    valor_base DECIMAL(10,2) NOT NULL,
    valor_comissao DECIMAL(10,2) NOT NULL,
    pago BOOLEAN NOT NULL DEFAULT FALSE,
    data_calculo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_comissao_atendimento PRIMARY KEY (id_comissao),
    CONSTRAINT fk_ca_atendimento FOREIGN KEY (id_atendimento)
        REFERENCES atendimento(id_atendimento) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_ca_funcionario FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ======================================================
-- 2. MASSA DE DADOS
-- ======================================================
SET NAMES utf8mb4;

INSERT INTO pessoa (id_pessoa, nome, sobrenome, cpf, email) VALUES
(1, 'Helena', 'Prado Vieira', '22233344401', 'helena.vieira@podologiatatuape.exemplo'),
(2, 'Marcos', 'Antônio Teixeira', '22233344402', 'marcos.teixeira@podologiatatuape.exemplo'),
(3, 'Juliana', 'Carvalho Pinto', '22233344403', 'juliana.pinto@podologiatatuape.exemplo'),
(4, 'Ana Beatriz', 'Souza', '11122233301', 'ana.souza@exemplo.com.br'),
(5, 'Carlos Eduardo', 'Lima', '11122233302', 'carlos.lima@exemplo.com.br'),
(6, 'Mariana', 'Ferreira Costa', '11122233303', 'mariana.costa@exemplo.com.br'),
(7, 'João Pedro', 'Almeida', '11122233304', 'joao.almeida@exemplo.com.br'),
(8, 'Fernanda', 'Oliveira Santos', '11122233305', 'fernanda.santos@exemplo.com.br'),
(9, 'Ricardo', 'Mendes Barbosa', '11122233306', NULL),
(10, 'Luciana', 'Rocha Martins', '11122233307', 'luciana.martins@exemplo.com.br'),
(11, 'Paulo Henrique', 'Duarte', '11122233308', 'paulo.duarte@exemplo.com.br'),
(12, 'Patrícia', 'Gomes Lima', '22233344404', 'patricia.lima@podologiatatuape.exemplo');

INSERT INTO telefone_pessoa (id_pessoa, numero, tipo) VALUES
(1, '(11) 98888-0001', 'celular'),
(2, '(11) 98888-0002', 'celular'),
(3, '(11) 98888-0003', 'celular'),
(3, '(11) 2222-0003', 'comercial'),
(4, '(11) 91234-0004', 'celular'),
(4, '(11) 2293-0004', 'residencial'),
(5, '(11) 91234-0005', 'celular'),
(6, '(11) 91234-0006', 'celular'),
(7, '(11) 91234-0007', 'celular'),
(8, '(11) 91234-0008', 'celular'),
(9, '(11) 91234-0009', 'celular'),
(10, '(11) 91234-0010', 'celular'),
(11, '(11) 91234-0011', 'outro'),
(12, '(11) 98888-0012', 'celular');

INSERT INTO cliente (id_cliente, id_pessoa, data_nascimento) VALUES
(1, 4, '1990-03-14'),
(2, 5, '1958-07-22'),
(3, 6, '1966-11-05'),
(4, 7, '1985-01-30'),
(5, 8, '1993-09-18'),
(6, 9, '1972-04-09'),
(7, 10, '1988-12-02'),
(8, 11, '2002-06-27'),
(9, 3, '1984-10-03');

INSERT INTO funcionario (id_funcionario, id_pessoa, cargo, comissao, salario) VALUES
(1, 1, 'Podóloga', 30.00, 3500.00),
(2, 2, 'Podólogo', 30.00, 3500.00),
(3, 3, 'Recepcionista', 0.00, 2200.00),
(4, 12, 'Gerente', 0.00, 5000.00);

INSERT INTO perfil (id_perfil, nome, descricao) VALUES
(1, 'Administrador', 'Acesso total ao sistema'),
(2, 'Recepção', 'Agenda e recebimentos'),
(3, 'Podólogo', 'Agenda e registro de atendimentos');

INSERT INTO permissao (id_permissao, codigo, descricao) VALUES
(1, 'AGENDA_VER', 'Visualizar a agenda'),
(2, 'AGENDA_EDITAR', 'Criar e alterar agendamentos'),
(3, 'ATENDIMENTO_REGISTRAR', 'Registrar check-in, avaliação, anamnese e procedimentos'),
(4, 'FINANCEIRO_VER', 'Consultar contas e fluxo de caixa'),
(5, 'FINANCEIRO_LANCAR', 'Registrar recebimentos e pagamentos'),
(6, 'ESTOQUE_GERENCIAR', 'Registrar movimentações de estoque'),
(7, 'USUARIO_GERENCIAR', 'Gerenciar usuários e perfis'),
(8, 'RELATORIO_VER', 'Consultar relatórios gerenciais');

INSERT INTO perfil_permissao (id_perfil, id_permissao) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(2, 1),
(2, 2),
(2, 4),
(2, 5),
(3, 1),
(3, 3),
(3, 6);

INSERT INTO usuario (id_usuario, id_funcionario, id_perfil, email_login, senha_hash, ativo, token_recuperacao, token_expira_em) VALUES
(1, 1, 3, 'helena.vieira@podologiatatuape.exemplo', '$2b$12$HASH.FICTICIO.SOMENTE.PARA.TESTE.AAAAAAAAAAAAAAAAAAAAAAAA', 1, NULL, NULL),
(2, 2, 3, 'marcos.teixeira@podologiatatuape.exemplo', '$2b$12$HASH.FICTICIO.SOMENTE.PARA.TESTE.BBBBBBBBBBBBBBBBBBBBBBBB', 1, NULL, NULL),
(3, 3, 2, 'juliana.pinto@podologiatatuape.exemplo', '$2b$12$HASH.FICTICIO.SOMENTE.PARA.TESTE.CCCCCCCCCCCCCCCCCCCCCCCC', 1, 'TOKEN.FICTICIO.DE.RECUPERACAO', '2026-10-22 18:00:00'),
(4, 4, 1, 'patricia.lima@podologiatatuape.exemplo', '$2b$12$HASH.FICTICIO.SOMENTE.PARA.TESTE.DDDDDDDDDDDDDDDDDDDDDDDD', 1, NULL, NULL);

INSERT INTO procedimento (id_procedimento, nome, descricao, duracao_minutos, preco_base) VALUES
(1, 'Avaliação podológica', 'Avaliação da pele, unhas, pisada e sensibilidade dos pés.', 30, 100.00),
(2, 'Podoprofilaxia', 'Higienização, corte e lixamento de unhas e cuidado com a pele.', 50, 120.00),
(3, 'Tratamento de unha encravada', 'Remoção da espícula e correção da onicocriptose.', 45, 180.00),
(4, 'Órtese ungueal em resina', 'Órtese para correção de unha encravada, valor por unha.', 30, 90.00),
(5, 'Tratamento de micose ungueal', 'Desbaste e aplicação tópica para onicomicose.', 40, 150.00),
(6, 'Remoção de calos e calosidades', 'Desbaste de hiperqueratoses plantares e laterais.', 30, 80.00),
(7, 'Tratamento de verruga plantar', 'Tratamento local de verrugas plantares.', 40, 200.00),
(8, 'Palmilha sob medida', 'Avaliação da pisada e confecção de palmilha personalizada.', 60, 350.00),
(9, 'Hidratação e esfoliação podal', 'Esfoliação e hidratação profunda dos pés.', 30, 70.00),
(10, 'Cuidado do pé diabético', 'Avaliação e cuidados preventivos específicos para pé diabético.', 50, 160.00);

INSERT INTO agendamento (id_agendamento, id_cliente, id_funcionario, data_agendamento, hora_inicio, status) VALUES
(1, 1, 1, '2026-09-01', '09:00:00', 'realizado'),
(2, 2, 2, '2026-09-03', '10:00:00', 'realizado'),
(3, 3, 1, '2026-09-08', '14:00:00', 'realizado'),
(4, 4, 2, '2026-09-10', '15:30:00', 'cancelado'),
(5, 7, 2, '2026-09-10', '16:30:00', 'realizado'),
(6, 5, 2, '2026-09-15', '14:00:00', 'realizado'),
(7, 6, 1, '2026-09-17', '11:00:00', 'faltou'),
(8, 2, 2, '2026-09-22', '09:30:00', 'realizado'),
(9, 3, 1, '2026-10-06', '10:30:00', 'realizado'),
(10, 8, 2, '2026-10-08', '13:00:00', 'realizado'),
(11, 1, 1, '2026-10-13', '09:30:00', 'realizado'),
(12, 5, 2, '2026-10-20', '14:30:00', 'realizado'),
(13, 8, 1, '2026-10-22', '10:00:00', 'confirmado'),
(14, 4, 2, '2026-10-27', '09:00:00', 'confirmado'),
(15, 6, 1, '2026-11-03', '10:00:00', 'pendente'),
(16, 3, 1, '2026-11-05', '15:00:00', 'pendente');

INSERT INTO lembrete (id_lembrete, id_agendamento, data_hora_envio, canal, status_envio) VALUES
(1, 1, '2026-08-31 09:00:12', 'whatsapp', 'enviado'),
(2, 2, '2026-09-02 09:00:12', 'sms', 'enviado'),
(3, 3, '2026-09-07 09:00:00', 'whatsapp', 'falhou'),
(4, 4, '2026-09-09 09:00:12', 'sms', 'enviado'),
(5, 5, '2026-09-09 09:00:12', 'whatsapp', 'enviado'),
(6, 6, '2026-09-14 09:00:12', 'sms', 'enviado'),
(7, 7, '2026-09-16 09:00:12', 'whatsapp', 'enviado'),
(8, 8, '2026-09-21 09:00:12', 'sms', 'enviado'),
(9, 9, '2026-10-05 09:00:12', 'whatsapp', 'enviado'),
(10, 10, '2026-10-07 09:00:12', 'sms', 'enviado'),
(11, 11, '2026-10-12 09:00:12', 'whatsapp', 'enviado'),
(12, 12, '2026-10-19 09:00:12', 'sms', 'enviado'),
(13, 13, '2026-10-21 09:00:12', 'whatsapp', 'enviado'),
(14, 14, '2026-10-26 09:00:00', 'sms', 'pendente'),
(15, 15, '2026-11-02 09:00:00', 'whatsapp', 'pendente'),
(16, 16, '2026-11-04 09:00:00', 'sms', 'pendente');

INSERT INTO atendimento (id_atendimento, id_agendamento, data_hora_checkin, data_hora_finalizacao, status, retorno_necessario, data_retorno_sugerida, observacoes) VALUES
(1, 1, '2026-09-01 09:02:00', '2026-09-01 09:55:00', 'finalizado', 0, NULL, 'Sem intercorrências.'),
(2, 2, '2026-09-03 10:03:00', '2026-09-03 11:05:00', 'finalizado', 1, '2026-09-22', 'Sensibilidade reduzida no pé esquerdo; orientado autocuidado diário.'),
(3, 3, '2026-09-08 14:05:00', '2026-09-08 14:50:00', 'finalizado', 1, '2026-10-06', 'Unha encravada no hálux direito; atenção ao sangramento (anticoagulante).'),
(4, 5, '2026-09-10 16:32:00', '2026-09-10 17:25:00', 'finalizado', 0, NULL, 'Micose em 3 unhas do pé direito.'),
(5, 6, '2026-09-15 14:04:00', '2026-09-15 15:08:00', 'finalizado', 1, '2026-10-20', 'Molde da palmilha realizado.'),
(6, 8, '2026-09-22 09:31:00', '2026-09-22 10:25:00', 'finalizado', 0, NULL, 'Retorno: sem lesões novas.'),
(7, 9, '2026-10-06 10:32:00', '2026-10-06 11:05:00', 'finalizado', 0, NULL, 'Órtese reposicionada.'),
(8, 10, '2026-10-08 13:04:00', '2026-10-08 13:55:00', 'finalizado', 1, '2026-11-10', 'Verruga plantar tratada; retorno em 30 dias.'),
(9, 11, '2026-10-13 09:33:00', '2026-10-13 10:35:00', 'finalizado', 0, NULL, 'Podoprofilaxia e remoção de calosidades.'),
(10, 12, '2026-10-20 14:33:00', '2026-10-20 15:35:00', 'finalizado', 0, NULL, 'Palmilha ajustada e entregue.'),
(11, 13, '2026-10-22 10:04:00', NULL, 'em_andamento', 0, NULL, NULL);

INSERT INTO anamnese (id_atendimento, medicamentos, historico, observacoes) VALUES
(1, NULL, 'Sem comorbidades relevantes.', NULL),
(2, 'Metformina 850 mg; Gliclazida 60 mg', 'Diabetes tipo 2 há 12 anos, com neuropatia periférica leve.', 'Alergia a látex.'),
(3, 'Rivaroxabana 20 mg (anticoagulante)', 'Fibrilação atrial controlada.', 'Atenção ao risco de sangramento.'),
(4, NULL, 'Pré-diabetes em acompanhamento.', 'Dermatite de contato a esmaltes e solventes.'),
(5, 'Anticoncepcional oral', 'Sem comorbidades relevantes.', NULL),
(6, 'Metformina 850 mg; Gliclazida 60 mg', 'Diabetes tipo 2 controlado; sensibilidade reduzida nos pés.', 'Alergia a látex.'),
(7, 'Rivaroxabana 20 mg (anticoagulante)', 'Fibrilação atrial controlada.', NULL),
(8, 'Insulina glargina e insulina lispro', 'Diabetes tipo 1 desde a adolescência; usa insulina.', NULL),
(9, NULL, 'Sem comorbidades relevantes.', NULL),
(10, 'Anticoncepcional oral', 'Sem comorbidades relevantes.', NULL),
(11, 'Insulina glargina e insulina lispro', 'Diabetes tipo 1 desde a adolescência; usa insulina.', NULL);

INSERT INTO avaliacao (id_atendimento, queixa_principal, observacoes) VALUES
(1, 'Check-up dos pés e das unhas.', NULL),
(2, 'Formigamento e ressecamento nos pés.', NULL),
(3, 'Dor e inflamação na unha do hálux direito.', NULL),
(4, 'Unhas amareladas e espessadas.', NULL),
(5, 'Dor ao caminhar e desgaste irregular do calçado.', NULL),
(6, 'Acompanhamento de pé diabético.', NULL),
(7, 'Retorno para reposicionar a órtese ungueal.', NULL),
(8, 'Verruga dolorosa no calcanhar esquerdo.', NULL),
(9, 'Manutenção e calosidades nos calcanhares.', NULL),
(10, 'Ajuste da palmilha e ressecamento.', NULL);

INSERT INTO executa (id_atendimento, id_procedimento, quantidade, valor_aplicado, observacoes) VALUES
(1, 1, 1, 100.00, NULL),
(1, 2, 1, 120.00, NULL),
(2, 1, 1, 100.00, NULL),
(2, 10, 1, 160.00, NULL),
(3, 3, 1, 180.00, 'Hálux direito.'),
(3, 4, 2, 90.00, 'Órtese em 2 unhas.'),
(4, 5, 1, 150.00, 'Três unhas do pé direito.'),
(4, 6, 1, 70.00, 'Desconto de pacote (valor padrão R$ 80,00).'),
(5, 8, 1, 350.00, 'Molde e confecção da palmilha.'),
(6, 10, 1, 160.00, NULL),
(7, 4, 1, 90.00, 'Reposicionamento da órtese.'),
(7, 9, 1, 70.00, NULL),
(8, 7, 1, 200.00, 'Calcanhar esquerdo.'),
(8, 9, 1, 70.00, NULL),
(9, 2, 1, 120.00, NULL),
(9, 6, 1, 80.00, NULL),
(10, 2, 1, 120.00, NULL),
(10, 9, 1, 70.00, NULL),
(11, 1, 1, 100.00, NULL);

INSERT INTO fornecedor (id_fornecedor, nome, documento, telefone, email) VALUES
(1, 'PodoMed Distribuidora Ltda', '12.345.678/0001-90', '(11) 3000-0001', 'vendas@podomed.exemplo'),
(2, 'Higiene Total Materiais Ltda', '98.765.432/0001-10', '(11) 3000-0002', 'contato@higienetotal.exemplo'),
(3, 'Papelaria Tatuapé', NULL, NULL, NULL);

INSERT INTO produto (id_produto, nome, descricao, unidade_medida, estoque_minimo, preco_venda) VALUES
(1, 'Lâmina de bisturi nº 15', 'Lâmina descartável estéril.', 'unidade', 20, NULL),
(2, 'Luvas descartáveis', 'Luvas de procedimento.', 'par', 50, NULL),
(3, 'Resina para órtese ungueal', 'Kit de resina fotopolimerizável.', 'kit', 3, NULL),
(4, 'Antisséptico clorexidina 2%', 'Frasco de 100 ml.', 'frasco', 5, NULL),
(5, 'Creme hidratante podal', 'Pote de 200 g, também vendido ao cliente.', 'pote', 3, 35.00),
(6, 'Máscara descartável', 'Máscara tripla.', 'unidade', 50, NULL),
(7, 'Fresa descartável', 'Fresa para desbaste de unhas e calos.', 'unidade', 15, NULL),
(8, 'Gaze estéril', 'Pacote de gaze estéril.', 'pacote', 10, NULL);

INSERT INTO produto_fornecedor (id_produto, id_fornecedor, preco_compra) VALUES
(1, 1, 1.20),
(1, 2, 1.35),
(2, 2, 0.90),
(2, 1, 1.00),
(3, 1, 85.00),
(4, 2, 9.50),
(5, 2, 18.00),
(6, 2, 0.45),
(7, 1, 3.80),
(8, 2, 5.50);

INSERT INTO procedimento_produto (id_procedimento, id_produto, quantidade_padrao) VALUES
(1, 2, 1),
(1, 6, 1),
(2, 1, 1),
(2, 2, 1),
(2, 7, 1),
(3, 1, 1),
(3, 2, 1),
(3, 8, 1),
(3, 4, 0.10),
(4, 3, 0.25),
(4, 2, 1),
(5, 2, 1),
(5, 7, 1),
(6, 1, 1),
(6, 2, 1),
(7, 1, 1),
(7, 2, 1),
(7, 8, 1),
(7, 4, 0.10),
(8, 2, 1),
(9, 2, 1),
(9, 5, 0.10),
(10, 2, 1),
(10, 8, 1),
(10, 1, 1);

INSERT INTO movimentacao_estoque (id_movimentacao, id_produto, id_fornecedor, tipo, quantidade, data_hora, motivo) VALUES
(1, 1, 1, 'entrada', 100.00, '2026-09-01 08:00:00', 'Compra NF 1001'),
(2, 3, 1, 'entrada', 5.00, '2026-09-01 08:00:00', 'Compra NF 1001'),
(3, 7, 1, 'entrada', 40.00, '2026-09-01 08:00:00', 'Compra NF 1001'),
(4, 2, 2, 'entrada', 200.00, '2026-09-01 08:30:00', 'Compra NF 2002'),
(5, 4, 2, 'entrada', 12.00, '2026-09-01 08:30:00', 'Compra NF 2002'),
(6, 5, 2, 'entrada', 8.00, '2026-09-01 08:30:00', 'Compra NF 2002'),
(7, 6, 2, 'entrada', 100.00, '2026-09-01 08:30:00', 'Compra NF 2002'),
(8, 8, 2, 'entrada', 30.00, '2026-09-01 08:30:00', 'Compra NF 2002'),
(9, 2, NULL, 'saida', 1.00, '2026-09-01 09:22:00', 'Consumo no atendimento 1 (procedimento 1)'),
(10, 6, NULL, 'saida', 1.00, '2026-09-01 09:22:00', 'Consumo no atendimento 1 (procedimento 1)'),
(11, 1, NULL, 'saida', 1.00, '2026-09-01 09:22:00', 'Consumo no atendimento 1 (procedimento 2)'),
(12, 2, NULL, 'saida', 1.00, '2026-09-01 09:22:00', 'Consumo no atendimento 1 (procedimento 2)'),
(13, 7, NULL, 'saida', 1.00, '2026-09-01 09:22:00', 'Consumo no atendimento 1 (procedimento 2)'),
(14, 2, NULL, 'saida', 1.00, '2026-09-03 10:23:00', 'Consumo no atendimento 2 (procedimento 1)'),
(15, 6, NULL, 'saida', 1.00, '2026-09-03 10:23:00', 'Consumo no atendimento 2 (procedimento 1)'),
(16, 2, NULL, 'saida', 1.00, '2026-09-03 10:23:00', 'Consumo no atendimento 2 (procedimento 10)'),
(17, 8, NULL, 'saida', 1.00, '2026-09-03 10:23:00', 'Consumo no atendimento 2 (procedimento 10)'),
(18, 1, NULL, 'saida', 1.00, '2026-09-03 10:23:00', 'Consumo no atendimento 2 (procedimento 10)'),
(19, 1, NULL, 'saida', 1.00, '2026-09-08 14:25:00', 'Consumo no atendimento 3 (procedimento 3)'),
(20, 2, NULL, 'saida', 1.00, '2026-09-08 14:25:00', 'Consumo no atendimento 3 (procedimento 3)'),
(21, 8, NULL, 'saida', 1.00, '2026-09-08 14:25:00', 'Consumo no atendimento 3 (procedimento 3)'),
(22, 4, NULL, 'saida', 0.10, '2026-09-08 14:25:00', 'Consumo no atendimento 3 (procedimento 3)'),
(23, 3, NULL, 'saida', 0.50, '2026-09-08 14:25:00', 'Consumo no atendimento 3 (procedimento 4)'),
(24, 2, NULL, 'saida', 2.00, '2026-09-08 14:25:00', 'Consumo no atendimento 3 (procedimento 4)'),
(25, 2, NULL, 'saida', 1.00, '2026-09-10 16:52:00', 'Consumo no atendimento 4 (procedimento 5)'),
(26, 7, NULL, 'saida', 1.00, '2026-09-10 16:52:00', 'Consumo no atendimento 4 (procedimento 5)'),
(27, 1, NULL, 'saida', 1.00, '2026-09-10 16:52:00', 'Consumo no atendimento 4 (procedimento 6)'),
(28, 2, NULL, 'saida', 1.00, '2026-09-10 16:52:00', 'Consumo no atendimento 4 (procedimento 6)'),
(29, 2, NULL, 'saida', 1.00, '2026-09-15 14:24:00', 'Consumo no atendimento 5 (procedimento 8)'),
(30, 2, NULL, 'saida', 1.00, '2026-09-22 09:51:00', 'Consumo no atendimento 6 (procedimento 10)'),
(31, 8, NULL, 'saida', 1.00, '2026-09-22 09:51:00', 'Consumo no atendimento 6 (procedimento 10)'),
(32, 1, NULL, 'saida', 1.00, '2026-09-22 09:51:00', 'Consumo no atendimento 6 (procedimento 10)'),
(33, 7, NULL, 'saida', 25.00, '2026-10-01 08:00:00', 'Descarte de lote com embalagem violada'),
(34, 3, NULL, 'saida', 0.25, '2026-10-06 10:52:00', 'Consumo no atendimento 7 (procedimento 4)'),
(35, 2, NULL, 'saida', 1.00, '2026-10-06 10:52:00', 'Consumo no atendimento 7 (procedimento 4)'),
(36, 2, NULL, 'saida', 1.00, '2026-10-06 10:52:00', 'Consumo no atendimento 7 (procedimento 9)'),
(37, 5, NULL, 'saida', 0.10, '2026-10-06 10:52:00', 'Consumo no atendimento 7 (procedimento 9)'),
(38, 1, NULL, 'saida', 1.00, '2026-10-08 13:24:00', 'Consumo no atendimento 8 (procedimento 7)'),
(39, 2, NULL, 'saida', 1.00, '2026-10-08 13:24:00', 'Consumo no atendimento 8 (procedimento 7)'),
(40, 8, NULL, 'saida', 1.00, '2026-10-08 13:24:00', 'Consumo no atendimento 8 (procedimento 7)'),
(41, 4, NULL, 'saida', 0.10, '2026-10-08 13:24:00', 'Consumo no atendimento 8 (procedimento 7)'),
(42, 2, NULL, 'saida', 1.00, '2026-10-08 13:24:00', 'Consumo no atendimento 8 (procedimento 9)'),
(43, 5, NULL, 'saida', 0.10, '2026-10-08 13:24:00', 'Consumo no atendimento 8 (procedimento 9)'),
(44, 1, NULL, 'saida', 1.00, '2026-10-13 09:53:00', 'Consumo no atendimento 9 (procedimento 2)'),
(45, 2, NULL, 'saida', 1.00, '2026-10-13 09:53:00', 'Consumo no atendimento 9 (procedimento 2)'),
(46, 7, NULL, 'saida', 1.00, '2026-10-13 09:53:00', 'Consumo no atendimento 9 (procedimento 2)'),
(47, 1, NULL, 'saida', 1.00, '2026-10-13 09:53:00', 'Consumo no atendimento 9 (procedimento 6)'),
(48, 2, NULL, 'saida', 1.00, '2026-10-13 09:53:00', 'Consumo no atendimento 9 (procedimento 6)'),
(49, 1, NULL, 'saida', 1.00, '2026-10-20 14:53:00', 'Consumo no atendimento 10 (procedimento 2)'),
(50, 2, NULL, 'saida', 1.00, '2026-10-20 14:53:00', 'Consumo no atendimento 10 (procedimento 2)'),
(51, 7, NULL, 'saida', 1.00, '2026-10-20 14:53:00', 'Consumo no atendimento 10 (procedimento 2)'),
(52, 2, NULL, 'saida', 1.00, '2026-10-20 14:53:00', 'Consumo no atendimento 10 (procedimento 9)'),
(53, 5, NULL, 'saida', 0.10, '2026-10-20 14:53:00', 'Consumo no atendimento 10 (procedimento 9)'),
(54, 2, NULL, 'saida', 1.00, '2026-10-22 10:24:00', 'Consumo no atendimento 11 (procedimento 1)'),
(55, 6, NULL, 'saida', 1.00, '2026-10-22 10:24:00', 'Consumo no atendimento 11 (procedimento 1)');

INSERT INTO conta_receber (id_conta_receber, id_atendimento, numero_parcela, descricao, valor, data_vencimento, status) VALUES
(1, 1, 1, 'Atendimento 1', 220.00, '2026-09-01', 'aberta'),
(2, 2, 1, 'Atendimento 2', 260.00, '2026-09-03', 'aberta'),
(3, 3, 1, 'Atendimento 3 - parcela 1/2', 180.00, '2026-09-08', 'aberta'),
(4, 3, 2, 'Atendimento 3 - parcela 2/2', 180.00, '2026-10-08', 'vencida'),
(5, 4, 1, 'Atendimento 4', 220.00, '2026-09-10', 'aberta'),
(6, 5, 1, 'Atendimento 5 - parcela 1/2', 175.00, '2026-09-15', 'aberta'),
(7, 5, 2, 'Atendimento 5 - parcela 2/2', 175.00, '2026-10-15', 'aberta'),
(8, 6, 1, 'Atendimento 6', 160.00, '2026-09-22', 'vencida'),
(9, 7, 1, 'Atendimento 7', 160.00, '2026-10-06', 'aberta'),
(10, 8, 1, 'Atendimento 8', 270.00, '2026-10-08', 'aberta'),
(11, 9, 1, 'Atendimento 9', 200.00, '2026-10-13', 'aberta'),
(12, 10, 1, 'Atendimento 10', 190.00, '2026-10-27', 'aberta');

INSERT INTO recebimento (id_recebimento, id_conta_receber, forma_pagamento, valor, data_hora_recebimento, status) VALUES
(1, 1, 'pix', 220.00, '2026-09-01 09:58:00', 'confirmado'),
(2, 2, 'credito', 260.00, '2026-09-03 11:08:00', 'confirmado'),
(3, 3, 'dinheiro', 180.00, '2026-09-08 14:55:00', 'confirmado'),
(4, 4, 'pix', 100.00, '2026-10-08 10:00:00', 'confirmado'),
(5, 5, 'debito', 220.00, '2026-09-10 17:30:00', 'confirmado'),
(6, 6, 'credito', 175.00, '2026-09-15 15:10:00', 'confirmado'),
(7, 7, 'credito', 175.00, '2026-10-15 09:00:00', 'confirmado'),
(8, 9, 'pix', 160.00, '2026-10-06 11:10:00', 'confirmado'),
(9, 10, 'pix', 270.00, '2026-10-08 13:58:00', 'estornado'),
(10, 10, 'credito', 270.00, '2026-10-09 10:00:00', 'confirmado'),
(11, 11, 'pix', 200.00, '2026-10-13 10:40:00', 'confirmado'),
(12, 12, 'pix', 190.00, '2026-10-22 09:00:00', 'pendente');

INSERT INTO conta_pagar (id_conta_pagar, id_fornecedor, descricao, valor, data_vencimento, status) VALUES
(1, 1, 'Compra de materiais - NF 1001', 697.00, '2026-09-15', 'aberta'),
(2, 2, 'Compra de materiais - NF 2002', 648.00, '2026-09-15', 'vencida'),
(3, NULL, 'Aluguel da sala - setembro', 3200.00, '2026-09-10', 'aberta'),
(4, NULL, 'Aluguel da sala - outubro', 3200.00, '2026-10-10', 'aberta'),
(5, 3, 'Material de escritório', 150.00, '2026-10-05', 'aberta'),
(6, NULL, 'Conta de energia - outubro', 480.00, '2026-10-25', 'aberta'),
(7, NULL, 'Assinatura de software (cancelada)', 90.00, '2026-10-12', 'cancelada');

INSERT INTO pagamento_conta_pagar (id_pagamento_conta, id_conta_pagar, forma_pagamento, valor, data_hora_pagamento) VALUES
(1, 1, 'pix', 697.00, '2026-09-15 09:00:00'),
(2, 2, 'pix', 300.00, '2026-09-15 09:05:00'),
(3, 3, 'transferencia', 3200.00, '2026-09-10 08:30:00'),
(4, 4, 'transferencia', 3200.00, '2026-10-10 08:30:00'),
(5, 5, 'dinheiro', 150.00, '2026-10-05 10:00:00');

INSERT INTO fluxo_caixa (id_fluxo, id_recebimento, id_pagamento_conta, descricao) VALUES
(1, 1, NULL, 'Recebimento #1 (conta a receber #1)'),
(2, 2, NULL, 'Recebimento #2 (conta a receber #2)'),
(3, 3, NULL, 'Recebimento #3 (conta a receber #3)'),
(4, NULL, 3, 'Pagamento #3 (conta a pagar #3)'),
(5, 5, NULL, 'Recebimento #5 (conta a receber #5)'),
(6, NULL, 1, 'Pagamento #1 (conta a pagar #1)'),
(7, NULL, 2, 'Pagamento #2 (conta a pagar #2)'),
(8, 6, NULL, 'Recebimento #6 (conta a receber #6)'),
(9, NULL, 5, 'Pagamento #5 (conta a pagar #5)'),
(10, 8, NULL, 'Recebimento #8 (conta a receber #9)'),
(11, 4, NULL, 'Recebimento #4 (conta a receber #4)'),
(12, 10, NULL, 'Recebimento #10 (conta a receber #10)'),
(13, NULL, 4, 'Pagamento #4 (conta a pagar #4)'),
(14, 11, NULL, 'Recebimento #11 (conta a receber #11)'),
(15, 7, NULL, 'Recebimento #7 (conta a receber #7)');

INSERT INTO comissao_atendimento (id_comissao, id_atendimento, id_funcionario, percentual_aplicado, valor_base, valor_comissao, pago, data_calculo) VALUES
(1, 1, 1, 30.00, 220.00, 66.00, 1, '2026-09-01 09:55:00'),
(2, 2, 2, 30.00, 260.00, 78.00, 1, '2026-09-03 11:05:00'),
(3, 3, 1, 30.00, 360.00, 108.00, 1, '2026-09-08 14:50:00'),
(4, 4, 2, 30.00, 220.00, 66.00, 1, '2026-09-10 17:25:00'),
(5, 5, 2, 30.00, 350.00, 105.00, 1, '2026-09-15 15:08:00'),
(6, 6, 2, 30.00, 160.00, 48.00, 1, '2026-09-22 10:25:00'),
(7, 7, 1, 30.00, 160.00, 48.00, 0, '2026-10-06 11:05:00'),
(8, 8, 2, 30.00, 270.00, 81.00, 0, '2026-10-08 13:55:00'),
(9, 9, 1, 30.00, 200.00, 60.00, 0, '2026-10-13 10:35:00'),
(10, 10, 2, 30.00, 190.00, 57.00, 0, '2026-10-20 15:35:00');

-- ======================================================
-- 3. CONSULTAS GERENCIAIS
-- ======================================================
-- G01: Quais procedimentos são mais realizados e quais geram mais receita?
SELECT p.id_procedimento, p.nome,
       SUM(e.quantidade) AS vezes_executado,
       SUM(e.quantidade * e.valor_aplicado) AS receita,
       ROUND(SUM(e.quantidade * e.valor_aplicado) * 100.0 /
             (SELECT SUM(e2.quantidade * e2.valor_aplicado)
              FROM executa e2
              JOIN atendimento t2 ON t2.id_atendimento = e2.id_atendimento
              WHERE t2.status = 'finalizado'), 1) AS percentual_da_receita
FROM executa e
JOIN procedimento p ON p.id_procedimento = e.id_procedimento
JOIN atendimento t ON t.id_atendimento = e.id_atendimento
WHERE t.status = 'finalizado'
GROUP BY p.id_procedimento, p.nome
ORDER BY receita DESC;

-- G02: Qual o faturamento de cada mês e quanto desse valor foi efetivamente recebido?
SELECT x.mes,
       SUM(x.faturado) AS faturado,
       SUM(x.recebido) AS recebido
FROM (SELECT SUBSTR(t.data_hora_finalizacao, 1, 7) AS mes,
             e.quantidade * e.valor_aplicado AS faturado,
             0 AS recebido
      FROM executa e
      JOIN atendimento t ON t.id_atendimento = e.id_atendimento
      WHERE t.status = 'finalizado'
      UNION ALL
      SELECT SUBSTR(r.data_hora_recebimento, 1, 7), 0, r.valor
      FROM recebimento r
      WHERE r.status = 'confirmado') x
GROUP BY x.mes
ORDER BY x.mes;

-- G03: Quantos atendimentos e quanto faturamento cada podólogo gerou, e qual o ticket médio?
SELECT f.id_funcionario, pe.nome,
       COUNT(DISTINCT t.id_atendimento) AS atendimentos,
       SUM(e.quantidade * e.valor_aplicado) AS faturamento,
       ROUND(SUM(e.quantidade * e.valor_aplicado) / COUNT(DISTINCT t.id_atendimento), 2) AS ticket_medio
FROM atendimento t
JOIN agendamento g ON g.id_agendamento = t.id_agendamento
JOIN funcionario f ON f.id_funcionario = g.id_funcionario
JOIN pessoa pe ON pe.id_pessoa = f.id_pessoa
JOIN executa e ON e.id_atendimento = t.id_atendimento
WHERE t.status = 'finalizado'
GROUP BY f.id_funcionario, pe.nome
ORDER BY faturamento DESC;

-- G04: Quais clientes mais compram e quando foi a última visita de cada um?
SELECT cl.id_cliente, pe.nome, pe.sobrenome,
       COUNT(DISTINCT t.id_atendimento) AS atendimentos,
       SUM(e.quantidade * e.valor_aplicado) AS total_gasto,
       MAX(DATE(t.data_hora_checkin)) AS ultimo_atendimento
FROM cliente cl
JOIN pessoa pe ON pe.id_pessoa = cl.id_pessoa
JOIN agendamento g ON g.id_cliente = cl.id_cliente
JOIN atendimento t ON t.id_agendamento = g.id_agendamento AND t.status = 'finalizado'
JOIN executa e ON e.id_atendimento = t.id_atendimento
GROUP BY cl.id_cliente, pe.nome, pe.sobrenome
ORDER BY total_gasto DESC;

-- G05: Qual a proporção de atendimentos realizados, cancelamentos e faltas até 22/10/2026?
SELECT status,
       COUNT(*) AS quantidade,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM agendamento WHERE data_agendamento < '2026-10-22'), 1) AS percentual
FROM agendamento
WHERE data_agendamento < '2026-10-22'
GROUP BY status
ORDER BY quantidade DESC;

-- G06: Quais clientes estão com contas vencidas e quanto devem?
SELECT pe.nome, pe.sobrenome, c.id_conta_receber, c.numero_parcela, c.data_vencimento,
       c.valor AS valor_da_conta,
       c.valor - COALESCE(r.recebido, 0) AS saldo_devedor
FROM conta_receber c
JOIN atendimento t ON t.id_atendimento = c.id_atendimento
JOIN agendamento g ON g.id_agendamento = t.id_agendamento
JOIN cliente cl ON cl.id_cliente = g.id_cliente
JOIN pessoa pe ON pe.id_pessoa = cl.id_pessoa
LEFT JOIN (SELECT id_conta_receber, SUM(valor) AS recebido
           FROM recebimento WHERE status = 'confirmado'
           GROUP BY id_conta_receber) r ON r.id_conta_receber = c.id_conta_receber
WHERE c.status <> 'cancelada'
  AND c.data_vencimento < '2026-10-22'
  AND c.valor - COALESCE(r.recebido, 0) > 0
ORDER BY saldo_devedor DESC;

-- G07: Quais produtos estão abaixo do estoque mínimo e a que preço o fornecedor mais barato vende?
SELECT p.id_produto, p.nome, p.unidade_medida,
       s.saldo, p.estoque_minimo,
       CASE WHEN s.saldo < p.estoque_minimo THEN 'repor' ELSE 'ok' END AS situacao,
       (SELECT MIN(pf.preco_compra) FROM produto_fornecedor pf WHERE pf.id_produto = p.id_produto) AS menor_preco_compra
FROM produto p
JOIN (SELECT id_produto,
             SUM(CASE WHEN tipo = 'entrada' THEN quantidade ELSE -quantidade END) AS saldo
      FROM movimentacao_estoque
      GROUP BY id_produto) s ON s.id_produto = p.id_produto
ORDER BY s.saldo - p.estoque_minimo;

-- G08: Como o caixa se comportou em cada mês (entradas, saídas e saldo do mês)?
SELECT SUBSTR(x.data_hora, 1, 7) AS mes,
       SUM(CASE WHEN x.sentido = 'entrada' THEN x.valor ELSE 0 END) AS entradas,
       SUM(CASE WHEN x.sentido = 'saida' THEN x.valor ELSE 0 END) AS saidas,
       SUM(CASE WHEN x.sentido = 'entrada' THEN x.valor ELSE -x.valor END) AS saldo_do_mes
FROM (SELECT 'entrada' AS sentido, r.data_hora_recebimento AS data_hora, r.valor
      FROM fluxo_caixa f
      JOIN recebimento r ON r.id_recebimento = f.id_recebimento
      UNION ALL
      SELECT 'saida', p.data_hora_pagamento, p.valor
      FROM fluxo_caixa f
      JOIN pagamento_conta_pagar p ON p.id_pagamento_conta = f.id_pagamento_conta) x
GROUP BY SUBSTR(x.data_hora, 1, 7)
ORDER BY mes;

-- G09: Quais clientes atendidos não voltam há mais de 30 dias e não têm retorno agendado?
SELECT cl.id_cliente, pe.nome, pe.sobrenome,
       MAX(DATE(t.data_hora_checkin)) AS ultimo_atendimento
FROM cliente cl
JOIN pessoa pe ON pe.id_pessoa = cl.id_pessoa
JOIN agendamento g ON g.id_cliente = cl.id_cliente
JOIN atendimento t ON t.id_agendamento = g.id_agendamento AND t.status = 'finalizado'
GROUP BY cl.id_cliente, pe.nome, pe.sobrenome
HAVING MAX(DATE(t.data_hora_checkin)) < '2026-09-22'
   AND NOT EXISTS (SELECT 1 FROM agendamento g2
                   WHERE g2.id_cliente = cl.id_cliente
                     AND g2.data_agendamento >= '2026-10-22'
                     AND g2.status IN ('pendente', 'confirmado'));

-- G10: Quanto de comissão foi paga e quanto está pendente para cada funcionário?
SELECT f.id_funcionario, pe.nome,
       SUM(CASE WHEN m.pago = 1 THEN m.valor_comissao ELSE 0 END) AS comissao_paga,
       SUM(CASE WHEN m.pago = 0 THEN m.valor_comissao ELSE 0 END) AS comissao_pendente
FROM comissao_atendimento m
JOIN funcionario f ON f.id_funcionario = m.id_funcionario
JOIN pessoa pe ON pe.id_pessoa = f.id_pessoa
GROUP BY f.id_funcionario, pe.nome
ORDER BY comissao_pendente DESC;

-- ======================================================
-- 4. CONSULTAS DE AUDITORIA
-- ======================================================
-- A01: Pessoas sem nenhum papel (nem cliente nem funcionário) (esperado: 0 linhas)
SELECT p.id_pessoa, p.nome, p.sobrenome
FROM pessoa p
LEFT JOIN cliente c ON c.id_pessoa = p.id_pessoa
LEFT JOIN funcionario f ON f.id_pessoa = p.id_pessoa
WHERE c.id_cliente IS NULL AND f.id_funcionario IS NULL;

-- A02: Pessoas com papel duplo (cliente e funcionária) - informativo (esperado: pessoa 3 (1 linha))
SELECT p.id_pessoa, p.nome, c.id_cliente, f.id_funcionario
FROM pessoa p
JOIN cliente c ON c.id_pessoa = p.id_pessoa
JOIN funcionario f ON f.id_pessoa = p.id_pessoa;

-- A03: E-mail de login diferente do e-mail da pessoa funcionária (duplicidade de dado) (esperado: 0 linhas)
SELECT u.id_usuario, u.email_login, p.email AS email_pessoa
FROM usuario u
JOIN funcionario f ON f.id_funcionario = u.id_funcionario
JOIN pessoa p ON p.id_pessoa = f.id_pessoa
WHERE p.email IS NULL OR u.email_login <> p.email;

-- A04: Atendimento finalizado sem avaliação, anamnese, procedimento ou conta a receber (RN17) (esperado: 0 linhas)
SELECT t.id_atendimento
FROM atendimento t
WHERE t.status = 'finalizado'
  AND (NOT EXISTS (SELECT 1 FROM avaliacao v WHERE v.id_atendimento = t.id_atendimento)
    OR NOT EXISTS (SELECT 1 FROM anamnese an WHERE an.id_atendimento = t.id_atendimento)
    OR NOT EXISTS (SELECT 1 FROM executa e WHERE e.id_atendimento = t.id_atendimento)
    OR NOT EXISTS (SELECT 1 FROM conta_receber c WHERE c.id_atendimento = t.id_atendimento));

-- A05: Status do agendamento incompatível com a existência/status do atendimento (esperado: 0 linhas)
SELECT g.id_agendamento, g.status AS status_agendamento, t.id_atendimento, t.status AS status_atendimento
FROM agendamento g
LEFT JOIN atendimento t ON t.id_agendamento = g.id_agendamento
WHERE (t.id_atendimento IS NULL AND g.status = 'realizado')
   OR (t.id_atendimento IS NOT NULL AND g.status IN ('pendente','cancelado','faltou'))
   OR (t.status = 'finalizado' AND g.status <> 'realizado')
   OR (t.status = 'em_andamento' AND g.status <> 'confirmado');

-- A06: Datas do atendimento incoerentes com o status (finalizado sem data de finalização, em andamento com finalização) (esperado: 0 linhas)
SELECT t.id_atendimento, t.status, t.data_hora_checkin, t.data_hora_finalizacao
FROM atendimento t
WHERE (t.status = 'finalizado' AND (t.data_hora_finalizacao IS NULL OR t.data_hora_checkin IS NULL))
   OR (t.status = 'em_andamento' AND t.data_hora_finalizacao IS NOT NULL);

-- A07: Soma das contas a receber (não canceladas) diferente da soma dos procedimentos executados (esperado: 0 linhas)
SELECT t.id_atendimento, x.total_executado, c.total_contas
FROM atendimento t
JOIN (SELECT id_atendimento, SUM(quantidade * valor_aplicado) AS total_executado FROM executa GROUP BY id_atendimento) x
  ON x.id_atendimento = t.id_atendimento
JOIN (SELECT id_atendimento, SUM(valor) AS total_contas FROM conta_receber WHERE status <> 'cancelada' GROUP BY id_atendimento) c
  ON c.id_atendimento = t.id_atendimento
WHERE x.total_executado <> c.total_contas;

-- A08: Recebimentos confirmados acima do valor da conta a receber (esperado: 0 linhas)
SELECT c.id_conta_receber, c.valor, SUM(r.valor) AS recebido
FROM conta_receber c
JOIN recebimento r ON r.id_conta_receber = c.id_conta_receber AND r.status = 'confirmado'
GROUP BY c.id_conta_receber, c.valor
HAVING SUM(r.valor) > c.valor;

-- A09: Pagamentos acima do valor da conta a pagar (esperado: 0 linhas)
SELECT c.id_conta_pagar, c.valor, SUM(p.valor) AS pago
FROM conta_pagar c
JOIN pagamento_conta_pagar p ON p.id_conta_pagar = c.id_conta_pagar
GROUP BY c.id_conta_pagar, c.valor
HAVING SUM(p.valor) > c.valor;

-- A10: Status da conta a receber incoerente com vencimento e saldo em 22/10/2026 (esperado: 0 linhas)
SELECT c.id_conta_receber, c.status, c.data_vencimento, c.valor - COALESCE(r.recebido, 0) AS saldo
FROM conta_receber c
LEFT JOIN (SELECT id_conta_receber, SUM(valor) AS recebido FROM recebimento WHERE status = 'confirmado' GROUP BY id_conta_receber) r
  ON r.id_conta_receber = c.id_conta_receber
WHERE (c.status = 'aberta' AND c.data_vencimento < '2026-10-22' AND c.valor - COALESCE(r.recebido, 0) > 0)
   OR (c.status = 'vencida' AND (c.data_vencimento >= '2026-10-22' OR c.valor - COALESCE(r.recebido, 0) <= 0));

-- A11: Status da conta a pagar incoerente com vencimento e saldo em 22/10/2026 (esperado: 0 linhas)
SELECT c.id_conta_pagar, c.status, c.data_vencimento, c.valor - COALESCE(p.pago, 0) AS saldo
FROM conta_pagar c
LEFT JOIN (SELECT id_conta_pagar, SUM(valor) AS pago FROM pagamento_conta_pagar GROUP BY id_conta_pagar) p
  ON p.id_conta_pagar = c.id_conta_pagar
WHERE (c.status = 'aberta' AND c.data_vencimento < '2026-10-22' AND c.valor - COALESCE(p.pago, 0) > 0)
   OR (c.status = 'vencida' AND (c.data_vencimento >= '2026-10-22' OR c.valor - COALESCE(p.pago, 0) <= 0));

-- A12: Caixa: recebimento confirmado ou pagamento sem lançamento; lançamento de recebimento não confirmado (esperado: 0 linhas)
SELECT 'recebimento confirmado sem lançamento' AS problema, r.id_recebimento AS id
FROM recebimento r LEFT JOIN fluxo_caixa f ON f.id_recebimento = r.id_recebimento
WHERE r.status = 'confirmado' AND f.id_fluxo IS NULL
UNION ALL
SELECT 'lançamento de recebimento não confirmado', f.id_fluxo
FROM fluxo_caixa f JOIN recebimento r ON r.id_recebimento = f.id_recebimento
WHERE r.status <> 'confirmado'
UNION ALL
SELECT 'pagamento sem lançamento', p.id_pagamento_conta
FROM pagamento_conta_pagar p LEFT JOIN fluxo_caixa f ON f.id_pagamento_conta = p.id_pagamento_conta
WHERE f.id_fluxo IS NULL;

-- A13: Saldo de estoque negativo em qualquer momento (RN15) (esperado: 0 linhas)
SELECT x.id_movimentacao, x.id_produto, x.data_hora, x.saldo_acumulado
FROM (SELECT m.id_movimentacao, m.id_produto, m.data_hora,
             SUM(CASE WHEN m.tipo = 'entrada' THEN m.quantidade ELSE -m.quantidade END)
               OVER (PARTITION BY m.id_produto ORDER BY m.data_hora, m.id_movimentacao) AS saldo_acumulado
      FROM movimentacao_estoque m) x
WHERE x.saldo_acumulado < 0;

-- A14: Produtos abaixo do estoque mínimo - informativo (esperado: produto 7 (fresa descartável))
SELECT p.id_produto, p.nome, p.estoque_minimo,
       SUM(CASE WHEN m.tipo = 'entrada' THEN m.quantidade ELSE -m.quantidade END) AS saldo
FROM produto p
JOIN movimentacao_estoque m ON m.id_produto = p.id_produto
GROUP BY p.id_produto, p.nome, p.estoque_minimo
HAVING SUM(CASE WHEN m.tipo = 'entrada' THEN m.quantidade ELSE -m.quantidade END) < p.estoque_minimo;

-- A15: Lembretes incoerentes com o agendamento (esperado: 0 linhas)
SELECT l.id_lembrete, l.id_agendamento, l.status_envio, g.status AS status_agendamento, l.data_hora_envio
FROM lembrete l
JOIN agendamento g ON g.id_agendamento = l.id_agendamento
WHERE (g.status IN ('cancelado','faltou') AND l.status_envio = 'pendente')
   OR (l.status_envio = 'pendente' AND l.data_hora_envio < '2026-10-22 23:59:59');

-- A16: Clientes sem nenhuma anamnese (nunca atendidos) - informativo (esperado: clientes 4, 6 e 9)
SELECT c.id_cliente, p.nome, p.sobrenome
FROM cliente c
JOIN pessoa p ON p.id_pessoa = c.id_pessoa
WHERE NOT EXISTS (
  SELECT 1 FROM agendamento g
  JOIN atendimento t ON t.id_agendamento = g.id_agendamento
  JOIN anamnese an ON an.id_atendimento = t.id_atendimento
  WHERE g.id_cliente = c.id_cliente);

-- A17: Contas a receber vencidas com saldo (inadimplência) em 22/10/2026 - informativo (esperado: contas 4 (saldo 80,00) e 8 (saldo 160,00))
SELECT c.id_conta_receber, c.id_atendimento, c.numero_parcela, c.data_vencimento, c.valor,
       COALESCE(SUM(CASE WHEN r.status = 'confirmado' THEN r.valor END), 0) AS recebido,
       c.valor - COALESCE(SUM(CASE WHEN r.status = 'confirmado' THEN r.valor END), 0) AS saldo
FROM conta_receber c
LEFT JOIN recebimento r ON r.id_conta_receber = c.id_conta_receber
WHERE c.status <> 'cancelada' AND c.data_vencimento < '2026-10-22'
GROUP BY c.id_conta_receber, c.id_atendimento, c.numero_parcela, c.data_vencimento, c.valor
HAVING c.valor - COALESCE(SUM(CASE WHEN r.status = 'confirmado' THEN r.valor END), 0) > 0;

-- A18: Contas a pagar vencidas com saldo em 22/10/2026 - informativo (esperado: conta 2 (saldo 348,00))
SELECT c.id_conta_pagar, c.descricao, c.data_vencimento, c.valor,
       COALESCE(SUM(p.valor), 0) AS pago, c.valor - COALESCE(SUM(p.valor), 0) AS saldo
FROM conta_pagar c
LEFT JOIN pagamento_conta_pagar p ON p.id_conta_pagar = c.id_conta_pagar
WHERE c.status <> 'cancelada' AND c.data_vencimento < '2026-10-22'
GROUP BY c.id_conta_pagar, c.descricao, c.data_vencimento, c.valor
HAVING c.valor - COALESCE(SUM(p.valor), 0) > 0;

-- A19: Comissão incoerente: valor, percentual, base, atendimento não finalizado ou funcionário diferente do agendamento (esperado: 0 linhas)
SELECT m.id_comissao, m.id_atendimento
FROM comissao_atendimento m
JOIN atendimento t ON t.id_atendimento = m.id_atendimento
JOIN agendamento g ON g.id_agendamento = t.id_agendamento
JOIN funcionario f ON f.id_funcionario = m.id_funcionario
LEFT JOIN (SELECT id_atendimento, SUM(quantidade * valor_aplicado) AS total FROM executa GROUP BY id_atendimento) x
  ON x.id_atendimento = m.id_atendimento
WHERE m.valor_comissao <> ROUND(m.valor_base * m.percentual_aplicado / 100, 2)
   OR m.percentual_aplicado <> f.comissao
   OR m.valor_base <> COALESCE(x.total, 0)
   OR t.status <> 'finalizado'
   OR g.id_funcionario <> m.id_funcionario;

-- A20: Atendimento finalizado de funcionário com comissão, mas sem registro de comissão (esperado: 0 linhas)
SELECT t.id_atendimento, g.id_funcionario
FROM atendimento t
JOIN agendamento g ON g.id_agendamento = t.id_agendamento
JOIN funcionario f ON f.id_funcionario = g.id_funcionario
LEFT JOIN comissao_atendimento m ON m.id_atendimento = t.id_atendimento
WHERE t.status = 'finalizado' AND f.comissao > 0 AND m.id_comissao IS NULL;

-- A21: Recebimentos pendentes (aguardando confirmação) - informativo (esperado: recebimento 12)
SELECT r.id_recebimento, r.id_conta_receber, r.forma_pagamento, r.valor, r.data_hora_recebimento
FROM recebimento r
WHERE r.status = 'pendente';

-- A22: Saldo acumulado do caixa, calculado por junção (o DDL não guarda valor nem data em fluxo_caixa) - informativo (esperado: 15 linhas)
SELECT x.id_fluxo, x.data_hora, x.origem, x.valor_com_sinal,
       SUM(x.valor_com_sinal) OVER (ORDER BY x.data_hora, x.id_fluxo) AS saldo_acumulado
FROM (SELECT f.id_fluxo,
             COALESCE(r.data_hora_recebimento, p.data_hora_pagamento) AS data_hora,
             CASE WHEN f.id_recebimento IS NOT NULL THEN 'recebimento' ELSE 'pagamento' END AS origem,
             CASE WHEN f.id_recebimento IS NOT NULL THEN r.valor ELSE -p.valor END AS valor_com_sinal
      FROM fluxo_caixa f
      LEFT JOIN recebimento r ON r.id_recebimento = f.id_recebimento
      LEFT JOIN pagamento_conta_pagar p ON p.id_pagamento_conta = f.id_pagamento_conta) x
ORDER BY x.data_hora, x.id_fluxo;

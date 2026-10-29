-- ETAPAS 18 E 19: CONSULTAS GERENCIAIS E DE AUDITORIA ADICIONAIS
-- Arquivo organizado a partir do SQL enviado para documentação do projeto.
-- ATENÇÃO: a segunda consulta gerencial mantém a condição de JOIN original; revisar antes de executar.

-- ------------------------------------------------------
-- ETAPA 18: CRIEM CONSULTAS GERENCIAIS ADICIONAIS
-- Estrutura: Pergunta do Negócio + SQL + Informação para Decisão
-- ------------------------------------------------------

-- Decisão: Avaliar taxas cobradas por operadoras de cartão e negociar condições melhores ou incentivar o Pix.
SELECT r.forma_pagamento,
       COUNT(r.id_recebimento) AS total_transacoes,
       SUM(r.valor) AS valor_total_arrecadado,
       ROUND(SUM(r.valor) * 100.0 / (SELECT SUM(valor) FROM recebimento WHERE status = 'confirmado'), 2) AS percentual_participacao
FROM recebimento r
WHERE r.status = 'confirmado'
GROUP BY r.forma_pagamento
ORDER BY valor_total_arrecadado DESC;

-- Decisão: Implantar campanhas de confirmação automatizadas com antecedência para reduzir perdas de horários.
SELECT cl.id_cliente, pe.nome, pe.sobrenome,
       SUM(CASE WHEN g.status = 'cancelado' THEN 1 ELSE 0 END) AS total_cancelados,
       SUM(CASE WHEN g.status = 'faltou' THEN 1 ELSE 0 END) AS total_faltas
FROM cliente cl
JOIN pessoa pe ON pe.id_pessoa = cl.id_pessoa
JOIN agendamento g ON g.id_agendamento = cl.id_cliente
GROUP BY cl.id_cliente, pe.nome, pe.sobrenome
HAVING total_cancelados > 0 OR total_faltas > 0
ORDER BY total_faltas DESC, total_cancelados DESC;


-- ------------------------------------------------------
-- ETAPA 19: CRIEM CONSULTAS DE AUDITORIA ADICIONAIS
-- Finalidade: Verificar consistência e qualidade dos dados.
-- ------------------------------------------------------


SELECT t.id_atendimento, t.data_hora_finalizacao
FROM atendimento t
WHERE t.status = 'finalizado'
  AND NOT EXISTS (
      SELECT 1 FROM anamnese an WHERE an.id_atendimento = t.id_atendimento
  );


SELECT cp.id_conta_pagar, cp.descricao, cp.valor
FROM conta_pagar cp
LEFT JOIN fornecedor f ON f.id_fornecedor = cp.id_fornecedor
WHERE cp.id_fornecedor IS NOT NULL AND f.id_fornecedor IS NULL;

-- Queries

-- Envolve apenas seleção e projeção (OK)
-- Obtém o id, nome, população, e UF de todos os Municipio cadastrados com UF igual a RJ
SELECT id, nome, populacao, estado_id FROM Municipio WHERE estado_id = 'RJ';

-- Envolve junção de apenas duas relações (OK)
-- Obtém o nome, localização, rede, nome do municipio e UF de todas as Escola cuja UF é MG ou PR
SELECT Escola.nome, localizacao, rede, Municipio.nome AS municipio, Municipio.estado_id AS uf
FROM Escola INNER JOIN Municipio ON Escola.municipio_id=Municipio.id
WHERE Municipio.estado_id = 'MG' OR Municipio.estado_id = 'PR';

-- Envolve junção externa de apenas duas relações
-- Todas as Escola que não tem taxas associadas apesar de cadastradas no sistema
SELECT nome, rede, localizacao
FROM Escola left JOIN Taxa ON Escola.id=Taxa.escola_id
WHERE rede = 'Federal' AND Taxa.id = null;

-- Envolve junção de apenas duas relações
-- Obtém todos os telefones da escola de nome CEFET CELSO SUCKOW DA FONSECA
SELECT codigo, numero
FROM Escola INNER JOIN Telefone on Telefone.escola_id=Escola.id
WHERE nome = 'CEFET CELSO SUCKOW DA FONSECA';

-- Envolve junção externa de apenas duas relações
-- Nomes, localização e taxas de todas as Escola da rede Federal e suas respectivas taxas de aprovação do ensino medio caso existam
SELECT nome, localizacao, (.colocar taxas aqui.)
FROM Escola left JOIN Taxa on Escola.id=Taxa.escola_id
WHERE rede = 'Federal' and ( (Taxa.tipo = null or Taxa.tipo = 'Aprovação') and (Taxa.serie = null or Taxa.serie between 10 and 13));


-- Envolve junção de três relações

-- Obtém o nome, rede, localização e uf de todas as Escola da região Sudeste
SELECT Escola.nome, rede, localizacao, uf
FROM Escola INNER JOIN Municipio on Escola.municipio_id=Municipio.id INNER JOIN Estado on estado.id=Municipio.estado_id
WHERE Estado.regiao = 'Sudeste';

-- Envolve junção de três relações
-- A media das taxas de aprovação do terceiro ano do ensino medio por estado
SELECT avg(Taxa.valor) as media de aprovacao, uf, bandeira
FROM Escola INNER JOIN Taxa on Escola.id=Taxa.escola_id INNER JOIN Municipio on Escola.municipio_id=Municipio.id INNER JOIN Estado on Estado.id=Municipio.estado_id
WHERE Taxa.serie = 12
group by Estado.uf;

-- Consulta envovendo operações sobre conjuntos
-- As escolas que tem reprovacão maior que 50% ou abandono maior que 50% em qualquer ano
SELECT distinct Escola.nome
FROM Escola left JOIN Taxa on Escola.id = Taxa.escola_id
WHERE Taxa.tipo = 'Reprovação' and Taxa.valor >= 50
union
SELECT distinct Escola.nome
FROM escola left JOIN taxa on Escola.id = Taxa.escola_id
WHERE Taxa.tipo = 'Abandono' and Taxa.valor >= 50

-- Consulta envolvendo função de agregação
-- Obtém o número de Escola cadastradas no sistema por estado
SELECT count(distinct Escola.id), Estado.nome, uf, regiao, bandeira
FROM Escola INNER JOIN Municipio on Escola.municipio_id=Municipio.id INNER JOIN Estado on Estado.id=Municipio.estado_id
group by Estado.uf

-- Consulta envolvendo função de agregação
-- Número de Escola cadastradas por região
SELECT count(distinct Escola.id), regiao
FROM Escola INNER JOIN Municipio on Escola.municipio_id=municipio.id INNER JOIN Estado on Estado.id=Municipio.estado_id
group by regiao;

-- Consulta envolvendo função de agregação
-- Número de Escola cadastradas que não preencheram nenhum dado por região
SELECT count(distinct Escola.id), regiao
FROM Escola INNER JOIN Municipio on Escola.municipio_id=Municipio.id INNER JOIN Estado on Estado.id=Municipio.estado_id left JOIN taxas on Escola.id=Taxa.escola_id
WHERE Taxa.id = null
group by regiao;


-- Consulta envovendo subconsultas aninhadas
-- Estados que possui média de reprovacao das escolas maior ou igual a 30%
SELECT name FROM
(
    SELECT Estado.nome as name, avg(taxa.valor) as media
    FROM estado JOIN municipio on estado.id = municipio.estado_id left JOIN escola on municipio.id = escola.municipio_id left JOIN taxa on escola.id = taxa.escola_id
    group by Estado.UF
) as t
WHERE t.media >= 30

-- Consulta envovendo subconsultas aninhadas
-- Escolas que possuem mais de 2 terceirizadas contratadas
SELECT name FROM
(
    SELECT Escola.nome as name, count(terceirizada.id) as c
    FROM TerceirizadaEscola JOIN Terceirizada on Terceirizada.id = TerceirizadaEscola.terceirizada_id JOIN Escola on Escola.id = TerceirizadaEscola.escola_id
    group by Escola.id
) as t
WHERE c > 2

-- Consulta do tipo relatório
-- A escola com maior taxa de abandono do terceiro ano do ensino medio na cidade do rio de janeiro agrupadas por rede
SELECT max(Taxa.valor), Escola.nome, rede, localizacao
FROM Escola INNER JOIN Taxa on Escola.id=Taxa.escola_id
WHERE Taxa.serie = 12 and Taxa.tipo = 'Abandono'
group by Escola.rede;

-- Consulta do tipo relatório
-- A escola com maior taxa de abandono do terceiro ano do ensino medio na cidade do rio de janeiro agrupadas por rede
SELECT min(Taxa.valor), Escola.nome, rede, localizacao
FROM Escola INNER JOIN Taxa on Escola.id=Taxa.escola_id
WHERE Taxa.serie = 12 and Taxa.tipo = 'Abandono'
group by Escola.rede;

-- -- Obtém o número de Escola cadastradas no sistema e o numero de Escola que possuem taxas preenchidas por estado
-- SELECT count(distinct Escola.id), Estado.nome, uf, regiao, (bandeira?)
-- FROM Escola INNER JOIN Municipio on Escola.municipio_id=municipio.id INNER JOIN Estado on estado.id=municipio.estado_id INNER JOIN taxas on Escola.id=taxas.escola_id
-- WHERE sasdasddsads

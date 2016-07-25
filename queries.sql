-- Queries

-- Envolve apenas seleção e projeção
-- Obtém o id, nome, população, e UF de todos os municipios cadastrados com UF igual a RJ
select id, nome, populacao, estado_id as uf from municipio where uf = 'RJ';

-- Envolve junção de apenas duas relações
-- Obtém o nome, localização, rede, nome do municipio e UF de todas as escolas cuja UF é RO ou RS
select escola.nome, localizacao, rede, municipio.nome as municipio, municipio.estado_id as uf
from escola inner join municipio on escola.municipio_id=municipio.id
where municipio.estado_id = 'RO' or municipio.estado_id = 'RS';

-- Envolve junção externa de apenas duas relações
-- Todas as escolas que não tem taxas associadas apesar de cadastradas no sistema
select nome, rede, localizacao
from escola left join taxa on escola.id=taxa.escola_id
where rede = 'Federal' and taxa.id = null;

-- Envolve junção de apenas duas relações
-- Obtém todos os telefones da escola de nome CEFET CELSO SUCKOW DA FONSECA
select codigo, numero
from escolas inner join telefones on telefones.escola_id=escolas.id
where nome = 'CEFET CELSO SUCKOW DA FONSECA';

-- Envolve junção externa de apenas duas relações
-- Nomes, localização e taxas de todas as escolas da rede Federal e suas respectivas taxas de aprovação do ensino medio caso existam
select nome, localizacao, (.colocar taxas aqui.)
from escolas left join taxas on escolas.id=taxas.escola_id
where rede = 'Federal' and ( (taxas.tipo = null or taxas.tipo = 'Aprovação') and (taxas.serie = null or taxas.serie between 10 and 13));


-- Envolve junção de três relações
-- Obtém o nome, rede, localização e uf de todas as escolas da região Sudeste
select escolas.nome, rede, localizacao, uf
from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id
where estados.regiao = 'Sudeste';

-- Envolve junção de três relações
-- A media das taxas de aprovação do terceiro ano do ensino medio por estado
select avg(taxas.valor) as media de aprovacao, uf, bandeira
from escolas inner join taxas on escolas.id=taxas.escola_id inner join municipios on escolas.municipio_id=municipios.id inner join estados on estados.id=municipios.estado_id
where taxas.serie = 12
group by estado.uf;

-- Consulta envovendo operações sobre conjuntos
-- As escolas que tem reprovacão maior que 50% ou abandono maior que 50% em qualquer ano
select distinct escola.nome
from escola left join taxa on escola.id = taxa.escola_id
where taxa.tipo = 'Reprovação' and taxa.valor >= 50
union
select distinct escola.nome
from escola left join taxa on escola.id = taxa.escola_id
where taxa.tipo = 'Abandono' and taxa.valor >= 50

-- Consulta envolvendo função de agregação
-- Obtém o número de escolas cadastradas no sistema por estado
select count(distinct escolas.id), estados.nome, uf, regiao, bandeira
from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id
group by estados.uf

-- Consulta envolvendo função de agregação
-- Número de escolas cadastradas por região
select count(distinct escolas.id), regiao
from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id
group by regiao;

-- Consulta envolvendo função de agregação
-- Número de escolas cadastradas que não preencheram nenhum dado por região
select count(distinct escolas.id), regiao
from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id left join taxas on escolas.id=taxas.escola_id
where taxas.id = null
group by regiao;


-- Consulta envovendo subconsultas aninhadas
-- Estados que possui média de reprovacao das escolas maior ou igual a 30%
select name from
(
    select Estado.nome as name, avg(taxa.valor) as media
    from estado join municipio on estado.id = municipio.estado_id left join escola on municipio.id = escola.municipio_id left join taxa on escola.id = taxa.escola_id
    group by name
) as t
where t.media >= 30

-- Consulta envovendo subconsultas aninhadas


-- Consulta do tipo relatório
-- A escola com maior taxa de abandono do terceiro ano do ensino medio na cidade do rio de janeiro agrupadas por rede
select max(taxas.valor), escolas.nome, rede, localizacao
from escolas inner join taxas on escolas.id=taxas.escola_id
where taxas.serie = 12 and taxas.tipo = 'Abandono'
group by escolas.rede;

-- Consulta do tipo relatório
-- A escola com maior taxa de abandono do terceiro ano do ensino medio na cidade do rio de janeiro agrupadas por rede
select min(taxas.valor), escolas.nome, rede, localizacao
from escolas inner join taxas on escolas.id=taxas.escola_id
where taxas.serie = 12 and taxas.tipo = 'Abandono'
group by escolas.rede;

-- -- Obtém o número de escolas cadastradas no sistema e o numero de escolas que possuem taxas preenchidas por estado
-- select count(distinct escolas.id), estados.nome, uf, regiao, (bandeira?)
-- from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id inner join taxas on escolas.id=taxas.escola_id
-- where sasdasddsads

-- Queries

-- Envolve apenas seleção e projeção
select id, nome, populacao, estado_id as uf from municipios where uf = 'RJ';

-- Envolve junção de apenas duas relações
select escola.nome, localizacao, rede, municipio.nome as municipio, municipio.estado_id as uf
from escolas inner join municipios on escolas.municipio_id=municipio.id
where uf = 'RJ' or uf = 'RS';

-- Envolve junção externa de apenas duas relações
-- Todas as escolas que não tem taxas associadas apesar de cadastradas no sistema
select nome, rede, localizacao
from escolas left join taxas on escolas.id=taxas.escola_id
where rede = 'Federal' and  taxas.id = null;

-- Envolve junção externa de apenas duas relações
-- Nomes, localização e taxas de todas as escolas da rede Federal e suas respectivas taxas de aprovação do ensino medio caso existam
select nome, localizacao, (.colocar taxas aqui.)
from escolas left join taxas on escolas.id=taxas.escola_id
where rede = 'Federal' and ( (taxas.tipo = null or taxas.tipo = 'Aprovação') and (taxas.serie = null or taxas.serie like '%Médio'));

-- Envolve junção de três relações
-- Obté o nome, rede, localização e uf de todas as escolas da região Sudeste 
select escolas.nome, rede, localizacao, uf
from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id
where estados.regiao = 'Sudeste';

-- Envolve junção de duas relações
-- Obtém todos os telefones da escola de nome CEFET CELSO SUCKOW DA FONSECA
select codigo, numero 
from escolas inner join telefones on telefones.escola_id=escolas.id
where nome = 'CEFET CELSO SUCKOW DA FONSECA';

-- Obtém o número de escolas cadastradas no sistema por estado
select count(distinct escolas.id), estados.nome, uf, regiao, (bandeira?)
from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id

-- -- Obtém o número de escolas cadastradas no sistema e o numero de escolas que possuem taxas preenchidas por estado
-- select count(distinct escolas.id), estados.nome, uf, regiao, (bandeira?)
-- from escolas inner join municipios on escolas.municipio_id=municipio.id inner join estados on estado.id=municipio.estado_id inner join taxas on escolas.id=taxas.escola_id
-- where sasdasddsads
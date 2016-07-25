-- Queries

-- Envolve apenas seleção e projeção (OK)
-- Obtém o id, nome, população, e UF de todos os Municipio cadastrados com UF igual a RJ
select id, nome, populacao, estado_id as uf from Municipio where estado_id = 'RJ';

-- Envolve junção de apenas duas relações (OK)
-- Obtém o nome, localização, rede, nome do municipio e UF de todas as Escola cuja UF é MG ou PR
select Escola.nome, localizacao, rede, Municipio.nome as municipio, Municipio.estado_id as uf
from Escola inner join Municipio on Escola.municipio_id=Municipio.id
where Municipio.estado_id = 'MG' or Municipio.estado_id = 'PR';

-- Envolve junção externa de apenas duas relações
-- Todas as Escola que não tem taxas associadas apesar de cadastradas no sistema
select nome, rede, localizacao
from Escola left join Taxa on Escola.id=Taxa.escola_id
where rede = 'Federal' and Taxa.id = null;

-- Envolve junção de apenas duas relações
-- Obtém todos os telefones da escola de nome CEFET CELSO SUCKOW DA FONSECA
select codigo, numero
from Escola inner join Telefone on Telefone.escola_id=Escola.id
where nome = 'CEFET CELSO SUCKOW DA FONSECA';

-- Envolve junção externa de apenas duas relações
-- Nomes, localização e taxas de todas as Escola da rede Federal e suas respectivas taxas de aprovação do ensino medio caso existam
select nome, localizacao, (.colocar taxas aqui.)
from Escola left join Taxa on Escola.id=Taxa.escola_id
where rede = 'Federal' and ( (Taxa.tipo = null or Taxa.tipo = 'Aprovação') and (Taxa.serie = null or Taxa.serie between 10 and 13));


-- Envolve junção de três relações

-- Obtém o nome, rede, localização e uf de todas as Escola da região Sudeste
select Escola.nome, rede, localizacao, uf
from Escola inner join Municipio on Escola.municipio_id=Municipio.id inner join Estado on estado.id=Municipio.estado_id
where Estado.regiao = 'Sudeste';

-- Envolve junção de três relações
-- A media das taxas de aprovação do terceiro ano do ensino medio por estado
select avg(Taxa.valor) as media de aprovacao, uf, bandeira
from Escola inner join Taxa on Escola.id=Taxa.escola_id inner join Municipio on Escola.municipio_id=Municipio.id inner join Estado on Estado.id=Municipio.estado_id
where Taxa.serie = 12
group by Estado.uf;

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
-- Obtém o número de Escola cadastradas no sistema por estado
select count(distinct Escola.id), Estado.nome, uf, regiao, bandeira
from Escola inner join Municipio on Escola.municipio_id=Municipio.id inner join Estado on Estado.id=Municipio.estado_id
group by Estado.uf

-- Consulta envolvendo função de agregação
-- Número de Escola cadastradas por região
select count(distinct Escola.id), regiao
from Escola inner join Municipio on Escola.municipio_id=municipio.id inner join Estado on Estado.id=Municipio.estado_id
group by regiao;

-- Consulta envolvendo função de agregação
-- Número de Escola cadastradas que não preencheram nenhum dado por região
select count(distinct Escola.id), regiao
from Escola inner join Municipio on Escola.municipio_id=Municipio.id inner join Estado on Estado.id=Municipio.estado_id left join taxas on Escola.id=Taxa.escola_id
where Taxa.id = null
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
select max(Taxa.valor), Escola.nome, rede, localizacao
from Escola inner join Taxa on Escola.id=Taxa.escola_id
where Taxa.serie = 12 and Taxa.tipo = 'Abandono'
group by Escola.rede;

-- Consulta do tipo relatório
-- A escola com maior taxa de abandono do terceiro ano do ensino medio na cidade do rio de janeiro agrupadas por rede
select min(Taxa.valor), Escola.nome, rede, localizacao
from Escola inner join Taxa on Escola.id=Taxa.escola_id
where Taxa.serie = 12 and Taxa.tipo = 'Abandono'
group by Escola.rede;

-- -- Obtém o número de Escola cadastradas no sistema e o numero de Escola que possuem taxas preenchidas por estado
-- select count(distinct Escola.id), Estado.nome, uf, regiao, (bandeira?)
-- from Escola inner join Municipio on Escola.municipio_id=municipio.id inner join Estado on estado.id=municipio.estado_id inner join taxas on Escola.id=taxas.escola_id
-- where sasdasddsads

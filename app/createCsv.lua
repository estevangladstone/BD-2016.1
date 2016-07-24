local files = {}
io.write("Generate municipos? (y for yes)")
io.flush()
local geMu = io.read()
if geMu == "y" then
	geMu = true
else
	geMu = false
end
print(geMu)

-- Todos os arquivos de rendimento
table.insert(files, io.open("rendimentoescolaCO.csv", "r"))
table.insert(files, io.open("rendimentoescolaN.csv", "r"))
table.insert(files, io.open("rendimentoescolaNaBM.csv", "r"))
table.insert(files, io.open("rendimentoescolaNeBM.csv", "r"))
table.insert(files, io.open("rendimentoescolaS.csv", "r"))
table.insert(files, io.open("rendimentoescolaSd.csv", "r"))

local escolas = io.open("../planilhas/escolas.csv", "w+")
if geMu then
	municipios = io.open("../planilhas/municipios.csv", "w+")
	municipiosOcurrence = {}
end
local taxas_aprov = io.open("../planilhas/taxas_aprov.csv", "w+")
local taxas_reprov = io.open("../planilhas/taxas_reprov.csv", "w+")
local taxas_aband = io.open("../planilhas/taxas_aband.csv", "w+")

for x, file in pairs(files) do
	print (x)
	for line in file:lines() do
		local i = 0
		local stringEscolas = ""
		local escola_id, escola_rede, escola_nome, escola_localizacao, escola_municipio_id = "", "", "", "", ""
		local municipio_id, municipio_uf, municipio_nome, municipio_populacao = "", "", "", "\"\""
		local stringTaxaAprovacao = ""
		local stringTaxaReprovacao = ""
		local stringTaxaAbandono = ""
		local taxa_id, taxa_ano, taxa_escola_id = "", "", ""
		local taxa_aprov, taxa_aband, taxa_reprov = {}, {}, {}
		local stringMunicipios = ""
		local municipio_happen = false

		for v in string.gmatch(line, "[^;]*") do
			if v ~= "" then
				i = i + 1

				if i == 1 then
					taxa_ano = "\"" .. v .. "\""
				elseif i == 3 then
					municipio_uf = "\"" .. v .. "\""
				elseif i == 4 then
					escola_municipio_id = "\"" .. v .. "\""
					municipio_id = tonumber(v)
					if geMu then
						for _, y in pairs(municipiosOcurrence) do
							if municipio_id == y then
								municipio_happen = true
								break
							end
						end
						if not municipio_happen then
							table.insert(municipiosOcurrence, tonumber(v))
						end
					end
				elseif i == 5 then
					municipio_nome =  "\"" .. v .. "\""
				elseif i == 6 then
					escola_localizacao = "\"" .. v .. "\""
				elseif i == 7 then
					escola_rede = "\"" .. v .. "\""
				elseif i == 9 then
					escola_nome = "\"" .. v .. " \""
				elseif i == 8 then
					escola_id = "\"" .. v .. "\""
					taxa_escola_id = "\"" .. v .. "\""
				elseif (i >= 10 and i <= 18) or (i >= 22 and i <= 25) then
					table.insert(taxa_aprov, v)
				elseif (i >= 28 and i <= 36) or (i >= 40 and i <= 43) then
					table.insert(taxa_reprov, v)
				elseif (i >= 46 and i <= 54) or (i >= 58 and i <= 61) then
					table.insert(taxa_aband, v)
				end
			end
		end
		stringEscolas = escola_id .. ";" .. escola_rede .. ";" .. escola_nome .. ";" .. escola_localizacao .. ";" .. escola_municipio_id .. "\n"
		escolas:write(stringEscolas)

		for k in pairs(taxa_aprov) do
			stringTaxaAprovacao = taxa_ano .. ";" .. "\"" .. k .. "\"" .. ";" .. "\"" .. (taxa_aprov[k] or 0) .. "\"" .. ";" .. "\"Aprovacao\"" .. ";" .. taxa_escola_id .. "\n"
			stringTaxaReprovacao = taxa_ano .. ";" .. "\"" .. k .. "\"" .. ";" .. "\"" .. (taxa_reprov[k] or 0) .. "\"" .. ";" .. "\"Reprovacao\"" .. ";" .. taxa_escola_id .. "\n"
			stringTaxaAbandono = taxa_ano .. ";" .. "\"" .. k .. "\"" .. ";" .. "\"" .. (taxa_aband[k] or 0) .. "\"" .. ";" .. "\"Aprovacao\"" .. ";" .. taxa_escola_id .. "\n"
			taxas_aprov:write(stringTaxaAprovacao)
			taxas_reprov:write(stringTaxaReprovacao)
			taxas_aband:write(stringTaxaAbandono)
		end

		if geMu then
			stringMunicipios = "\"" .. municipio_id .. "\"" .. ";" .. municipio_nome .. ";" .. municipio_populacao .. ";" .. municipio_uf .. "\n"
			if not municipio_happen then
				municipios:write(stringMunicipios)
			end
		end
	end
	file:close()
end
escolas:flush()
escolas:close()
taxas_aprov:flush()
taxas_reprov:flush()
taxas_aband:flush()
taxas_aprov:close()
taxas_reprov:close()
taxas_aband:close()
if geMu then
	municipios:flush()
	municipios:close()
end

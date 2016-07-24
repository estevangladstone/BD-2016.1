function ParseCSVLine (line,sep)
	local res = {}
	local pos = 1
	sep = sep or ','
	while true do
		local c = string.sub(line,pos,pos)
		if (c == "") then break end
		if (c == '"') then
			-- quoted value (ignore separator within)
			local txt = ""
			repeat
				local startp,endp = string.find(line,'^%b""',pos)
				txt = txt..string.sub(line,startp+1,endp-1)
				pos = endp + 1
				c = string.sub(line,pos,pos)
				if (c == '"') then txt = txt..'"' end
				-- check first char AFTER quoted string, if it is another
				-- quoted string without separator, then append it
				-- this is the way to "escape" the quote char in a quote. example:
				--   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
			until (c ~= '"')
			table.insert(res,txt)
			assert(c == sep or c == "")
			pos = pos + 1
		else
			-- no quotes used, just look for the first separator
			local startp,endp = string.find(line,sep,pos)
			if (startp) then
				table.insert(res,string.sub(line,pos,startp-1))
				pos = endp + 1
			else
				-- no separator found -> use rest of string and terminate
				table.insert(res,string.sub(line,pos))
				break
			end
		end
	end
	return res
end

local files = {}
table.insert(files, io.open("rendimentoescolaCO.csv", "r"));
table.insert(files, io.open("rendimentoescolaN.csv", "r"));
table.insert(files, io.open("rendimentoescolaNaBM.csv", "r"));
table.insert(files, io.open("rendimentoescolaNeBM.csv", "r"));
table.insert(files, io.open("rendimentoescolaS.csv", "r"));
table.insert(files, io.open("rendimentoescolaSd.csv", "r"));
local escolas = io.open("../planilhas/escolas.csv", "w+")
for x, file in pairs(files) do
	for line in file:lines() do
		local i = 0
		local stringEscolas = "";
		local id, rede, nome, localizacao, municipio_id = "", "", "", "", ""
		for v in string.gmatch(line, "[^;]*") do
			if v ~= "" then
				i = i + 1
				if i == 4 then
					municipio_id = "\"" .. v .. "\""
				elseif i == 6 then
					localizacao = "\"" .. v .. "\""
				elseif i == 7 then
					rede = "\"" .. v .. "\""
				elseif i == 9 then
					nome = "\"" .. v .. "\""
				elseif i == 8 then
					id = "\"" .. v .. "\""
				end
			end
		end
		stringEscolas = id .. ";" .. rede .. ";" .. nome .. ";" .. localizacao .. ";" .. municipio_id .. "\n"
		if stringEscolas ~= "" then
			escolas:write(stringEscolas)
		end
	end
	file:close()
end
escolas:flush()
escolas:close()

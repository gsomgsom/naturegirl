local M = {}

--библиотека json используется для удобной сериализации данных их файла
-- local json = require("json")

local path_extract = function(fn)
	return system.pathForFile( fn, system.DocumentsDirectory )
end

--сохрание
function M.save(f,data)
	local file_path = path_extract(f)
	local file = io.open(file_path, "w")
	if file then
		local json_txt = json.encode(data)--перевод таблицы в json
		file:write( json_txt )--запись в файл
		io.close( file )
	end
end

--загрузка
function M.load(f)
	local file_path = path_extract(f)
	local file = io.open(file_path, "r")--открытие файла на чтение
	if file then
		local json_txt = file:read("*a")--чтение всего файла как текст
		io.close( file )--закрытие файла
		local data = json.decode(json_txt)
		return data
	else
		return nil;
	end
end

return M

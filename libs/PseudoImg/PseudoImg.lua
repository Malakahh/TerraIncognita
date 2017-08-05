local Img = {}

function Img.Write(filePath, width, height, data)
	if filePath == nil or width == nil or height == nil or data == nil then return end

	local f = io.open(filePath, "w")
	f:write(tostring(width) .. "x" .. tostring(height) .. "\n")

	local x,y
	for y = 1, height - 1 do
		for x = 1, width - 1 do
			f:write(tostring(data[y][x]) .. ",")
		end
	end
end

return Img
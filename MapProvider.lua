local perlin = require "libs.PerlinNoise.Perlin"
local blob = require "libs.Util.Blob"

local mapProvider = {}

--Tile level settings (think water-level, etc.)
mapProvider.tileLevels = {
	--Example
	--{ name = "ExampleTile", level = [-1.0, 1.0] }
	--{ name = "MySampleTile", level = -0.75 }
	--{ name = "OtherSampleTile", level = 0.8 }


	--{ name = "out-of-map", level = 0.0 },
	{ name = "deepwater", level = 0.1 },
	--{ name = "deepwater-green", level = 0.0 },
	{ name = "water", level = 0.35 },
	--{ name = "water-green", level = 0.0 },
	{ name = "grass", level = 0.55 },
	{ name = "grass-medium", level = 0.6 },
	{ name = "grass-dry", level = 0.65 },
	--{ name = "dirt", level = 0.0 },
	--{ name = "dirt-dark", level = 0.0 },
	--{ name = "sand", level = 0.0 },
	{ name = "sand-dark", level = 0.95 },
	--{ name = "red-desert", level = 0.0 },
	{ name = "red-desert-dark", level = 1 },
	--{ name = "stone-path", level = 0.0 },
	--{ name = "lab-dark-1", level = 0.0 },
	--{ name = "lab-dark-2", level = 0.0 },
}

do
	local function comparer(a, b)
		return a.level < b.level
	end

	table.sort(mapProvider.tileLevels, comparer)
end

-- Noise settings - careful with these
-- mapProvider.freq = 1/64.0
-- mapProvider.octs = 5
-- mapProvider.persistance = 700

mapProvider.freq = 1/128.0
mapProvider.octs = 5
mapProvider.persistance = 700

function mapProvider:GetTile(x, y)
	--Sort out starting area
	if self.startingArea == nil then
		local b = blob:New(nil, nil, 64, 64, nil) --resolution, lerpSteps, radius, variance, windowSize
		self.startingArea = b:Spawn(0.55)
	end

	local val

	if self.startingArea[y] ~= nil and self.startingArea[y][x] ~= nil then
		val = self.startingArea[y][x]
	else
		val = perlin:fBm(x * mapProvider.freq, y * mapProvider.freq, mapProvider.persistance, mapProvider.octs)
	end

	local tile = {}
	tile.position = {x, y}
	for _,v in ipairs(mapProvider.tileLevels) do
		if val <= v.level then
			tile.name = v.name
			break
		end
	end

	return tile
end

return mapProvider
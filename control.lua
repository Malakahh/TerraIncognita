--local events = require "libs.BetterEvents.BetterEvents"
local perlin = require "libs.PerlinNoise.Perlin"
local Img = require "libs.PseudoImg.PseudoImg"


-- local frame = {}
-- --events.RegisterForEvents(frame)

-- function frame:on_player_created(event)
-- 	game.players[1].print("Terra Incognita loaded")
-- end

-- function frame:on_chunk_generated(event)
-- 	-- body
-- end

local xMax = 64
local yMax = 64
local seed = 1337

perlin:GenerateGradientGrid(xMax, yMax, seed)

local freq = 1/32.0
local octs = 5

local noise = {}
local x,y
for y = 1, yMax -1 do
	noise[y] = {}

	for x = 1, xMax -1 do
		local nx = x + 0.5
		local ny = y + 0.5
		--noise[y][x] = perlin:GetNoise(nx, ny)
		-- noise[y][x] = perlin:GetNoise(nx, ny) +
		-- 	0.5 * perlin:GetNoise(math.floor(nx / 2 + 0.5), math.floor(ny / 2 + 0.5)) +
		-- 	0.25 * perlin:GetNoise(math.floor(nx / 4 + 0.75), math.floor(ny / 4 + 0.75))

		--noise[y][x] = noise[y][x] / (1 + 0.5 + 0.25)
		noise[y][x] = perlin:FBM(nx * freq, ny * freq, octs)
	end
end

Img.Write("pImg.dat", xMax, yMax, noise)

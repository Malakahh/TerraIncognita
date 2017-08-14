local events = require "libs.BetterEvents.BetterEvents"
local perlin = require "libs.PerlinNoise.Perlin"
local map = require "MapProvider"
local rso = require "rsoInterface"
--local scout = require "scout"

local frame = {}
events.RegisterForEvents(frame)

script.on_init(function ()
	perlin:init()
	rso:Init()
	rso:DisableChunkHandler()
end)

function frame:on_player_created(event)
	game.players[1].print("Terra Incognita loaded")
	--scout:DoChart()
end

function frame:on_chunk_generated(event)
	local surface = event.surface

	local tl = event.area.left_top
	local br = event.area.right_bottom

	local tiles = {}

	local water = 0
	local nonwater = 0

	for y = tl.y, br.y do
		for x = tl.x, br.x do
			local tile = map:GetTile(x,y)

			if tile.name == "water" or tile.name == "deepwater" then
				water = water + 1
			else
				nonwater = nonwater + 1
			end

			table.insert(tiles, tile)
		end
	end

	surface.set_tiles(tiles, true)

	--if water / nonwater < 0.2 then
		rso:GenerateChunk(event)
	--end
end
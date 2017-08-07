local events = require "libs.BetterEvents.BetterEvents"
local perlin = require "libs.PerlinNoise.Perlin"
local map = require "MapProvider"


local frame = {}
events.RegisterForEvents(frame)

script.on_init(function ()
	perlin:init()
end)

function frame:on_player_created(event)
	game.players[1].print("Terra Incognita loaded")
end

function frame:on_chunk_generated(event)
	local surface = event.surface

	local tl = event.area.left_top
	local br = event.area.right_bottom

	local tiles = {}

	for y = tl.y, br.y do
		for x = tl.x, br.x do
			table.insert(tiles, map:GetTile(x,y))
		end
	end

	surface.set_tiles(tiles, true)
end
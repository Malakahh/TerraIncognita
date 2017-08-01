local events = require "libs.BetterEvents.BetterEvents"

local frame = {}
events.RegisterForEvents(frame)

function frame:on_player_created(event)
	game.players[1].print("Terra Incognita loaded")
end

function frame:on_chunk_generated(event)
	-- body
end

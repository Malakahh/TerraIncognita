local scout = {}

function scout:DoChart()
	game.players[1].force.chart(game.players[1].surface,
                        {{x = -1024, y = -1024}, {x = 1024, y = 1024}})
end

return scout
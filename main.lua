function love.load()
	Object = require("libs.classic")
	Player = require("entities.player")

	player = Player()
end

function love.update(dt) end

function love.draw()
	player:draw()
end

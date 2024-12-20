function love.load()
	Object = require("libs.classic")
	Player = require("entities.player")
	Enemy = require("entities.enemy")

	player = Player()
	enemy = Enemy()
end

function love.update(dt)
	player:update(dt)
	enemy:update(dt)
end

function love.draw()
	player:draw()
	enemy:draw()
end

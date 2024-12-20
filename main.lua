function love.load()
	Object = require("libs.classic")
	Player = require("entities.player")
	Enemy = require("entities.enemy")
	Bullet = require("entities.bullet")

	player = Player()
	enemy = Enemy()
	listOfBullets = {}
end

function love.keypressed(key)
	player:keyPressed(key)
end

function love.update(dt)
	player:update(dt)
	enemy:update(dt)

	for index, bullet in pairs(listOfBullets) do
		bullet:update(dt)

		bullet:checkCollision(enemy)

		if bullet.dead then
			table.remove(listOfBullets, index)
		end
	end
end

function love.draw()
	player:draw()
	enemy:draw()

	for _, bullet in pairs(listOfBullets) do
		bullet:draw()
	end
end

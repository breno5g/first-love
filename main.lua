-- function love.load()
-- 	Object = require("libs.classic")
-- 	Player = require("entities.player")
-- 	Enemy = require("entities.enemy")
-- 	Bullet = require("entities.bullet")

-- 	player = Player()
-- 	enemy = Enemy()
-- 	listOfBullets = {}
-- end

-- function love.keypressed(key)
-- 	player:keyPressed(key)
-- end

-- function love.update(dt)
-- 	player:update(dt)
-- 	enemy:update(dt)

-- 	for index, bullet in pairs(listOfBullets) do
-- 		bullet:update(dt)

-- 		bullet:checkCollision(enemy)

-- 		if bullet.dead then
-- 			table.remove(listOfBullets, index)
-- 		end
-- 	end
-- end

-- function love.draw()
-- 	player:draw()
-- 	enemy:draw()

-- 	for _, bullet in pairs(listOfBullets) do
-- 		bullet:draw()
-- 	end
-- end

local circle = {}

function love.load()
	love.window.setMode(1000, 800)

	circle.x = 100;
	circle.y = 100;
	circle.radius = 50;
	circle.speed = 200
end

function love.keypressed(key)
	if (key == "escape") then
		love.event.quit()
	end
end

function love.update(dt)
	--love.mouse.getPosition returns the x and y position of the cursor.
	mouse_x, mouse_y = love.mouse.getPosition()

	angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

	cos = math.cos(angle)
	sin = math.sin(angle)

	--Make the circle move towards the mouse
	circle.x = circle.x + circle.speed * cos * dt
	circle.y = circle.y + circle.speed * sin * dt
end

function love.draw()
	love.graphics.circle("line", circle.x, circle.y, circle.radius)

	love.graphics.print("angle: " .. angle, 10, 10)

	love.graphics.line(circle.x, circle.y, mouse_x, circle.y)
	love.graphics.line(circle.x, circle.y, circle.x, mouse_y)

	love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
end
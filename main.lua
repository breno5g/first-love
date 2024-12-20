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
local arrow = {}

function love.load()
	love.window.setMode(1000, 800)

	circle.x = 100;
	circle.y = 100;
	circle.radius = 50;
	circle.speed = 200;

	arrow.x = 200;
	arrow.y = 200;
	arrow.speed = 200;
	arrow.angle = 0;
	arrow.image = love.graphics.newImage("assets/arrow_right.png")
	arrow.origin_x, arrow.origin_y = arrow.image:getDimensions()

	arrow.origin_x = arrow.origin_x / 2
	arrow.origin_y = arrow.origin_y / 2

end

function love.keypressed(key)
	if (key == "escape") then
		love.event.quit()
	end
end

function getDistance(x1, y1, x2, y2)
	local  a = (x2 - x1) ^ 2 
	local  b = (y2 - y1) ^ 2
	local  c = a + b

	return math.sqrt(c)
end

function love.update(dt)
	mouse_x, mouse_y = love.mouse.getPosition()

	-- Use this for circle
	-- angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

	-- cos = math.cos(angle)
	-- sin = math.sin(angle)

	-- local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)

	-- if distance < 400 then
	-- 		circle.x = circle.x + circle.speed * cos * (distance/100) * dt
	-- 		circle.y = circle.y + circle.speed * sin * (distance/100) * dt
	-- end

	-- Use this for arrow
	angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
	arrow.angle = angle

	arrow.x = arrow.x + arrow.speed * math.cos(angle) * dt
	arrow.y = arrow.y + arrow.speed * math.sin(angle) * dt


end

function love.draw()
	love.graphics.print("angle: " .. angle, 10, 10)
	-- love.graphics.circle("line", circle.x, circle.y, circle.radius)


	-- love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
	-- love.graphics.line(mouse_x, mouse_y, mouse_x, circle.y)
	-- love.graphics.line(circle.x, circle.y, mouse_x, circle.y)

	-- local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)
	-- love.graphics.circle("line", circle.x, circle.y, distance)

	love.graphics.circle("fill", mouse_x, mouse_y, 5)

	love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle, 1, 1, arrow.origin_x, arrow.origin_y)
end
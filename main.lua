local image = love.graphics.newImage("assets/sheep.png")
local x = 100
local y = 100
local speed = 100
function love.load() end

local function calculateDirection(first, second)
	local direction = (first and 1 or 0) - (second and 1 or 0)
	return direction
end

function love.update(dt)
	local xDir = calculateDirection(love.keyboard.isDown("right"), love.keyboard.isDown("left"))
	local yDir = calculateDirection(love.keyboard.isDown("down"), love.keyboard.isDown("up"))

	x = x + speed * dt * xDir
	y = y + speed * dt * yDir
end

function love.draw()
	love.graphics.setColor(25 / 255, 40 / 255, 230 / 255)
	love.graphics.draw(image, x, y)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(image, x + image:getWidth() + 10, y)
end


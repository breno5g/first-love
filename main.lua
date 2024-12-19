local r1 = {
	x = 10,
	y = 100,
	width = 100,
	height = 100,
}

local r2 = {
	x = 250,
	y = 300,
	width = 100,
	height = 100,
}

function love.load() end

local function calculateDirection(first, second)
	local direction = (first and 1 or 0) - (second and 1 or 0)
	return direction
end

function love.update(dt)
	local xDir = calculateDirection(love.keyboard.isDown("right"), love.keyboard.isDown("left"))
	local yDir = calculateDirection(love.keyboard.isDown("down"), love.keyboard.isDown("up"))
	r1.x = r1.x + 100 * dt * xDir
	r1.y = r1.y + 100 * dt * yDir
end

local function checkCollision(a, b)
	local a_left = a.x
	local a_right = a.x + a.width
	local a_top = a.y
	local a_bottom = a.y + a.height

	local b_left = b.x
	local b_right = b.x + b.width
	local b_top = b.y
	local b_bottom = b.y + b.height

	return a_right > b_left and a_left < b_right and a_bottom > b_top and a_top < b_bottom
end

function love.draw()
	local mode
	if checkCollision(r1, r2) then
		--If there is collision, draw the rectangles filled
		mode = "fill"
	else
		--else, draw the rectangles as a line
		mode = "line"
	end
	love.graphics.rectangle(mode, r1.x, r1.y, r1.width, r1.height)
	love.graphics.rectangle(mode, r2.x, r2.y, r2.width, r2.height)
end

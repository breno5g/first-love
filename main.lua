function love.load()
	x = 300
	y = 150
	speed = 100

	fruits = { "apple", "banana", "pineaple" }
end

function love.update(dt)
	local xDir = love.keyboard.isDown("right") and 1 or love.keyboard.isDown("left") and -1 or 0
	local yDir = love.keyboard.isDown("up") and -1 or love.keyboard.isDown("down") and 1 or 0
	x = x + speed * dt * xDir
	y = y + speed * dt * yDir
end

function love.draw()
	love.graphics.rectangle("line", x, y, 200, 150)

	for i, v in ipairs(fruits) do
		love.graphics.print(v, 100, 100 + 50 * i)
	end
end


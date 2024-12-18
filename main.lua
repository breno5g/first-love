function love.load()
	x = 50
	speed = 50
end

function love.update(dt)
	x = x + (speed * dt)
end

function love.draw()
	love.graphics.rectangle("line", x, 50, 200, 150)
end

function love.load()
	x = 50
	speed = 100
end

function love.update(dt)
	if x < 600 then
		x = x + (speed * dt)
	end
end

function love.draw()
	love.graphics.rectangle("line", x, 50, 200, 150)
end

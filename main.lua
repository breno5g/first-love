local cellSize = 5
local selectedX = 0
local selectedY = 0

function love.load()
	love.window.setMode(500, 500)
	love.graphics.setBackgroundColor(1, 1, 1)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.update()
	selectedX = math.floor(love.mouse.getX() / cellSize) + 1
	selectedY = math.floor(love.mouse.getY() / cellSize) + 1
end

function love.draw()
	for y = 1, 500 do
		for x = 1, 500 do
			local cellDrawSize = cellSize - 1

			love.graphics.setColor(0.86, 0.86, 0.86)
			love.graphics.rectangle("fill", (x - 1) * cellSize, (y - 1) * cellSize, cellDrawSize, cellDrawSize)
		end
	end

	love.graphics.setColor(0, 0, 0)
	love.graphics.print("selected x: " .. selectedX .. ", selected y: " .. selectedY)
end

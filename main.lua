require("hello")
print(hello)
function love.load()
	rectList = {}
end

local function createRect()
	local rect = {}
	rect.x = 100
	rect.y = 100
	rect.width = 70
	rect.height = 90
	rect.speed = 100

	table.insert(rectList, rect)
end

function love.keypressed(key)
	if key == "space" then
		createRect()
	end
end

function love.update(dt)
	local yDir = love.keyboard.isDown("up") and -1 or love.keyboard.isDown("down") and 1 or 0
	for _, rect in ipairs(rectList) do
		rect.x = rect.x + rect.speed * dt
		rect.y = rect.y + rect.speed * dt * yDir
	end
end

function love.draw(dt)
	for _, v in ipairs(rectList) do
		love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
	end
end

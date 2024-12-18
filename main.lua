function love.load()
	Object = require("libs.classic")
	--Don't forget to load the file
	require("rectangle")

	r1 = Rectangle(100, 100, 200, 50, 100)
	r2 = Rectangle(350, 80, 25, 140, 120)
	print(r1.test, r2.test)
end

function love.update(dt)
	r1:update(dt)
	r2:update(dt)
end

function love.draw()
	r1:draw()
	r2:draw()
end

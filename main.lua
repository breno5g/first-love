function love.load()
	Object = require("libs.classic")
	--Don't forget to load the file
	require("rectangle")

	r1 = Rectangle()
	r2 = Rectangle()
	print(r1.test, r2.test)
end

function love.update(dt)
	r1:update(dt)
end

function love.draw()
	r1:draw()
end

Rectangle = Object.extend(Object)

function Rectangle:new(x, y, width, height, speed)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.speed = speed
end

function Rectangle:update(dt)
	self.x = self.x + self.speed * dt
end

function Rectangle:draw()
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

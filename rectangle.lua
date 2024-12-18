Rectangle = Object.extend(Object)

function Rectangle:new()
	self.x = 100
	self.y = 100
	self.width = 200
	self.height = 150
	self.speed = 100
end

function Rectangle:update(dt)
	self.x = self.x + self.speed * dt
end

function Rectangle:draw()
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

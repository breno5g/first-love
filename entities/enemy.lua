local Enemy = Object:extend()

function Enemy:new()
	self.image = love.graphics.newImage("assets/snake.png")
	self.x = 325
	self.y = 525
	self.speed = 100
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function Enemy:update(dt)
	self.x = self.x + self.speed * dt

	local window_width = love.graphics.getWidth()

	if self.x - self.width / 2 < 0 then
		self.x = 0 + self.width / 2
		self.speed = -self.speed
	elseif self.x + self.width / 2 > window_width then
		self.x = window_width - self.width / 2
		self.speed = -self.speed
	end
end

function Enemy:draw()
	local rad = 180 * (math.pi / 180)
	local ox, oy = self.width / 2, self.height / 2
	love.graphics.draw(self.image, self.x, self.y, rad, 1, 1, ox, oy)
end

return Enemy

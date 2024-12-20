local Player = Object:extend()

function Player:new()
	self.image = love.graphics.newImage("assets/panda.png")
	self.x = 300
	self.y = 20
	self.speed = 500
	self.width = self.image:getWidth()
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

function Player:update(dt)
	local xDir = (love.keyboard.isDown("right") and 1 or 0) - (love.keyboard.isDown("left") and 1 or 0)
	self.x = self.x + self.speed * dt * xDir

	local window_width = love.graphics.getWidth()
	if self.x < 0 then
		self.x = 0
	elseif self.x + self.width > window_width then
		self.x = window_width - self.width
	end
end

return Player

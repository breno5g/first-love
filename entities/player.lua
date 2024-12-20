local Player = Object:extend()

function Player:new()
	self.image = love.graphics.newImage("assets/panda.png")
	self.x = 300
	self.y = 20
	self.speed = 500
end

function Player:draw()
	love.graphics.draw(self.image, self.x, self.y)
end

return Player

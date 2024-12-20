local Bullet = Object:extend()

function Bullet:new(x, y)
  self.image = love.graphics.newImage("assets/bullet.png")
  self.x = x
  self.y = y
  self.speed = 700
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.dead = false
end

function Bullet:update(dt)
  self.y = self.y + self.speed * dt
end

function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:checkCollision(obj) 
  local self_left, self_right = self.x, self.x + self.width
  local self_top, self_bottom = self.y, self.y + self.height

  local obj_left, obj_right = obj.x, obj.x + obj.width
  local obj_top, obj_bottom = obj.y, obj.y + obj.height

  local isColidingY = self_bottom > obj_top and self_top < obj_bottom
  local isColidingX = self_right > obj_left and self_left < obj_right

  if isColidingX and isColidingY then
    obj.speed = obj.speed > 0 and obj.speed + 50 or obj.speed - 50
    self.dead = true
  end
end

return Bullet
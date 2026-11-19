local Entity = {}
Entity.__index = Entity

function Entity.new(x, y, imagePath, health)
    local self = setmetatable({}, Entity)

    self.x = x
    self.y = y
    self.image = love.graphics.newImage(imagePath)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.health = health
    self.maxHealth = health

    self.velocity_y = 0
    self.is_jumping = false

    return self
end

function Entity:updatePhysics(gravity, dt, platforms)
    local Collision = require("collision")

    self.velocity_y = self.velocity_y + gravity * dt
    self.y = self.y + self.velocity_y * dt

    Collision.checkSideCollision(self, platforms)
    if Collision.checkHeadCollision(self, platforms, self.velocity_y) then
        self.velocity_y = 0
        self.is_jumping = false
    end

    if Collision.checkGroundCollision(self, platforms) then
        self.velocity_y = 0
        self.is_jumping = false
    end
end

function Entity:jump(jumpForce)
    if not self.is_jumping then
        self.velocity_y = -jumpForce
        self.is_jumping = true
    end
end

function Entity:takeDamage(amount)
    self.health = math.max(0, self.health - amount)
end

function Entity:heal(amount)
    self.health = math.min(self.maxHealth, self.health + amount)
end

function Entity:isOnGround(platforms)
    local Collision = require("collision")
    return Collision.getCurrentPlatform(self, platforms) ~= nil
end

function Entity:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.image, self.x, self.y)
end

return Entity
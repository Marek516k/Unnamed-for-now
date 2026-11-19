local Entity = require("entity")
local Config = require("config")
local Collision = require("collision")

local Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player.new()
    local self = Entity.new(
        Config.player.spawn_x,
        Config.player.spawn_y,
        "sprites/Player.png",
        Config.player.max_health
    )
    setmetatable(self, Player)

    self.speed = Config.player.speed
    self.jump_force = Config.player.jump_force
    self.jump_acceleration = Config.player.jump_acceleration
    self.gravity = Config.gravity

    return self
end

function Player:update(dt, platforms)
    local window_width = Config.window_width

    if love.keyboard.isDown("a") then
        self.x = math.max(0, self.x - self.speed * dt)
    end

    if love.keyboard.isDown("d") then
        self.x = math.min(window_width - self.width, self.x + self.speed * dt)
    end

    if love.keyboard.isDown("w") and self:isOnGround(platforms) then
        self:jump(self.jump_force)
    end

    if love.keyboard.isDown("w") and self.is_jumping then
        self.velocity_y = self.velocity_y - self.jump_acceleration * dt
    end

    self:updatePhysics(self.gravity, dt, platforms)
end

function Player:draw()
    Entity.draw(self)

    -- Debug collision box
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end

return Player
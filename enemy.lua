local Entity = require("entity")
local Config = require("config")
local Collision = require("collision")
local HealthUI = require("healthui")

local Enemy = {}
Enemy.__index = Enemy
setmetatable(Enemy, Entity)

function Enemy.new(enemyType)
    local self = Entity.new(
        Config.enemy.spawn_x,
        Config.enemy.spawn_y,
        "sprites/Enemy.png",
        Config.enemy.max_health
    )
    setmetatable(self, Enemy)

    self.speed = Config.enemy.speed
    self.jump_force = Config.enemy.jump_force
    self.jump_acceleration = Config.enemy.jump_acceleration
    self.gravity = Config.gravity
    self.enemy_type = enemyType or "cube"

    self.jump_attempt_timer = 0

    return self
end

function Enemy:findLowestPlatform(platforms)
    local currentPlatform = Collision.getCurrentPlatform(self, platforms)
    if not currentPlatform then return nil end

    local lowestPlatform = nil
    local lowestY = currentPlatform.y

    for _, platform in ipairs(platforms) do
        if platform.y > lowestY and platform.width > 400 then
            lowestY = platform.y
            lowestPlatform = platform
        end
    end

    return lowestPlatform
end

function Enemy:canJumpFromPlatform(platforms)
    if not self:isOnGround(platforms) then return false end

    local currentPlatform = Collision.getCurrentPlatform(self, platforms)
    if not currentPlatform then return false end

    if currentPlatform.width > 400 then return true end

    local edgeThreshold = 2
    local distanceFromLeft = self.x - currentPlatform.x
    local distanceFromRight = (currentPlatform.x + currentPlatform.width) - (self.x + self.width)

    return distanceFromLeft < edgeThreshold or distanceFromRight < edgeThreshold
end

function Enemy:update(dt, platforms, playerEntity)
    local window_width = Config.window_width

    local dx = playerEntity.x - self.x
    local dy = playerEntity.y - self.y

    local moveDirection = 0

    if dx > 10 then
        moveDirection = 1
    elseif dx < -10 then
        moveDirection = -1
    end

    if moveDirection > 0 and self.x > window_width - self.width then
        moveDirection = 0
    elseif moveDirection < 0 and self.x < 0 then
        moveDirection = 0
    end

    if moveDirection > 0 then
        self.x = self.x + self.speed * dt
    elseif moveDirection < 0 then
        self.x = self.x - self.speed * dt
    end

    if dy < -10 and self:isOnGround(platforms) and not self.is_jumping then
        self.jump_attempt_timer = self.jump_attempt_timer + dt

        if self.jump_attempt_timer > Config.enemy.jump_cooldown then
            local lowestPlatform = self:findLowestPlatform(platforms)
            if lowestPlatform then
                dx = lowestPlatform.x + lowestPlatform.width / 2 - (self.x + self.width / 2)
            end
            self.jump_attempt_timer = 0
        end

        local canJump = false
        for _, platform in ipairs(platforms) do
            if self.x + self.width > platform.x and platform.y > self.y then
                canJump = true
                break
            end
        end

        if canJump and self:canJumpFromPlatform(platforms) then
            self:jump(self.jump_force)
            self.jump_attempt_timer = 0
        end
    else
        self.jump_attempt_timer = 0
    end

    if self.is_jumping then
        self.velocity_y = self.velocity_y - self.jump_acceleration * dt
    end

    self:updatePhysics(self.gravity, dt, platforms)
end

function Enemy:draw()
    Entity.draw(self)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)

    local health_bar_x = self.x + self.width / 2 - Config.ui.health_bar_max_width / 2
    local health_bar_y = self.y + Config.ui.enemy_health_offset_y
    HealthUI.drawHealthBar(health_bar_x, health_bar_y, self.health, self.maxHealth)
end

return Enemy
local Config = require("config")
local Collision = require("collision")

local Weapon = {}
Weapon.__index = Weapon

function Weapon.new(player)
    local self = setmetatable({}, Weapon)

    self.player = player
    self.damage = Config.weapon.damage
    self.width = Config.weapon.width
    self.height = Config.weapon.height
    self.offset_x = Config.weapon.offset_x

    self.is_attacking = false
    self.current_frame = 1
    self.animation_timer = 0

    self:loadAnimationFrames()

    return self
end

function Weapon:loadAnimationFrames()
    self.sprite_sheet = love.graphics.newImage("sprites/sword.png")

    self.frames = {}
    local frameWidth = Config.weapon_animation.frame_width
    local frameHeight = Config.weapon_animation.frame_height

    for i = 1, Config.weapon_animation.frame_count do
        self.frames[i] = love.graphics.newQuad(
            (i - 1) * frameWidth, 0,
            frameWidth, frameHeight,
            self.sprite_sheet:getDimensions()
        )
    end
end

function Weapon:update(dt)
    self.x = self.player.x + self.player.width + self.offset_x
    self.y = self.player.y + self.player.height / 2

    if self.is_attacking then
        self.animation_timer = self.animation_timer + dt

        if self.animation_timer >= Config.weapon_animation.frame_duration then
            self.animation_timer = self.animation_timer - Config.weapon_animation.frame_duration
            self.current_frame = self.current_frame + 1

            if self.current_frame > Config.weapon_animation.frame_count then
                self.current_frame = 1
                self.is_attacking = false
            end
        end
    end

    if love.mouse.isDown(1) and not self.is_attacking then
        self.is_attacking = true
        self.current_frame = 1
        self.animation_timer = 0
    end
end

function Weapon:checkCollision(target)
    if self.is_attacking and Collision.isRectangleColliding(
        self.x, self.y, self.width, self.height,
        target.x, target.y, target.width, target.height
    ) then
        target:takeDamage(self.damage)
        return true
    end
    return false
end

function Weapon:draw()
    local frame = self.frames[self.current_frame] or self.frames[1]

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(
        self.sprite_sheet,
        frame,
        self.x, self.y,
        0,
        1, 1,
        self.width / 2, self.height / 2
    )

    -- Debug collision box
    if self.is_attacking then
        love.graphics.setColor(1, 1, 0)
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    end

    love.graphics.setColor(1, 1, 1)
end

return Weapon
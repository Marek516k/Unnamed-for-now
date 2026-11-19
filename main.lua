love = require("love")

local Config = require("config")
local Player = require("player")
local Enemy = require("enemy")
local Weapon = require("weapon")
local PlatformManager = require("platformmanager")
local HealthUI = require("healthui")
local Combat = require("combat")

local gameState = {
    player = nil,
    enemy = nil,
    weapon = nil,
    platforms = nil,
}

function love.load()
    love.window.setMode(Config.window_width, Config.window_height, {resizable = false, vsync = false})

    gameState.platforms = PlatformManager.create()
    gameState.player = Player.new()
    gameState.enemy = Enemy.new("cube")
    gameState.weapon = Weapon.new(gameState.player)

    HealthUI.init()
end

function love.update(dt)
    gameState.player:update(dt, gameState.platforms)

    gameState.enemy:update(dt, gameState.platforms, gameState.player)

    gameState.weapon:update(dt)

    gameState.weapon:checkCollision(gameState.enemy)

    Combat.enemyAttack(gameState.enemy, gameState.player)

    if gameState.player.health <= 0 then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)

    PlatformManager.draw(gameState.platforms)
    gameState.player:draw()
    gameState.enemy:draw()
    gameState.weapon:draw()

    HealthUI.drawHealthBar(Config.ui.player_health_x, Config.ui.player_health_y, gameState.player.health, gameState.player.maxHealth)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

-- Player and Enemy hitboxes, collision detection and response
-- Player health and other GUI elements, Enemy health + rewards?
-- Enemy and Player attack and animation
-- Player abilities, maybe some kind of skill tree or something like that also enemies could have them too maybe?
-- Enemy death animation, Player death animation and game over screen
-- room designing, dungeon generation
-- make an actual system for this
-- more enemies, more Player abilities, traps, collectibles, secrets, etc.
-- sets, boss fights, etc.
-- overlays, parallax backgrounds, etc.
-- overhaul of the code and graphics, maybe a different art style, etc.
-- some story and lore, maybe?
-- sound effects and music
-- to be though about ...
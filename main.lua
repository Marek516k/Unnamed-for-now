love = require("love")
require("variables")
require("playerFunctions")
require("enemyFunctions")
require("Platforms")
require("combat")
require("weapon_anim")
require("enemyAnimations")

function love.load()
    love.window.setMode(1080, 720, {resizable = false, vsync = false})
    Variables()
    loadSheets()
end

function love.update(dt)
    updateSheet(dt)
    PlayerMovement(dt)
    EnemyMovement(dt)
end

function love.draw()
    DrawPlatforms()
    DisplayHP(Player.health)
    DrawSheet()
    DrawPlayer()
    DrawEnemy()
    love.graphics.rectangle(
        "line",
        Enemy.x,
        Enemy.y,
        Enemy.width + 2,
        Enemy.height + 2)

    love.graphics.rectangle(
        "line",
        weapon.x,
        weapon.y,
        32,32
    )
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

-- TODO:
-- Enemy movement correction
-- Player and Enemy hitboxes, collision detection and response
-- Player health and other GUI elements, Enemy health + rewards?
-- Enemy and Player attack and animation
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
love = require("love")
require("variables")
require("playerFunctions")
require("enemyFunctions")
require("Platforms")

function love.load()
    Variables()
end

function love.update(dt)
    EnemyMovement(dt)
    PlayerMovement(dt)
end

function love.draw()
    DrawPlatforms()
    DrawPlayer()
    DrawEnemy()
end

-- TODO:
-- enemy movement correction
-- player and enemy hitboxes, collision detection and response
-- player health and other GUI elements, enemy health + rewards?
-- enemy and player attack and animation
-- enemy death animation, player death animation and game over screen
-- room designing, dungeon generation
-- make an actual system for this
-- more enemies, more player abilities, traps, collectibles, secrets, etc.
-- sets, boss fights, etc.
-- overlays, parallax backgrounds, etc.
-- overhaul of the code and graphics, maybe a different art style, etc.
-- some story and lore, maybe?
-- sound effects and music
-- to be though about ...
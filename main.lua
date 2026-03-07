love = require("love")
variables = require("variables")
playerFunctions = require("playerFunctions")

function love.load()
    variables()
end

function love.update(dt)
    playerFunctions.playerMovement(dt)
end

function love.draw()
    playerFunctions.drawGround()
    playerFunctions.drawPlayer()
end
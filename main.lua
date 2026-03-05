love = require("love")
variables = require("variables")
functions = require("functions")

function love.load()
    variables()
end

function love.update(dt)
    functions.playerMovement(dt)
end

function love.draw()
    functions.drawGround()
    functions.drawPlayer()
end
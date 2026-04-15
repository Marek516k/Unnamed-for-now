local enemyImage = love.graphics.newImage("sprites/Enemy.png")
local playerImage = love.graphics.newImage("sprites/Player.png")

function Variables()
    Player = {
        x = 600,
        y = 400,
        speed = 150,
        jumpforce = 6,
        gravity = 10,
        jumpAcceleration = 4,
        isJumping = false,
        image = playerImage,
        width = playerImage:getWidth(),
        height = playerImage:getHeight(),
        health = 100
    }

    Enemy = {
        x = 200,
        y = 400,
        speed = 120,
        gravity = 10,
        jumpforce = 6,
        jumpAcceleration = 4,
        isJumping = false,
        image = enemyImage,
        width = enemyImage:getWidth(),
        height = enemyImage:getHeight(),
        type = "cube"
    }

    Platforms = {
        {
            x = 0,
            y = 580,
            width = 1080,
            height = 20,
            color = {0.5, 0.5, 0.5}
        },
        {
            x = 200,
            y = 540,
            width = 200,
            height = 20,
            color = {0.5, 0.5, 0.8}
        },
        {
            x = 450,
            y = 500,
            width = 200,
            height = 30,
            color = {0.7, 0.5, 0.5}
        },
        {
            x = 600,
            y = 450,
            width = 200,
            height = 20,
            color = {0.5, 0.7, 0.5}
        }
    }
end
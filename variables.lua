function Variables()
    love.window.setMode(1080, 720, {resizable=true, vsync=true})

    player = {
        x = 520,
        y = 590,
        speed = 150,
        jumpforce = 6,
        gravity = 10,
        jumpAcceleration = 4,
        isJumping = false,
        image = love.graphics.newImage("sprites/player.png"),
        width = love.graphics.newImage("sprites/player.png"):getWidth(),
        height = love.graphics.newImage("sprites/player.png"):getHeight()
    }

    enemy = {
        x = 720,
        y = 600,
        speed = 100,
        jumpforce = 7,
        gravity = 10,
        jumpAcceleration = 4,
        isJumping = false,
        image = love.graphics.newImage("sprites/enemy.png"),
        width = love.graphics.newImage("sprites/enemy.png"):getWidth(),
        height = love.graphics.newImage("sprites/enemy.png"):getHeight()
    }

    platforms = {
        {
            x = 0,
            y = 600,
            width = 1080,
            height = 50,
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
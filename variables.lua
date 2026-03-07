function variables()
    love.window.setMode(1080, 720, {resizable=true, vsync=true})
    player = {
        x = 520,
        y = 600,
        speed = 150,
        jumpforce = 30,
        gravity = 10,
        image = love.graphics.newImage("sprites/player.png")
    }

    grounds = {
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

return variables
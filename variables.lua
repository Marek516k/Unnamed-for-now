function variables()
    love.window.setMode(1080, 720, {resizable=true, vsync=true})
    player = {
        x = 520,
        y = 600,
        speed = 200,
        jumpforce = 10,
        gravity = 10,
        image = love.graphics.newImage("sprites/player.png")
    }

    ground = {
        x = 0,
        y = 600,
        width = 1080,
        height = 50,
        color = {0.5, 0.5, 0.5}
    }
end

return variables
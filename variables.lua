
function variables()
    love.window.setMode(1080, 720, {resizable=true, vsync=true})
    player = {
        x = 100,
        y = 100,
        speed = 200,
        image = love.graphics.newImage("sprites/player.png")
    }
end

return variables
function loadSheets()
    SpriteSheet = love.graphics.newImage("sprites/sword.png")

    local frameWidth = 32
    local frameHeight = 32

    frames = {}
    for i = 0, 6 do
        frames[i+1] = love.graphics.newQuad(
            i * frameWidth, 0,
            frameWidth, frameHeight,
            SpriteSheet:getDimensions()
        )
    end

    currentFrame = 1
end

function DrawSheet()
    if attacking then
        love.graphics.draw(
            SpriteSheet,
            frames[currentFrame],
            Player.x + 32, Player.y,
            0,
            1, 1,
            16, 16
        )
    end
end

function updateSheet(dt)
    if love.mouse.isDown(1) then
        attacking = true
    end

    if attacking then
        timer = (timer or 0) + dt
        speed = 0.09

        if timer >= speed then
            timer = timer - speed
            currentFrame = currentFrame % #frames + 1
        end
    end
end
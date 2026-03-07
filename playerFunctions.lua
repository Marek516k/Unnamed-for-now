local acceleration = 0

function CheckGroundCollision()
    isOnGround = false
    for _, ground in pairs(grounds) do
        if player.y + player.image:getHeight() >= ground.y and
            player.y < ground.y + ground.height and
            player.x + player.image:getWidth() > ground.x and
            player.x < ground.x + ground.width then
            isOnGround = true
            player.y = ground.y - player.image:getHeight()
            break
        end
    end
end
function playerMovement(dt)
    CheckGroundCollision()

    if not isOnGround then
        acceleration = acceleration + player.gravity * dt
        player.y = player.y + acceleration * dt * player.speed / 4.5

    else
        acceleration = 0
    end

    if love.keyboard.isDown("w") and isOnGround then
        player.y = player.y - player.jumpforce * dt * player.speed
    end

    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end

    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function drawPlayer()
    love.graphics.draw(player.image, player.x, player.y)
end

function drawGround()
    for _, ground in pairs(grounds) do
        love.graphics.setColor(ground.color)
        love.graphics.rectangle("fill", ground.x, ground.y, ground.width, ground.height)
    end
    love.graphics.setColor(1, 1, 1)
end

return {
    playerMovement = playerMovement,
    drawPlayer = drawPlayer,
    drawGround = drawGround
}
function playerMovement(dt)
    local isOnGround = player.y + player.image:getHeight() >= ground.y
    if not isOnGround then
        player.y = player.y + player.gravity * dt * player.speed / 12

    else
        player.y = ground.y - player.image:getHeight()
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
    love.graphics.setColor(ground.color)
    love.graphics.rectangle("fill", ground.x, ground.y, ground.width, ground.height)
    love.graphics.setColor(1, 1, 1)
end

return {
    playerMovement = playerMovement,
    drawPlayer = drawPlayer,
    drawGround = drawGround
}
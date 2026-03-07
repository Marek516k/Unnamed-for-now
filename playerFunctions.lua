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
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end

    if love.keyboard.isDown("w") and isOnGround and not player.isJumping then
        acceleration = -player.jumpforce
        player.isJumping = true
    end

    if player.isJumping or not isOnGround then
        acceleration = acceleration + player.gravity * dt
        if love.keyboard.isDown("w") and player.isJumping then
            acceleration = acceleration - player.jumpAcceleration * dt
        end
        player.y = player.y + acceleration * dt * player.speed / 4.5
    end

    CheckGroundCollision()
    if isOnGround then
        acceleration = 0
        player.isJumping = false
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
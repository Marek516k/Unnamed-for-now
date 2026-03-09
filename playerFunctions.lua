local acceleration = 0
local isOnPlatform = false

function CheckGroundCollision()
    isOnPlatform = false
    for _, platform in pairs(platforms) do
        if player.y + player.height >= platform.y and
            player.y < platform.y + platform.height and
            player.x + player.width > platform.x and
            player.x < platform.x + platform.width then
            isOnPlatform = true
            player.y = platform.y - player.height
            break
        end
    end
end

function PlayerMovement(dt)
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end

    if love.keyboard.isDown("w") and isOnPlatform and not player.isJumping then
        acceleration = acceleration - player.jumpforce
        player.isJumping = true
    end

    if player.isJumping or not isOnPlatform then
        acceleration = acceleration + player.gravity * dt
        if love.keyboard.isDown("w") and player.isJumping then
            acceleration = acceleration - player.jumpAcceleration * dt
        end
        player.y = player.y + acceleration * dt * player.speed / 5
    end

    CheckGroundCollision()
    if isOnPlatform then
        acceleration = 0
        player.isJumping = false
    end

    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function DrawPlayer()
    love.graphics.draw(player.image, player.x, player.y)
end
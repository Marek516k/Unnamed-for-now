local acceleration = 0
local isOnPlatform = false

function CheckGroundCollision()
    isOnPlatform = false
    for _, platform in pairs(Platforms) do
        if Player.y + Player.height >= platform.y and
            Player.y < platform.y + platform.height and
            Player.x + Player.width > platform.x and
            Player.x < platform.x + platform.width then
            isOnPlatform = true
            Player.y = platform.y - Player.height
            break
        end
    end
end

function PlayerMovement(dt)
    if love.keyboard.isDown("a") then
        Player.x = Player.x - Player.speed * dt
    end

    if love.keyboard.isDown("d") then
        Player.x = Player.x + Player.speed * dt
    end

    if love.keyboard.isDown("w") and isOnPlatform and not Player.isJumping then
        acceleration = acceleration - Player.jumpforce
        Player.isJumping = true
    end

    if Player.isJumping or not isOnPlatform then
        acceleration = acceleration + Player.gravity * dt
        if love.keyboard.isDown("w") and Player.isJumping then
            acceleration = acceleration - Player.jumpAcceleration * dt
        end
        Player.y = Player.y + acceleration * dt * Player.speed / 5
    end

    CheckGroundCollision()
    if isOnPlatform then
        acceleration = 0
        Player.isJumping = false
    end

    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function DrawPlayer()
    love.graphics.draw(Player.image, Player.x, Player.y)
end
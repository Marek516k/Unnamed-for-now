local acceleration = 0
local isOnPlatform = false

function CheckGroundCollision()
    isOnPlatform = false
    for _, platform in pairs(Platforms) do
        if Player.y + Player.height >= platform.y and
            Player.y < platform.y + platform.height and
            Player.x + Player.width > platform.x and Player.x < platform.x + platform.width then
            isOnPlatform = true
            Player.y = platform.y - Player.height
            break
        end
    end
end

function CheckHeadCollision()
    for _, platform in pairs(Platforms) do
        if Player.y <= platform.y + platform.height and
            Player.y + Player.height > platform.y and
            Player.x + Player.width > platform.x and
            Player.x < platform.x + platform.width and acceleration < 0 then
            Player.y = platform.y + platform.height
            acceleration = 0
            Player.isJumping = false
            return true
        end
    end
    return false
end

function CheckSideCollision()
    for _, platform in pairs(Platforms) do
        -- overlaps vertically with platform 
        if Player.y + Player.height > platform.y and
            Player.y < platform.y + platform.height then

            -- left side
            if Player.x + Player.width > platform.x and
                Player.x + Player.width <= platform.x + 10 and
                Player.x < platform.x then
                Player.x = platform.x - Player.width
            end

            -- right side
            if Player.x < platform.x + platform.width and
                Player.x >= platform.x + platform.width - 10 and
                Player.x + Player.width > platform.x + platform.width then
                Player.x = platform.x + platform.width
            end
        end
    end
end

function PlayerMovement(dt)
    if love.keyboard.isDown("a") then
        if Player.x < 0 then
            Player.x = Player.x
        else
            Player.x = Player.x - Player.speed * dt
        end
    end

    if love.keyboard.isDown("d") then
        if Player.x > love.graphics.getWidth() - Player.width then
            Player.x = Player.x
        else
            Player.x = Player.x + Player.speed * dt
        end
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

    CheckSideCollision()
    CheckHeadCollision()
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
local acceleration = 0
local EisOnPlatform = false

function ECheckGroundCollision()
    EisOnPlatform = false
    for _, platform in pairs(Platforms) do
        if Enemy.y + Enemy.height >= platform.y and
            Enemy.y < platform.y + platform.height and
            Enemy.x + Enemy.width > platform.x and Enemy.x < platform.x + platform.width then
            EisOnPlatform = true
            Enemy.y = platform.y - Enemy.height
            break
        end
    end
end

function ECheckHeadCollision()
    for _, platform in pairs(Platforms) do
        if Enemy.y <= platform.y + platform.height and
            Enemy.y + Enemy.height > platform.y and
            Enemy.x + Enemy.width > platform.x and
            Enemy.x < platform.x + platform.width and acceleration < 0 then
            Enemy.y = platform.y + platform.height
            acceleration = 0
            Enemy.isJumping = false
            return true
        end
    end
    return false
end

function ECheckSideCollision()
    for _, platform in pairs(Platforms) do
        if Enemy.y + Enemy.height > platform.y and
            Enemy.y < platform.y + platform.height then

            if Enemy.x + Enemy.width > platform.x and
                Enemy.x + Enemy.width <= platform.x + 10 and
                Enemy.x < platform.x then
                Enemy.x = platform.x - Enemy.width
            end

            if Enemy.x < platform.x + platform.width and
                Enemy.x >= platform.x + platform.width - 10 and
                Enemy.x + Enemy.width > platform.x + platform.width then
                Enemy.x = platform.x + platform.width
            end
        end
    end
end

function EnemyCanJumpFromPlatform()
    if not EisOnPlatform then
        return false
    end

    local currentPlatform = nil
    for _, platform in pairs(Platforms) do
        if Enemy.y + Enemy.height >= platform.y and
            Enemy.y < platform.y + platform.height and
            Enemy.x + Enemy.width > platform.x and
            Enemy.x < platform.x + platform.width then
            currentPlatform = platform
            break
        end
    end

    if not currentPlatform then
        return false
    end

    if currentPlatform.width > 400 then
        return true
    end

    local edgeThreshold = 2
    local distanceFromLeft = Enemy.x - currentPlatform.x
    local distanceFromRight = (currentPlatform.x + currentPlatform.width) - (Enemy.x + Enemy.width)

    return distanceFromLeft < edgeThreshold or distanceFromRight < edgeThreshold
end

function EnemyMovement(dt)
    local dx = Player.x - Enemy.x
    local dy = Player.y - Enemy.y

    if dx > 10 then  -- Player is to the right
        if Enemy.x > love.graphics.getWidth() - Enemy.width then
            Enemy.x = Enemy.x
        else
            Enemy.x = Enemy.x + Enemy.speed * dt
        end
    elseif dx < -10 then  -- Player is to the left
        if Enemy.x < 0 then
            Enemy.x = Enemy.x
        else
            Enemy.x = Enemy.x - Enemy.speed * dt
        end
    end

    if dy < - 10 and EisOnPlatform and not Enemy.isJumping then
        local canJump = false
        for _, platform in pairs(Platforms) do
            if Enemy.x + Enemy.width > platform.x then
                if platform.y > Enemy.y then
                    canJump = true
                    break
                end
            end
        end

        if canJump and EnemyCanJumpFromPlatform() then
            acceleration = acceleration - Enemy.jumpforce
            Enemy.isJumping = true
        end
    end

    if Enemy.isJumping or not EisOnPlatform then
        acceleration = acceleration + Enemy.gravity * dt
        Enemy.y = Enemy.y + acceleration * dt * Enemy.speed / 5
    end

    ECheckSideCollision()
    ECheckHeadCollision()
    ECheckGroundCollision()

    if EisOnPlatform then
        acceleration = 0
        Enemy.isJumping = false
    end
end

function DrawEnemy()
    love.graphics.draw(Enemy.image, Enemy.x, Enemy.y)
end
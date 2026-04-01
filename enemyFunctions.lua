local acceleration = 0
local EisOnPlatform = false
local jumpAttemptTimer = 0
local randomMoveTimer = 0
local randomMoveDirection = 0

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

function GetCurrentEnemyPlatform()
    for _, platform in pairs(Platforms) do
        if Enemy.y + Enemy.height >= platform.y and
            Enemy.y < platform.y + platform.height and
            Enemy.x + Enemy.width > platform.x and
            Enemy.x < platform.x + platform.width then
            return platform
        end
    end
    return nil
end

function FindLowestPlatform()
    local currentPlatform = GetCurrentEnemyPlatform()
    if not currentPlatform then return nil end

    local lowestPlatform = nil
    local lowestY = currentPlatform.y

    for _, platform in pairs(Platforms) do
        if platform.y > lowestY and platform.width > 400 then
            lowestY = platform.y
            lowestPlatform = platform
        end
    end

    return lowestPlatform
end

function EnemyMovement(dt)
    local dx = Player.x - Enemy.x
    local dy = Player.y - Enemy.y

    randomMoveTimer = randomMoveTimer - dt
    if randomMoveTimer <= 0 then
        randomMoveDirection = math.random(-1, 1)
        randomMoveTimer = math.random(1, 3)
    end

    local moveDirection = 0
    local tryingToJump = false

    if dy < -10 and EisOnPlatform and not Enemy.isJumping then
        tryingToJump = true
        jumpAttemptTimer = jumpAttemptTimer + dt
        -- can't jump for 1.5 seconds, find lowest platform
        if jumpAttemptTimer > 1.5 then
            local lowestPlatform = FindLowestPlatform()
            if lowestPlatform then
                dx = lowestPlatform.x + lowestPlatform.width / 2 - (Enemy.x + Enemy.width / 2)
            end
            jumpAttemptTimer = 0
        end
    else
        jumpAttemptTimer = 0
    end

    if dx > 10 then  -- Player is to the right
        if Enemy.x > love.graphics.getWidth() - Enemy.width then
            moveDirection = 0
        else
            moveDirection = 1
        end
    elseif dx < -10 then  -- Player is to the left
        if Enemy.x < 0 then
            moveDirection = 0
        else
            moveDirection = -1
        end
    else
        moveDirection = randomMoveDirection
    end

    if moveDirection > 0 then
        Enemy.x = Enemy.x + Enemy.speed * dt
    elseif moveDirection < 0 then
        Enemy.x = Enemy.x - Enemy.speed * dt
    end

    if dy < -10 and EisOnPlatform and not Enemy.isJumping then
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
            jumpAttemptTimer = 0
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
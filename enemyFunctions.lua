local acceleration = 0
local EisOnPlatform = false

function ECheckGroundCollision()
    EisOnPlatform = false
    for _, platform in pairs(Platforms) do
        if Enemy.y + Enemy.height >= platform.y and
            Enemy.y < platform.y + platform.height and
            Enemy.x + Enemy.width > platform.x and
            Enemy.x < platform.x + platform.width then
            EisOnPlatform = true
            Enemy.y = platform.y - Enemy.height
            break
        end
    end
end

function EnemyMovement(dt)
    local dx = Player.x - Enemy.x
    local dy = Player.y - Enemy.y

    if dx > 10 then  -- Player is to the right
        Enemy.x = Enemy.x + Enemy.speed * dt
    elseif dx < -10 then  -- Player is to the left
        Enemy.x = Enemy.x - Enemy.speed * dt
    end

    if dy < - 10 and EisOnPlatform and not Enemy.isJumping then
        local canJump = false
        for _, platform in pairs(Platforms) do
            if Enemy.x + Enemy.width > platform.x and Enemy.x < platform.x + platform.width then
                if platform.y > Enemy.y then
                    canJump = true
                    break
                end
            end
        end

        if canJump then
            acceleration = acceleration - Enemy.jumpforce
            Enemy.isJumping = true
        end
    end

    if Enemy.isJumping or not EisOnPlatform then
        acceleration = acceleration + Enemy.gravity * dt
        Enemy.y = Enemy.y + acceleration * dt * Enemy.speed / 5
    end

    ECheckGroundCollision()

    if EisOnPlatform then
        acceleration = 0
        Enemy.isJumping = false
    end
end

function DrawEnemy()
    love.graphics.draw(Enemy.image, Enemy.x, Enemy.y)
end
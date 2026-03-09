local acceleration = 0
local EisOnPlatform = false

function ECheckGroundCollision()
    EisOnPlatform = false
    for _, platform in pairs(platforms) do
        if enemy.y + enemy.height >= platform.y and
            enemy.y < platform.y + platform.height and
            enemy.x + enemy.width > platform.x and
            enemy.x < platform.x + platform.width then
            EisOnPlatform = true
            enemy.y = platform.y - enemy.height
            break
        end
    end
end

function EnemyMovement(dt)
    local dx = player.x - enemy.x
    local dy = player.y - enemy.y

    if dx > 10 then  -- Player is to the right
        enemy.x = enemy.x + enemy.speed * dt
    elseif dx < -10 then  -- Player is to the left
        enemy.x = enemy.x - enemy.speed * dt
    end

    if dy < 0 and EisOnPlatform and not enemy.isJumping then
        local canJump = false
        for _, platform in pairs(platforms) do
            if enemy.x + enemy.width > platform.x and enemy.x < platform.x + platform.width then
                if platform.y > enemy.y then
                    canJump = true
                    break
                end
            end
        end

        if canJump then
            acceleration = acceleration - enemy.jumpforce
            enemy.isJumping = true
        end
    end

    if enemy.isJumping or not EisOnPlatform then
        acceleration = acceleration + enemy.gravity * dt
        enemy.y = enemy.y + acceleration * dt * enemy.speed / 5
    end

    ECheckGroundCollision()
    if EisOnPlatform then
        acceleration = 0
        enemy.isJumping = false
    end
end

function DrawEnemy()
    love.graphics.draw(enemy.image, enemy.x, enemy.y)
end
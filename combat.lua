local Heart_image = love.graphics.newImage("sprites/Heart.png")
local hitTimer = 0

function Takedmg(enemyType)
    if enemyType == "cube" then
        Player.health = Player.health - 10
    elseif enemyType == "slime" then
        Player.health = Player.health - 200
    end
end

function DisplayHP(currentHP)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 20, 20, currentHP * 2, 20)
    love.graphics.setColor(0.50, 0.11, 0.80)
    love.graphics.rectangle("line", 21, 21, 200, 20)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(currentHP, 50, 23.5)
    love.graphics.draw(Heart_image, 20, 20)
end

function EnemyAttack(Ex,Ey,enemyType)
    local dx = Player.x - Ex
    local dy = Player.y - Ey

    hitTimer = hitTimer + love.timer.getDelta()
    local canHit = hitTimer > 1
    if canHit then
        if enemyType == "cube" then
            if math.abs(dx) < 50 and math.abs(dy) < 50 then
                Takedmg(enemyType)
            end
        elseif enemyType == "slime" then
            if math.abs(dx) < 100 and math.abs(dy) < 100 then
                Takedmg(enemyType)
            end
        end
        hitTimer = 0
    end
end
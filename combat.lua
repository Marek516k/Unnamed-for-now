local Config = require("config")

local Combat = {}

local hitTimer = 0

function Combat.enemyAttack(enemy, player)
    local dx = player.x - enemy.x
    local dy = player.y - enemy.y

    hitTimer = hitTimer + love.timer.getDelta()

    if hitTimer > Config.combat.hit_cooldown then
        local attackRange = Config.combat.enemy_attack_range[enemy.enemy_type] or 50

        if math.abs(dx) < attackRange and math.abs(dy) < attackRange then
            local damage = Config.combat.damage_by_type[enemy.enemy_type] or 10
            player:takeDamage(damage)
        end

        hitTimer = 0
    end
end

function Combat.reset()
    hitTimer = 0
end

return Combat
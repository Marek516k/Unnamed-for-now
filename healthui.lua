local Config = require("config")

local HealthUI = {}

local heartImage = nil

function HealthUI.init()
    heartImage = love.graphics.newImage("sprites/Heart.png")
end

function HealthUI.drawHealthBar(x, y, currentHealth, maxHealth)
    local maxWidth = Config.ui.health_bar_max_width
    local healthPercent = math.max(0, currentHealth / maxHealth)
    local barWidth = healthPercent * maxWidth

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "fill",
        x,
        y,
        barWidth,
        Config.ui.health_bar_height
    )

    love.graphics.setColor(0.50, 0.11, 0.80)
    love.graphics.rectangle(
        "line",
        x + 1,
        y + 1,
        maxWidth,
        Config.ui.health_bar_height
    )

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(currentHealth, x + 30, y + 2)

    if heartImage then
        love.graphics.draw(heartImage, x, y)
    end
end

return HealthUI
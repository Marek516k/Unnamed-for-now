local Config = require("config")

local PlatformManager = {}

function PlatformManager.create()
    return {
        {
            x = 0,
            y = 580,
            width = 1080,
            height = 20,
            color = {0.5, 0.5, 0.5}
        },
        {
            x = 200,
            y = 470,
            width = 200,
            height = 20,
            color = {0.5, 0.5, 0.8}
        },
        {
            x = 450,
            y = 450,
            width = 200,
            height = 20,
            color = {0.7, 0.5, 0.5}
        },
        {
            x = 650,
            y = 450,
            width = 200,
            height = 20,
            color = {0.5, 0.7, 0.5}
        }
    }
end

function PlatformManager.draw(platforms)
    for _, platform in ipairs(platforms) do
        love.graphics.setColor(platform.color)
        love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
    end
    love.graphics.setColor(1, 1, 1)
end

return PlatformManager
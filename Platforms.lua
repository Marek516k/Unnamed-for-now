function DrawPlatforms()
    for _, platform in pairs(Platforms) do
        love.graphics.setColor(platform.color)
        love.graphics.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
    end
    love.graphics.setColor(1, 1, 1)
end
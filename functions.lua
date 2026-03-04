function playerMovement(dt)
    local speed = player.speed

    -- basic input handler for movement and other stuff
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        player.y = player.y - speed * dt
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        player.y = player.y + speed * dt
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        player.x = player.x - speed * dt
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        player.x = player.x + speed * dt
    end
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function drawPlayer()
    love.graphics.draw(player.image, player.x, player.y)
end

return {
    playerMovement = playerMovement,
    drawPlayer = drawPlayer
}
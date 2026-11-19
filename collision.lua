local Collision = {}

-- Check if two rectangles overlap
function Collision.isRectangleColliding(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2
end

function Collision.checkGroundCollision(entity, platforms)
    for _, platform in ipairs(platforms) do
        if Collision.isRectangleColliding(
            entity.x, entity.y + entity.height,
            entity.width, 0,
            platform.x, platform.y,
            platform.width, platform.height
        ) then
            entity.y = platform.y - entity.height
            return true
        end
    end
    return false
end

function Collision.checkHeadCollision(entity, platforms, verticalVelocity)
    if verticalVelocity >= 0 then return false end

    for _, platform in ipairs(platforms) do
        if Collision.isRectangleColliding(
            entity.x, entity.y,
            entity.width, 0,
            platform.x, platform.y + platform.height,
            platform.width, 0
        ) then
            entity.y = platform.y + platform.height
            return true
        end
    end
    return false
end

function Collision.checkSideCollision(entity, platforms)
    for _, platform in ipairs(platforms) do
        -- Overlaps vertically with platform
        if entity.y + entity.height > platform.y and
            entity.y < platform.y + platform.height then

            -- Left side
            if entity.x + entity.width > platform.x and
                entity.x + entity.width <= platform.x + 10 and
                entity.x < platform.x then
                entity.x = platform.x - entity.width
            end

            -- Right side
            if entity.x < platform.x + platform.width and
                entity.x >= platform.x + platform.width - 10 and
                entity.x + entity.width > platform.x + platform.width then
                entity.x = platform.x + platform.width
            end
        end
    end
end

-- Get the platform that is being stood on by the entity
function Collision.getCurrentPlatform(entity, platforms)
    for _, platform in ipairs(platforms) do
        if Collision.isRectangleColliding(
            entity.x, entity.y + entity.height,
            entity.width, 0,
            platform.x, platform.y,
            platform.width, platform.height
        ) then
            return platform
        end
    end
    return nil
end

return Collision
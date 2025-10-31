local wave, super = Class(Wave)

function wave:spawnAimingVine(self, player_x, player_y, delay, remove)

    local peenor = Utils.random(1,4,1)

    local x, y = 0, 0

    if peenor == 1 then
        -- Right
        x = SCREEN_WIDTH + 200
        y = Utils.random(0, SCREEN_HEIGHT - 100)
    elseif peenor == 2 then
        -- Down
        x = Utils.random(-100, SCREEN_WIDTH)
        y = SCREEN_HEIGHT + 200
    elseif peenor == 3 then
        -- Left
        x = -200
        y = Utils.random(0, SCREEN_HEIGHT - 100)
    elseif peenor == 4 then
        -- Up
        x = Utils.random(-100, SCREEN_WIDTH)
        y = -200
    end

    -- Get the angle between the bullet position and the soul's position
    local angle = Utils.angle(x, y, player_x, player_y)

    -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)

    local friction = Utils.random(30, 40)/9
    local flip = Utils.random() > 0.5

    local afterimage = self:spawnBullet("rosy/vine_afterimage", x, y, angle, 50, friction, flip)
    self.timer:after(delay, function()
        Assets.playSound("happy_HYEAAA", 0.3, 1.0)
        Game.battle.camera:shake(1, 1, 0.1)
        local vine = self:spawnBullet("rosy/vine", x, y, angle, 50, friction, flip)
        if remove == true then
            self.timer:after(0.5, function()
                self.timer:tween(1, vine, {alpha = 0}, nil, function()
                    vine:remove()
                end)
            end)
        end
    end)
end

return wave
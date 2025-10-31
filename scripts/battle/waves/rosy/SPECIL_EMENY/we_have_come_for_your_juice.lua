local Basic, super = Class(Wave)

function Basic:onStart()
    self.time = 10

    local function mini_rosy()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("rosy/minirosy", x, y, math.rad(180), 4)
        Assets.playSound("rosy_WOW", 0.1, 0.9 + Utils.random(0, 0.2))

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end

    self.timer:every(1, function()
        self.timer:script(function(wait)
            mini_rosy()
            wait(0.1)
            mini_rosy()
            wait(0.1)
            mini_rosy()
        end)
    end)

end

function Basic:update()
    -- Code here gets called every frame


    super.update(self)
end

return Basic
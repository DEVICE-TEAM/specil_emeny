local wave, super = Class(Wave)

-- Credit to skarph from the Kristal Discord Server.
-- https://discord.com/channels/899153719248191538/900166836958666752/1280619398876627006

function wave:onStart()
    
    self.timer:every(0.5, function()

        local x = MathUtils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = MathUtils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

        self:freakSplosion(x, y)

    end)

end

function wave:freakSplosion(x, y)

    local function freakSplosionRing(amount, size)
        for i = 1, amount do
            x = math.sin(2 * math.pi * i/amount) * size + x
            y = math.cos(2 * math.pi *  i/amount) * size + y
            
            self:spawnBullet("memoryhead/freak_bullet", x - size, y + size/2, nil, 0.6)
        end
    end

    self:spawnBullet("memoryhead/freak_bullet", x, y, nil, 0.4)
    freakSplosionRing(6, 10)

end

return wave
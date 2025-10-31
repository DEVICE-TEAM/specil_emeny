local wave, super = Class(Wave)


function wave:onStart()

    self.timer:every(0.1, function()

        local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

        self:spawnBullet("memoryhead/freak_bullet", x, y, nil, 0.6)
    end)

end

return wave
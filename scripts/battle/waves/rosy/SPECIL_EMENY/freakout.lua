local wave, super = Class(Wave)


function wave:onStart()

    self.time = 12

    self.timer:every(0.2, function()

        local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

        self:spawnBullet("rosy/freak_bullet", x, y, nil, 0.6)
    end)


    self.timer:every(1.8, function()

        local player_x = Game.battle.soul.x
        local player_y = Game.battle.soul.y

        Assets.playSound("happy_WAAHHH", 0.5, 1)
        wave:spawnAimingVine(self, player_x, player_y, 0.5)
    end)

end

return wave
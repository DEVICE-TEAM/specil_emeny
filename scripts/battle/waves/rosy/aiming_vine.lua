local wave, super = Class(Wave)


function wave:onStart()

    self.timer:every(0.6, function()

        local player_x = Game.battle.soul.x
        local player_y = Game.battle.soul.y

        Assets.playSound("happy_WAAHHH", 0.5, 1)
        wave:spawnAimingVine(self, player_x, player_y, 0.5)
    end)

end

return wave
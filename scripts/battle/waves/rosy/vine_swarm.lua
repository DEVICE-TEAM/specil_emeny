local wave, super = Class(Wave)

function wave:onStart()

    Assets.playSound("happy_WAAHHH", 0.7, 0.65)
    self.timer:every(0.05, function()

        local player_x = Game.battle.soul.x
        local player_y = Game.battle.soul.y

        wave:spawnAimingVine(self, player_x, player_y, 0.7)
    end, 15)

    self.timer:after(1.0, function()
        Game.battle.camera:shake(5, 5, 0.1)
    end)

end

return wave
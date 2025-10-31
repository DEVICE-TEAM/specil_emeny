local wave, super = Class(Wave)

function wave:onStart()

    Game.battle.arena:addChild(
        Warning(
            Game.battle.arena.width/2,
            Game.battle.arena.height/2,
            Game.battle.arena.width - 8,
            Game.battle.arena.width - 8,
            0.25
        )
    )

    local vine_y = 230
    local vine_x = 380

    self.timer:after(0.3, function()
        self.timer:every(0.08, function()
            Assets.playSound("happy_HYEAAA", 0.3, 1.0)

            local flip = Utils.random() > 0.5

            self:spawnBullet("rosy/vine", SCREEN_WIDTH + 200, vine_y, math.rad(180), 50, math.random(25, 30)/10, flip)
            
            vine_y = vine_y - 25
        end, 5)
    end)


end

function wave:update()
    -- Code here gets called every frame

    super.update(self)
end

return wave
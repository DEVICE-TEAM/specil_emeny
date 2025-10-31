local wave, super = Class(Wave)

function wave:onStart()
 
    Assets.playSound("amalgam_noise", 0.7, 0.6)
   
    self.timer:tween(1, Game.battle.arena, {width = SCREEN_WIDTH}, "in-out-quad")
    self.timer:every(0.05, function()

        local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

        self:spawnBullet("memoryhead/freak_bullet", x, y, nil, 0.8)
    end)

    self.timer:tween(5, Game.battle.arena, {height = 20}, "in-out-quad")

end

return wave
local wave, super = Class(Wave)


function wave:onStart()

    Assets.playSound("amalgam_noise", 0.7, 0.8)

    local raise_factor = 0

    local wiffle_bat = self:spawnBullet("memoryhead/lost_girl/whiffle_bat", SCREEN_WIDTH/2, 20)
    wiffle_bat.alpha = 0
    wiffle_bat.scale_x = 2.5

    Game.battle.timer:tween(0.7, wiffle_bat, {scale_x = 2, alpha = 1}, "in-out-quad")

    self.timer:every(0.4, function()

        local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = Utils.random(Game.battle.arena:getTop() + 10, (Game.battle.arena:getBottom() - 10) + raise_factor)

        self:spawnBullet("memoryhead/freak_bullet", x, y)
    end)

    self.timer:after(1, function()

        Game.battle.timer:tween(0.7, wiffle_bat, {y = Game.battle.arena:getBottom() - 30, rotation = 0}, "in-bounce")
        raise_factor = -40
    end)

    self.timer:after(1.4, function()

        Game.battle:shakeCamera(10, 10)
        Assets.playSound("impact", 0.7)
    end)
end

return wave
local wave, super = Class(Wave)


function wave:onStart()
    self.time = 8

    Assets.playSound("amalgam_noise", 0.4, 0.8)

    local cognitohazard = self:spawnBullet("memoryhead/cognitohazard", Game.battle.arena:getCenter())
    cognitohazard.alpha = 0
    cognitohazard.scale_x = 2.5

    local freak_juice = self:spawnBullet("memoryhead/freak_juice")

    self.timer:tween(1, Game.battle.arena, {width = 300, height = 300}, "in-out-quad")

    Game.battle.timer:tween(1.0, cognitohazard, {scale_x = 2, alpha = 1}, "in-out-quad", function()

        self.timer:every(0.1, function()

            local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
            local y = Utils.random(Game.battle.arena:getTop() + 10, (Game.battle.arena:getBottom() - 10) - freak_juice.growth)

            self:spawnBullet("memoryhead/freak_bullet", x, y)
        end)

        self.timer:every(1/10, function()
            self:spawnBullet(
                "memoryhead/cognito_bubble",
                Utils.random(freak_juice.x + freak_juice.scale_x/2, freak_juice.x - freak_juice.scale_x/2),
                Utils.random(freak_juice.y, freak_juice.y - freak_juice.scale_y/3)
            )
        end)
    end)

    self.timer:every(1.5, function()
        self:getFreaky(freak_juice, cognitohazard)
    end)
end

function wave:getFreaky(freak_juice, cognitohazard)
    cognitohazard:shake()
    Game.battle:shakeCamera(4, 4)
    Assets.playSound("amalgam_noise", 0.6, 0.8 - (freak_juice.growth / 400))
    Game.battle.timer:tween(0.5, freak_juice, {growth = freak_juice.growth + 40}, "out-cubic")
    Game.battle.timer:tween(0.5, cognitohazard, {scale_x = 2.25, scale_y = 2.25}, "out-cubic", function()
        Game.battle.timer:tween(1, cognitohazard, {scale_x = 2, scale_y = 2}, "out-cubic")
    end)

end

return wave
local wave, super = Class(Wave)

function wave:onStart()

    self.time = 12
    local i_forgor = self:spawnBullet("rosy/i_forgor")

    self.rosy = Game.battle:getActiveEnemies()[1]
    
    self.rosy:shake()

    self.rosy:setSprite("confused")

    self.memoryhead_a = Game.battle:addChild(Character("memoryhead", self.rosy.x, self.rosy.y - 60))
    self.memoryhead_a.alpha = 0
    self.memoryhead_b = Game.battle:addChild(Character("memoryhead", self.rosy.x, self.rosy.y + 100))
    self.memoryhead_b.alpha = 0

    self.timer:script(function(wait)
        wait(6)
        self:memHeadFadeIn(self.memoryhead_a)
        self:memHeadFadeIn(self.memoryhead_b)

        Assets.playSound("amalgam_noise", 0.6, 0.7)

        wait(0.5)

        i_forgor:explode()
        self.rosy:shake()
        self.rosy:setAnimation("idle")

        self.timer:every(0.15, function()

            local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
            local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

            self:spawnBullet("memoryhead/freak_bullet", x, y, nil, 0.6)
        end)

        self.timer:every(1, function()

            local player_x = Game.battle.soul.x
            local player_y = Game.battle.soul.y

            Assets.playSound("happy_WAAHHH", 0.5, 1)
            wave:spawnAimingVine(self, player_x, player_y, 0.5)
        end)
    end)
    
end

function wave:update()
    -- Code here gets called every frame

    super.update(self)
end

function wave:onEnd(death)
    self:memHeadFadeOut(self.memoryhead_a)
    self:memHeadFadeOut(self.memoryhead_b)

    self.rosy:shake()
    self.rosy:setAnimation("idle")
end

function wave:memHeadFadeIn(input)
    Game.battle.timer:tween(1, input, {alpha = 1})
end

function wave:memHeadFadeOut(input)
    Game.battle.timer:tween(1, input, {alpha = 0}, nil, function()
        input:remove()
    end)
end

return wave
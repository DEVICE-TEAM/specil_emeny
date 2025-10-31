local wave, super = Class(Wave)

function wave:onStart()

    self.rosy = Game.battle:getActiveEnemies()[1]

    self.rosy:setSprite("crocs")

    self.rosy:flash()
    self.rosy:shake()
    Assets.playSound("boost")
    
    self.timer:after(0.5, function()
        Assets.playSound("jump")
        self.rosy:setSprite("crocs_jump")
        self.timer:tween(0.2, self.rosy, {y = self.rosy.y - 400}, "in-out-quad")
    end)
    self.timer:tween(0.2, Game.battle.arena, {width = SCREEN_WIDTH}, "in-out-quad", function()
        Game.battle.arena:addChild(
            Warning(
                Game.battle.arena.width/2 - 50,
                Game.battle.arena.height/2,
                550,
                Game.battle.arena.height - 8,
                0.5
            )
        )
    end)

    self.timer:after(1.75, function()
        self:spawnBullet("rosy/the_shoe", 0, -20)
    end)
    self.timer:after(2.0, function()
        self:spawnBullet("rosy/the_shoe", 150, -20)
    end)
    self.timer:after(2.25, function()
        self:spawnBullet("rosy/the_shoe", 300, -20)
    end)
    self.timer:after(2.5, function()
        self:spawnBullet("rosy/the_shoe", 450, -20)
    end)

end

function wave:onEnd(death)
    Game.battle.timer:tween(1, self.rosy, {y = self.rosy.y + 400}, "in-out-quad", function()
        self.rosy:setSprite("crocs")
        Game.battle.timer:after(0.5, function()
            self.rosy:shake(10)
            self.rosy:setAnimation("idle")
        end)
    end)
end

function wave:update()
    -- Code here gets called every frame

    super.update(self)
end

return wave
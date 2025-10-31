local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/rosy/mini_rosy_1")
    self.sprite:setAnimation({{"bullets/rosy/mini_rosy_1", "bullets/rosy/mini_rosy_2"}, 1/2, true})

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self:setHitbox(5,5,10,10)

    self.damage = 55
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    local twitch = Utils.random()

    if twitch > 0.8 then
        self.x = self.x + Utils.random(-1, 1)
        self.y = self.y + Utils.random(-1, 1)
    end

    if self.x < 100 and self.bungo == nil then
        self.remove_offscreen = true
        self.bungo = true
        if Utils.random(1, 5, 1) > 2 then
            self.physics.speed = 0
            self.flippedamundo = true
            self.physics.direction = self.physics.direction + math.rad(180)
            Game.battle.timer:tween(0.5, self, {scale_x = -2}, "in-out-bounce", function()
                self.physics.speed = 6
            end)
        end
    else
        if self.flippedamundo ~= true then
            self.physics.speed = (2 + (Utils.dist(Game.battle.soul.x, Game.battle.soul.y, self.x, self.y)/20))
        end
    end

    super.update(self)
end

return SmallBullet
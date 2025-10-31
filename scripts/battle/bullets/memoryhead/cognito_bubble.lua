local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/bubble")
    self.alpha = 0
    self:setScale(0.5, 0.5)

    self.damage = 55

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = math.rad(270 + Utils.random(0, 10))
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self:setHitbox(2,2,1,1)
    self.physics.speed = 1
    self.physics.friction = -0.05
    self:setLayer(self.layer - 5)
    -- Assets.playSound("bubble_pop", 0.2, 1.0)
    self.can_graze = false
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if self.alpha == 0 then
        local pengu = Utils.random(1.0)
        Game.battle.timer:tween(1.5, self, {alpha = 1, scale_x = 1.25 + pengu, scale_y = 1.25 + pengu}, "in-out-cubic")
    end

    super.update(self)
end

return SmallBullet
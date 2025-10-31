local bullet, super = Class(Bullet)

function bullet:init(x, y, dir, speed, friction, flip)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/rosy/long_vine")

    if flip then
        self.sprite.flip_y = true
    end

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir

    self.rotation = dir + math.pi
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.physics.friction = friction
    self.origin_x = 0.5
    self.origin_y = 0.5
    self:setHitbox(32,10,400,2)
    self.destroy_on_hit = false
    self.alpha = 0.5

    Game.battle.timer:tween(1, self, {alpha = 0})

    self.damage = 0
    self.can_graze = false

end

return bullet
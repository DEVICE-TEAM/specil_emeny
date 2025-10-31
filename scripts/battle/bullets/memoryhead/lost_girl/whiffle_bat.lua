local bullet, super = Class(Bullet)

function bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/memoryhead/lost_girl/whiffle_bat")

    self.destroy_on_hit = false
    self.damage = 55
    self.can_graze = false
    self.collider = ColliderGroup(self, {
        Hitbox(self, 10, 20, 30, 20),
        Hitbox(self, 40, 10, 20, 20),
        Hitbox(self, 60, 20, 100, 20),
    })

    self.rotation = math.rad(-40)
    
    self.layer = self.layer + 10
end

function bullet:update()
    super.update(self)

end

function bullet:draw()
    super.draw(self)

end

return bullet
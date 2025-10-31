local bullet, super = Class(Bullet)

function bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/rosy/its_you_its_me/me")

    self.destroy_on_hit = false
    self.damage = 55
    
    self.layer = self.layer + 10

end

function bullet:update()

    super.update(self)
end

function bullet:draw()
    super.draw(self)

end

return bullet
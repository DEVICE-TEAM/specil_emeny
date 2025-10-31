local bullet, super = Class(Bullet)

function bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/memoryhead/cognitohazard")

    self:setOrigin(0.5, 0.5)

    self.destroy_on_hit = false
    self.damage = 0
    self.can_graze = false

    self.layer = self.layer + 10
end

function bullet:update()

    if self.alpha == 1 and self.damage == 0 then
        self.damage = 55
        self.can_graze = true
    end

    local twitch = Utils.random()

    if twitch > 0.8 then
        self.x = self.x + Utils.random(-1, 1)
        self.y = self.y + Utils.random(-1, 1)
    end
    super.update(self)
end

return bullet
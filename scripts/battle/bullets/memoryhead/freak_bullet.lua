local bullet, super = Class(Bullet)

function bullet:init(x, y, img, telegraph)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/memoryhead/freak_bullet_1")

    if telegraph == nil then
        telegraph = 0
    end

    local basically_randomness = MathUtils.random(0, 0.2)
    self.alpha = 0
    Game.battle.timer:tween(telegraph + basically_randomness, self, {alpha = 1})

    Game.battle.timer:after(telegraph + basically_randomness, function()
        self.sprite:setSprite("bullets/memoryhead/freak_bullet")
        self.sprite:play(1/20, false, function()
            self:remove()
        end)
    end)

    self.destroy_on_hit = false
    self.damage = 0
    self.can_graze = false

    self:setScale(1, 1)
    self.layer = self.layer - 5
end

function bullet:update()
    super.update(self)
    if self.sprite.frame == 7 then
        self.damage = 55
        self.can_graze = true
    elseif self.sprite.frame == 8 then
        self.damage = 0
        self.can_graze = false
    end
end

function bullet:draw()
    super.draw(self)

end

return bullet
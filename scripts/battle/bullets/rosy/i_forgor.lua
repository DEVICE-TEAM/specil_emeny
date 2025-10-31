local bullet, super = Class(Bullet)

function bullet:init(x, y, dir, speed, friction, flip)
    -- Last argument = sprite path
    super.init(self, SCREEN_WIDTH/2, Game.battle.arena:getTop() + 30, "bullets/i_forgor_1")

    self.sprite:setAnimation({{"bullets/i_forgor_1", "bullets/i_forgor_2"}, 1/2, true})

    self:setOrigin(0.5)
    self:setScale(1)

    self.layer = BATTLE_LAYERS["below_soul"]

    self.alpha = 0.5

    self.destroy_on_hit = false
    self.damage = 0
    self.can_graze = false

end

function bullet:update()
    super.update(self)
end

function bullet:draw()
    super.draw(self)

end

return bullet
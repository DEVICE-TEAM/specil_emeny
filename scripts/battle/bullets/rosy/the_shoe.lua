local bullet, super = Class(Bullet)

function bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/rosy/the_shoe")

    self.destroy_on_hit = false
    self.damage = 110
    
    self.layer = self.layer + 10

    self:setOrigin(0.5, 1)
    
    self:setHitbox(5,289,100,20)

    Game.battle.timer:tween(0.75, self, {y = Game.battle.arena:getBottom()}, "in-bounce")
    Game.battle.timer:after(0.4, function()
        Assets.playSound("impact", 1, 0.75)
        Game.battle:shakeCamera(10, 10, 0.25)
    end)

end

function bullet:update()

    super.update(self)
end

function bullet:draw()
    super.draw(self)

end

return bullet
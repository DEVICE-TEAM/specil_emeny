local SmallBullet, super = Class(Bullet)

function SmallBullet:init()
    -- Last argument = sprite path
    super.init(self, SCREEN_WIDTH/2, Game.battle.arena.bottom, "pixel")
    self.growth = 0
    self:setOrigin(0.5, 1)
    self:setHitbox(0,0,1,1)
    self.sprite.color = {0, 0, 0, 1}
    self:setScale(Game.battle.arena.width, self.growth)
    self:setLayer(self.layer + 20)

    self.damage = 55

    local outlinefx = StaticOutlineFX({1, 1, 1, 1})
    self:addFX(outlinefx)

    self.destroy_on_hit = false
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    self:setScale(Game.battle.arena.width, self.growth)

    self.y = Game.battle.arena:getBottom()

    super.update(self)
end

return SmallBullet
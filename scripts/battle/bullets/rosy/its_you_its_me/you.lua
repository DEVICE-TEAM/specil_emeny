local bullet, super = Class(Bullet)

function bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/rosy/its_you_its_me/you")

    self.destroy_on_hit = false
    self.damage = 0
    self.can_graze = false
    
    self.layer = self.layer + 10

    self:setOrigin(0.5, 1)
    self:setHitbox(25,350,20,40)

end

function bullet:onCollide(soul)
    if Game.battle.reunited ~= true then
        Assets.playSound("kristal_intro", 0.7)
        Game.battle.soul.alpha = 0
        Game.battle.reunited = true

        Game.battle.timer:script(function(wait)
            local fader = Fader()
            fader.color = COLORS.white
            fader:setLayer(BATTLE_LAYERS["top"])
            Game.battle:addChild(fader)
            fader:fadeOut({speed = 2})

            wait(2)
            Game.battle.timer:after(0.5, function()
                
                fader:fadeIn({speed = 1})
            end)
            Game.battle:setState("DEFENDINGEND", "WAVEENDED")
        end)
    end
end

function bullet:update()

    super.update(self)
end

function bullet:draw()
    super.draw(self)

end

return bullet
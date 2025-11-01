local actor, super = Class(Actor, "memoryhead")

function actor:init()
    super.init(self)

    self.name = "Memoryhead"

    self.width = 28
    self.height = 29

    self.path = "enemies/memoryhead"

    self.default = "idle"

    self.voice = "memoryhead"

    self.animations = {
        ["idle"] = {"idle", 1/3, true}
    }

end

function actor:fadeOut(callback)

    Game.battle.timer:tween(1, self, {alpha = 0}, nil, function()
        self:removeFX("funky_mode")
        if callback then
            callback()
        end
    end)
end

function actor:fadeIn()
    Game.battle.timer:tween(1, self, {alpha = 1})
end


function actor:onSpriteUpdate(sprite)
    sprite.img_timer = (sprite.img_timer or 0) + DTMULT
    sprite.y = sprite.y + math.sin(Kristal.getTime() * 3 + 1) * 0.25
    sprite.x = sprite.x + math.sin(Kristal.getTime() * 1.5 + 1) * 0.25
end

return actor
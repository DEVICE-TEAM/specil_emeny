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

    local wave_shader = love.graphics.newShader([[
        extern number wave_sine;
        extern number wave_mag;
        extern number wave_height;
        extern vec2 texsize;
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
            number i = texture_coords.y * texsize.y;
            vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
            return Texel(texture, coords) * color;
        }
    ]])

    Game.battle.timer:tween(1, self, {alpha = 0}, nil, function()
        self:removeFX("funky_mode")
        if callback then
            callback()
        end
    end)
    self:addFX(ShaderFX(wave_shader, {
        ["wave_sine"] = function () return Kristal.getTime() * 100 end,
        ["wave_mag"] = 5,
        ["wave_height"] = 5,
        ["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
    }), "funky_mode")
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
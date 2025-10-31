local wave, super = Class(Wave)


function wave:onStart()

    self.time = 12

    self.rosy = Game.battle:getActiveEnemies()[1]
    
    self.rosy:shake()

    self.rosy:setSprite("confused")

    self.memoryhead_a = Game.battle:addChild(Character("memoryhead", self.rosy.x, self.rosy.y - 60))
    self.memoryhead_a.alpha = 0
    self.memoryhead_b = Game.battle:addChild(Character("memoryhead", self.rosy.x, self.rosy.y + 100))
    self.memoryhead_b.alpha = 0
    
    self.no_L = Game.battle:addChild(Sprite("beckon", self.rosy.x - 100, self.rosy.y - 20, nil, nil, "npcs/weird_noelle/battle"))
    self.no_L.alpha = 0
    self.no_L:setOrigin(0.5)
    self.no_L:setScale(2, 2)
    self.no_L:setLayer(9999)

    self:memHeadFadeIn(self.memoryhead_a)
    self:memHeadFadeIn(self.memoryhead_b)
    self:memHeadFadeIn(self.no_L)

    Assets.playSound("amalgam_noise")

    self.timer:every(2.2, function()

        local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

        self:spawnBullet("memoryhead/lost_girl/iceshock", x, y, nil, 0.6)

        Assets.playSound("damage")
        self.no_L:shake(6)
        self.no_L:setSprite("crush")
        self.timer:after(0.5, function() self.no_L:setSprite("beckon") end)

        local thank_you = SpeechBubble("[voice:noelle][shake:0.7]Thank you...[wait:4][next]", 47, 17)
        thank_you:setRight(true)
        thank_you:setScale(0.5, 0.5)
        self.no_L:addChild(thank_you)
    end)

    self.timer:every(0.4, function()

        local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
        local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

        self:spawnBullet("memoryhead/freak_bullet", x, y, nil, 0.6)
    end)

    self.timer:every(1.8, function()

        local player_x = Game.battle.soul.x
        local player_y = Game.battle.soul.y

        Assets.playSound("happy_WAAHHH", 0.5, 1)
        wave:spawnAimingVine(self, player_x, player_y, 0.5)
    end)

end

function wave:onEnd(death)
    --self.memoryhead_a.actor:fadeOut()
    --self.memoryhead_b.actor:fadeOut()
    self:memHeadFadeOut(self.memoryhead_a)
    self:memHeadFadeOut(self.memoryhead_b)

    self:noLTakesL()
    
    self.rosy:shake()
    self.rosy:setAnimation("idle")
end

function wave:noLTakesL()
    Assets.playSound("deathnoise")
    local percent = DamageNumber("damage", 55, self.no_L.x, self.no_L.y, {1, 0, 0})
    percent.layer = WORLD_LAYERS["below_ui"]
    Game.battle:addChild(percent)

    self.no_L.visible = false

    local death_x, death_y = self.no_L:getRelativePos(0, 0, self)
    local death = FatalEffect(self.no_L:getTexture(), death_x, death_y, function() self.no_L:remove() end)
    death:setColor(self.no_L:getDrawColor())
    death:setScale(self.no_L:getScale())
    Game.battle:addChild(death)
end

function wave:memHeadFadeIn(input)
    Game.battle.timer:tween(1, input, {alpha = 1})
end

function wave:memHeadFadeOut(input)
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

    Game.battle.timer:tween(1, input, {alpha = 0}, nil, function()
        input:remove()
    end)
    input:addFX(ShaderFX(wave_shader, {
        ["wave_sine"] = function () return Kristal.getTime() * 100 end,
        ["wave_mag"] = 5,
        ["wave_height"] = 5,
        ["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
    }), "funky_mode")
end

return wave
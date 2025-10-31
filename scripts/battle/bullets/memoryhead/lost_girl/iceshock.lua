local bullet, super = Class(Bullet)

function bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y)

    self.destroy_on_hit = false
    self.can_graze = false

    self.damage = 99

    local function createParticle(x_particle, y_particle)
        local sprite = Sprite("effects/icespell/snowflake", x_particle, y_particle)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(1.5)
        sprite.layer = BATTLE_LAYERS["bullets"] + 2
        Game.battle:addChild(sprite)
        return sprite
    end

    local particles = {}
    Game.battle.timer:script(function(wait)
        wait(1/30)
        Assets.playSound("icespell", 0.7)
        particles[1] = createParticle(x-25, y-20)
        wait(3/30)
        particles[2] = createParticle(x+25, y-20)
        wait(3/30)
        particles[3] = createParticle(x, y+20)
        wait(3/30)
        Game.battle:addChild(IceSpellBurst(x, y))
        for _,particle in ipairs(particles) do
            for i = 0, 5 do
                local effect = IceSpellEffect(particle.x, particle.y)
                effect:setScale(0.75)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = BATTLE_LAYERS["bullets"] + 1
                Game.battle:addChild(effect)
            end
        end
        wait(1/30)
        for _,particle in ipairs(particles) do
            particle:remove()
        end
        wait(4/25)

        self.collider = ColliderGroup(self, {
            Hitbox(self, -10, -10, 20, 20),
        })
        -- local damage = self:getDamage(user, target)
        -- target:hurt(damage, user, function() target:freeze() end)
        -- 
        -- Game.battle:finishActionBy(user)
        
        wait(4/30)
        self:remove()
    end)
end


return bullet
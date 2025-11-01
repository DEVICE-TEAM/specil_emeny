---@diagnostic disable: inject-field
local Rosy, super = Class(EnemyBattler)

function Rosy:init()
    super.init(self)

    self:setActor("rosy")

    self.name = "Rosy"

    self.max_health = 55
    self.health = 55
    self.attack = 0
    self.defense = 0

    self.money = 0

    self.exit_on_defeat = false

    self.disable_mercy = true
    self.spare_points = 0

    self.check = {
        "AT 0 DF 0\n* It is known."
    }

    self:registerAct("X-Slash", "Requires\ncalm\nheart", nil)
    self:registerAct("Breathe", "Relieve\ntension", nil)

    --self:removeAct("Check")
    --self:removeAct("X-Slash")
    --self:registerAct("", "", nil, nil, nil, {"party/ralsei/icon/head"})
end

function Rosy:onHurt(damage, battler)

    Game.battle.rosy_hit = true

    local function hurt(animation, sound, shake)
        self:setAnimation(animation)
        self:getActiveSprite():shake(shake, 0, 0.5, 2/30)
        Assets.playSound(sound)
    end

    if damage > 1 or self.health <= 35 then
        hurt("hurt_real", "rosy_oh", 5)
    else
        hurt("hurt", "rosy_OOWWWW", 10)
    end

    if self.health <= 0 and Game.battle.encounter.current_phase == 1 then
        Game.battle.music:stop()
    end
end

function Rosy:onHurtEnd()
    if self.health ~= 0 and Game.battle.encounter.current_phase == 1 or Game.battle.encounter.current_phase > 1 then
        self:getActiveSprite():resetSprite()
    end
end

function Rosy:getAttackDamage(damage, battler, points)
    local dealt_damage = 0
    if Game.battle.rosy_gone ~= true then
        if points == 150 then
            if self.health <= 49 then
                dealt_damage = 55
            else
                dealt_damage = 55
            end
        elseif points > 50 then
            if self.health <= 49 then
                dealt_damage = 55
            else
                dealt_damage = 55
            end
        else
            dealt_damage = 0
        end

        if Game.battle.reunited == true then
            dealt_damage = dealt_damage * 2
        end
    end
    return dealt_damage
end

function Rosy:fakeSlash(battler, flipped)
    -- Literally just copy-pasted from Kristal Source.
    local attacksprite = battler.chara:getWeapon():getAttackSprite(battler, self, 150) or battler.chara:getAttackSprite()
    local dmg_sprite = Sprite(attacksprite or "effects/attack/cut")
    dmg_sprite:setOrigin(0.5, 0.5)
    dmg_sprite:setScale(2.5, 2.5)
    local relative_pos_x, relative_pos_y = self:getRelativePos(self.width/2, self.height/2)
    dmg_sprite:setPosition(relative_pos_x + self.dmg_sprite_offset[1], relative_pos_y + self.dmg_sprite_offset[2])
    dmg_sprite.layer = self.layer + 0.01
    table.insert(self.dmg_sprites, dmg_sprite)
    local dmg_anim_speed = 1/15
    if attacksprite == "effects/attack/shard" then
        -- Ugly hardcoding BlackShard animation speed accuracy for now
        dmg_anim_speed = 1/10
    end
    if flipped then
        dmg_sprite.flip_x = true
        dmg_sprite.x = dmg_sprite.x - dmg_sprite.width/2
    end
    dmg_sprite:play(dmg_anim_speed, false, function(s) s:remove(); TableUtils.removeValue(self.dmg_sprites, dmg_sprite) end) -- Remove itself and Remove the dmg_sprite from the enemy's dmg_sprite table when its removed
    self.parent:addChild(dmg_sprite)
end

function Rosy:getAttackTension(points)
    return 0
end

function Rosy:onAct(battler, name)
    local act = self.getAct(self, name)

    if name == "X-Slash" then
        if Game.battle.rosy_gone ~= true then
            if Game.tension >= 10 then
                return {
                    "* Kris was too stressed\nto use X-Slash.",
                    "* (You must have less than 10% tension.)"
                }
            else
                Game.battle.timer:script(function (wait)
                    battler:setSprite("battle/attack", 1/15, false)
                    battler:flash()

                    local dealt_damage
                    if self.health <= 49 then
                        dealt_damage = 5
                    else
                        dealt_damage = 2
                    end
        
                    Assets.playSound("scytheburst")
                    self:hurt(dealt_damage, battler)
                    self:fakeSlash(battler)

                    wait(0.5)

                    battler:setSprite("battle/attack", 1/15, false)
                    battler:flash()

                    Assets.playSound("scytheburst")
                    self:hurt(dealt_damage, battler)
                    self:fakeSlash(battler, true)
                end)
                Game:setTension(Game:getTension() + 25)
                return "* Kris used X-Slash![wait:4]\n* Tension raised by 25%."
            end
        else
            return {
                "* Rosy is not in range for X-Slash."
            }
        end

    elseif name == "Breathe" then

    ---@diagnostic disable-next-line: param-type-mismatch
    Game.battle:startActCutscene(function(c, battler, e)
        Game:setTension(Game:getTension() - 30)
        c:text("* You took a deep breath.[wait:4]\n* Tension reduced by 30%.")
    end)
    elseif name == "" then

        if Utils.contains(act["icons"][1], "ralsei") then
            act["icons"] = {"party/susie/icon/head"}

            ---@diagnostic disable-next-line: param-type-mismatch
            Game.battle:startActCutscene(function(c, battler, e)
                e.dialogue_override = ""

                e:setSprite("battle/idle_1")
                c:text("* Kris called for help...")
                c:text("* ... but nobody came.")
                
                c:battlerText(e, "whO???")
                e:setAnimation("idle")
            end)
        elseif Utils.contains(act["icons"][1], "susie") then
            ---@diagnostic disable-next-line: param-type-mismatch
            Game.battle:startActCutscene(function(c, battler, e)
                e.dialogue_override = ""

                e:setSprite("battle/idle_1")
                c:text("* Kris called for help...")

                c:text("* ... but nobody came.")

                c:battlerText(e, "biG pUrPlE aIn'T\nsAvIn' yA!")
                e:setAnimation("idle")
                ---Game.inventory:tryGiveItem("good_egg")
            end)
            act["icons"] = {"ui/icons/old_man"}
        elseif Utils.contains(act["icons"][1], "old_man") then
            ---@diagnostic disable-next-line: param-type-mismatch
            Game.battle:startActCutscene(function(c, battler, e)
                e.dialogue_override = ""

                e:setSprite("battle/idle_1")
                c:text("* Kris called for help...")

                c:text("* ... but nobody came.")

                e.scale_x = 4
                c:battlerText(e, "bRO")
                e.scale_x = 2
                c:battlerText(e, "dIS iS jUS\ngEtTiN' sAD")
                c:battlerText(e, "lEaVE grAnDpA's\naShEs ouTtA diS!1!")
                e:setAnimation("idle")
            end)

            act["icons"] = {"party/noelle/icon/head"}

        elseif Utils.contains(act["icons"][1], "noelle") then
            ---@diagnostic disable-next-line: param-type-mismatch
            Game.battle:startActCutscene(function(c, battler, e)
                e.dialogue_override = ""
                ---Game.inventory:removeItem("good_egg")
                e:setSprite("battle/hurt_real")
                c:text("* You whispered Noelle's name...")

                e:setSprite("battle/idle_1")
                c:text("* ... but nobody came.")

                e.scale_x = 4
                c:battlerText(e, "UR JSUT", {auto = true})

                e.scale_x = 1.5
                c:battlerText(e, "I JuST wANNA", {auto = true})

                e.scale_x = 2
                e.flip_y = true
                c:battlerText(e, "GRRRR", {auto = true})

                e.scale_x = 4
                e.flip_y = false
                c:battlerText(e, "UR JSUT", {auto = true})

                e.scale_x = 3
                c:battlerText(e, "AAAAAAGH")

                e.scale_x = 2
                e:shake(3, nil, 0)
                c:battlerText(e, "U MAEk mE sO,[wait:3] SO,[wait:3]\nmAED, KRIS!")

                e:stopShake()

                c:battlerText(e, "yOU tInK pUtTin' dA\nrING oN SomE\nrICH gIRl...")
                c:battlerText(e, "iS goNnA lEt\nyOu kIlL mE????")
                c:battlerText(e, "tInk aGaIn, buSTERR!!!1!")
                e:setAnimation("idle")
            end)

            act["icons"] = {"ui/icons/knight"}

        elseif Utils.contains(act["icons"][1], "knight") then
            Game.battle.music:stop()
            Game.battle:startActCutscene("rosy_battle", "finale")
        end

    end

    return super.onAct(self, battler, name)
end

return Rosy
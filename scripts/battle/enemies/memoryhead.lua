local Memoryhead, super = Class(EnemyBattler)

function Memoryhead:init()
    super.init(self)

    self:setActor("memoryhead")

    self.name = "     "

    self.max_health = 100
    self.health = 100
    self.attack = 9
    self.defense = 999

    self.money = 0

    self.exit_on_defeat = false

    self.disable_mercy = true
    self.spare_points = 0

    self.t_siner = 0

    self.dialogue = {
        "[voice:none][sound:mem_head_radio] [image:effects/mem_head_waveform] "
    }

    self:registerAct("ITEM")
    self:registerAct("STAT")
    self:registerAct("CELL")

end


function Memoryhead:onAct(battler, name)
    local act = self.getAct(self, name)

    if name == "Check" then
        return "* No data available."
    elseif name == "ITEM" then
        if self.used_up == true then
            return "* It was used up."
        else
            local result = Game.inventory:tryGiveItem("bad_memory")
            if result == true then
                self.used_up = true
                return "* The enemy put a piece of itself in your inventory."
            else
                return "* But your inventory was full."
            end
        end
    elseif name == "STAT" then
        return "* AT - " + (battler.chara.stats.attack + 10) + " DF - " + (battler.chara.stats.defense + 10) + " MG - " + (battler.chara.stats.magic + 10)
    elseif name == "CELL" then
        ---@diagnostic disable-next-line: param-type-mismatch
        Game.battle:startActCutscene(function(c, battler, e)            
            Assets.playSound("phone", 0.7)

            c:text("* You take out your CELL PHONE.[wait:4]\n* You can hear voices through the receiver...!")
            c:battlerText(e, TableUtils.pick({
                "[voice:toriel]You were always a\ndissappointment\nto me.",
                "[voice:asgore]It was your fault.",
                "[voice:noelle]You hurt me,[wait:4] Kris."
            }))

            local tension_amount = #Game.battle.enemies * 25
            Game:setTension(Game:getTension() + tension_amount)

            c:text("* Your heart felt heavy...[wait:8]\n* You gained "+ tension_amount +"% tension.[wait:4]\n* New ACTs opened up.")

            for _,enemy in ipairs(Game.battle.enemies) do
                enemy:removeAct("ITEM")
                enemy:removeAct("STAT")
                enemy:removeAct("CELL")
                enemy:registerAct("Join")
                enemy:registerAct("Pray", "Relieve\ntension")
                enemy:registerAct("Forget", "Requires\ncalm\nheart")
                enemy.dialogue = {
                    "Come join the fun.",
                    "It's a real get together",
                    "Lorem ipsum docet",
                    "Become one of us!"
                }
            end
        end)

    elseif name == "Join" then

        self.dialogue_override = TableUtils.pick(
            {
                "Then, hold still.",
                "Just a moment.",
                "You'll be with us shortly.",
            }
        )

        return "* You just couldn't do it anymore."

    elseif name == "Pray" then

        ---@diagnostic disable-next-line: param-type-mismatch
        Game.battle:startActCutscene(function(c, battler, e)

            local pray_text = TableUtils.pick(
                {
                    "* You remember a pleasant melody.",
                    "* You remember Q.C's Hot Chocolate.",
                    "* You remember your friends.",
                }
            )

            Game:setTension(Game:getTension() - 20)
            c:text("* You prayed to the      ...\n[wait:8]" + pray_text)

            self.dialogue_override = TableUtils.pick(
                {
                    "The ANGEL is coming.",
                    "There, there.",
                    "There was a prophecy."
                }
            )
        end)
    
    elseif name == "Forget" then
        ---@diagnostic disable-next-line: param-type-mismatch
        Game.battle:startActCutscene(function(c, battler, e)
            if Game.tension < 5 then
                for _,enemy in ipairs(Game.battle.enemies) do
                    ---@diagnostic disable-next-line: undefined-field
                    enemy:fadeOut(function()
                        for _,enemy in ipairs(Game.battle.enemies) do
                            Game.battle:removeEnemy(enemy, true)
                        end
                    end)
                end
                if Game.tension < 1 then
                    Kristal.callEvent("completeAchievement", "tranquil_heart")
                end
                Game.battle.trippy_background:remove()
                Game.battle.music:stop()
                c:text("* [noskip]What enemy?[wait:20]")
            else
                c:text("* But you couldn't forget.")
                c:text("* (You must have less than 5% tension.)")
            end

        end)
    end

    return super.onAct(self, battler, name)
end

function Memoryhead:fadeOut(callback)

    Game.battle.timer:tween(1, self:getActiveSprite(), {alpha = 0}, nil, function()
        self:getActiveSprite():removeFX("funky_mode")
        if callback then
            callback()
        end
    end)
end

function Memoryhead:fadeIn()
    Game.battle.timer:tween(1, self:getActiveSprite(), {alpha = 1})
end

function Memoryhead:update()
    super.update(self)

    if (Game.battle.state == "MENUSELECT") and (Game.tension < 5) then
        self.t_siner = self.t_siner + (1 * DTMULT)
        for _,menu_item in ipairs(Game.battle.menu_items) do
            if menu_item.name == "Forget" then
                menu_item.color =
                    function()
                        return (Utils.mergeColor(COLORS.yellow, COLORS.white, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
                    end
            end
        end
    end
end

return Memoryhead
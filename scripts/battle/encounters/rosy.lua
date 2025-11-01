local RosyBattle, super = Class(PhaseEncounter)

function RosyBattle:init()
    super.init(self)

    self.text = "* [color:red]SPECIL EMENY[color:reset][shake:0] aPpRoAcES!1!"

    self.music = "mus_rt_SPECIL_EMENY"

    self.background = false
    self.fear_tp = true

    self.rosy = self:addEnemy("rosy")

    Game:setTension(55)

    self:phaseDataInit()
    self:backgroundInit()

    -- Game.battle.your_taking_too_long = 0

    self.rosy:setSprite("battle/hurt_real")
    self.rosy.alpha = 0

end

function RosyBattle:backgroundInit()
    Game.battle.back_background = Sprite("effects/blank_background")
    Game.battle.back_background:setLayer(BATTLE_LAYERS["bottom"])
    Game.battle.back_background:setScale(10, 10)
    Game.battle:addChild(Game.battle.back_background)

    Game.battle.trippy_background = Sprite("effects/background", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    Game.battle.trippy_background:setLayer(BATTLE_LAYERS["bottom"])
    Game.battle.trippy_background:setOrigin(0.5)
    Game.battle.trippy_background.alpha = 0
    Game.battle:addChild(Game.battle.trippy_background)
    Game.battle.trippy_background_part_2 = Sprite("effects/background", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    Game.battle.trippy_background_part_2:setLayer(BATTLE_LAYERS["bottom"])
    Game.battle.trippy_background_part_2:setOrigin(0.5)
    Game.battle.trippy_background_part_2.alpha = 0
    Game.battle:addChild(Game.battle.trippy_background_part_2)
end

function RosyBattle:phaseDataInit()

    local rosy = self.rosy

    -- Phase 1
    self:addPhase({

        {   -- Turn 1
            wave = "rosy/SPECIL_EMENY/intro",
            dialogue = function(c)

                if Game.battle.rosy_hit == true then
                    rosy:setSprite("battle/idle_1")
                    c:battlerText(rosy, "iZ bEeN a[wait:8] lOnG,\n[wait:4]lONG,[wait:4] tIem")

                    rosy.scale_x = 2.5
                    rosy:shake()
                    c:battlerText(rosy, "kiRSSY kRIS")

                    rosy.scale_x = 3.5
                    rosy:shake(2, 0, 0)
                    c:battlerText(rosy, "KIRSKKSKK")

                    rosy.scale_x = 2
                else
                    Game.battle.rosy_not_hit_on_turn_one = true
                    rosy:setSprite("battle/hurt_real")
                    c:battlerText(rosy, "[voice:rosy_pre]hey,[wait:5] idiot.[wait:10]\nyou missed.")
                end

                rosy:shake()
                rosy:setAnimation("idle")
            end,

            -- Up Next
            text = "* You are [color:red]AFRAID[color:reset] of the EMENY...[wait:8]\n* When TP reaches MAX, you are damaged!"

        },

        {   -- Turn 2
            wave = "rosy/aiming_vine",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                if Game.battle.rosy_not_hit_on_turn_one ~= true then
                    c:battlerText(rosy, "ooOOOOOHOHOHO")
                    c:battlerText(rosy, "dONT tRY aN\nfOGET!!1")

                    rosy:shake()
                    rosy:setSprite("wink")
                    c:battlerText(rosy, "dEY mAED a wHOLE\nSONG aBoUT DAT!")

                    rosy:shake()
                    rosy:setSprite("battle/idle_1")
                    c:battlerText(rosy, "wE gO wAAyyyy\nbACK.")
                    c:battlerText(rosy, "isN'T iT bEtTeR\ntO oWN uP tO\nyOuR pAST???")

                    rosy:shake()
                    rosy:setSprite("battle/eyes_closed")
                    c:battlerText(rosy, "unLESS...")

                    rosy:shake()
                    rosy:setSprite("battle/hurt_real")
                    c:battlerText(rosy, "[voice:rosy_pre]...there's something\nyou'd rather hide?")

                else
                    rosy:shake(0.5, 0, 0)
                    c:battlerText(rosy, "yOU coUDnT hIT\na rOSy oN dA\nbRoAdSiDe o' dA\nbARNN")

                    rosy:setSprite("default")
                    rosy:shake()
                    c:battlerText(rosy, "dAT[wait:10]\niS eMbArRaSsIn")

                end

                rosy:shake()
                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* The Rosylings are hungry."

        },

        {   -- Turn 3
            wave = "rosy/SPECIL_EMENY/we_have_come_for_your_juice",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "sO mANEY pROBLUMS...")
                c:battlerText(rosy, "aL iN oNE THREe\naPpLE hIGH XtERIOR...")

                rosy:shake()
                rosy:setSprite("default")

                c:battlerText(rosy, "hoW dO DEY DO IT?????")
                rosy:shake(0.5, 0, 0)
                c:battlerText(rosy, "i gOTtA gO tO dA iDiOT\nbAbY fACtRY aN sEEE\nhoW yOuy WeRE mADEE")

                rosy:shake()
                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* The Rosylings are even more hungry."

        },

        {   -- Turn 4
            wave = "rosy/SPECIL_EMENY/we_have_come_for_your_snacks",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "aN wAT dO yOU\nhAvE tO fEeL\nsOrRy fOR,[wait:4] hUH???")
                c:battlerText(rosy, "a fAMlY dAT...[wait:4]\nloVeZ U???")
                c:battlerText(rosy, "fRiEnDz...[wait:4]\ndAt aLwAyZ hAV\nuR bAcK????")

                rosy:shake()
                rosy:setSprite("battle/poor_widdue_kris")
                rosy:shake(0.5, 0, 0)
                c:battlerText(rosy, "ooOOOOOOOooo...\n[wait:8]poowE wiDDuE kWIsss...")
                rosy:shake(1, 0, 0)
                c:battlerText(rosy, "ooOOOOOOOooo...\n[wait:8]fiSH ouTTa wAAtEErrr\nsTroYYYY...")
                rosy:shake(2, 0, 0)
                c:battlerText(rosy, "\"i dON'T fIT iN\ncAuSE iM HOOOmAAn...\"")

                rosy:shake(4, 0)
                rosy:setSprite("battle/gimme_a_break")
                c:battlerText(rosy, "giMME.[wait:4]\na.[wait:4]\nBREAK.")

                rosy:shake()
                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]we were ALL\nunwanted at one point,\n[wait:4]half-wit.")
                c:battlerText(rosy, "[voice:rosy_pre]that's what an\norphan is.")

                rosy:shake()
                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* Did someone turn on the AC?"

        },

        {   -- Turn 5
            wave = "rosy/SPECIL_EMENY/memhead_assist_1",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "aN yOU haV\ndA [wait:8][speed:0.7]COJONES")
                c:battlerText(rosy, "dA aBsOLuT[wait:8]\n[speed:0.7]CHUTZPAH")
                c:battlerText(rosy, "tO fEEl sORRy\nfoR uRsElF???")
                c:battlerText(rosy, "wAT aBoOt dA\npEePlE YOU hURt??")

                rosy:shake()
                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]or...[wait:10]\nthe people you\nLET get hurt...?")

                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* She was used up."

        },

        {   -- Turn 6
            wave = "rosy/SPECIL_EMENY/freakout",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "woAAAHh!1!")
                c:battlerText(rosy, "wHO wAs dOSe\nguYz???")
                c:battlerText(rosy, "eH.[wait:10]\nwHaTeVaH...")
                c:battlerText(rosy, "...hmMMMMm")
                c:battlerText(rosy, "gAVe mE\naN iDEAr...")

                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* Rosy forgot which attack came next."

        },

        {   -- Turn 7
            wave = "rosy/SPECIL_EMENY/i_forgor",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "...")
                c:battlerText(rosy, "wAT wErE wE\ntalKiN bOUt??")

                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* Rosy is preparing a powerful attack."

        },

        {   -- Turn 8
            wave = "rosy/SPECIL_EMENY/the_shoe",
            dialogue = function(c)

                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "o\nRIGHT")
                c:battlerText(rosy, "dA tRoOf iS:")
                c:battlerText(rosy, "dErE iS nO[wait:5]\n\"rIgHT aND rON\"")
                c:battlerText(rosy, "dErE iS nO[wait:5]\n\"HAPPY eNdInG\"!1!")
                c:battlerText(rosy, "anD dErE is\nsiR tAnly nO[wait:5]\n\"fReEdUmB\"")

                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* The Rosylings are unionizing."

        },

        {   -- Turn 9
            wave = "rosy/SPECIL_EMENY/we_have_come_for_your_snacks",
            dialogue = function(c)
                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "yOu dOn'T haV\nwAt iT tAkEz!1!")
                c:battlerText(rosy, "yOU CAN't hAnDlE\ndA tRoOf!!")
                c:battlerText(rosy, "alWaYz bEeN dAt wAY!\nsIncE yOU wErE 3!!1!")

                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* Rosy is looking frustrated."

        },

        {   -- Turn 10
            wave = "rosy/vine_swarm",
            dialogue = function(c)
                rosy:setSprite("battle/hurt_real")

                c:battlerText(rosy, "[voice:rosy_pre]that's why...")
                c:battlerText(rosy, "[voice:rosy_pre]...")

                rosy:shake()
                rosy:setSprite("happy")
                c:battlerText(rosy, "[voice:rosy_pre]i don't understand.")
                c:battlerText(rosy, "[voice:rosy_pre]i CAN'T understand!")
                
                rosy:shake()
                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]why i wasn't\ngood enough...?")
                
                rosy:shake()
                rosy:setSprite("happy")
                c:battlerText(rosy, "[voice:rosy_pre]i did...\nEVERYTHING...")
                
                rosy:shake()
                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]and yet...")
                rosy:shake(2, 0, 0)
                c:battlerText(rosy, "[voice:rosy_pre]YOU!")

                Game.battle.timer:after(4, function()
                    rosy:shake()
                    rosy:setAnimation("idle")
                end)
            end,

            -- Up next.
            text = "* The Rosylings are starving."

        },

        {   -- Turn 11
            wave = "rosy/SPECIL_EMENY/we_have_come_for_your_snacks",
            dialogue = function(c)
                
                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "wHo wOUdA tHouGHt!?\n[wait:10]iTtY bItTy kRisp...")
                
                rosy:shake()
                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]would be...")
                c:battlerText(rosy, "[voice:rosy_pre][speed:0.7]THE ONE.")
                rosy:shake()
                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* The Rosylings are breaking down the door."

        },

        {   -- Turn 12
            wave = "rosy/SPECIL_EMENY/freak_swarm",
            dialogue = function(c)

                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]and yet...")
                c:battlerText(rosy, "[voice:rosy_pre]you aren't even\ngrateful.")
                c:battlerText(rosy, "[voice:rosy_pre]being[wait:10] \"the hero\"")
                c:battlerText(rosy, "[voice:rosy_pre]...the [wait:10]\"main\ncharacter\"")
                c:battlerText(rosy, "[voice:rosy_pre]you act almost\nas if it's some\nkind of...[wait:10] BURDEN?")

                rosy:shake()
                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* Rosy is buying up all the shoes."

        },

        {   -- Turn 12
            wave = "rosy/SPECIL_EMENY/shoe_tunnel",
            dialogue = function(c)
                
                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "...")
                c:battlerText(rosy, "y'kNoW wAt???")
                c:battlerText(rosy, "if iT IS a\nbURdEn...")
                c:battlerText(rosy, "dEn mAyBE i\ncAn hElP!1!")

                rosy:setAnimation("idle")
            end,

            -- Up next.
            text = "* Rosy is pulling out all the stops!"

        },

        {   -- Turn 12
            wave = "rosy/SPECIL_EMENY/break",
            dialogue = function(c)
                
                rosy:setSprite("battle/idle_1")

                c:battlerText(rosy, "jUS giMmE a\nmInuTE!")
                
                Assets.playSound("slidewhist")
                Game.battle.timer:tween(1, rosy, {x = rosy.x + 250}, "in-out-quad")
                c:wait(1)
                Game.battle.rosy_gone = true


            end,

            -- Up next.
            text = "* Something terrible is coming...!"

        },

        {   -- Turn 13
            wave = "rosy/SPECIL_EMENY/its_you_its_me",
            dialogue = function(c)

                Assets.playSound("slidewhist")
                Game.battle.timer:tween(1, rosy, {x = rosy.x - 250}, "in-out-quad")
                c:wait(1)

                Game.battle.rosy_gone = false
            
                rosy:shake()
                rosy:setSprite("battle/hurt_real")
                c:battlerText(rosy, "[voice:rosy_pre]the SOUL.")
                c:battlerText(rosy, "[voice:rosy_pre]if it burdens\nyou so...")
                c:battlerText(rosy, "[voice:HAPPY]GIVE IT TO ME!")
                rosy:shake()
                rosy:setAnimation("idle")
            end,

        },

    })

    self:randomWavesForPhase({
        "rosy/SPECIL_EMENY/shoe_tunnel",
        "rosy/SPECIL_EMENY/freak_swarm"
    })
    self:randomDialogueForPhase({
        "rOSy dA rOsE!!1!",
        "jUSt ROSY",
        "EAT.",
        "HAPPY HAPPY",
        "oOOOOoo yEAh,[wait:4] baBy![wait:4]\ndAt'S wAt wE'Re\ntAlKIn' aBouT!",
    })
    self:randomTextForPhase({
        "* You feel something crawling on your back...[wait:10]\n* Oh,[wait:4] it's just Rosy.",
        "* yOU pRoBaBly sHUDN't B rEaDinG dIS...[wait:4]\n* bCUZ yOU aRe sTUpID aNd cAn'T rEAD.",
        "* It's Rosy Time!"
    })

    -- Phase 1.5
    self:addPhase({{ wave = "rosy/SPECIL_EMENY/intro", text = "* It never ends." }})
    self:randomDialogueForPhase({
        "oOOOOoo yEAh,[wait:4] baBy![wait:4]\ndAt'S wAt wE'Re\ntAlKIn' aBouT!",
        "HAPPY HAPPY",
        "ATTAC mE lIeK\noNe oF yOuR\ndEeR gURlZ",
        "rOSy dA rOsE!!1!",
        "jUSt ROSY",
        "EAT.",
        "FRESH FROM THE JUICE.[wait:4]\nFRESH FROM THE JUICE.[wait:4]\nFRESH FROM THE JUICE.",
        "hE'S lAuGhIn' aT uS,[wait:4]\nyOU knOW??"
    })
    self:randomWavesForPhase({
        "rosy/vine_swarm"
    })
    self:randomTextForPhase({
        "* You feel hopeless.",
        "* Rosy's HP bottomed out,[wait:4] but she looks no worse for wear.",
        "* ROSY coursing through your veins.",
        "* Doomed to death of ROSY!",
        "* Something in the distance is circling in for the kill."
    })

    -- Phase 2
    -- self:addPhase({{ wave = "rosy/SPECIL_EMENY/intro", text = "* Felt like a turning point." }})
    -- self:randomDialogueForPhase({
    --     "FRESH FROM THE JUICE.[wait:4]\nFRESH FROM THE JUICE.[wait:4]\nFRESH FROM THE JUICE.",
    --     "EAT.",
    --     "fuNNi JOAK",
    --     "wHIppIn' oUT dA\nbIGgUNZ!!1!",
    --     "i Am nOw\nrOSY pHAsE 2",
    --     "gOiN' hOg wIld!1!",
    --     "gET OFF MY LAWN!!!!!"
    -- })
    -- self:randomWavesForPhase({
    --     "rosy/vine_swarm"
    -- })
    -- self:randomTextForPhase({
    --     "Placeholder"
    -- })
end

function RosyBattle:onBattleEnd()
    Game.battle.timer:tween(1, Game.battle.back_background, {alpha = 0})
    Game.world.timer:after(1, function()
        Game.world:startCutscene("nightmare.END")
    end)

    -- Achievements.
    if Game.battle.got_hit ~= true then
        Kristal.callEvent("completeAchievement", "no_hit")
    end
    if Game.battle.wimp ~= true then
        Kristal.callEvent("completeAchievement", "no_items")
    end
end


function RosyBattle:update()

    local rosy = self.rosy

    -- Background animation
    if Game.battle.music:isPlaying() then
        if Game.battle.music:tell() > 9 and Game.battle.trippy_background.alpha == 0 then
            Game.battle.timer:tween(4, Game.battle.trippy_background, {alpha = 0.3}, "in-out-cubic")
            Game.battle.timer:tween(4, Game.battle.trippy_background_part_2, {alpha = 0.1}, "in-out-cubic")

        end
    end
    Game.battle.trippy_background:setScale(1.05 + (math.sin(Kristal.getTime()) / 25))
    Game.battle.trippy_background:setScale(1.05 + (math.sin(Kristal.getTime()) / 40))

    -- YOUR TAKING TOO LONG!
    -- (Removed for time. Wanted unique VA and for it to work a bit better. Will be re-added eventually.)
    -- if Game.battle:getState() == "ACTIONSELECT" and
    --    self.current_phase_turn == 1 and
    --    self.current_phase == 1 then
    --     Game.battle.your_taking_too_long = Game.battle.your_taking_too_long + 1
    --     
    --     if Game.battle.your_taking_too_long == 400 then
    --         rosy:setSprite("default")
    --         rosy:shake()
    --     elseif Game.battle.your_taking_too_long == 600 then
    --         rosy:shake(0.5,0,0)
    --     elseif Game.battle.your_taking_too_long == 700 then
    --         rosy:shake(1,0,0)
    --     elseif Game.battle.your_taking_too_long == 800 then
    --         Game.battle:startCutscene("rosy_battle", "YOUR_TAKING_TOO_LONG")
    --     end
    -- end

    super.update(self)
end

function RosyBattle:beforeStateChange(old, new)
    if new == "INTRO" and Game.battle.intro_happened ~= true then
        Game.battle:startCutscene("rosy_battle", "intro")
    elseif new == "ACTIONSDONE" then
        if Game.battle:getActiveEnemies()[1] then
            if Game.battle:getActiveEnemies()[1].health == 0 and self.current_phase == 1 then
                Game.battle:startCutscene("rosy_battle", "phase_1_5")
            end
        end
    elseif new == "BATTLETEXT" then
        if Game.battle.substate == "ITEM" then
            Game.battle.wimp = true
        end
    end
end

-- https://www.youtube.com/watch?v=AA-6FVKGk7M
-- function RosyBattle:comeUpHereSusie()
-- 
--     Game.battle.timer:after(1, function()
-- 
--         local susie = Game.battle:addChild(Character("susie", 259, 259))
-- 
--         local ralsei = Game.battle:addChild(Character("ralsei", 420, 259))
-- 
--         Game.battle.timer:after(2, function()
--             Game.battle:convertToPartyBattler(susie)
--             Game.battle:convertToPartyBattler(ralsei)
-- 
--             Assets.playSound("impact", 0.7)
--             Assets.playSound("weaponpull_fast", 0.8)
-- 
--         end)
--     end)
-- end

return RosyBattle
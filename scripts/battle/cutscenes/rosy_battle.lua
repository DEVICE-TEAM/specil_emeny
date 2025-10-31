return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param c BattleCutscene
    intro = function(c, battler, enemy)
        local rosy = c:getCharacter("rosy")
        local kris = c:getCharacter("kris")

        local wind = Music()
        wind:play("mus_ut_wind")
        c:wait(3)
        if Game:getFlag("rosy_quick") ~= true then
            Game.battle.timer:tween(2, rosy, {alpha = 1})
            c:wait(3)
            c:battlerText(rosy, "[voice:none][speed:0.5]...")
            c:battlerText(rosy, "[voice:none][speed:0.5]but you won't.")
            c:battlerText(rosy, "[voice:none][speed:0.5]you'll never.")
            c:battlerText(rosy, "[voice:none][speed:0.5]that's why...")
            wind:remove()

            rosy:shake()
            rosy:setSprite("look_left")
            c:battlerText(rosy, "i'LL juST hAvE tO\nplAy wItH YOU!1!")
        else
            Game.battle.timer:tween(1, rosy, {alpha = 1})
            c:wait(1)
            wind:remove()
        end

        Assets.playSound("rosy_LETS_PLAY_TOGETHER")
        rosy:shake(4, 0, 0.5)
        c:wait(0.75)
        rosy:shake(5, 0, 0.3)
        c:wait(0.75)
        rosy:shake(6, 0, 0.25)
        c:wait(1.5)

        Game.battle.intro_happened = true
        rosy:shake(4, 0, 0.5)
        rosy:setAnimation("idle")

    end,

    ---@param c BattleCutscene
    phase_1_5 = function(c, battler, enemy)
        local rosy = c:getCharacter("rosy")
        local kris = c:getCharacter("kris")

        c:text("* ...")
        c:battlerText(rosy, "...")
        rosy.sprite:resetSprite()
        c:battlerText(rosy, "i AM nOW roSY\npHAsE 1.51!1!")

        Game.battle.music:play("mus_rt_cavity")
        Game.battle.encounter:setPhase(2)
        rosy:removeAct("Check")
        rosy:removeAct("X-Slash")
        rosy:removeAct("Breathe")
        rosy:registerAct("", "", nil, nil, nil, {"party/ralsei/icon/head"})

    end,

    ---@param c BattleCutscene
    YOUR_TAKING_TOO_LONG = function(c, battler, enemy)
        local rosy = c:getCharacter("rosy")

        local too_long = Assets.playSound("rosy_YOUR_TAKING_TOO_LONG")
        local pengu = DialogueText("[style:none][color:red][voice:none][noskip][instant]YOUR[stopinstant][wait:20] [instant]TAKING[stopinstant][wait:15] [instant]TOO[stopinstant][wait:6] [instant]LONG![stopinstant][wait:20]", rosy.x, rosy.y - 100, 200, 100, {auto = true, align = "center"})
        pengu.origin_x = 0.5


        Game.battle:addChild(pengu)

        c:wait(function() return too_long:isPlaying() ~= true end)

        pengu:remove()

        Kristal.callEvent("completeAchievement", "YOUR_TAKING_TOO_LONG")

        rosy:shake()
        rosy:setAnimation("idle")

        Game.battle.timer:after(0.1, function()
            Game.battle:setState("DEFENDINGBEGIN")
        end)
        c:endCutscene()
    end,

    ---@param c BattleCutscene
    egg = function(c, battler, enemy)
        local rosy = c:getCharacter("rosy")
        local kris = c:getCharacter("kris")

        c:wait(3)

        c:battlerText(rosy, "...")
        rosy.sprite:resetSprite()
        c:battlerText(rosy, "ROSY PHASE 2.0")

        Game.battle.music:play("mus_rt_SPECIL_EMENY")
        Game.battle.encounter:setPhase(3)
        rosy:removeAct("")

    end,

    ---@param c BattleCutscene
    finale = function(c, battler, enemy)
        local rosy = c:getCharacter("rosy")
        local kris = c:getCharacter("kris")

        Game.battle.toggle_hurt_animation = true

        rosy:setSprite("battle/hurt_5")
        c:text("* Kris called for help...")

        c:wait(1)
        rosy:shake()
        Assets.playSound("wing")
        c:wait(0.5)
        rosy:shake()
        Assets.playSound("wing")
        c:wait(0.25)
        rosy:shake()
        Assets.playSound("wing")
        rosy:setSprite("battle/hurt_real")

        c:wait(1.0)

        c:battlerText(rosy, "...")

        Game.battle.music:play("mus_rt_cavity")

        rosy:setSprite("battle/idle_1")
        c:battlerText(rosy, "dATs IT!")

        local rosy_trap = Sprite("effects/rosy_trap", kris.x, kris.y + 400)
        rosy_trap:setLayer(BATTLE_LAYERS["below_battlers"])
        rosy_trap:setOrigin(0.5)
        rosy_trap:setScale(2)
        Game.battle:addChild(rosy_trap)

        Game.battle.timer:tween(0.6, rosy_trap, {y = rosy_trap.y - 400}, "in-out-cubic")
        Assets.playSound("happy_WAAHHH", 0.5, 0.7)
        c:wait(0.3)

        local penguhealth = math.floor(Game.party[1]:getHealth()/10)
        kris:hurt(penguhealth, true)

        Game.battle.timer:tween(0.6, kris, {y = kris.y - 40}, "in-out-cubic")
        kris:setSprite("rosy_trapped", 0.001, true)
        c:wait(0.25)
        kris:hurt(penguhealth, true)

        local wriggle_kris = Game.battle.timer:every(0.1, function()
            local wriggle_x, wriggle_y = Utils.random(-1, 1), Utils.random(-1, 1)

            rosy_trap.x = rosy_trap.x + wriggle_x
            rosy_trap.y = rosy_trap.y + wriggle_y
            kris.x = kris.x + wriggle_x
            kris.y = kris.y + wriggle_y
        end)

        c:wait(2.0)

        c:battlerText(rosy, "uR JUS sAiYAN rAnDom\ntINGz nOW")
        c:battlerText(rosy, "sHOwS hOW ScREWed\nyOU aRE")

        c:wait(0.5)

        rosy.scale_x = 3
        c:battlerText(rosy, "\"dA knIGHT\"")
        rosy.scale_x = 1
        c:battlerText(rosy, "cOmE ORRRN,[wait:5] KRIS!")
        rosy.scale_x = 4
        rosy:shake(2, nil, 0)
        c:battlerText(rosy, "dEY hAVeN'T hAd dOsE\nfOR a hUnDReD yEArZ")

        c:wait(0.5)
        kris:hurt(penguhealth, true)
        c:wait(0.25)
        kris:hurt(penguhealth, true)
        c:wait(1)

        rosy:stopShake()
        rosy.scale_x = 1
        c:battlerText(rosy, "trOOF iS:")
        rosy.scale_x = 2
        rosy.flip_y = true
        c:battlerText(rosy, "dA gAmE wUZ rIgGeD\nfRoM dA sTARt!")

        c:wait(0.5)

        rosy.flip_y = false
        c:battlerText(rosy, "dIS wHOlE tING")
        c:battlerText(rosy, "yOU nEVa hAD a\ncHAnCE!!")

        c:wait(0.5)
        kris:hurt(penguhealth, true)
        c:wait(0.25)
        kris:hurt(penguhealth, true)
        c:wait(1)

        rosy:setSprite("battle/hurt_real")
        c:battlerText(rosy, "[voice:rosy_pre]c'mon, kris.")
        c:battlerText(rosy, "[voice:rosy_pre]scream.")

        c:wait(0.5)
        kris:hurt(penguhealth, true)
        c:wait(0.25)
        kris:hurt(penguhealth, true)
        c:wait(1)

        rosy:shake(1, nil, 0)
        c:battlerText(rosy, "[voice:HAPPY]SCREAM FOR ME.")

        kris:hurt(penguhealth, true)
        c:wait(0.25)
        kris:hurt(Game.party[1]:getHealth() - 1, true)

        c:battlerText(rosy, "[voice:HAPPY]SCREAM FOR ME YOU\nUSELESS BAG OF", {auto = true})

        Game.battle.music:stop()

        local knight = Game.battle:addChild(Character("knight", rosy.x, rosy.y))

        knight.layer = BATTLE_LAYERS["above_battlers"]

        local function damage_rosy(spam)
            rosy:shake()

            local x, y = rosy.x, rosy.y - 50

            if spam == true then
                x, y = x + Utils.random(-50, 50), y + Utils.random(-50, 50)
            end

            local percent = DamageNumber("damage", 999, x, y, {1, 0, 0})
            percent.layer = WORLD_LAYERS["below_ui"]
            Game.battle:addChild(percent)
        end

        local function knight_slash_rosy()
            knight.x, knight.y = rosy.x + 50, rosy.y + 40
            knight:setAnimation("crescent_slash")
            c:wait(0.25)
            Game.battle:shakeCamera(12, 12, 0.5)
            Assets.playSound("rosy_oh")
            Assets.playSound("damage", 1, 0.9)
            rosy:setAnimation("hurt_real")
            damage_rosy()
            rosy:setAnimation("sink")
        end

        local function rosy_reorient(x, y)
            rosy.x, rosy.y = x, y
            rosy:setAnimation("rise")
        end

        knight_slash_rosy()

        c:wait(1)

        rosy.x = rosy.x + 400
        rosy:setSprite("default")
    
        c:wait(1)

        Game.battle.timer:tween(1, rosy, {x = rosy.x - 380})
        Assets.playSound("slidewhist")
        
        c:wait(1)
        c:battlerText(rosy, "woW!1!")
        c:battlerText(rosy, "glAD i waSn'T\ndAt gUy!")

        c:wait(0.5)
        knight_slash_rosy()
        c:wait(0.25)
        rosy_reorient(rosy.x - 40, rosy.y - 40)
        c:wait(0.5)
        knight_slash_rosy()
        c:wait(0.25)
        rosy_reorient(rosy.x + 90, rosy.y + 140)
        c:wait(0.5)
        knight_slash_rosy()
        c:wait(0.25)
        rosy_reorient(SCREEN_WIDTH/2 + 200, SCREEN_HEIGHT/2 - 60)
        c:wait(1)

        knight:setAnimation("flurry")
        knight.flip_x = true
        knight.x, knight.y = rosy.x - 200, -400

        Assets.playSound("wing")
        Game.battle.timer:tween(0.5, knight, {y = rosy.y + 40}, "in-quad")
        c:wait(0.5)
        Assets.playSound("wing")
        Game.battle.timer:tween(0.5, knight, {x = knight.x - 40, y = knight.y - 40}, "in-quad")
        c:wait(0.5)
        Game.battle.timer:tween(0.25, knight, {x = knight.x + 60, y = knight.y + 60}, "out-quad")

        rosy:setAnimation("hurt_real")
        for i = 1, 20, 1 do
            damage_rosy(true)
            Assets.playSound("damage", 0.5, 1.0)
            c:wait(0.1)
        end
        rosy:shake(0.1, 0, 0)
        Game.battle.music:play("mus_dr_knight_appears")
        Game.battle.music.volume = 0
        Game.battle.music:fade(1, 2)
        Game.battle.timer:tween(2.0, knight, {x = knight.x - 250, y = knight.y - 30}, "in-out-cubic")
        knight:shake()
        knight:setAnimation("idle")

        c:wait(2)
        c:battlerText(rosy, "...")
        c:battlerText(rosy, "[voice:rosy_pre]predictable.")

        rosy:setSprite("happy")
        c:battlerText(rosy, "[voice:rosy_pre]you're really\npredictable,[wait:20] you\nknow that?")

        rosy:shake(1, 0, 0)
        rosy:setSprite("happy_lookaway")
        c:battlerText(rosy, "[shake:1.5][voice:rosy_pre]like a bunch of\nlittle maggots...[wait:20]\nfeeding on filth...")

        rosy:setSprite("happy")
        c:battlerText(rosy, "[voice:rosy_pre]you can't resist...")

        rosy:shake(4, 0, 0)
        c:battlerText(rosy, "[voice:HAPPY]SEEING[wait:3] ME[wait:3] SUFFER.")

        rosy:shake(0.1, 0, 0)
        rosy:setAnimation("hurt_real")
        c:battlerText(rosy, "[voice:rosy_pre]well,[wait:5] just you wait!")
        rosy:setSprite("happy")
        c:battlerText(rosy, "[voice:HAPPY]JUST[wait:3] YOU[wait:3]      ", {auto = true})


        Game.battle.music:stop()
        local swoon_sprite = Sprite("effects/swoon", rosy.x - 100, rosy.y)
        swoon_sprite:setLayer(WORLD_LAYERS["top"])
        swoon_sprite:setOrigin(0.5)
        swoon_sprite:setScale(2)
        Game.stage:addChild(swoon_sprite)
        Assets.playSound("knight_cut", 1.0, 0.1)
        c:fadeOut(0)
        local old_rosy_x, old_rosy_y = rosy.x, rosy.y
        rosy.x, rosy.y = 1000, 1000

        c:wait(4)

        local miss_message = DamageNumber("msg", "miss", old_rosy_x, old_rosy_y - 50, {1, 0, 0})
        miss_message.layer = WORLD_LAYERS["below_ui"]
        Game.battle:addChild(miss_message)

        Assets.playSound("antumbral_shield")

        swoon_sprite:remove()
        Assets.stopSound("knight_cut")
        c:fadeIn(0)
        knight:setSprite("idle_troubled")
        c:wait(2)
        knight:setAnimation("idle")
        knight.flip_x = false
        knight.x = knight.x + 100
        Game.battle.timer:tween(2, knight, {x = knight.x + 200}, "out-quad")
        Game.battle.music:play("mus_dr_knight_appears")
        Game.battle.music.volume = 0
        Game.battle.music:fade(1, 2)
        c:wait(3)
        Game.battle.music:pause()
        c:fadeOut(0)
        knight.x = 10000
        Game.battle.timer:clear()
        rosy_trap:remove()
        c:wait(4)
        Game.battle.trippy_background:remove()
        c:fadeIn(0)
        kris.y = kris.y + 40
        kris:setSprite("fell")
        c:wait(2)
        kris:setSprite("sit")
        kris:shake()
        Assets.playSound("wing")
        c:wait(4)
        kris:setAnimation("battle/idle")
        kris:shake()
        Assets.playSound("wing")

        c:wait(1)
        Game:setFlag("ending", 1)
        Game.battle:removeEnemy(rosy, true)
    end
}
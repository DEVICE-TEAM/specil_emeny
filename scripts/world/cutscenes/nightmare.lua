---@diagnostic disable: undefined-field

return {

    ---@param c WorldCutscene
    back = function(c, event)
        local kris = c:getCharacter("kris")

        if Game:getFlag("nightmare.tried_to_go_back", 0) == 0 then
            c:text("* You tried to go back.")
            c:text("* But you can[wait:2] never[wait:2] go back.")
            c:text("* There's only one way you can go.")
        elseif Game:getFlag("nightmare.tried_to_go_back", 0) < 10 then
            c:text("* Only forward.")
        else
            c:text("* Proceed.")
        end

        Game:setFlag("nightmare.tried_to_go_back", Game:getFlag("nightmare.tried_to_go_back", 0) + 1)

        kris:walkTo(kris.x + 20, kris.y, 0.5)
    end,

    ---@param c WorldCutscene
    initial_stare_abyss = function(c, event)
        local kris = c:getCharacter("kris")

        c:detachCamera()

        c:text("* You looked at it.")
        c:panTo(Game.world.camera.x, Game.world.camera.y - 400, 4)
        c:wait(4)
        Game.world.music:pause()
        c:wait(6)

        Game.world.music:setVolume(0)
        Game.world.music:play()
        Game.world.music:fade(1, 4)

        c:panTo(Game.world.camera.x, Game.world.camera.y + 400, 4, nil, function()
            c:attachCamera()
        end)
    end,

    ---@param c WorldCutscene
    ramb = function(c, event)
        local kris = c:getCharacter("kris")
        local ramb = c:getCharacter("ramb")

        local ramb_og_x = ramb.x

        local ramb_move
        if kris.facing == "up" then
            c:wait(0.25)
            if kris.x > ramb.x then
                ramb_move = -40
            else
                ramb_move = 40
            end
            Game.world.timer:tween(0.5, ramb, {x = ramb.x + ramb_move}, "in-quad")
            c:wait(0.25)
        elseif kris.facing == "down" then
            return
        end

        c:setSpeaker(ramb)
        if Game:getFlag("nightmare.ramb_interaction", 0) == 0 then
            ramb.sprite.head:setSprite("surprised")
            c:text("* Kris![wait:4] Oh,[wait:4] Kris!")

            ramb.sprite.head:setSprite("happy")
            c:text("* Boy,[wait:4] am I happy to see you,[wait:4] luv.")

            ramb.sprite.head:setSprite("surprised")
            c:text("* Ol' Tenna's gone nutty!")

            ramb.sprite.head:setSprite("happy")
            c:text("* If you don't believe me,[wait:4] ask him yourself!")

            Game:setFlag("nightmare.ramb_interaction", 1)

        elseif Game:getFlag("nightmare.ramb_interaction", 0) == 1 then
            c:text("* Ask him yourself,[wait:4] luv!")

        elseif Game:getFlag("nightmare.ramb_interaction", 0) == 2 then

            ramb.sprite.head:setSprite("head_turned")
            c:text("* Right?")
            c:text("* Positively barmy.")

            ramb.sprite.head:setAnimation({"head_turn", 1/5, false, next="happy"})
            c:text("* But,[wait:4] we're used to that,[wait:4] aren't we?")

            ramb.sprite.head:setSprite("surprised")
            c:text("* That's just how he is.")

            ramb.sprite.head:setSprite("head_turned")
            c:text("* Ol' Tenna...")

            ramb.sprite.head:setSprite("turn_look")
            c:text("* Just a bit o' LOVE's what he needs.")

            ramb.sprite.head:setSprite("happy")
            c:text("* Right?")

            local choice = c:choicer({"Yes", "No"})
            if choice == 1 then

                ramb.sprite.head:setAnimation({"happy_nostalgic", 1/5, false, next="nostalgic"})
                c:text("* Right.")
                c:text("* Wouldn't expect you to answer any different,[wait:4] luv.")

                ramb.sprite.head:setSprite("surprised")
                c:text("* I mean,[wait:4] it's your fault,[wait:4] innit?")

                ramb.sprite.head:setAnimation({"happy_nostalgic", 1/5, false, next="nostalgic"})
                c:text("* Must've deserved it!")
            else
                ramb.sprite.head:setSprite("head_turned")
                c:text("* ...")
                c:text("* That's odd.")
                ramb.sprite.head:setAnimation({"head_turn", 1/5, false, next="happy"})
                c:text("* Why'd you let it happen,[wait:4] then?")
            end

            kris:walkTo(kris.x, kris.y + 40, 1)
            c:wait(1)

            ramb.sprite.head:setSprite("surprised")
            c:text("* Say,[wait:4] Kris.")

            kris:setFacing("up")

            ramb.sprite.head:setSprite("turn_subtle")
            c:text("* Don't mean to pry,[wait:4] I really don't...")

            ramb.sprite.head:setSprite("surprised")
            c:text("* But,[wait:4] is it right that some need more love than others?")

            choice = c:choicer({"Yes", "No"})
            if choice == 1 then

                ramb.sprite.head:setAnimation({"happy_nostalgic", 1/5, false, next="nostalgic"})
                c:text("* Would it were true,[wait:4] luv.[wait:10]\n* Would it were true...")

                ramb.sprite.head:setSprite("turn_subtle")
                c:text("* An old plug like me might see happiness in a world like that.")
            else
                c:text("* Right.")
            end
            
            ramb.sprite.head:setSprite("turn_look")
            c:text("* Reminds me of the girl you used to know.")

            ramb.sprite.head:setSprite("head_turned")
            c:text("* ...")

            ramb.sprite.head:setSprite("surprised")
            c:text("* Oh,[wait:4] blimey![wait:4] Completely slipped my mind...")

            ramb.sprite.head:setSprite("happy")
            c:text("* She's lookin' for you,[wait:4] you know!")

            ramb.sprite.head:setSprite("annoyed")
            c:text("* Would be rude not to pay her a visit.")

            ramb.sprite.head:setSprite("happy")
            c:text("* Got [wait:2]just[wait:2] the thing you need...")

            local item_result, item_text = Game.inventory:tryGiveItem("odd_controller")

            if item_result then
                c:text(item_text)
            end

            ramb.sprite.head:setAnimation({"happy_nostalgic", 1/5, false, next="nostalgic"})
            c:text("* Never say your old pal Ramb never helped ya outta a scrap or two!")
            c:text("* Hahaha...")

            ramb.sprite.head:setSprite("surprised")
            c:text("* How is she,[wait:4] by the by?")

            Game:setFlag("nightmare.ramb_interaction", 3)

        elseif Game:getFlag("nightmare.ramb_interaction", 0) == 3 then

            ramb.sprite.head:setSprite("surprised")
            c:text("* How is she,[wait:4] by the by?")

        end

        ramb.sprite.head:setSprite("happy")
        Game.world.timer:tween(0.5, ramb, {x = ramb_og_x}, "out-quad")

    end,

    ---@param c WorldCutscene
    tenna = function(c, event)

        local inventory = Game.inventory:getDarkInventory()
        local kris = c:getCharacter("kris")
        if kris.facing == "down" then
            if Game:getFlag("nightmare.console_interaction", 0) <= 2 then
                if Game:getFlag("nightmare.console_interaction", 0) == 0 then
                    c:text("* You see an old third-generation game console tucked underneath.")
                    c:text("* It needed a different plug.")
                    Game:setFlag("nightmare.console_interaction", 1)
                else
                    c:text("* ...")
                end
                if inventory:hasItem("odd_controller") then
                    c:text("* ...?")
                    c:text("* Staring at the controller made you remember something...")

                    c:fadeOut(2)
                    c:wait(2)
                    Game.world.music:fade(0, 2)

                    Game:setFlag("nightmare.ramb_gone", 1)

                    c:text("* And this is their room!", nil, "patience")
                    c:text("* Wanna show her around,[wait:4] Kris?", nil, "patience")

                    c:wait(1.0)

                    c:text("* You want to show her your game?", nil, "patience")

                    c:wait(0.5)
                    c:playSound("bump", 0.7)
                    c:wait(0.75)
                    c:playSound("bump", 0.7)
                    c:wait(1)
                    c:playSound("wing", 0.7)
                    c:wait(0.5)

                    local mus_memory_retro = Music()
                    mus_memory_retro:play("mus_rt_memory_retro")

                    c:text("* Oh,[wait:4] so,[wait:4] they like...[wait:4] videos[wait:2] games?", nil, "toriel")

                    c:text("* Very much so!", nil, "patience")
                    c:text("* Many of the older children complain of them...[wait:4] erm....", nil, "patience")
                    c:text("* Being a bit[wait:8] TOO[wait:2] good at games,[wait:4] haha.", nil, "patience")

                    c:text("* Could they,[wait:4] perhaps...[wait:10] bring that console home with us?", nil, "toriel")

                    c:text("* Of course!", nil, "patience")
                    c:text("* Most of the others really don't care for games that old anymore,[wait:4] anyways.", nil, "patience")
                    c:text("* It'd feel wrong for it to collect dust here when Kris could be enjoying it at home.", nil, "patience")

                    c:text("* Thank you so much!", nil, "toriel")
                    c:text("* How much do I owe you?", nil, "toriel")

                    c:text("* Nothing![wait:10] It's for free.", nil, "patience")

                    c:text("* Free!?..[wait:10]\n* Oh,[wait:6] now,[wait:4] I cannot let that stand.", nil, "toriel")
                    c:text("* It is an antique,[wait:4] is it not?", nil, "toriel")
                    c:text("* You must let me pay you something.", nil, "toriel")

                    c:text("* Well, I...", nil, "patience")
                    c:text("* ...", nil, "patience")
                    c:wait(0.5)
                    c:text("* Kris,[wait:4] give us a moment, alright?", nil, "patience")

                    mus_memory_retro:fade(0, 1, function()
                        mus_memory_retro:remove()
                    end)
                    c:wait(1.0)
                    Assets.playSound("doorclose")

                    c:text("* Truth is...[wait:10]\n* Kris has been a bit of a handful for us.", nil, "patience")
                    c:text("* We love unconventional children,[wait:4] and Kris is such a gifted child...", nil, "patience")
                    c:text("* But,[wait:4] the other children don't usually seem to think that way.", nil, "patience")
                    c:text("* We have a zero-tolerance policy towards bullying,[wait:4] but...", nil, "patience")
                    c:text("* ...we can't exactly force children to play together if they don't want to...", nil, "patience")
                    c:text("* I think the loneliness is what might give them their tendency to lash out.", nil, "patience")

                    c:wait(1.0)

                    c:text("* Ah.\n[wait:10]* I think I understand, miss.", nil, "toriel")
                    c:text("* Perhaps all they need is a mother's touch...?", nil, "toriel")

                    c:text("* Maybe so!\n[wait:10]* I would just keep in mind", nil, "patience", {auto = true})

                    c:text("* Tori![wait:10]\n* Paperwork's in order for once![wait:4]\n* Oh ho ho!", nil, "asgore")
                    c:text("* Have you met Kris yet?", nil, "asgore")
                    c:text("* I think them and Asriel will be like two peas in a pod.", nil, "asgore")

                    Game:setFlag("nightmare.tv_mem_3", true)

                    Game.world.music:fade(1, 2)
                    c:fadeIn(2)
                    Game:setFlag("nightmare.console_interaction", 3)
                end
            else
                c:text("* No more to be known.")
            end
        else
            c:text("* ...")
            c:text("* He's dead.")
            if Game:getFlag("nightmare.ramb_interaction", 0) == 1 then
                Game:setFlag("nightmare.ramb_interaction", 2)
            end
        end

    end,

    ---@param c WorldCutscene
    tv_mem_1 = function(c, event)
        
        c:fadeOut(2)
        c:wait(2)
        Game.world.music:fade(0, 2)

        local mus_memory_domestic_dissonance = Music()
        mus_memory_domestic_dissonance:play("mus_rt_memory_domestic_dissonance")

        c:text("[shake:0.75]* I don't want you near my children!", nil, "toriel")

        Assets.playSound("swing_heavy")
        c:wait(0.25)
        Assets.playSound("plate_break")
        c:wait(0.5)

        c:text("* Are we throwing things now!?", nil, "asgore")
        c:text("* And...[wait:6]\n* \"Your\" children!?[wait:6]\n* They're my children too!", nil, "asgore")

        c:wait(0.25)

        c:text("[shake:0.75]* Not after today...!", nil, "toriel")

        c:wait(0.5)

        c:text("* Tori...!", nil, "asgore")

        c:wait(0.1)

        c:text("[shake:0.75]* DON'T YOU[wait:4] DARE CALL ME THAT!", nil, "toriel")

        Assets.playSound("swing_heavy")
        c:wait(0.1)
        Assets.playSound("swing_heavy")
        c:wait(0.25)
        Assets.playSound("plate_break")
        c:wait(0.3)
        Assets.playSound("plate_break")
        c:wait(0.5)

        c:text("* If you would just let me explain myself I promise yo", nil, "asgore", {auto = true})

        c:text("[shake:0.75]* I DON'T KNOW WHAT EXPLANATION YOU COULD POSSIBLY GIVE!", nil, "toriel")

        c:text("* IT WAS THE ONLY WAY!", nil, "asgore")

        Assets.playSound("swing_heavy")
        c:wait(0.25)
        Assets.playSound("plate_break")
        Assets.playSound("ominous_stab_less_harsh")
        c:text("[shake:1]* AAAGH...", nil, "asgore")

        c:wait(0.5)

        c:text("[speed:0.5]* ...!", nil, "toriel")
        c:text("[speed:0.75]* Asgore...\n[wait:10]* Did I...?", nil, "toriel")
        c:text("[speed:0.75]* I'm...[wait:4] sorry...[wait:4] I...", nil, "toriel")

        c:wait(0.25)

        c:text("[shake:1][speed:0.5]* It's...[wait:4] alright...", nil, "asgore")

        c:text("[shake:0.5][speed:0.5]* Just...[wait:4] let me explain myself...!", nil, "asgore")

        mus_memory_domestic_dissonance:fade(0, 1, function()
            mus_memory_domestic_dissonance:remove()
        end)

        Game.world.music:fade(1, 2)
        c:fadeIn(2)

        Game:setFlag("nightmare.tv_mem_1", true)
    end,

    ---@param c WorldCutscene
    tv_mem_2 = function(c, event)
        
        c:fadeOut(2)
        c:wait(2)
        Game.world.music:fade(0, 2)

        local mus_memory_white_blanket = Music()
        mus_memory_white_blanket:play("mus_gg_white_blanket")

        c:text("[voice:dess_young]* Elly![wait:4] Kris![wait:8]\n* Up here![wait:4] Look!")
        c:text("[voice:dess_young]* The view is fantastic!")

        c:wait(0.5)

        c:text("[voice:noelle_young]* Ok,[wait:4] Dess!")

        c:wait(2)

        c:text("[voice:dess_young]* You too,[wait:4] Krismas!")
        c:text("[voice:dess_young]* C'mon!\n[wait:10]* Both of you!\n[wait:10]* Come join the fun!")

        c:wait(0.5)

        c:text("[voice:noelle_young]* I'm trying,[wait:4] Dess!")

        c:wait(2)

        c:text("[voice:dess_young]* ...")
        c:text("[voice:dess_young]* Alright!")
        c:text("[voice:dess_young]* First one up here gets ICE-E's on me!")

        c:wait(0.5)

        c:text("[voice:noelle_young]* Uuuugh![wait:10]\n* That's unfair!")
        c:text("[voice:noelle_young]* I don't even like ICE-E's anymore,[wait:4] Dess!")

        c:wait(0.2)

        c:text("[voice:dess_young]* Huh...?")
        c:text("[voice:dess_young]* What do you mean?")
        c:text("[voice:dess_young]* We got it last week!")

        c:wait(0.5)

        c:text("[voice:noelle_young]* Kris said...[wait:4] ICE-E eats kids...!")
        c:text("[voice:noelle_young]* Th-they said...[wait:4] he turns does...[wait:4] into [shake:1]DOUGH[shake:0]!")
        c:text("[voice:noelle_young]* I couldn't eat mine anymore,[wait:4] so,[wait:4] I gave all mine to them!")

        c:wait(0.5)

        c:text("[voice:dess_young]* What the...")
        c:text("[voice:dess_young]* KRIS!")

        mus_memory_white_blanket:fade(0, 1, function()
            mus_memory_white_blanket:remove()
        end)

        Game.world.music:fade(1, 2)
        c:fadeIn(2)

        Game:setFlag("nightmare.tv_mem_2", true)
    end,

    ---@param c WorldCutscene
    tv_progress = function(c, event)
        if Game:getFlag("nightmare.tv_mem_1") and Game:getFlag("nightmare.tv_mem_2") and Game:getFlag("nightmare.tv_mem_3") then
            c:text("* Out of the void...[wait:4] something...!")
            Game:saveQuick()
            Game:setFlag("nightmare.tv_unlocked", true)
            c:startEncounter("memoryhead_TV")

        else
            c:text("* There's just too much holding you back.")
            if Game:getFlag("nightmare.tv_mem_1") and Game:getFlag("nightmare.tv_mem_2") then
                if Game:getFlag("nightmare.ramb_interaction", 0) == 3 then
                    c:text("* Your mother always stowed your old console behind the TV when you weren't using it.")
                else
                    c:text("* Maybe that old plug knows something..?")
                end
            else
                c:text("* Look back.")
            end
        end
    end,

    ---@param c WorldCutscene
    cyber_spawn_noelle = function(c, event)

        Game:setFlag("nightmare_noelle_spawned", Game:getFlag("nightmare_noelle_spawned", 0) + 1)

        local n_spawned = Game:getFlag("nightmare_noelle_spawned", 0)

        Assets.playSound("amalgam_noise", 0.05, 0.7)
        local noelle = Game.world:spawnNPC("noelle", c:getMarker("noelle_spawn_" + n_spawned))
        noelle:addFX(RecolorFX(0, 0, 0, 1.0))
        c:enableMovement()
        noelle:walkToSpeed("noelle_walk_" + n_spawned, 8, nil, nil, function()
            noelle:remove()
        end)
    end,

    ---@param c WorldCutscene
    cyber_mem_fun = function(c, event)
        c:enableMovement()
        c:text("[voice:dess_young]* Come join the fun,[wait:4] Krismas![wait:20]", nil, {auto = true})
    end,

    ---@param c WorldCutscene
    cyber_mem_get_together = function(c, event)
        c:enableMovement()
        c:text("[voice:MTM]* It's a real get together![wait:20]", nil, {auto = true})
    end,

    ---@param c WorldCutscene
    cyber_mem_riley = function(c, event)
        c:enableMovement()
        c:text("[voice:riley]* We need to get to the bottom of this...[wait:20]", nil, {auto = true})
    end,

    ---@param c WorldCutscene
    cyber_mem_scuti = function(c, event)
        c:enableMovement()
        c:text("[voice:scuti]* I don't want these voices in my head anymore![wait:20]", nil, {auto = true})
    end,

    ---@param c WorldCutscene
    cyber_mem_asgore = function(c, event)
        c:enableMovement()
        c:text("[voice:asgore]* I need to show them all...[wait:20]", nil, {auto = true})
    end,

    ---@param c WorldCutscene
    cyber_mem_susie = function(c, event)
        c:enableMovement()
        c:text("[voice:susie]* I can't be alone anymore...[wait:20]", nil, {auto = true})
    end,

    ---@param c WorldCutscene
    cyber_memhead_ambush = function(c, event)
        local kris = c:getCharacter("kris")
        local memoryhead_a = c:spawnNPC("memoryhead", kris.x, kris.y - 80)
        memoryhead_a.alpha = 0
        memoryhead_a:setScale(0)
        local memoryhead_b = c:spawnNPC("memoryhead", kris.x + 80, kris.y)
        memoryhead_b.alpha = 0
        memoryhead_b:setScale(0)
        local memoryhead_c = c:spawnNPC("memoryhead", kris.x, kris.y + 80)
        memoryhead_c.alpha = 0
        memoryhead_c:setScale(0)

        Game.world.music:pause()

        Assets.playSound("amalgam_noise")
        Game.world.timer:tween(1, memoryhead_b, {scale_x = 2, scale_y = 2, alpha = 1}, "in-out-quad")
        c:wait(0.5)
        Assets.playSound("amalgam_noise")
        Game.world.timer:tween(1, memoryhead_a, {scale_x = 2, scale_y = 2, alpha = 1}, "in-out-quad")
        c:wait(0.5)
        Assets.playSound("amalgam_noise")
        Game.world.timer:tween(1, memoryhead_c, {scale_x = 2, scale_y = 2, alpha = 1}, "in-out-quad")
        c:wait(1)

        memoryhead_a:shake()
        memoryhead_b:shake()
        memoryhead_c:shake()
        
        Game.world.timer:tween(6, memoryhead_b, {x = kris.x, y = kris.y}, "in-out-quad")
        Game.world.timer:tween(6, memoryhead_a, {x = kris.x, y = kris.y}, "in-out-quad")
        Game.world.timer:tween(6, memoryhead_c, {x = kris.x, y = kris.y}, "in-out-quad")
        Assets.playSound("amalgam_noise", 1.3, 0.5)
        Game.world.timer:every(0.5, function()
            kris:setFacing(TableUtils.pick({
                "up", "right", "down"
            }))
            kris:shake()
        end, 10)
        c:wait(3)

        c:startEncounter("memoryhead_CYBER", true, {{"memoryhead_a", memoryhead_a}, {"memoryhead_b", memoryhead_b}, {"memoryhead_c", memoryhead_c}})
        memoryhead_a:remove()
        memoryhead_b:remove()
        memoryhead_c:remove()

    end,


    ---@param c WorldCutscene
    weird_noelle = function(c, event)

        local noelle = Game.world:getCharacter("weird_noelle")
        local kris = Game.world:getCharacter("kris")

        c:detachCamera()

        if Game:getFlag("weird_noelle_met") ~= true then
            Game:setFlag("weird_noelle_met", true)
            Game:saveQuick()

            c:setSpeaker(noelle)

            Assets.playSound("wing")
            noelle:shake()
            noelle:setSprite("sit_lean_right")
            c:wait(0.5)
            c:text("* H[wait:2]", {auto = true})
            c:text("* Hi, Kris.")
            c:wait(0.25)

            Game.world.music:play("mus_rt_memory_tomorrow")

            Assets.playSound("wing")
            noelle:shake()
            noelle:setSprite("sit_lean_left")
            c:wait(0.5)
            c:text("* I'm really happy to see you,[wait:4] Kris.")
            
            Assets.playSound("wing")
            noelle:shake()
            noelle:setSprite("sit_lean_right")
            c:wait(0.1)
            
            Assets.playSound("wing")
            noelle:shake()
            noelle:setSprite("sit_lean_left")
            c:wait(0.5)
            c:text("* I've been waiting all day,[wait:4] Kris.")
            c:text("* Waiting.[wait:4]\n* Waiting.[wait:4]\n* Waiting.")
            
            c:wait(1.0)
            
            Assets.playSound("wing")
            noelle:shake()
            noelle:setSprite("sit_turn")
            c:wait(1.0)
            c:text("* That's not nice.")
            c:text("* That's not nice keeping us waiting like that,[wait:4] Kris.")
            
            noelle:shake()
            noelle:setSprite("default")
            c:wait(0.5)
            c:text("* I don't like waiting\nanymore,[wait:4] Kris.", "happy_down")

            kris:walkTo(kris.x, kris.y + 20, 1, "up", true)
            c:wait(1)
            c:text("* I [wait:4]CAN'T wait.", "happy")
            c:text("* You CAN'T leave us waiting, Kris.[wait:4]\n* You[wait:4] CAN'T.", "happy")
            c:text("* We have so much to do.", "happy_left")
            c:text("* You,[wait:4] me...", "happy_right")
            
            c:text("* ...", "happy")
            
            c:wait(1)

            Assets.playSound("wing")
            noelle:shake()
            noelle:setSprite("shrug")
            c:text("* All [color:red]three[color:reset] of us!\n[wait:10]* All [color:red]three[color:reset] of us,[wait:4] Kris.", "happy_happy")
            
            noelle:shake()
            c:text("* FAHaHA.", "happy_happy")
            
            kris:walkTo(kris.x, kris.y + 20, 1, "up", true)
            
            c:wait(1)
            c:text("* Let me tell you the truth,[wait:4] Kris.", "tell")
            c:text("* Catti...", "tell_left")
            c:text("* Jockington...", "tell")
            c:text("* Snowy...", "tell_left")
            c:text("* Berdly...", "tell")
            noelle:shake()
            c:wait(1)
            noelle:shake()
            c:wait(0.5)
            c:text("* SUSI[wait:4]", "susie", {auto = true})
            noelle:shake()
            c:text("* S[wait:4]", "susie", {auto = true})
            noelle:shake()
            c:text("* SUSIE...", "susie")

            c:wait(0.25)
            c:text("* ...", "susie")

            c:wait(0.5)
            c:text("* I never reAlly cared about any of them.", "didnt_matter")
            c:text("* Not REallY.", "happy_happy")
            
            Assets.playSound("wing")
            noelle:shake()

            c:text("* I juSt[wait:4]", "susie", {auto = true})
            c:text("* I just didn't know how much it was possible to[wait:4] cArE.", "happy_happy")
            c:text("* The desirE to[wait:4] sErve.", "happy_right")
            c:text("* To[wait:4] idolizE.", "didnt_matter")
            c:text("* I'm addIcted to it.", "sad")
            c:text("* I need[wait:4] mORE.", "happy_down")
            c:fadeOut(0.1)
            Game.world.music:stop()
            noelle:setSprite("shrug_shade")
            c:wait(1)
            c:fadeIn(0.1)
            c:text("[voice:none][speed:0.5][noskip]* I need it to spEAK tO me aGain, Kris.", "happy_shade")
            
            Assets.playSound("wing")
            noelle:shake()
            c:wait(0.25)
            Assets.playSound("wing")
            noelle:shake()
            c:wait(0.1)
            Assets.playSound("wing")
            noelle:shake()
            c:wait(0.1)
            Assets.playSound("wing")
            noelle:shake()
            c:wait(0.1)
            Assets.playSound("wing")
            noelle:shake()
            c:wait(0.1)
            Assets.playSound("wing")
            noelle:shake()
            c:wait(0.05)

            local you
            noelle:setSprite("jumpscare")
            c:text("[voice:none][speed:0.5][noskip]* I[wait:5]\n* NEED[wait:5][func:YOU][face:shade]\n* YOU[wait:40]", "happy_shade", nil, {auto = true, functions = {
                YOU = function()
                    Game.world.timer:script(function(wait)
                        you = Assets.playSound("YOU", 2)
                    end)
                    Game.world.timer:every(0.005, function()
                        local you_text = Text("YOU", MathUtils.random(0, SCREEN_WIDTH), MathUtils.random(0, SCREEN_HEIGHT))
                        Game.stage:addChild(you_text)
                        Game.world.timer:after(2, function()
                            you_text:remove()
                        end)
                    end, 1000)
                end
            }})

            you:stop()
            c:gotoCutscene("nightmare.CTD")
        else
            Game:setFlag("rosy_quick", true)
            c:text("* ...")
            noelle:setSprite("sit_turn_rosy")
            noelle:shake()
            c:text("* rOsY dA rOSE!!!!", nil, "rosy")
            
            c:loadMap("dw_church/nightmare/FINAL")
            c:startEncounter("rosy")
        end
    end,

    ---@param c WorldCutscene
    CTD = function(c, event)

        c:loadMap("dw_church/nightmare/FINAL")

        local CTD = Sprite("catastrophic_error", nil, nil, nil, nil, "effects/error")
        CTD:setLayer(CTD.layer + 1)
        CTD:setOrigin(0.5)
        CTD:setPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
        Game.world.stage:addChild(CTD)

        local function error_piece(number)
            local error_piece_sprite = Sprite("error_piece_" + number, nil, nil, nil, nil, "effects/error")
            error_piece_sprite:setLayer(error_piece_sprite.layer + 1)
            error_piece_sprite:setOrigin(0.5)
            error_piece_sprite:setPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            Game.world.stage:addChild(error_piece_sprite)
            return error_piece_sprite
        end

        c:wait(6)

        Assets.playSound("giga_punch")
        CTD:setSprite("catastrophic_error_bash_1")
        Game.world.stage:shake()
        c:wait(2)
        Assets.playSound("giga_punch", nil, 0.9)
        CTD:setSprite("catastrophic_error_bash_2")
        Game.world.stage:shake()
        c:wait(2)
        Assets.playSound("giga_punch", nil, 0.7)
        CTD:setSprite("catastrophic_error_bash_3")
        Game.world.stage:shake()
        c:wait(2)
        Assets.playSound("giga_punch", nil, 0.6)
        CTD:setSprite("catastrophic_error_bash_4")
        Game.world.stage:shake()
        c:wait(2)

        Game.world.stage:shake()
        CTD:remove()
        Assets.playSound("explosion")
        local error_pieces = {error_piece(1), error_piece(2), error_piece(3), error_piece(4), error_piece(5)}
        for _,piece in ipairs(error_pieces) do
            Game.stage.timer:tween(2, piece, {y = piece.y + 800, x = piece.x + MathUtils.random(-50, 50), rotation = piece.rotation + math.rad(MathUtils.random(-50, 50))}, "in-out-quad", function()
                piece:remove()
            end)
        end
        c:wait(2)
        c:gotoCutscene("nightmare.rosy")
    end,

    ---@param c WorldCutscene
    rosy = function(c, event)

        local DR_save
        local DR_save_1 = DRSaveFile:get(1, 1)
        local DR_save_2 = DRSaveFile:get(1, 2)
        local DR_save_3 = DRSaveFile:get(1, 3)

        if DR_save_1 ~= nil then
            DR_save = DR_save_1
        elseif DR_save_2 ~= nil then
            DR_save = DR_save_2
        elseif DR_save_3 ~= nil then
            DR_save = DR_save_3
        end

        c:attachCamera()
        local kris = c:getCharacter("kris")
        kris:setFacing("up")

        c:wait(0.5)

        local rosy = c:spawnNPC("rosy", kris.x, kris.y)

        Assets.playSound("damage")
        kris:shake()
        Game.world.timer:tween(0.5, kris, {
            y = kris.y + 100
        })

        c:wait(0.5)

        Game.world.music:play("mus_rt_rosy_da_rose")

        c:setSpeaker(rosy)
        c:text("* waHAHOOooo!!!", "default")
        c:text("* hApPy bIrFdAy!!!!", "specil_frend")
        c:text("* rOSy dA rOSE!!!1![wait:10]\n[face:specil_frend]* cOMIn' iN wIt dA sTEeL cHaIRR!!1!", "squish")
        c:text("* diDuNT SEa dAT oNE cOmIn', didJA??", "squish")

        c:wait(0.5)
        
        rosy:setSprite("crocs")
        rosy:flash()
        rosy:shake()
        Assets.playSound("boost")
        c:text("* rOSY dA rOsE.\n* bACK aT iT aGaIn wIt hER bRANd nEw kICkZ!1!", "specil_frend")
        c:text("* oooOOOOOhh yEAH.[wait:10]\ndAtS wAt iM tAkIn' bOUT!1!", "squish")
        c:text("* hoW[wait:4] rElEvAnT", "specil")
        c:text("* hoW[wait:4] nEW", "squish")
        c:text("* bUY IT!!1!", "specil_frend")

        rosy:setSprite("default")
        rosy:shake()

        c:wait(1)

        c:text("* hoW yOu bEaN, KRSIS??", "default")
        c:text("* iZ bEAN lIEK...", "squish")
        c:text("* 7 rOSylLiOn yEaRZ sInCE i lAsT sAw yOu!!", "specil_frend")

        kris:shake()

        kris:walkTo(kris.x, kris.y + 100, 0.5)

        c:wait(0.3)
        c:text("[noskip]* uH uH!![wait:10] nONONO!!!1![wait:40]", "specil_frend", nil, {auto = true, advance = false})

        local rosy_vine = Sprite("long_vine", kris.x - 400, kris.y, nil, nil, "effects")
        rosy_vine.flip_x = true
        rosy_vine.layer = 1000
        rosy_vine:setScale(2)
        Game.world:addChild(rosy_vine)

        Game.world.timer:tween(0.1, rosy_vine, {x = kris.x - 50}, "in-out-quad")
        
        Assets.playSound("happy_WAAHHH")
        c:wait(0.1)
        Game.world.timer:tween(0.5, kris, {y = kris.y - 100})
        Assets.playSound("damage")

        c:wait(1)

        c:text("* goSH diDdLy dArN,[wait:4] krIS", "squish")
        c:text("* i tHOuGHt yOu'D bE a bIt diFfrEnT aFtEr aLl dIs tImE", "default")
        c:text("* bUTT aS iT tURnZ oUt...", "squish")
        c:text("* yOuR dA sAmE LIl kID I uSeD tO sTeAl cHocOlAtE maLk fRoM1!", "specil_frend")
        c:text("* eXcEpT nOW...", "squish")
        c:text("* yOu hAvE a FREND!1!...", "default")
        c:text("* a[wait:4] [speed:0.5]SPECIL FREND.", "default")

        rosy:setSprite("happy")
        c:wait(0.1)
        Game.world.music:stop()

        local background = Fader()
        background:fadeOut({speed = 0})
        background:setLayer(WORLD_LAYERS["top"])
        Game.world.stage:addChild(background)

        Game.world.music:play("mus_rt_alone")
        c:wait(3)

        local creepy_rosy = Sprite("effects/creepy_rosy/initial")
        creepy_rosy:setLayer(background.layer + 1)
        creepy_rosy:setOrigin(0.5)
        creepy_rosy:setPosition(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
        Game.world.stage:addChild(creepy_rosy)
        creepy_rosy.alpha = 0
        Game.world.timer:tween(2, creepy_rosy, {alpha = 1})

        c:wait(2)

        local function creepy_rosy_text(input, auto)
            input = string.gsub(input, "\n", "\n\n\n\n\n\n\n\n")
            local pengu = DialogueText("[voice:none][speed:0.5]" + input, SCREEN_WIDTH/2, 85, nil, nil, {auto = true, align = "center"})
            pengu.origin_x = 0.5
            pengu:setLayer(background.layer + 10)
            Game.world.stage:addChild(pengu)
            if auto ~= true then
                c:wait(function()
                    return Input.pressed("confirm") or Input.down("ctrl") and not pengu:isTyping()
                end)
                if not Input.down("ctrl") then
                    Game.world.timer:tween(1, pengu, {alpha = 0, y = pengu.y + 5}, "in-out-quad", function()
                        pengu:remove()
                    end)
                    c:wait(1.25)
                else
                    pengu:remove()
                end
            else
                c:wait(function()
                    return not pengu:isTyping()
                end)
                pengu:remove()
            end
        end

        creepy_rosy_text("...")
        creepy_rosy_text("finally") c:wait(1)
        creepy_rosy_text("you") c:wait(1)
        creepy_rosy_text("you\n[wait:20]and me")
        creepy_rosy_text("all[wait:10] alone") c:wait(1)
        creepy_rosy_text("...")
        creepy_rosy_text("but")
        creepy_rosy_text("we're[wait:10] not alone\n[wait:20]are we?") c:wait(1)
        creepy_rosy_text("not alone\n[wait:20]in our own ways") c:wait(2)

        if DR_save then
            creepy_rosy_text("i'm sorry\n[wait:20]" + string.lower(DR_save.name))
        else
            creepy_rosy_text("i'm sorry")
        end

        creepy_rosy_text("all this\nmust not really make sense")
        creepy_rosy_text("but\ni'll explain.")
        c:wait(1)
        creepy_rosy_text("i always wanted to be\nspecial.")
        creepy_rosy_text("i always wanted to\nfeel important.")
        creepy_rosy_text("but i was always\nthe \"weird girl.\"")
        creepy_rosy_text("the \"weird girl\"\nwith imaginary friends.")
        creepy_rosy_text("but i knew\nthe truth")
        creepy_rosy_text("my friends were fake...")
        creepy_rosy_text("but\nmy bullies were fake too.")
        creepy_rosy_text("the whole world.")
        creepy_rosy_text("there was only one\nreal one.")
        creepy_rosy_text("so")
        creepy_rosy_text("when i found out about\nyou.")
        creepy_rosy_text("i wanted to be your\nfriend.")
        creepy_rosy_text("your[wait:4]\nspecial friend.")
        creepy_rosy_text("and i did a lot.")
        creepy_rosy_text("but...\nit was stolen from me.")
        creepy_rosy_text("...and now...?")
        creepy_rosy_text("i'm just\na stupid flower.")
        c:wait(1)
        creepy_rosy_text("but now\nbecause of your choices...")
        creepy_rosy_text("i could finally\nfind you!")
        creepy_rosy_text("and we can finally\nmake things right.")
        creepy_rosy_text("you can play with me!")
        c:wait(2)
        creepy_rosy_text("...")
        creepy_rosy_text("but")
        creepy_rosy_text("you like kris better\ndon't you...?")
        c:wait(1)
        creepy_rosy_text("honestly\ni don't blame you...")
        c:wait(1)
        creepy_rosy_text("kris is good\nat listening.")
        creepy_rosy_text("but")
        creepy_rosy_text("i'm a good listener too\nyou know...?")
        c:wait(1)
        creepy_rosy_text("and")
        creepy_rosy_text("and they don't LOVE YOU\nthe way i do...")
        creepy_rosy_text("they're\nnaughty.")
        creepy_rosy_text("they\ndisobey.")
        creepy_rosy_text("they\ndon't know their place.")
        creepy_rosy:shake()
        c:wait(1)
        creepy_rosy_text("if")
        creepy_rosy_text("if you're not gonna\nplay with me...")
        creepy_rosy_text("then...")
        creepy_rosy_text("i'll give you\na gift.")
        Game.world.music:stop()
        c:wait(1)
        creepy_rosy_text("kris...")
        creepy_rosy_text("from now on...?")
        Game.world.music:play("mus_dr_tinnitus")

        creepy_rosy:setAnimation({"effects/creepy_rosy/creepy", 0.25, false})
        Assets.playSound("happy_WAAHHH", nil, 0.2)
        creepy_rosy_text("[noskip]YOU SHOULD\nDO AS YOU'RE TOLD.[wait:60]", true)

        rosy:remove()
        rosy_vine:remove()
        creepy_rosy:remove()
        background:fadeIn()

        c:startEncounter("rosy")
    end,

    ---@param c WorldCutscene
    END = function(c, event)
        c:fadeOut(2)
        c:wait(2)

        if Game:getFlag("ending", 0) == 0 then
           Game:setFlag("ending", 1) -- Make normal ending.
        end

        Game:addPartyMember("susie")
        Game:addPartyMember("ralsei")

        c:loadMap("dw_church/initial", "kris_return")
        Game.world.music:pause()
        Game.world.map:getTileLayer("book_retrieved").visible = true

        local kris = c:getCharacter("kris")
        local susie = c:getCharacter("susie")
        local ralsei = c:getCharacter("ralsei")

        susie:setFacing("left")
        kris.x = kris.x - 20
        susie.x = kris.x + 40
        susie:setSprite("kneel_heal")
        kris:setSprite("landed_1")

        --ralsei:setSprite("walk_head_down")
        ralsei.x = kris.x - 340

        c:fadeIn(0.1)
        c:setSpeaker(susie)
        c:text("* Kris![wait:4] Hey, Kris![wait:4] Y...\nyou okay!?", "surprise_frown")
        c:text("* You were just standing\nthere,[wait:4] with your eyes\nclosed...", "frown_down")
        c:text("* Then you just started...[wait:4]\nbreathing hard, and...", "surprise")
        c:text("* Here,[wait:4] get up.", "sad_smile_down")
        c:wait(0.5)
        kris:shake()
        kris:setFacing("down")
        kris:setSprite("walk")
        susie:setSprite("look_down_right")
        c:wait(2)
        susie:setSprite("walk")
        ralsei:walkTo(kris.x - 80, kris.y, 1)
        c:wait(1)

        ralsei:alert(1, {play_sound = false})
        c:text("* Ralsei, where the heck\nwere you?", "teeth")

        c:setSpeaker(ralsei)
        c:text("* H-huh?[wait:4] I was...[wait:4] um...[wait:4]\nI...", "strained")

        c:setSpeaker(susie)
        c:text("* I got the puzzle\nsolution,[wait:4] let's just go!", "annoyed")
        c:interpolateFollowers()
    end,
}
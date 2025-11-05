return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param c WorldCutscene
    BEGINNING = function(c, event)

        -------------------------------------------------------------
        --- INIT
        -------------------------------------------------------------

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

        local kris = Game.world:getCharacter("kris")
        local susie = Game.world:getCharacter("susie")
        local ralsei = Game.world:getCharacter("ralsei")

        kris.alpha, susie.alpha, ralsei.alpha = 0, 0, 0

        local unsupported_os = not (love.system.getOS() == "Windows" or love.system.getOS() == "OS X")

        local save_warning_first_line =
                "Could not locate Chapter 1 completion data.\n\n"..
                "While not explicitly required, this program is intended for players who have completed DELTARUNE up to Chapter 4.\n\n"..
                "Additional small features are unlocked for those who have DELTARUNE completion data on their system."
        local save_warning_second_option = "PLAY DELTARUNE"
        if unsupported_os then
            save_warning_first_line =
                "You have a currently unsupported OS! ("..love.system.getOS()..")\n\n"..
                "You are still able to play, but some small features may not be available to you, due to not being able to access your DELTARUNE save file."
            save_warning_second_option = "       QUIT     "
        end

        if DR_save == nil or unsupported_os == true then
            local chosen
            local save_warning = Text(
                save_warning_first_line,

                SCREEN_WIDTH, 20, 540, nil, { auto_size = true, align = "center" }
            )
            save_warning.alpha = 0
            save_warning:setOrigin(0.5, 0)
            Game.world:addChild(save_warning)
            Game.world.timer:tween(0.5, save_warning, { alpha = 1 }, "linear")

            local save_warning_choicer = GonerChoice(SCREEN_WIDTH/2, 380, {
                {{"   CONTINUE",0,0},{"<<"},{">>"},{save_warning_second_option,360,0}}
            }, function(choice)
                chosen = choice
            end)
            save_warning_choicer:setOrigin(0.5)
            save_warning_choicer:setSelectedOption(2, 1)
            save_warning_choicer:setSoulPosition(240, 0)

            Game.stage:addChild(save_warning_choicer)
            
            c:wait(function() return chosen ~= nil end)
            Assets.playSound("AUDIO_APPEARANCE")
            Game.world.timer:tween(0.4, save_warning, { scale_x = 1.1 }, "in-out-quad")
            c:wait(0.4)
            Game.world.timer:tween(0.6, save_warning, { scale_x = 0, alpha = 0 }, "in-out-quad")
            c:wait(1.0)
            if chosen == save_warning_second_option then
                if save_warning_second_option == "PLAY DELTARUNE" then
                    love.system.openURL("https://deltarune.com/")
                end
                Kristal.returnToMenu()
            end
            c:wait(1.0)
        end

        if (love.filesystem.getInfo("saves/"..Mod.info.id.."/RESET") == nil) then

            local function intro_text(input, auto)
                local pengu = DialogueText("[speed:0.5][voice:none]" + input, SCREEN_WIDTH/2, 85, 400, nil, {auto = true, align = "center"})
                pengu.origin_x = 0.5
                Game.world.stage:addChild(pengu)

                if auto ~= true then
                    c:wait(function()
                        return (Input.pressed("confirm") or Input.down("ctrl")) and not pengu:isTyping()
                    end)
                    pengu:remove()
                    if Input.down("ctrl") ~= true then
                        c:wait(1.25)
                    else
                        c:wait(0.1)
                    end
                else
                    c:wait(function()
                        return not pengu:isTyping()
                    end)
                    pengu:remove()
                end
            end

            Game.world.music:play("mus_dr_tinnitus", 0.05)

            c:wait(2)
            intro_text("The ringing never stops now.")
            intro_text("An incessant little thing.")
            intro_text("Only hours have passed, and yet you already feel as if you will never be the same.")
            intro_text("You have buried it all you could.")
            intro_text("And yet...")
            Game.world.music:stop()
            intro_text("It's still all you can think of.")

            Game.world.music:play("mus_rt_memory_yesterday", 1)

            c:wait(2)

            local noelle = Sprite("effects/intro/noelle", SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
            noelle.layer = -10
            noelle:setOrigin(0.5)
            noelle.alpha = 0
            noelle:setScale(2)
            Game.stage:addChild(noelle)
            Game.world.timer:tween(1, noelle, {alpha = 1})

            local rose = Sprite("effects/intro/spr_rose", SCREEN_WIDTH/2, SCREEN_HEIGHT/2 + 20)
            rose.layer = -9
            rose:setOrigin(0.5)
            rose:setScale(2)

            intro_text("Noelle.")

            Game.world.timer:after(1.8, function()
                Assets.playSound("ominous_stab_harsh", 0.7)
                rose:play(0.1, false)
                Game.stage:addChild(rose)
            end)
            intro_text("[noskip]Her little heart[wait:7]\n\n\n\n\n\n\n\nwas shattered today.")
            intro_text("A foul deed.")
            intro_text("Even fouler\n\n\n\n\n\n\nthan you originally thought.")
            intro_text("As, her heart was sinew\n\n\n\n\n\n\nthat ensured the integrity of this world.")
            intro_text("With this foul act,\n\n\n\n\n\n\n\nthe world adjusts itself.")
            Game.world.timer:tween(1, noelle, {alpha = 0})
            rose:addFX(ShaderFX(Mod.grayShader))
            intro_text("The story\n\n\n\n\n\n\n\nshifts.")
            intro_text("Even if\n\n\n\n\n\n\n\nonly slightly.")
            intro_text("And with it,\n\n\n\n\n\n\n\nreality itself is damaged.")


            local memoryhead_a
            local memoryhead_b
            local memoryhead_c
            Game.world.timer:after(1, function()
                local function memoryhead(offset_x, offset_y)
                    local memoryhead_sprite = Sprite("effects/intro/memoryhead", SCREEN_WIDTH/2 + offset_x, SCREEN_HEIGHT/2 + offset_y)
                    memoryhead_sprite.layer = -5
                    memoryhead_sprite:setOrigin(0.5)
                    memoryhead_sprite.alpha = 0
                    memoryhead_sprite:setScale(0)
                    Assets.playSound("amalgam_noise", 0.1, MathUtils.random(0.7, 1.05))
                    Game.world.timer:tween(1, memoryhead_sprite, {alpha = 1, scale_x = 2, scale_y = 2})
                    Game.stage:addChild(memoryhead_sprite)
                    return memoryhead_sprite
                end
                Game.world.timer:script(function(wait)
                    memoryhead_a = memoryhead(-40, 20)
                    wait(0.2)
                    memoryhead_b = memoryhead(40, -20)
                    wait(0.2)
                    memoryhead_c = memoryhead(40, 40)
                end)
            end)
            intro_text("[noskip]Interlopers[wait:10] slip through\n\n\n\n\n\n\n\nthe cracks in reality.")
            intro_text("Using the light of your SOUL\n\n\n\n\n\nas their\nguide.")
            intro_text("They now stick\n\n\n\n\n\n\n\nto the back of your mind.")
            intro_text("Latching onto old memories\n\n\n\n\n\n\nyou could\nnever forget.")
            intro_text("Truly righting this wrong\n\n\n\n\n\n\n\nmay be impossible...")

            Game.world.timer:tween(1, memoryhead_a, {alpha = 0})
            Game.world.timer:tween(1, memoryhead_b, {alpha = 0})
            Game.world.timer:tween(1, memoryhead_c, {alpha = 0})
            Game.world.timer:tween(1, rose, {alpha = 0})

            intro_text("But, should these interlopers change the story any further...")

            intro_text("You may never be alone agai", true)
        end

        Game.world:loadMap("dw_church/initial")
        
        kris = Game.world:getCharacter("kris")
        susie = Game.world:getCharacter("susie")
        ralsei = Game.world:getCharacter("ralsei")

        Game.world.music:seek(50)

        kris:setFacing("right")
        
        kris.x = kris.x + 60

        susie:setFacing("left")
        susie.x = kris.x + 50

        ralsei:setSprite("walk_sad/right_1")
        ralsei:setFacing("right")
        ralsei.x = kris.x - 40

        c:setSpeaker(susie)
        c:text("* Hellooo...?", "suspicious")
        c:text("* Earth to dumbasses?", "teeth_b")
        Assets.playSound("sussurprise")
        susie:shake()
        susie:setSprite("exasperated_left")
        c:text("* Dozing off[wait:4][sound:whip_crack_only] AGAIN?", "teeth_b")

        kris:shake()
        ralsei:shake()
        ralsei:setSprite("walk")
        Assets.playSound("wing")
        ralsei:walkTo(ralsei.x + 1, ralsei.y, 1)
        c:setSpeaker(ralsei)
        c:text("* [noskip]Huh? What? Who? Where? How? When? Where? Who?[wait:4]", "surprise_confused", nil, {auto = true})
        ralsei:setFacing("right")
        c:text("* I...", "blush_shy")
        c:text("* I must've...", "blush_shy")
        c:text("* I apologize,[wait:4] Susie...", "blush_surprise")
        c:text("* I'm just...", "smile_side")
        c:text("* I'm just a little tired is all.", "strained")

        
        susie:setSprite("walk")
        susie:shake()
        c:setSpeaker(susie)
        c:text("* Do you ever... sleep?..", "suspicious")

        c:setSpeaker(ralsei)
        c:text("* Oh,[wait:4] of course I do!", "pleased")
        c:text("* A good [func:pause]7[wait:30][func:play] minutes every night.", "wink", nil, {functions = {
            pause = function()
                ralsei:setFacing("down")
                Game.world.music:pause()
            end,
            play = function()
                ralsei:setFacing("right")
                Game.world.music:play()
            end
        }})
        c:text("* That's normal,[wait:4] right...?", "pleased")

        c:setSpeaker(susie)
        c:text("* ...", "sus_nervous")
        Assets.playSound("sussurprise")
        susie:shake()
        kris:shake()
        susie:setSprite("exasperated_left")
        c:text("* ...and what's your excuse,[wait:4] huh?!", "teeth_b")
        c:text("* We must've slept like...[wait:4] 3 hours last night, Kris!", "teeth_b")
        c:text("* That's normal,[wait:4] right?!", "teeth_b")

        local choice = c:choicer({"Beauty\nsleep", "Shut Up"})
        if choice == 1 then
            susie:shake()
            susie:setSprite("walk")
            c:text("* ...", "sus_nervous")
            susie:setSprite("away")
            c:text("* Well,[wait:4] now that you mention it,[wait:4] I guess you do look pretty good...", "sus_nervous")
            Game.world.music:fade(0.2, 0.5)
            Game.world.timer:tween(4, Game.world.camera, {zoom_x = 2, zoom_y = 2})
            c:text("[speed:0.5][noskip]* Do you think...[wait:20] maybe if I tried that I could...[wait:40]", "sincere", {auto = true, wait = false, advance = false})
            Game.world:removeChild(c.textbox)
            Game.stage:addChild(c.textbox)
            c:wait(4)

            Game.world.music:pause()
            Assets.playSound("record_scratch")
            Game.world.camera:setZoom(1, 1)
            susie:shake()
            susie:setSprite("shock_left")
            c:text("* Wait.", "shock")
            susie:shake()
            susie:setSprite("walk")
            c:text("* We probably need to get a move on.", "sus_nervous")
            c:text("* We, uh...[wait:4] have fountains to close and everything...", "nervous")

            c:setSpeaker(ralsei)
            c:text("* Y-Yes.[wait:10]\n* I think that would be a good idea,[wait:4] Susie.", "pleased")
            Game.world.music:play()
            Game.world.music:fade(1, 1)
        elseif choice == 2 then
            Assets.playSound("ominous_sting")
            Game.world.music:stop()
            kris:shake()
            kris:setFacing("up")
            ralsei:shake()
            ralsei:setSprite("surprised_down")
            susie:shake()
            susie:setSprite("shock_left")
            c:text("* ...!", "sad_frown")
            susie:shake()
            susie:setSprite("walk_bangs_unhappy")
            c:text("* ...", "sad")
            c:text("* ...", "bangs_neutral")
            susie:setFacing("up")
            c:text("* Yeah.[wait:10]\n* Whatever.", "bangs_neutral")

            c:setSpeaker(ralsei)
            Assets.playSound("wing")
            ralsei:shake()
            ralsei:setSprite("walk")
            c:text("* I... erm...", "pleased")
            c:text("* Kris probably didn't mean...", "strained")

            c:setSpeaker(susie)
            c:text("* ...", "bangs_neutral")
            c:text("* ...\n[wait:10]* Yeah...", "small_smile_down")
            c:text("* These days have been pretty tough...", "shy_down")
            c:text("* But...", "annoyed_down")

            ralsei:setFacing("right")

                
            Assets.playSound("sussurprise")
            susie:shake()
            susie:setSprite("exasperated_left")
            c:text("* Why is everybody acting so weird!?", "teeth")
            susie:shake()
            susie:setSprite("away")
            c:text("* ...", "sus_nervous")
            susie:shake()
            susie:setSprite("walk")
            c:text("* Anyways, let's go.", "neutral")
            c:text("* We don't have much time.", "neutral_side")
        end

        c:interpolateFollowers()

        Game:setFlag("susie_interaction", choice)

        Game:setFlag("fun", MathUtils.randomInt(1, 100))
        Kristal.saveGame(1)

    end,
    MAINTENANCE = function(c, event)

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

        local DR_ch2_save_1 = DRSaveFile:get(2, 1)
        local DR_ch2_save_1_weird
        if DR_ch2_save_1 then DR_ch2_save_1_weird = DR_ch2_save_1.weird end
        local DR_ch2_save_2 = DRSaveFile:get(2, 2)
        local DR_ch2_save_2_weird
        if DR_ch2_save_2 then DR_ch2_save_2_weird = DR_ch2_save_2.weird end
        local DR_ch2_save_3 = DRSaveFile:get(2, 3)
        local DR_ch2_save_3_weird
        if DR_ch2_save_3 then DR_ch2_save_3_weird = DR_ch2_save_3.weird end

        local DR_ch4_save_1 = DRSaveFile:get(4, 1)
        local DR_ch4_save_1_weird
        if DR_ch4_save_1 then DR_ch4_save_1_weird = DR_ch4_save_1.weird end
        local DR_ch4_save_2 = DRSaveFile:get(4, 2)
        local DR_ch4_save_2_weird
        if DR_ch4_save_2 then DR_ch4_save_2_weird = DR_ch4_save_2.weird end
        local DR_ch4_save_3 = DRSaveFile:get(4, 3)
        local DR_ch4_save_3_weird
        if DR_ch4_save_3 then DR_ch4_save_3_weird = DR_ch4_save_3.weird end

        love.window.setTitle("THE END")

        local kris = Game.world:getCharacter("kris")
        local susie = Game.world:getCharacter("susie")
        local ralsei = Game.world:getCharacter("ralsei")

        kris.alpha, susie.alpha, ralsei.alpha = 0, 0, 0

        Game.world.music:play("AUDIO_DRONE")
        c:wait(3)
        c:GonerTextFull("...")
        c:GonerTextFull("OH.")
        c:GonerTextFull("I DID NOT[wait:10]\nSEE YOU THERE.")

        c:wait(1)

        local hour = os.date("*t").hour
        if hour >= 5 and hour < 12 then
            c:GonerTextFull("GOOD[wait:10]\nMORNING.")
        elseif hour >= 12 and hour < 17 then
            c:GonerTextFull("GOOD[wait:10]\nAFTERNOON.")
        elseif hour >= 17 and hour < 23 then
            c:GonerTextFull("GOOD[wait:10]\nEVENING.")
        else
            c:GonerTextFull("YOU ARE[wait:10]\nUP LATE...")
        end

        if DR_save ~= nil then
            c:GonerTextFull("\""+DR_save.name+".\"")
            
            c:GonerTextFull("SUCH A[wait:10]\nUNIQUE SPECIMEN[wait:10]\nYOU ARE.")
        else
            c:GonerTextFull("I KNOW EXACTLY[wait:10]\nWHY YOU ARE HERE.")
            c:GonerTextFull("BUT...[wait:10]\nCONFUSION PLAGUES ME.")
        end

        c:wait(1)

        c:GonerTextFull("THIS[wait:10]\n\"SCENARIO.\"")
        c:GonerTextFull("THIS[wait:10]\n\"ROUTE.\"")

        if DR_ch4_save_1_weird == true or DR_ch4_save_2_weird == true or DR_ch4_save_3_weird == true then
            c:GonerTextFull("...THAT YOU HAVE[wait:10]\nALREADY TAKEN TO ITS[wait:10]\nZENITH...")
            c:GonerTextFull("DOES IT[wait:10]\nGIVE YOU SUCH\nJOY...")
            c:GonerTextFull("TO[wait:10]\nDIVE[wait:10]\nEVER FURTHER...?")
        else
            if DR_ch2_save_1_weird == true or DR_ch2_save_2_weird == true or DR_ch2_save_3_weird == true then
                c:GonerTextFull("...THAT YOU HAVE[wait:10]\nYET TO EVEN TAKE[wait:10]\nTO ITS ZENITH...")
            else
                c:GonerTextFull("...THAT YOU HAVE[wait:10]\nREFUSED TO[wait:10]\nPARTICIPATE IN...")
            end
            c:GonerTextFull("AND YET...")
            c:GonerTextFull("HERE[wait:10]\nWE[wait:10]\nARE.")
            c:GonerTextFull("EATING[wait:10] THE FRUIT[wait:10]\nOF A TREE[wait:10]\nYOU NEVER PLANTED...")
            c:GonerTextFull("REAPING[wait:10] THE SEEDS[wait:10]\nTHAT YOU REFUSED[wait:10]\nTO SOW...")
        end

        c:GonerTextFull("IS[wait:10]\nTHE PAIN ITSELF[wait:10]\nYOUR REASON...?")
        c:GonerTextFull("THE[wait:10]\nLESSONS[wait:10]\nIT CAN TEACH?")
        if DR_save.gonermaker_pain == true or DR_save.favorite_food == "PAIN" then
            c:GonerTextFull("PERHAPS.")
        else
            c:GonerTextFull("PERHAPS[wait:10]\nNOT.")
        end

        c:wait(1)

        c:GonerTextFull("INTERESTING.")
        c:GonerTextFull("VERY,[wait:10]\nVERY,[wait:10]\nINTERESTING.")
        c:wait(1)
        c:GonerTextFull("I[wait:10]\nAPOLOGIZE FOR[wait:10]\nDALLYING.")
        c:GonerTextFull("THESE[wait:10]\nMOMENTS WE HAVE.")
        c:GonerTextFull("SO[wait:10]\nFRUSTRATINGLY[wait:10]\nFLEETING.")
        c:GonerTextFull("BUT,[wait:10] IT[wait:10]\nIS TIME.")

        love.filesystem.write("saves/"..Mod.info.id.."/RESET", "")
        c:gotoCutscene("DEVICE.MAINTENANCE_AGAIN")

    end,
    ---@param c WorldCutscene
    MAINTENANCE_AGAIN = function(c, event)

        love.window.setTitle("BEGIN AGAIN")

        if Game.world.music.current ~= "AUDIO_DRONE" then
            Game.world.music:play("AUDIO_DRONE")
        end

        local kris = Game.world:getCharacter("kris")
        local susie = Game.world:getCharacter("susie")
        local ralsei = Game.world:getCharacter("ralsei")

        kris.alpha, susie.alpha, ralsei.alpha = 0, 0, 0

        local chosen
        local gonertext = c:GonerText("   SHALL WE\n   BEGIN AGAIN?", false)

        local choicer = GonerChoice(SCREEN_WIDTH/2, 380, {
            {{"RETURN",0,0},{"<<"},{">>"},{"RESET",360,0}}
        }, function(choice)
            chosen = choice
        end)
        choicer:setOrigin(0.5)
        choicer:setSelectedOption(2, 1)
        choicer:setSoulPosition(200, 0)
        
        Game.stage:addChild(choicer)
        
        c:wait(function() return chosen ~= nil end)
            gonertext:remove()
            Game.world.music:stop()
            c:wait(0.5)
            c:fadeOut(4, { color = COLORS.white })
            Assets.playSound("kristal_intro", 2.0, 0.65)
            local Goner_String = TableUtils.pick({
                "AS YOU\nCOMMAND,[wait:10]\nSO IT SHALL\nBE.",
                "EVERY\nPOSSIBILITY.[wait:10]\nALL\nTOMORROWS.",
                "ANOTHER\nTALE.[wait:10]\nANOTHER\nANALYSIS."
            })
            c:GonerText(Goner_String, false)
            c:wait(4)
        if chosen == "RESET" then
            Kristal.callEvent("completeAchievement", "reset")
            Kristal.eraseData("file_1")
            love.filesystem.remove("saves/"..Mod.info.id.."/ENDING")
            love.filesystem.remove("saves/"..Mod.info.id.."/ENDING_ISSUE")
            Kristal.returnToMenu()
        else
            Kristal.loadGame(1)
        end
    end,
}
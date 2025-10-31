return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param c WorldCutscene
    start = function(c, event)

        love.window.setTitle("THE END")

        c:detachFollowers()
        c:detachCamera()

        local kris = c:getCharacter("kris")
        local susie = c:getCharacter("susie")
        local ralsei = c:getCharacter("ralsei")

        kris:walkTo(kris.x - 400, kris.y, 2)
        susie:walkTo(susie.x - 400, susie.y, 2)
        ralsei:walkTo(ralsei.x - 400, ralsei.y, 2)

        c:fadeOut(4)
        Game.world.music:fade(0, 8)
        c:wait(12)

        local ending = Game:getFlag("ending", 0)
        if ending == 1 then
            c:gotoCutscene("ENDING.normal")
        elseif ending == 2 then
            c:gotoCutscene("ENDING.egg")
        else
            c:gotoCutscene("ENDING.stupid")
        end
    end,

    normal = function(c, event)

        local kris = c:getCharacter("kris")
        local susie = c:getCharacter("susie")
        local ralsei = c:getCharacter("ralsei")

        -- c:setSpeaker(susie)
        -- c:text("* You got the normal ending, nerd.", "nervous")

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

        
        Game.world.music:play("mus_dr_tinnitus", 0.05, 0.7)

        c:wait(2)
        intro_text("As you thought.")
        intro_text("The ringing never stops.")
        intro_text("But...")
        intro_text("It grew duller.")
        intro_text("Even just that tiny bit.")
        intro_text("Perhaps you can fix it after all.")
        intro_text("You just need...")
        
        Kristal.callEvent("completeAchievement", "ending_normal")
    
        intro_text("...a bit of help...")

        Game.world.music:fade(0, 1)
        c:wait(1)

        c:gotoCutscene("ENDING.wrap_up")
    end,

    egg = function(c, event)

        local kris = c:getCharacter("kris")
        local susie = c:getCharacter("susie")
        local ralsei = c:getCharacter("ralsei")

        c:setSpeaker(susie)
        c:text("* You got the egg ending, nerd.", "nervous")

        Kristal.callEvent("completeAchievement", "ending_egg")

        c:gotoCutscene("ENDING.wrap_up")
    end,

    stupid = function(c, event)

        local kris = c:getCharacter("kris")
        local susie = c:getCharacter("susie")
        local ralsei = c:getCharacter("ralsei")

        c:setSpeaker(susie)
        c:text("* Uh...[wait:4] Kris?", "nervous")
        c:text("* Why did we walk in there just to walk right back out?", "nervous_side")
        Assets.playSound("whip_crack_only")
        c:text("* Are you stupid?", "teeth_b")
        c:choicer({"Yes", "Yes"})
    
        Kristal.callEvent("completeAchievement", "ending_stupid")
        
        c:text("* Ugh...[wait:10]\n* Oh brother...", "sus_nervous")
        if Game:getFlag("fun") >= 40 and Game:getFlag("fun") < 50 then
            c:text("* Hey.[wait:4] Ralsei.", "neutral_side")

            c:setSpeaker(ralsei)
            c:text("* H-Huh?", "blush_surprise")

            c:setSpeaker(susie)
            c:text("* Are we like...[wait:8]\n[speed:0.7]ACTUALLY[speed:1] the \"heroes of legend\" or whatever?", "suspicious")
            c:text("* 'Cause I'm starting to feel punked.", "nervous")

            c:setSpeaker(ralsei)
            c:text("* What kind of question is that,[wait:5] Susie...?", "strained")
            c:text("* Of course we are!", "wink")
            c:text("* We might have bumps along the way,[wait:5] but...", "smile_side")
            c:text("* Everything I've seen up until this point has only...", "pleased")
            c:text("* Erm...[wait:5] has only...[wait:5] confirmed that it's true.", "strained")

            c:setSpeaker(susie)
            c:text("* Well,[wait:5] I guess if you say so...", "nervous_side")
        else
            c:text("* Whatever.", "nervous_side")
        end

        c:gotoCutscene("ENDING.wrap_up")
    end,

    wrap_up = function(c, event)
        c:wait(2)

        Game.world.timer:every(0, function()
            if Input.pressed("confirm") and Game.world.sent ~= true then
                Game.world.sent = true
                love.system.openURL("https://github.com/DEVICE-TEAM/specil_emeny")
            end
        end)

        Game.world.music:play("mus_rt_memory_tomorrow", 1)
        local CREDITS = Text(
            "[color:yellow]Developer\n[color:white]The Stranger\n\n" +

            "[color:yellow]Contributors\n[color:white]Gilbert Jones\n\n"+
            "[color:yellow]Quality Assurance\n[color:white]Gilbert Jones\nel losos\n\n"+

            "[color:yellow]Assets & Libraries Used\n[color:white]" +
            "Toby Fox\nTemmie Chang\nThe DELTARUNE Team\n" +
            "Hyperboid\nDiamond Deltahedron\nArlee\n" +
            "Ashywalker\nSciSpace\nAcousticJamm\nBrendaK7200\n" +
            "Vitellary\nyeetussnoopy\nhamstopher_again\nMihBoss\n" +
            "levi dev\nThe Kristal Team\nThe Entire Kristal Discord Server\n\n"+

            "[color:yellow]Inspiration & Special Thanks\n[color:white]" +
            "Dorked / Inverted Fate\nBeethovenus / TS!UNDERSWAP\n" +
            "Toby Fox\n\n" +
            "[color:#777777](Press Confirm to see more detailed Credits...)"
            ,
            SCREEN_WIDTH/2, 500, 1000, nil, { auto_size = true })
        CREDITS:setOrigin(0.5, 0)
        Game.stage:addChild(CREDITS)
        Game.world.timer:tween(80, CREDITS, { y = CREDITS.height * -1 }, "linear")
        c:wait(80)
        

        Game.world.music:fade(0, 5)
        c:wait(5)

        love.filesystem.write("saves/"..Mod.info.id.."/ENDING", "")
        Kristal:returnToMenu()
    end
}
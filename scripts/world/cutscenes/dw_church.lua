return {
    ---@param c WorldCutscene
    initial = function(c, event)

        c:detachCamera()
        c:detachFollowers()

        local kris = c:getCharacter("kris")
        local susie = c:getCharacter("susie")
        local ralsei = c:getCharacter("ralsei")

        c:setSpeaker(susie)
        Game.world.music:fade(0, 1)

        c:text("* So,[wait:3] that,[wait:3] uh,[wait:3] piano\nthingy...", "neutral_side")
        c:text("* ... maybe the notes we\ngotta play are in a book?", "smirk")
        c:wait(1)

        kris:walkTo("kris_lookbook", 1, "up")
        susie:walkTo("susie_lookbook", 1.5, "up")
        ralsei:walkTo("ralsei_lookbook", 1.7, "up")

        c:panTo(Game.world.camera.x + 300, Game.world.camera.y, 2)
        c:wait(2)
        susie:setSprite("away")
        c:wait(1)
        susie.flip_x = true
        susie.x = susie.x - 20
        c:wait(1)
        susie.flip_x = false
        susie.x = susie.x + 20
        susie:setSprite("walk")
        susie:alert(0.5, {play_sound = false})
        c:wait(0.5)

        susie:setFacing("left")
        kris:setFacing("right")
        ralsei:setFacing("right")

        c:text("* Hey guys![wait:5] There's\nsomething weird about\nthis one!", "surprise")

        susie:setFacing("up")
        c:text("* It looks just like the\none that the old man...", "small_smile_down")
        c:text("* ...", "annoyed_down")

        c:wait(0.5)
        susie:setSprite("reach_up_1")
        Game.world.timer:tween(0.25, susie, {y = susie.y - 40}, "out-quad", function()
            Assets.playSound("grab")
            Game.world.map:getTileLayer("book_retrieved").visible = true
            Game.world.timer:tween(0.25, susie, {y = susie.y + 40}, "in-quad", function()
                susie:setSprite("walk")
            end)
        end)
        c:wait(1)

        Assets.playSound("locker")
        Game.world.map:getTileLayer("door_open").visible = true
        susie:setFacing("right")
        c:shakeCamera()

        c:wait(1)
        c:text("* Hey,[wait:4] look,[wait:4] it did\nsomething!", "surprise_smile")

        c:wait(0.5)

        kris:walkTo(kris.x + 140, kris.y, 0.7)
        susie:walkTo(susie.x + 110, susie.y, 0.5)
        ralsei:walkTo(ralsei.x + 140, ralsei.y, 0.7)

        c:wait(0.5)
        susie:walkTo(susie.x, susie.y - 80, 0.5)
        c:wait(0.25)
        Game.world.timer:tween(0.1, susie, {alpha = 0}, "linear", function()
            Game:removePartyMember("susie")
        end)

        c:wait(2)

        c:setSpeaker(ralsei)
        c:text("* ...", "small_smile_side_b")
        ralsei:walkTo(ralsei.x + 40, ralsei.y, 0.4)
        kris:setFacing("left")
        c:text("* Kris,[wait:4] rather than\nfollowing her...", "smile")
        ralsei:setSprite("walk_sad/right_1")
        c:text("* Why don't we just...[wait:10]\nclose our eyes...", "pleased")
        ralsei:setSprite("walk")
        c:text("* And think about what she\nmight be doing in there?", "pleased")

        local havent_proceeded
        local choice
        repeat
            choice = c:choicer({"Sure", "Seems\nunnecessary"})
            if choice ~= 2 then
                c:text("* ...", "strained")
                if not havent_proceeded then
                    c:text("* Were you...[wait:10] going to say something,[wait:4] Kris?", "strained")
                    havent_proceeded = true
                end
            end
        until choice == 2

        ralsei:walkTo(ralsei.x - 40, ralsei.y, 0.4, "right", true)
        c:wait(0.25)
        c:text("* H-huh?[wait:4] But,[wait:4] you know,[wait:4]\nSusie might want to\nbe...", "pleased")
        c:text("* It,[wait:4] it might be nice if\nshe had this chance\nto...", "surprise_neutral")
        ralsei:setFacing("up")
        c:text("* ...", "pensive")
        ralsei:walkTo(ralsei.x + 40, ralsei.y, 0.4)
        c:text("* Perhaps if you just\nclosed them for a\nmoment?", "pleased")

        repeat
            choice = c:choicer({"Close eyes\nfor just a\nmoment", "Don't"})
            if choice ~= 2 then
                c:text("* ...", "strained")
            end
        until choice == 2

        c:text("* ...", "pleased")
        ralsei:setFacing("up")
        c:text("* Perhaps if you just,[wait:4]\nclosed your eyes in\ngeneral?", "pleased")
        ralsei:setFacing("right")
        c:text("* Maybe we could think of\nsomeone else?", "pleased")

        repeat
            choice = c:choicer({"No", "Think of\nThe Knight", "Think of ????"})
            if choice ~= 3 then
                c:text("* ...", "strained")
            end
        until choice == 3

        c:fadeOut(4)

        c:wait(3.5)
        ralsei:walkTo(ralsei.x - 400, ralsei.y, 2)
        c:wait(2)
        Game:removePartyMember("ralsei")
        c:wait(1)
        c:loadMap("dw_church/nightmare")
        c:fadeIn(0)

    end,
}
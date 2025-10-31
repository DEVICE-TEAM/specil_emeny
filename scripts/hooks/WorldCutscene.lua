local Cutscene, super = Class(WorldCutscene)

function Cutscene:GonerText(str, advance)
    local text = DialogueText("[speed:0.3][spacing:6][style:GONER][voice:none]" .. str, 160, 100, 640, 480,
                        { auto_size = true })
    text.layer = WORLD_LAYERS["top"] + 100
    text.skip_speed = true
    text.parallax_x = 0
    text.parallax_y = 0

    Game.stage:addChild(text)

    if advance ~= false then
        self:wait(function () return not text:isTyping() end)
        self:wait(1)
        self:GonerTextFade(true, text)
    end
    return text
end

function Cutscene:GonerTextFade(wait, text)
    Game.world.timer:tween(1, text, { alpha = 0 }, "linear", function ()
        text:remove()
    end)
    if wait ~= false then
        self:wait(1.5)
    end
end


function Cutscene:GonerTextFull(input)
    local text = self:GonerText(input, false)
    self:wait(function()
        return Input.pressed("confirm") and not text:isTyping()
    end)
    self:GonerTextFade(true, text)
end


return Cutscene
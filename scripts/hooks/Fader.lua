--- A Fader is an Object that can be used to fade the screen in and out, usually using the instance stored at [`Game.fader`](lua://Game.fader) \
--- Modifying the fader's `width`, `height`, `x`, and `y` values can make it only affect a portion of the screen
---@class Fader : Object
---
---@field width number
---@field height number
---
---@field fade_color table
---@field alpha number
---
---@field state string
---@field callback_function fun()
---
---@field default_speed number
---@field speed number
---
---@field music Music?
---@field debug_select boolean
---@field blocky boolean
---
---@overload fun(...) : Fader
local Fader, super = Class(Fader)

function Fader:update()
    if self.state == "FADEOUT" then
        self.alpha = self.alpha + (DT / self.speed)
        if (self.alpha >= 1) then
            self.alpha = 1
            self.state = "NONE"
            if self.callback_function then
                self.callback_function()
            end
            self.callback_function = nil
        end
    end
    if self.state == "FADEIN" then
        self.alpha = self.alpha - (DT / self.speed)
        if (self.alpha <= 0) then
            self.alpha = 0
            self.state = "NONE"
            if self.callback_function then
                self.callback_function()
                self.callback_function = nil
            end
        end
    end
    if self.state == "NONE" then
        -- Bug Fix.
        -- self:setColor(0, 0, 0)
        -- self.fade_color = self.color
    end
end

return Fader
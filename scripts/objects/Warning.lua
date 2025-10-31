local Warning, super = Class(Object)

function Warning:init(x, y, width, height, input_time)
    super.init(self, x, y, width or Game.battle.arena.width - 8, height or Game.battle.arena.height - 8)
    self:setOrigin(0.5, 0.5)

    Game.battle.timer:after(input_time or 1, function()
        self:remove()
    end)
end

function Warning:draw()
    super.draw(self)

    Draw.setColor(((RUNTIME/0.15)%1>.5) and COLORS.red or COLORS.yellow)

    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 0, 0, self.width, self.height)

    local unit = 10

end

return Warning
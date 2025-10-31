local TensionBar, super = Class(TensionBar)

function TensionBar:getBackColor()
    if self:hasReducedTension() then
        return PALETTE["tension_back_reduced"]
    elseif Game.battle.encounter.fear_tp == true then
        return { 0.05, 0.05, 0.05, 1 }
    else
        return PALETTE["tension_back"]
    end
end

function TensionBar:drawBack()
    Draw.setColor(self:getBackColor())
    Draw.pushScissor()
    Draw.scissorPoints(0, 0, 25, 196 - (self:getPercentageFor250(self.current) * 196) + 1)
    Draw.draw(self.tp_bar_fill, 0, 0)
    Draw.popScissor()
end

function TensionBar:getFillColor()
    if self:hasReducedTension() then
        return PALETTE["tension_fill_reduced"]
    elseif Game.battle.encounter.fear_tp == true then
        return { 1, 0, 0, 1 }
    else
        return PALETTE["tension_fill"]
    end
end

function TensionBar:getFillMaxColor()
    if self:hasReducedTension() then
        return PALETTE["tension_max_reduced"]
    elseif Game.battle.encounter.fear_tp == true then
        return { 0, 0, 0, 1 }
    else
        return PALETTE["tension_max"]
    end
end

function TensionBar:getFillDecreaseColor()
    if self:hasReducedTension() then
        return PALETTE["tension_decrease_reduced"]
    elseif Game.battle.encounter.fear_tp == true then
        return { 1, 0.1, 0.1, 1 }
    else
        return PALETTE["tension_decrease"]
    end
end

return TensionBar

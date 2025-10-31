local map, super = Class(Map)

function map:onEnter()
    super.onEnter(self)

    if Game:getFlag("nightmare.field") ~= true then
        Game:setFlag("nightmare.field", true)
        Kristal.saveGame(1)
    end

end

return map

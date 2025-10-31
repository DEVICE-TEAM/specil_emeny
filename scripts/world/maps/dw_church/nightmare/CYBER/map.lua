local map, super = Class(Map)

function map:onEnter()
    super.onEnter(self)

    if Game:getFlag("nightmare.cyber") ~= true then
        Game:setFlag("nightmare.cyber", true)
        Kristal.saveGame(1)
    end

end

return map

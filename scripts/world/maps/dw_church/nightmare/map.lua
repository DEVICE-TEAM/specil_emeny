local map, super = Class(Map)

function map:onEnter()
    super.onEnter(self)

    if Game:getFlag("nightmare.tv") ~= true then
        Game:setFlag("nightmare.tv", true)
        Kristal.saveGame(1)
    end

end

return map

local map, super = Class(Map)

function map:onEnter()
    super.onEnter(self)

    Game.world.map:getTileLayer("book_retrieved").visible = false
    Game.world.map:getTileLayer("door_open").visible = false

end

return map

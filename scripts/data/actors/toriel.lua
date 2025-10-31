local Toriel, super = Class(Actor, "toriel")

function Toriel:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Toriel"

    -- Sound to play when this actor speaks (optional)
    self.voice = "toriel"

end

return Toriel
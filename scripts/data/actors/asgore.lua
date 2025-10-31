local Asgore, super = Class(Actor, "asgore")

function Asgore:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Asgore"

    -- Sound to play when this actor speaks (optional)
    self.voice = "asgore"

end

return Asgore
local Patience, super = Class(Actor, "patience")

function Patience:init()
    super.init(self)

    -- Sound to play when this actor speaks (optional)
    self.voice = "patience"

end

return Patience
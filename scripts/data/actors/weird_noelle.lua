local Noelle, super = Class(Actor, "weird_noelle")

function Noelle:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Noelle"

    self.width = 46
    self.height = 46

    self.path = "npcs/weird_noelle"

    self.default = "sit"

    self.voice = "noelle"

    self.portrait_path = "face/weird_noelle"
    self.portrait_offset = {-12, -10}
end

return Noelle
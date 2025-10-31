local actor, super = Class(Actor, "rosy")

function actor:init()
    super.init(self)

    self.name = "Rosy"

    self.width = 32
    self.height = 26
    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.path = "npcs/rosy"

    if Game.battle then
        self.default = "idle"
    else
        self.default = "rise"
    end

    self.portrait_path = "face/rosy/dark"
    self.portrait_offset = {-24, -18}

    self.voice = "rosy"

    self.animations = {
        ["rise"] = {"rise", 0.10, false, next="default"},
        ["sink"] = {"sink", 0.10, false},
        ["default"] = {"default", 1, true},
        ["look_left"] = {"look_left", 1, true},
        ["happy"] = {"happy", 1, true},
        ["happy_slam"] = {"happy_slam", 1/30, true},

        ["idle"] = {"battle/idle", 1/20, true},
        ["hurt"] = {"battle/hurt", 1/10, false, "idle"},
        ["hurt_real"] = {"battle/hurt_real", 1, false, "idle"},
        ["self_care"] = {"battle/self_care", 1, false, "idle"},
    }

    self.offsets = {
        ["rise"] = {0, 8},
        ["sink"] = {0, 8},
        ["default"] = {0, 8},
        ["look_left"] = {0, 8},
        ["happy"] = {0, 8},
        ["happy_slam"] = {-7, 8},
        ["happy_lookaway"] = {0, 8},
        ["confused"] = {0, 8},

        ["wink"] = {0, 8},

        
        ["crocs"] = {-7, 8},
        ["crocs_jump"] = {-7, 0},


        ["battle/idle"] = {0, 8},
        ["battle/hurt"] = {0, 8},
        ["battle/hurt_real"] = {0, 8},
        ["battle/self_care"] = {-4, 8},
        ["battle/poor_widdue_kris"] = {0, 8},
        ["battle/gimme_a_break"] = {0, 8},
        ["battle/eyes_closed"] = {0, 8},

    }

end

return actor
local item, super = Class(HealItem, "blue_raspberry")

function item:init()
    super.init(self)

    self.type = "item"
    self.name = "BlueRaspbry"

    self.price = 30
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.heal_amount = 50

    self.effect = "Heals\n" .. self.heal_amount .. "HP"
    self.shop = "Hard blue\nfruit,\nheals " .. self.heal_amount .. "HP"
    self.description = "The mythical blue raspberry. Neon blue, and hard as a rock, but delicious. +" .. self.heal_amount .. "HP"

    self.reactions = {
        -- DELTARUNE
        kris = {
            susie = "HEY! Let ME have some!",
            noelle = "Fahaha! You'll chip your teeth!",
        },
        susie = "OH, HELL YEAH!!",
        ralsei = "Interesting! A unique flavor!",
        noelle = "It's the size of my fist...",

        -- ROSY-TROVE
        riley = "Interesting.",
        kel = "Gonna have to brush twice later...",
        barry = "Barry approved.",
        scuti = "It's like hard candy..?",
        kepler = "I love boiled sweets!",
        helvetica = "HMPH... IT'S GOOD, I GUESS...",
    }

    -- BLUER RASPBERRY
    if (Mod.info.name == "ROSY-TROVE" and Game:getFlag("dw_completed", 0) >= 3) or Game:getConfig("darkCandyForm") == "darker" then
        self.name = "BluerRaspbry"
        self.heal_amount = 130
        self.price = 200
        self.description = "The blue grew. Still chips your teeth. Should probably just suck on it. +" .. self.heal_amount .. "HP"
        self.effect = "Heals\n" .. self.heal_amount .. "HP"
        self.shop = "Hard blue\nfruit,\nheals " .. self.heal_amount .. "HP"
    end
end

return item
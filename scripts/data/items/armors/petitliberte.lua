local item, super = Class(Item, "petitliberte")

function item:init()
    super.init(self)

    -- Display name
    self.name = "PetitLiberté"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Raggedy old beret called the 'little liberty.' Reduced damage against Shadow Crystal holders."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 0,
        defense = 3,
        magic = 3,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "ResistLiberty"
    self.bonus_icon = "ui/menu/icon/down"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = false,
        helvetica = false,

        barry = false
    }

    -- Character reactions
    self.reactions = {
        -- DELTARUNE
        susie = "Nope. Not after what happened in 3rd grade.",
        ralsei = "I'm something of an artist myself...",
        noelle = "Remember youth group, Kris?",

        -- ROSY-TROVE
        riley = "Freedom, eh...?",
        kel = {
            riley = "...at ease.",
            kel = "Colonel Keplie, reporting for duty!"
        },
        barry = "It can't be known to me.",
        scuti = "Th-thanks..!",
        kepler = "It's a bit of a fixer-upper...",
        helvetica = "NOPE. NOT AFTER WHAT HAPPENED IN 3RD GRADE.",
    }
end

return item
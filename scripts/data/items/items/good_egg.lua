local item, super = Class(Item, "good_egg")

-- YOU HAVE FOUND MY SECRET PLACE!

function item:init()
    super.init(self)

    -- Display name
    self.name = "Egg"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Not too important, not too unimportant."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {}
end

function item:getBattleText(user, target)
    Game.battle.music:stop()
    Assets.playSound("egg")
    -- Game.battle:startCutscene("rosy_battle", "egg")
    return {"* (You used the Egg.)"}
end

return item
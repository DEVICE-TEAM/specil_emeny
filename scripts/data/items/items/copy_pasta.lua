local item, super = Class(HealItem, "copy_pasta")

-- In battle, heals the amount of the last thing you ate in battle.
-- In the world, heal a scripted amount for STORY purposes. 💯💯💯💯💯💯
-- In ROSY-TROVE itself, the world healing amount will be based on Light items consumed in the Light World.
-- But, when ported to other projects, the world heal amount will be scripted.

function item:init()
    super.init(self)

    self.type = "item"
    self.name = "CopyPasta"

    self.price = 250
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.heal_amount = 10
    self.world_heal_amounts = {
        -- DELTARUNE
        ["kris"] = self.heal_amount,
        ["susie"] = 300,
        ["ralsei"] = self.heal_amount,
        ["noelle"] = 80,

        -- ROSY-TROVE
        ["riley"] = 40,
        ["kel"] = 140,
        ["barry"] = 1,
        ["scuti"] = 300,
        ["kepler"] = 110,
        ["helvetica"] = 20,

    }

    self.effect = "Healing\nvaries"
    self.shop = "Noodles that\ncopy last taste,\nheals ??HP"
    self.description = "Smooth, white, fettuccine noodles that taste of whatever you last ate. Healing varies."

    self.reactions = {
        -- DELTARUNE
        kris = {
            susie = "Tastes like pancakes, right?"
        },
        susie = "I KNEW those pancakes were a trap!",
        ralsei = "Tastes like... nothing. Haha!",
        noelle = "Communion wafers..?",

        -- ROSY-TROVE
        riley = "Salisberry steak.",
        kel = "Nothing like a nice ribeye!",
        barry = "Tastes like winning.",
        scuti = {
            scuti = "ICE-E's... my beloved...",
            kepler = "Hehehe..."
        },
        kepler = "Parmo's a classic!",
        helvetica = "UGH... TASTES FROZEN!",
    }
end

function item:getBattleHealAmount(id)
    local last_meal = Registry.createItem(Game:getFlag(id.."_last_meal"))
    if last_meal.id == "copy_pasta" or last_meal == nil then
        return self.heal_amount
    else
        --- Silly VSCode...
        ---@diagnostic disable-next-line: undefined-field
        return last_meal:getBattleHealAmount(id)
    end
end

function item:getBattleText(user, target)
    local last_meal = Registry.createItem(Game:getFlag(target.actor.id.."_last_meal"))
    local base_message = "* "..user.chara:getName().." used the "..self:getUseName().."![wait:10]\n"

    if last_meal.id == "copy_pasta" or last_meal == nil then
        return base_message.. "* It tasted really bland."
    else
        --- Silly VSCode...
        ---@diagnostic disable-next-line: undefined-field
        return base_message.. "* It tasted like "..last_meal:getUseName().."."
    end
end


return item
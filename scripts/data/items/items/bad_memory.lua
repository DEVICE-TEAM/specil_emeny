local item, super = Class(HealItem, "bad_memory")

-- ...
function item:init()
    super.init(self)

    self.type = "item"
    self.name = "BadMemory"

    self.price = 600
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.effect = "Lorem\nipsum\ndocet"
    self.shop = ""
    self.description = "?????"

    -- Character reactions
    self.reactions = {
        kris = {
            susie = "Are you okay, Kris?",
            ralsei = "...Kris?",
            noelle = "Oh."
        },
        susie = {
            susie = "It's... okay.",
            ralsei = "A-are you crying, Susie?",
            noelle = "S-Susie!?"
        },
        ralsei = "We are a sum of all our memories, are we not?",
        noelle = "Fahaha. Thanks, but, no.",

        -- ROSY-TROVE
        riley = "No.",
        kel = "Did I have to..?",
        barry = "I was born in the      .",

        helvetica = "... WHATEVER.",
    }

    -- Amount the poison damages in the world
    self.world_poison_amount = 1

    -- Amount the poison heals in battle
    self.battle_heal_amount = 1
    -- Amount the poison damages in battle
    self.battle_poison_amount = 2
end


function item:getBattleText(user, target)
    if Game.tension >= 90 then
        return "* The pain itself is reason why."
    else
        return "* "..user.chara:getName().." consumes the Bad Memory."
    end
end

function item:onWorldUse(target)
    if target.id == "noelle" or target.id == "riley" then
        return false
    elseif target.id == "barry" then
        return true
    end

    target:setHealth(math.max(1, target:getHealth() - self.world_poison_amount))
    Assets.playSound("hurt")
    return true
end

function item:onBattleUse(user, target)
    target:heal(self.battle_heal_amount, {1, 0, 1})
    if Game.tension >= 90 then
        Game:setTension(Game:getTension() - 75)
        Assets.playSound("heal")
    else
        Assets.playSound("hurt")
        Game:setTension(Game:getTension() + 15)

        if target.poison_effect_timer then
            Game.battle.timer:cancel(target.poison_effect_timer)
        end

        local poison_left = self.battle_poison_amount
        target.poison_effect_timer = Game.battle.timer:every(10/30, function()
            if poison_left == 0 then
                return false
            end
            if target.chara:getHealth() > 1 then
                target.chara:setHealth(target.chara:getHealth() - 1)
                poison_left = poison_left - 1
            else
                poison_left = 0
                return false
            end
        end)
    end
end

return item
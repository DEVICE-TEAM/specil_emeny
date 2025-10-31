
local HealItem, super = Class(HealItem)

function HealItem:onBattleUse(user, target)
    super.onBattleUse(self, user, target)

    if target.actor then
        Game:setFlag(target.actor.id.."_last_meal", self.id)
    end
end

return HealItem
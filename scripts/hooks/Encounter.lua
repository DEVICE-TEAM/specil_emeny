local Encounter, super = Class(Encounter)

function Encounter:update()

    if self.fear_tp == true and Game:getTension() == 100 then
        Game:setTension(Game:getTension() - 5)
        Game.battle:getActiveParty()[1]:hurt(55, true)
    end

    super.update(self)
end

return Encounter
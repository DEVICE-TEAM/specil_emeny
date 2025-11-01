---@diagnostic disable: undefined-field, inject-field
local MemoryheadBattle, super = Class(PhaseEncounter)

function MemoryheadBattle:init()
    super.init(self)

    self.text = "*       drew near!"

    self.music = "mus_rt_REMEMBER"

    self.background = false

    self.fear_tp = true


    Game.battle.back_background = Sprite("effects/blank_background")
    Game.battle.back_background:setLayer(BATTLE_LAYERS["bottom"])
    Game.battle.back_background:setScale(10, 10)
    Game.battle:addChild(Game.battle.back_background)
    Game.battle.timer:tween(1, Game.battle.back_background, {alpha = 1})

    Game.battle.trippy_background = Sprite("effects/DEPTHS_2")
    Game.battle.trippy_background:setLayer(BATTLE_LAYERS["bottom"])
    Game.battle.trippy_background:setOrigin(0.5)
    Game.battle.trippy_background:setScale(2, 2)
    Game.battle.trippy_background.wrap_texture_x = true
    Game.battle.trippy_background.wrap_texture_y = true
    Game.battle.trippy_background.physics.speed_x = 2
    Game.battle.trippy_background.alpha = 0
    Game.battle.timer:tween(1, Game.battle.trippy_background, {alpha = 1})

    Game.battle:addChild(Game.battle.trippy_background)

    self.memoryhead_a = self:addEnemy("memoryhead")
    self.memoryhead_b = self:addEnemy("memoryhead")

    self:addPhase({{
        text = "* You are [color:#ff0000]AFRAID[color:white] of the      ...[wait:8]\n* When TP reaches MAX, you are damaged!",
        wave = "memoryhead/freakout"
    }})
    self:randomWavesForPhase({
        "memoryhead/freakout",
        "memoryhead/lost_girl/whiffle_bat",
        "memoryhead/freaktunnel",
        "memoryhead/freaksplosion"
    })
    self:randomTextForPhase({
        "* Unrelated.",
        "* Come join the fun!",
        "* Ferial Fideicide.",
        "* Down, down, down.",
        "* Do you remember           ?",
        "* Smells like batteries.",
        "* But nobody came."
    })

end

function MemoryheadBattle:beforeStateChange(old, new)
    if new == "DEFENDINGBEGIN" then
        for _,enemy in ipairs(Game.battle.enemies) do
            enemy:fadeOut()
        end
    elseif new == "DEFENDINGEND" then
        for _,enemy in ipairs(Game.battle.enemies) do
            enemy:fadeIn()
        end
    end
end

function MemoryheadBattle:onBattleEnd()
    Game.battle.timer:tween(1, Game.battle.back_background, {alpha = 0})
end

return MemoryheadBattle
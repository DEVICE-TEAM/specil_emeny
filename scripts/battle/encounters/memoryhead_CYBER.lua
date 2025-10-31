---@diagnostic disable: undefined-field, inject-field
local MemoryheadBattle, super = Class(PhaseEncounter)

function MemoryheadBattle:init()
    super.init(self)

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

    local memoryhead_a = self:addEnemy("memoryhead")
    local memoryhead_b = self:addEnemy("memoryhead")
    local memoryhead_c = self:addEnemy("memoryhead")

    memoryhead_a.id = "memoryhead_a"
    memoryhead_b.id = "memoryhead_b"
    memoryhead_c.id = "memoryhead_c"

    self:addPhase({{
        text = "* Who are you running from?",
        wave = "memoryhead/freakout"
    }})
    self:randomWavesForPhase({
        "memoryhead/cognitohazard",
        "memoryhead/freakout_x3",
        -- "memoryhead/lost_girl/whiffle_bat",
        "memoryhead/freaktunnel_x3",
        "memoryhead/freaksplosion_x3"
    })
    self:randomTextForPhase({
        "* Unrelated.",
        "* Come join the fun!",
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

function MemoryheadBattle:onStateChange(old, new)
    if new == "ACTIONSELECT" and Game.battle.jumped ~= true then
        Game.battle.jumped = true
        Game.battle:setState("DEFENDINGBEGIN")
    end
end

function MemoryheadBattle:onBattleEnd()
    Game.battle.timer:tween(1, Game.battle.back_background, {alpha = 0})
end

function MemoryheadBattle:update()
    if Game:getTension() == 100 then
        Game:setTension(Game:getTension() - 5)
        Game.battle:getActiveParty()[1]:hurt(55, true)
    end
end

return MemoryheadBattle
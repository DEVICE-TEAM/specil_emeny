--- `PartyBattler`s are a type of `Battler` that represent [`PartyMember`](lua://PartyMember.init)s when they are in battle. \
--- The set of `PartyBattler`s in the current battle are stored in [`Game.battle.party`](lua://Battle.party). \
--- Unlike `EnemyBattler`, party members do not need to define a `PartyBattler` in a file as their PartyMember file defines everything necessary and is utilised by `PartyBattler`.
---
---@class PartyBattler : Battler
---
---@field chara         PartyMember The PartyMember this battler uses
---@field actor         Actor       The actor this battler uses
---
---@field action        table       The current action the battler has queued up
---
---@field defending     boolean     Whether the battler is currently defending
---@field hurt_timer    number      How long this battler's hurt sprite should be displayed for when hit
---@field hurting       boolean     Whether the battler is currently hurting (showing their hurt sprite)
---
---@field is_down       boolean     Whether the battler is downed
---@field sleeping      boolean     Whether the battler is sleeping
---
---@field should_darken boolean     *(Used internally)* Whether the battler's sprite should be darkened during waves
---@field darken_timer  number      *(Used internally)* A timer for the darkening of the battler's sprite during the wave transition
---@field darken_fx     RecolorFX   *(Used internally)* A RecolorFX used for darkening the battler's sprite during waves
---
---@field target_sprite Sprite
---@overload fun(chara:PartyMember, x?:number, y?:number) : PartyBattler
local PartyBattler, super = Class(PartyBattler)

---@param amount    number  The damage of the incoming hit
---@param exact?    boolean Whether the damage should be treated as exact damage instead of applying defense and element modifiers
---@param color?    table   The color of the damage number
---@param options?  table   A table defining additional properties to control the way damage is taken
---|"all"   # Whether the damage being taken comes from a strike targeting the whole party
---|"swoon" # Whether the damage should swoon the battler instead of downing them
function PartyBattler:hurt(amount, exact, color, options)
    options = options or {}

    local swoon = options["swoon"]

    if not options["all"] then
        Assets.playSound("hurt")
        if not exact then
            amount = self:calculateDamage(amount)
            if self.defending then
                amount = math.ceil((2 * amount) / 3)
            end
            -- we don't have elements right now
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))
        end

        self:removeHealth(amount, swoon)
    else
        -- We're targeting everyone.
        if not exact then
            amount = self:calculateDamage(amount)
            -- we don't have elements right now
            local element = 0
            amount = math.ceil((amount * self:getElementReduction(element)))

            if self.defending then
                amount = math.ceil((3 * amount) / 4) -- Slightly different than the above
            end
        end

        self:removeHealthBroken(amount, swoon) -- Use a separate function for cleanliness
    end

    if (self.chara:getHealth() <= 0) then
        self:statusMessage("msg", swoon and "swoon" or "down", color, true)
    else
        self:statusMessage("damage", amount, color, true)
    end

    self.hurt_timer = 0
    Game.battle:shakeCamera(4)

    if (not self.defending) and (not self.is_down) and (Game.battle.toggle_hurt_animation ~= true) then
        self.sleeping = false
        self.hurting = true
        self:toggleOverlay(true)
        self.overlay_sprite:setAnimation("battle/hurt", function()
            if self.hurting then
                self.hurting = false
                self:toggleOverlay(false)
            end
        end)
        if not self.overlay_sprite.anim_frames then -- backup if the ID doesn't animate, so it doesn't get stuck with the hurt animation
            Game.battle.timer:after(0.5, function()
                if self.hurting then
                    self.hurting = false
                    self:toggleOverlay(false)
                end
            end)
        end
    end
end

return PartyBattler

local Bullet, super = Class(Bullet)

--- *(Override)* Called when the bullet hits the player's soul without invulnerability frames. \
--- Not calling `super.onDamage()` here will stop the normal damage logic from occurring.
---@param soul Soul
---@return table<PartyBattler> battlers_hit
function Bullet:onDamage(soul)
    Game.battle.got_hit = true
    
    super.onDamage(self, soul)
end

return Bullet

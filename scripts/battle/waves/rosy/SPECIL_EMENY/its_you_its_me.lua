local wave, super = Class(Wave)

function wave:init()
    super.init(self)
    self:setArenaSize(SCREEN_WIDTH + 20,SCREEN_HEIGHT + 20)
    self:setArenaPosition((SCREEN_WIDTH / 2) - 10, SCREEN_HEIGHT / 2 - 10)
end

function wave:onStart()
    self.time = 9999

    self.you = self:spawnBullet("rosy/its_you_its_me/you", 100, -20)
    self.timer:tween(1, self.you, {y = SCREEN_HEIGHT/2}, "in-out-quad")
    
    self.me = self:spawnBullet("rosy/its_you_its_me/me", 500, SCREEN_HEIGHT/2)
    self.me.alpha = 0
    self.timer:tween(1, self.me, {alpha = 1}, "in-out-quad")

    
    self.timer:every(1.5, function()

        if Game.battle.reunited ~= true then
            local player_x = Game.battle.soul.x
            local player_y = Game.battle.soul.y

            Assets.playSound("happy_WAAHHH", 0.5, 1)
            self:spawnAimingVine(self, player_x, player_y, 0.5, true)
        end
    end)
    
    self.timer:every(0.2, function()

        if Game.battle.reunited ~= true then
            local x = Utils.random(Game.battle.arena:getLeft() + 10, Game.battle.arena:getRight() - 10)
            local y = Utils.random(Game.battle.arena:getTop() + 10, Game.battle.arena:getBottom() - 10)

            self:spawnBullet("memoryhead/freak_bullet", x, y, nil, 0.6)
        end
    end)
end

function wave:update()
    -- Code here gets called every frame

    if Game.battle.reunited ~= true then
        local soul = Game.battle.soul
        if soul then
            local dx = self.me.x - soul.x
            local dy = self.me.y - soul.y
            local dist = math.sqrt(dx*dx + dy*dy)

            if dist > 0 then
                local pull = 3.5 -- pull soul
                soul.x = soul.x + (dx/dist) * pull
                soul.y = soul.y + (dy/dist) * pull
            end
        end
    end
    super.update(self)
end

return wave
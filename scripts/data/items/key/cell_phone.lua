local item, super = Class(Item, "cell_phone")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Cell Phone"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "It can be used to make calls."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {}
end

function item:onWorldUse()

    if StringUtils.contains(Game.world.map.full_map_path, "nightmare") then
        ---@diagnostic disable-next-line: param-type-mismatch
        Game.world:startCutscene(function(cutscene)
            Assets.playSound("phone", 0.7)

            local was_playing = Game.world.music:isPlaying()

            if was_playing then
                Game.world.music:pause()
            end

            cutscene:text("* Ring... Ring...")

            if Game:getFlag("phone") then
                cutscene:text("* ...")
                cutscene:text("* But nobody came.")
            else
                if Game:getFlag("fun") > 50 then
                    cutscene:setSpeaker("toriel")
                    cutscene:text("* ...")
                    cutscene:text("* Kris,[wait:4] honey,[wait:4] are you there?")
                    cutscene:wait(0.5)
                    cutscene:text("* I just wanted to finally be honest with you.")
                    cutscene:wait(0.5)
                    cutscene:text("* You are the worst thing to have ever happened to me.")
                    cutscene:text("* Asriel")
                else
                    cutscene:setSpeaker("noelle")
                    cutscene:text("* Hey,[wait:4] Kris.")
                    cutscene:text("* You've been keeping me waiting long enough.")
                    cutscene:text("* I'm tired of waiting.")
                end
                Game:setFlag("phone", true)
            end

            if was_playing then
                Game.world.music:resume()
            end
        end)
    else
        ---@diagnostic disable-next-line: param-type-mismatch
        Game.world:startCutscene(function(cutscene)
            Assets.playSound("phone", 0.7)
            cutscene:text("* (You tried to call on the Cell\nPhone.)", nil, nil, {advance = false})
            cutscene:wait(40/30)
            local was_playing = Game.world.music:isPlaying()
            if was_playing then
                Game.world.music:pause()
            end
            Assets.playSound("smile")
            cutscene:wait(200/30)
            if was_playing then
                Game.world.music:resume()
            end
            cutscene:text("* It's nothing but garbage noise.")
        end)
    end

end

return item
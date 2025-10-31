local Map, super = Class(Map)

function Map:onEnter()
    super.onEnter(self)

    self.nightmarefilter1 = ShaderFX(Mod.grayShader)
    self.nightmarefilter2 = RecolorFX(0.7, 0.1, 0.3, 1.0)

    if StringUtils.contains(self.data.full_path, "nightmare") and StringUtils.contains(self.data.full_path, "FINAL") ~= true then
        for i, child in ipairs(Game.world.children) do

            local name
            local actor = child.actor

            if actor ~= nil then
                name = child.actor.name
            else
                name = " "
            end

            if StringUtils.contains(name, "Noelle") ~= true then
                child:addFX(self.nightmarefilter1)
                child:addFX(self.nightmarefilter2)
            end
        end
    end
end

return Map
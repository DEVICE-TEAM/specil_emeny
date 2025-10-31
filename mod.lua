function Mod:init()
    print("Loaded "..self.info.name.."!")

end

function Mod:postInit(new_file)
        
    if (love.filesystem.getInfo("saves/"..Mod.info.id.."/ENDING") ~= nil) and Kristal.getSaveFile(1) then
        if (love.filesystem.getInfo("saves/"..Mod.info.id.."/RESET") ~= nil) then
            Game.world:startCutscene("DEVICE.MAINTENANCE_AGAIN")
        else
            Game.world:startCutscene("DEVICE.MAINTENANCE")
        end
    elseif Kristal.getSaveFile(1) then
        Kristal.loadGame(1)
    else
        Game.world:startCutscene("DEVICE.BEGINNING")
    end
end

function Mod:onTextSound(sound, node)
    if sound == "HAPPY" then
        Assets.playSound(TableUtils.pick{
            "voice/HAPPY_1",
            "voice/HAPPY_2",
            "voice/HAPPY_3"
        })
    elseif sound == "rosy" then
        Assets.playSound(TableUtils.pick{
            "voice/rosy_1",
            "voice/rosy_2",
            "voice/rosy_3"
        }, 0.7)
    end
end

Mod.grayShader = love.graphics.newShader([[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        vec4 pixel = Texel(texture, texture_coords);
        
        // Calculate the luminance of the pixel using the NTSC standard
        float gray = dot(pixel.rgb, vec3(0.299, 0.587, 0.114));
        
        // Return the grayscale color
        return vec4(gray, gray, gray, pixel.a) * color;
    }
]])
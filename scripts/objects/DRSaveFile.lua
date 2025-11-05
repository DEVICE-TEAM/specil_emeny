---@diagnostic disable: need-check-nil
---@class DRSaveFile : Object
---@overload fun(...) : DRSaveFile
local DRSaveFile, super = Class(Object)

-- An Object to retrieve save file data from Dr. Ron's Delta.
-------------------------------------------------------
-- Credit to AcousticJamm from the Kristal Discord Server!
-- https://acousticjamm.carrd.co/
-- https://discord.com/channels/899153719248191538/900166836958666752/1015762801987432538
--
-- Also, credit to https://savedata.spamton.com/! Without this resource I
-- would NEVER have been able to decipher what each line meant in DELTARUNE's
-- saves!
--
-- The Stranger (Jake)


-- This function formats the directory for the save data.
--
-- MacOS probably doesn't work, and I have no clue how to do this for Linux, lol.
-- If someone could help me with those two I would be extremely grateful.
function DRSaveFile:directory()
    if love.system.getOS() == "Windows" then
        ---@diagnostic disable-next-line: param-type-mismatch
        return string.gsub(os.getenv('UserProfile'), "\\", "/") .. "/AppData/Local/DELTARUNE/"
    elseif love.system.getOS() == "OS X" then
        ---@diagnostic disable-next-line: param-type-mismatch
        return string.gsub(os.getenv('$HOME'), "\\", "/") .. "/Library/Application Support/com.tobyfox.deltarune/"
    else
        return nil
    end
end

-- This function checks to see if the save file in question actually exists.
function DRSaveFile:exists(fileName)
    local f
    if DRSaveFile:directory() ~= nil then
        f = io.open(DRSaveFile:directory() .. fileName, "r")
    end

    return f ~= nil and io.close(f)
end

-- This function extracts the data from your DELTARUNE Save File.
function DRSaveFile:get(chapter, slot)
    local save = { }
    local fileName = "filech" .. chapter .. "_" .. slot + 2 -- This checks for completion data, not active Chapter data.
    if DRSaveFile:exists(fileName) then
        local f = io.open(DRSaveFile:directory() .. fileName, "r")

        for line in f:lines() do
            table.insert(save, line)
        end
        f:close()

        -- NAMES
        save.name = save[1]
        save.vessel_name = save[2]

        if chapter == 1 then
            -- GONERMAKER
            ------ VESSEL
            save.vessel_head = tonumber(save[1217])
            save.vessel_torso = tonumber(save[1218])
            save.vessel_legs = tonumber(save[1219])

            ------ WHAT IS ITS FAVORITE FOOD?
            if tonumber(save[1220]) == 0 then save.favorite_food = "SWEET"
            elseif tonumber(save[1220]) == 1 then save.favorite_food = "SOFT"
            elseif tonumber(save[1220]) == 2 then save.favorite_food = "SOUR"
            elseif tonumber(save[1220]) == 3 then save.favorite_food = "SALTY"
            elseif tonumber(save[1220]) == 4 then save.favorite_food = "PAIN"
            elseif tonumber(save[1220]) == 5 then save.favorite_food = "COLD"
            else save.favorite_food = "SWEET"
            end

            ------ YOUR FAVORITE BLOOD TYPE?
            if tonumber(save[1221]) == 0 then save.favorite_blood_type = "A"
            elseif tonumber(save[1221]) == 1 then save.favorite_blood_type = "AB"
            elseif tonumber(save[1221]) == 2 then save.favorite_blood_type = "B"
            elseif tonumber(save[1221]) == 3 then save.favorite_blood_type = "C"
            elseif tonumber(save[1221]) == 4 then save.favorite_blood_type = "D"
            else save.favorite_blood_type = "A"
            end

            ------ WHAT COLOR DOES IT LIKE MOST?
            if tonumber(save[1222]) == 0 then save.favorite_color = "RED"
            elseif tonumber(save[1222]) == 1 then save.favorite_color = "BLUE"
            elseif tonumber(save[1222]) == 2 then save.favorite_color = "GREEN"
            elseif tonumber(save[1222]) == 3 then save.favorite_color = "CYAN"
            else save.favorite_color = "RED"
            end

            ------ PLEASE GIVE IT A GIFT.
            if tonumber(save[1226]) == 1 then save.vessel_gift = "KINDNESS"
            elseif tonumber(save[1226]) == 0 then save.vessel_gift = "MIND"
            elseif tonumber(save[1226]) == -1 then save.vessel_gift = "AMBITION"
            elseif tonumber(save[1226]) == -2 then save.vessel_gift = "BRAVERY"
            elseif tonumber(save[1226]) == -3 then save.vessel_gift = "VOICE"
            else save.vessel_gift = "MIND"
            end

            ------ HOW DO YOU FEEL ABOUT YOUR CREATION?
            if tonumber(save[1223]) == 0 then save.vessel_feeling = "LOVE"
            elseif tonumber(save[1223]) == 1 then save.vessel_feeling = "HOPE"
            elseif tonumber(save[1223]) == 2 then save.vessel_feeling = "DISGUST"
            elseif tonumber(save[1223]) == 3 then save.vessel_feeling = "FEAR"
            else save.vessel_feeling = "LOVE"
            end

            ------ HAVE YOU ANSWERED HONESTLY?
            if tonumber(save[1224]) == 0 then save.gonermaker_honesty = true
            elseif tonumber(save[1224]) == 1 then save.gonermaker_honesty = false
            else save.gonermaker_honesty = true
            end

            ------ YOU ACKNOWLEDGE THE POSSIBILITY OF PAIN AND SEIZURE.
            if tonumber(save[1225]) == 0 then save.gonermaker_pain = true
            elseif tonumber(save[1225]) == 1 then save.gonermaker_pain = false
            else save.gonermaker_pain = true
            end

        elseif chapter == 2 then
            -- Broken?
            if tonumber(save[1468]) == 20 then save.weird = true
            else save.weird = false
            end

        elseif chapter == 4 then
            -- Broken?
            if tonumber(save[1527]) ~= 0 then
                save.weird = true
            else
                save.weird = false
            end
        end
    else
        save = nil
    end

    return save
end

return DRSaveFile
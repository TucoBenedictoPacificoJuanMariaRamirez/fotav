-- This file handles the logic of the main gameplay and
-- provides the necessary solutions for that

require("logic.mapProperties")

--[[
    TODO:
        - function to call when a pipe is tapped
        - timer for decrementing house temps with modifyHouseTemp()
        - level timer function
        - endgame rating (0-3 stars)
        - endgame condition in level timer
        - implement physical max and min house temp bounds in pipeTap and modifyHouseTemp with respect to connected pipe temps
            -- min: houseTemp > 10 (v1.1: winter lvl? freezing water?)
            -- max: houseTemp < max(pipeTemps connected)
--]]

local logic = {}

level = nil
time = nil
pipes = nil
houses = nil

--loading a level, init level attributes
function createLevel(levelNum)
    print(" ")
    print ("Creating level " .. levelNum .. "...")
    level = maps['l' .. levelNum]
    time = level.time
    pipes = level.pipes
    houses = level.houses
    return logic
end

logic.createLevel = createLevel

--called by the eventListener on tap
function pipeTap(pipe)
    addTemp = pipe.temp / 10
    for i,v in ipairs(pipe.houses) do
        --ide kell 
        modifyHouseTemp(v, addTemp)
    end
end
logic.pipeTap = pipeTap

local function modifyHouseTemp(house, value)
    houses[house].temp = houses[house].temp + value
end

--called when no time left (lvl endscreen)
local function rating()

    -- ***: every houseTemp is optimal
    if() then
    end 
    -- **: at least half of the houseTemps are optimal
    elseif() then
    end

    -- *: at least the third of the houseTemps are optimal
    elseif() then
    end

    -- 0: 
    else

end

return logic

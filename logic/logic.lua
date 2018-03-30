-- This file handles the logic of the main gameplay and
-- provides the necessary solutions for that

require("logic.mapProperties")
require("math")

--[[
    TODO:
        - timer for decrementing house temps with modifyHouseTemp()
        - level timer function
        - endgame condition in level timer
--]]

local logic = {}

level = nil
limit = nil
decrease = nil
time = nil
pipes = nil
houses = nil
count = 0

--storing current house temperatures (table of {house, temp})
currentTemps = {}

--loading a level, init level attributes
function createLevel(levelNum)
    print(" ")
    print ("Creating level " .. levelNum .. "...")
    level = maps['l' .. levelNum]
    limit = level.limit
    decrease = level.decrease
    time = level.time
    pipes = level.pipes
    houses = level.houses
    
    --init currentTemps
    for i in houses do
        currentTemps.insert(i, 10) --hardcoded basic environmet temperature (v2.0 winter?)
        count = count + 1
    end

    return logic
end
logic.createLevel = createLevel

--called by the eventListener on tap
function pipeTap(pipe)
    addTemp = pipe.temp / 10
    for i,v in ipairs(pipe.houses) do
        modifyTempOnTap(v, i)
    end
end
logic.pipeTap = pipeTap

function modifyTempOnTap(house, pipe)
    --Mi van, ha 40, 20 fokos vizek vannak,
    --current = 30, és rányomunk a 20-ra?
    
    ----Tfh. a házban lévő víz hőmerséklete t1, mennyisége V1,
    ----     a csőben lévő víz hőmérséklete t2, mennyisége V2
    ----
    ----A keveredés alapján az új hőmérséklet: T=(t1*V1+t2*V2)/(V1+V2)

    currentTemps.house = (currentTemps.house*100 + pipe.temp*10) / (100+10)
end

--called when no time left (lvl endscreen)
function rating()   
    local optimal = 0

    for i in currentTemps do
        optimal = optimal + 1
    end

    
    -- ***: every houseTemp is optimal
    if optimal==count then
        return 3

    -- **: at least half of the houseTemps are optimal
    elseif optimal > math.ceil(count/2) then
        return 2

    -- *: at least the third of the houseTemps are optimal
    elseif optimal > math.ceil(count/3) then
        return 1
    -- 0: 
    else
        return 0
    end
end

--returns whether the current houseTemp is acceptable
function isWithinError(house)
    -- | goal-current | < limit  <===>  current > goal-limit  and  current < goal+limit
    local c = currentTemps.house
    local g = houses.house.goal
    return (c > g-limit  and  c < g+limit)
end

function cooling()
    for i in currentTemps do
        currentTemps.i = currentTemps.i -1
    end
end

return logic

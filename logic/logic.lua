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
logic.limit = nil
logic.decrease = nil
logic.time = nil
logic.pipes = nil
logic.houses = nil
logic.isEnd = false
logic.timer = nil
count = 0

--storing current house temperatures (table of {house, temp})
currentTemps = {}

--loading a level, init level attributes
function createLevel(levelNum)
    print("----------------------------------------------")
    print ("Creating level " .. levelNum .. "...")
    level = maps['l' .. levelNum]
    logic.limit = level.limit
    logic.decrease = level.decrease
    logic.time = level.time
    logic.pipes = level.pipes
    logic.houses = level.houses

    --init currentTemps
    
    print("Initializating currentTemps...")
    for key, value in pairs(logic.houses) do
        table.insert(currentTemps, {key, level.envTemp})
        count = count + 1
    end

    print("currentTemps after initialization: ")
    print2D(currentTemps)

    logicTimer(time)
    endCheck()

end
logic.createLevel = createLevel

--called by the eventListener on tap
function pipeTap(label)
    --print2D(logic.pipes)
    --for i,v in ipairs(logic.pipes[label].houses) do
    --        modifyTempOnTap(v, i)
    --end
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

    for key, value in pairs(currentTemps) do
        for key2, value2 in pairs(value) do
            house = currentTemps[key][key2]
            if string.sub(house,1,1)=="h" and isWithinError(house) then
                optimal = optimal+1
            end
        end
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
    
    c = getCurrentTempOf(tostring(house))
    print("logic.houses[house].goal")
    print(logic.houses[house].goal)
    
    local g = tonumber(logic.houses[house].goal)
    local l = tonumber(logic.limit)

    return (c > g-l  and  c < g+l)
end

function getCurrentTempOf(houseName)
    for key, value in pairs(currentTemps) do
        --print("    key: "..key)
        for key2, value2 in pairs(value) do
            if value2==house then
                --print("Current temperature of "..house.." is: "..currentTemps[key][key2+1])
                return currentTemps[key][key2+1]
            end
        end
    end
end

--TODO: currentTemps hivatkozás rossz
function cooling(temp)
    -- for i in currentTemps do
    --     if currentTemps.i - temp > level.envTemp then
    --         currentTemps.i = currentTemps.i - temp
    --     else 
    --         currentTemps.i = level.envTemp
    --     end
    -- end
    ----asd
end

function logicTimer(count)
    t = timer.performWithDelay(1000
            , function() 
                c = c - 1
                print(c)
                cooling(level.decrease)
              end
            , c
        )
    if isEnd then
        timer.cancel(t)
    end
end

function endCheck()
    t = timer.performWithDelay(200
            , function()
                if rating()==3 then
                    isEnd = true
                    --switch to endscreen
                end
              end
        )

    if isEnd then
        timer.cancel(t)
    end
end

function print2D( table )
    for key, value in pairs(table) do
        print("    key: "..key)
        for key2, value2 in pairs(value) do
            print("        value.key2: "..key2.."    value.value2: "..value2)
        end
    end
end

return logic
-- This file handles the logic of the main gameplay and
-- provides the necessary solutions for that

require("logic.mapProperties")
require("math")

local logic = {}

level = nil

logic.limit = nil
logic.decrease = nil
logic.time = nil
logic.pipes = nil
logic.houses = nil
logic.timer = nil
logic.isEnd = false
logic.tappable = true
logic.remaining = 0
logic.tapCoolDown = false --used to prevent continuous tapping effect; while true, tap is not available ("cooling down")
logic.ms = 100 --fixed timer rate
count = 0

--storing current house temperatures (table of {house, temp})
currentTemps = {}

--loading a level, init level attributes
function createLevel(levelNum)
    print("----------------------------------------------")
    print ("Creating level " .. levelNum .. "...")
    level = maps['l' .. levelNum]
	-- If the map cannot be loaded, this function returns -1
	if level == nil then
		return -1
	end

    logic.limit = level.limit
    logic.decrease = level.decrease
    logic.time = level.time
    logic.pipes = level.pipes
    logic.houses = level.houses
    logic.remaining = level.time

    initCurrentTemps()
    setCurrentTempOf("h1",30)

    --endCheck()
	return 0
end
logic.createLevel = createLevel

function initCurrentTemps()
    for key, value in pairs(logic.houses) do
        table.insert(currentTemps, {key, level.envTemp})
        count = count + 1
    end
end

--called by the eventListener on tap if the flag is not set
function pipeTap(event)
    if logic.tappable and not logic.tapCoolDown and not (event.phase=="ended") then
        print("tapped")
        pipeName = "p" .. event.target.id
        cnt = tableLength(logic.pipes[pipeName].houses)
        for i=1, cnt do
            modifyTempOnTap(logic.pipes[pipeName].houses[i], pipeName)
        end
        logic.tapCoolDown = true
    end
end
logic.pipeTap = pipeTap

function modifyTempOnTap(house, pipe)
    ----Tfh. a házban lévő víz hőmerséklete t1, mennyisége V1,
    ----     a csőben lévő víz hőmérséklete t2, mennyisége V2
    ----
    ----A keveredés alapján az új hőmérséklet: T=(t1*V1+t2*V2)/(V1+V2)

    setCurrentTempOf(house, math.ceil((getCurrentTempOf(house)*100 + logic.pipes[pipe].temp*10) / (100+10)))
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
logic.rating = rating

--MÉG NINCS TESZTELVE
--returns whether the current houseTemp is acceptable
function isWithinError(house)
    -- | goal-current | < limit  <===>  current > goal-limit  and  current < goal+limit

    c = getCurrentTempOf(tostring(house))

    local g = tonumber(logic.houses[house].goal)
    local l = tonumber(logic.limit)

    return (c > g-l  and  c < g+l)
end

function endCheck()
    t = timer.performWithDelay(logic.ms
            , function()
                print("rating: "..rating())
                if rating()==3 then
                    print("              vege")
                    isEnd = true
                    --switch to endscreen
                end
              end
        )
end
logic.endCheck = endCheck

function getCurrentTempOf(houseName)
    for key, value in pairs(currentTemps) do
        for key2, value2 in pairs(value) do
            if value2==houseName then
                return currentTemps[key][key2+1]
            end
        end
    end
end
logic.getCurrentTempOf = getCurrentTempOf

function setCurrentTempOf(houseName, new)
    for key, value in pairs(currentTemps) do
        for key2, value2 in pairs(value) do
            if value2==houseName then
                currentTemps[key][key2+1]=new
            end
        end
    end
end
logic.setCurrentTempOf = setCurrentTempOf

function cooling()
    for key, value in pairs(currentTemps) do
        local house = value[1] 
        local toSet = (getCurrentTempOf(house)*100 + level.envTemp*1) / (100+1)
        setCurrentTempOf(house, round(toSet,1))
    end
end

function logicTimer(count)
    t = timer.performWithDelay(logic.ms
            , function()
                if not isEnd then
                    if count >= 0.005 then
                        count = count-logic.ms/1000
                        logic.remaining = count
                    else 
                        logic.tappable = false
                    end
                    logic.tapCoolDown = false
                end 
            end
            , (count*1000/logic.ms)
        )
    t2 = timer.performWithDelay(logic.ms, function() if not isEnd then cooling() endCheck() end end, logic.time*1000/logic.ms)
end
logic.logicTimer = logicTimer

function print2D( table )
    for key, value in pairs(table) do
        print("    key: "..key)
        for key2, value2 in pairs(value) do
            print("        value.key2: "..key2.."    value.value2: "..value2)
        end
    end
end

function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

--http://lua-users.org/wiki/SimpleRound
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

return logic

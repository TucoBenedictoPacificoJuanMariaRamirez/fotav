require("gameLogic.mapProperties")

--[[
    TODO:
        - function to call when a pipe is tapped
        - main thread function for decrementing house temps
        - main thread timer function for the time limit
--]]

level = nil
time = nil
pipes = nil
houses = nil

--loading a level, init level attributes
function createLevel(levelNum)
    print(" ")
    print ("Creating level "..levelNum.."...")
    level = maps['l'..levelNum]
    time = level.time
    pipes = level.pipes
    houses = level.houses
    local logic = {
        level=level, time=time, pipes=pipes, houses=houses
    }

    return logic
end

--called by the eventListener on tap
function pipeTap(pipe)
    addTemp = pipe.temp/10
    for i,v in ipairs(pipe.houses) do
        modifyHouseTemp(v, addTemp)
    end
end

function modifyHouseTemp(house, value)
    houses[house].temp = houses[house].temp + value
end
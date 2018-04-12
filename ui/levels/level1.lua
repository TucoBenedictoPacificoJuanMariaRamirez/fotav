-- Modified by Nagy Bence
-- 2018.03.17

-- This file describes the UI of Level 1

local level = {}

-- load logic for this map
local logic = require("logic.logic")

local initialized = false

local text = nil
local mapsBtn = nil

local tempText = nil

local function handleBackToMap(event)
	if ("ended" == event.phase) then
		screenController.mapsScreen()
    end
end

local function init()
	logic.createLevel(1)
	bg = display.newImageRect("assets/background.png", 360, 570)
	
	
	cso = widget.newButton(
		{
		id = 1,
		x = display.contentCenterX,
		y = display.contentCenterY + 200,
		width = 150,
		height = 35,
		onPress = logic.pipeTap,
		fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
		shape = "roundedRect"
		})
	
	logicTimer(logic.time)
	levelTimer(logic.time)
	endCheck()
	
	levelTime = display.newText(logic.time, display.contentCenterX, 100, native.systemFont, 30)
	

	print("rating: "..rating())
		
end
level.init = init

function levelTimer(count)
	ms = 100
    t = timer.performWithDelay(ms, function () updateTempText() end, count*1000/ms)
    if logic.isEnd then
        timer.cancel(t)
    end
end

function updateTempText()
	display.remove(tempText)
	tempText = display.newText(logic.getCurrentTempOf("h1"), display.contentCenterX, cso.y-70, native.systemFone, 30)
end

local function hide()
	if initialized then
		display.remove(text)
		mapsBtn.isVisible = false
	end
end
level.hide = hide

return level
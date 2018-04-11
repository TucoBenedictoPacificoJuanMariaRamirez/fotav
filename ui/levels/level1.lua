-- Modified by Nagy Bence
-- 2018.03.17

-- This file describes the UI of Level 1

local level = {}

-- load logic for this map
local logic = require("logic.logic")

local initialized = false

local text = nil
local mapsBtn = nil

local function handleBackToMap(event)
	if ("ended" == event.phase) then
		screenController.mapsScreen()
    end
end

local function init()
	logic.createLevel(1)
	bg = display.newImageRect("assets/background.png", 360, 570)
	levelTime = display.newText(logic.time, display.contentCenterX, 100, native.systemFont, 30)
	
	cso = widget.newButton(
		{
		label = "p1",
		x = display.contentCenterX,
		y = display.contentCenterY + 200,
		width = 150,
		height = 35,
		onEvent = logic.pipeTap(label),
		fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
		shape = "roundedRect"
		})
	
	houseTemp = display.newText(currentTemps[1][2], display.contentCenterX, cso.y-70, native.systemFone, 30)
		
end
level.init = init

local function hide()
	if initialized then
		display.remove(text)
		mapsBtn.isVisible = false
	end
end
level.hide = hide

return level
-- Modified by Nagy Bence
-- 2018.03.17

-- This file describes the UI of Level 4

local level = {}

-- load logic for this map

local initialized = false

local text = nil
local mapsBtn = nil

local function handleBackToMap(event)
	if ("ended" == event.phase) then
		screenController.mapsScreen()
    end
end

local function init()
	text = display.newText("LEVEL 4", display.contentCenterX, display.contentCenterY - 120, native.systemFont, 30)
	text:setFillColor(56, 150, 90)
	
	if initialized then
		mapsBtn.isVisible = true
	else
		mapsBtn = widget.newButton(
			{
			label = "BACK TO MAPS",
			x = display.contentCenterX,
			y = display.contentCenterY + 200,
			width = 150,
			height = 35,
			onEvent = handleBackToMap,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})
		initialized = true
	end
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
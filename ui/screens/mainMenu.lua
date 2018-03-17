-- Modified by Nagy Bence
-- 2018.03.15

-- This file contains the UI element objects for the main Menu

local mainMenu = {}
local initialized = false

local mainText = nil
local toMapsBtn = nil

local function handleEvent(event)
	if ("ended" == event.phase) then
        screenController.mapsScreen()
    end
end

local function init()
	mainText = display.newText("MAIN SCREEN", display.contentCenterX, display.contentCenterY, native.systemFont, 30)
	mainText:setFillColor(128, 23, 170)

	if initialized then
		toMapsBtn.isVisible = true
	else
		toMapsBtn = widget.newButton(
			{
			label = "MAPS",
			x = display.contentCenterX,
			y = display.contentCenterY + 60,
			onEvent = handleEvent,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})
		initialized = true
	end
end
mainMenu.init = init

local function hide()
	if initialized then
		display.remove(mainText)
		toMapsBtn.isVisible = false
	end
end
mainMenu.hide = hide

return mainMenu
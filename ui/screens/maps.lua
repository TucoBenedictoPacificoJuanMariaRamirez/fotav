-- Modified by Nagy Bence
-- 2018.03.15

-- This file contains the UI element objects for the maps screen

local maps  = {}
local initialized = false

local mapsText = nil

local function init()
	mapsText = display.newText("MAPS SCREEN", display.contentCenterX, display.contentCenterY, native.systemFont, 30)
	mapsText:setFillColor(12, 230, 90)
	initialized = true
end
maps.init = init

local function hide()
	if initialized then
		display.remove(mapsText)
	end
end
maps.hide = hide

return maps
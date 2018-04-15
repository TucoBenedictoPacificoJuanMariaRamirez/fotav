-- This file contains the UI element objects for the main Menu

local mainMenu = {}
local initialized = false

local staticImages = nil
local toMapsBtn = nil

local function handleEvent(event)
  screenController.mapsScreen()
end

local function init()
	staticImages = initGroup()
	staticImages:insert(loadImage("assets/start_screen/tap.png", 0.04, 0, 35))
	staticImages:insert(loadImage("assets/start_screen/road.png", 0.071, 0, -220))
	staticImages:insert(loadImage("assets/start_screen/building_red.png", 0.025, -80, -60))
	staticImages:insert(loadImage("assets/start_screen/building_green.png", 0.025, -20, -70))
	staticImages:insert(loadImage("assets/start_screen/building_blue.png", 0.02, 100, -70))
	staticImages:insert(loadImage("assets/start_screen/building_purple.png", 0.02, 40, -60))
	staticImages:insert(loadImage("assets/start_screen/building_yellow.png", 0.02, -140, -100))
	staticImages:insert(loadImage("assets/start_screen/building_blue.png", 0.02, -90, -120))
	staticImages:insert(loadImage("assets/start_screen/building_red.png", 0.025, 20, -110))
	staticImages:insert(loadImage("assets/start_screen/building_darkgreen.png", 0.020, 130, -100))

	if initialized then
		toMapsBtn.isVisible = true
	else
		toMapsBtn = widget.newButton({
			width = display.actualContentWidth,
			height = display.actualContentHeight,
			x = display.contentCenterX,
			y = display.contentCenterY,
			onRelease = handleEvent,
			fillColor = { default={1,1,1,0.01}, over={0,0,0,0} },
			shape = "rect",
		})
		initialized = true
	end
end
mainMenu.init = init

local function hide()
	-- Not calling remove causes memory leak
	-- TODO: call only on app exit, and set isVisible instead
	display.remove(staticImages)
	if initialized then
		toMapsBtn.isVisible = false
	end
end
mainMenu.hide = hide

function initGroup()
	local g = display.newGroup()
	g.x = display.contentCenterX
	g.y = display.contentCenterY
	return g
end

function loadImage(file, scale, x, y)
	-- Load img temporarily using deprecated function to get the dimensions
	local temp = display.newImage(file)
	local sizeX, sizeY = temp.width, temp.height
	display.remove(temp)
	local img = display.newImageRect(file, sizeX * scale, sizeY * scale)
	img.x = x
	img.y = -y
	return img
end

return mainMenu

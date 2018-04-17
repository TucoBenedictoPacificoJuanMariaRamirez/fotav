-- This file contains the UI element objects for the main Menu

local mainMenu = {}
local initialized = false

local staticImages = nil
local cloudsClose, cloudsMiddle, cloudsFar = nil
local animationTimer = nil
local toMapsBtn = nil

local function handleEvent(event)
  screenController.mapsScreen()
end

local function init()
  staticImages = initGroup()
  cloudsClose = {initGroup(), initGroup()}
  cloudsMiddle = {initGroup(), initGroup()}
  cloudsFar = {initGroup(), initGroup()}
  do -- load static images
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
    staticImages:insert(loadImage("assets/start_screen/sun.png", 0.015, 100, 220))
  end
  do -- load clouds
    fillWithCloseClouds(cloudsClose)
    fillWithMiddleClouds(cloudsMiddle)
    fillWithFarClouds(cloudsFar)
  end
  animationTimer = timer.performWithDelay(1000 / 60, animateClouds, 0)

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

function animateClouds()
  local function move(chunk, speed)
    for k,v in pairs(chunk) do
      v.x = v.x + speed
      if v.x > display.contentCenterX + display.actualContentWidth then
        v.x = display.contentCenterX - display.actualContentWidth
      end
    end
  end
  move(cloudsClose, 0.8)
  move(cloudsMiddle, 0.6)
  move(cloudsFar, 0.3)
end

local function hide()
	-- Not calling remove causes memory leak
	-- TODO: call only on app exit, and set isVisible instead
	if initialized then
    timer.cancel(animationTimer)
    display.remove(staticImages)
    display.remove(cloudsClose[1])
    display.remove(cloudsClose[2])
    display.remove(cloudsMiddle[1])
    display.remove(cloudsMiddle[2])
    display.remove(cloudsFar[1])
    display.remove(cloudsFar[2])
		toMapsBtn.isVisible = false
	end
end
mainMenu.hide = hide

function fillWithCloseClouds(group)
  group[1]:insert(loadImage("assets/start_screen/cloud_01.png", 0.03, 80, 170))
  group[1]:insert(loadImage("assets/start_screen/cloud_02.png", 0.03, -80, 200))
  group[2]:insert(loadImage("assets/start_screen/cloud_01.png", 0.03, 80, 170))
  group[2]:insert(loadImage("assets/start_screen/cloud_02.png", 0.03, -80, 200))
  group[2].x = group[2].x - display.actualContentWidth
end

function fillWithMiddleClouds(group)
  group[1]:insert(loadImage("assets/start_screen/cloud_03.png", 0.02, -20, 120))
  group[2]:insert(loadImage("assets/start_screen/cloud_03.png", 0.02, -20, 120))
  group[2].x = group[2].x - display.actualContentWidth
end

function fillWithFarClouds(group)
  group[1]:insert(loadImage("assets/start_screen/cloud_04.png", 0.015, -100, 100))
  group[1]:insert(loadImage("assets/start_screen/cloud_05.png", 0.015, 60, 80))
  group[2]:insert(loadImage("assets/start_screen/cloud_04.png", 0.015, -100, 100))
  group[2]:insert(loadImage("assets/start_screen/cloud_05.png", 0.015, 60, 80))
  group[2].x = group[2].x - display.actualContentWidth
end

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

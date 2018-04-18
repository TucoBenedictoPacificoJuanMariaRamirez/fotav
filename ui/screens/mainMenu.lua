-- This file contains the UI element objects for the main Menu

local mainMenu = {}
local initialized = false

local everything = nil
local staticImages = nil
local cloudsClose, cloudsMiddle, cloudsFar = nil
local animationTimer = nil
local toMapsBtn = nil

local function handleEvent(event)
  screenController.mapsScreen()
end

local function init()
	if initialized then
		toMapsBtn.isVisible = true
    everything.isVisible = true
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
    do -- initialize groups
      everything = initGroup(false)
      staticImages = initGroup(true)
      cloudsClose = {initGroup(true), initGroup(true)}
      cloudsMiddle = {initGroup(true), initGroup(true)}
      cloudsFar = {initGroup(true), initGroup(true)}
    end
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
		initialized = true
	end
  animationTimer = timer.performWithDelay(1000 / 60, animateClouds, 0)
	fancy_log("Main Menu loaded")
end
mainMenu.init = init

local function hide()
	-- TODO: Not calling remove on group causes memory leak (?)
	if initialized then
    timer.cancel(animationTimer)
    everything.isVisible = false
		toMapsBtn.isVisible = false
	end
end
mainMenu.hide = hide

local function transition(isGoingToBeCurrent)
  if isGoingToBeCurrent then
    init()
    everything.y = display.actualContentHeight
  else
    everything.y = 0
  end
  transitionTimer = timer.performWithDelay(1000 / 60,
    function()
      if isGoingToBeCurrent then
        everything.y = everything.y - 3
        if everything.y <= 0 then
          timer.cancel(transitionTimer)
        end
      else
        everything.y = everything.y + 3
        if everything.y >= display.actualContentHeight then
          hide()
          timer.cancel(transitionTimer)
        end
      end
    end, 0)
end
mainMenu.transition = transition

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

function initGroup(isChild)
	local g = display.newGroup()
  if isChild then
  	g.x = display.contentCenterX
  	g.y = display.contentCenterY
    everything:insert(g)
  end
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

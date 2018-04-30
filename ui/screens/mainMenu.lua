-- This file contains the UI element objects for the main Menu

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local animationTimer = nil
local cloudsClose, cloudsMiddle, cloudsFar = nil
local staticImages = nil
local toMapsBtn = nil


function scene:create(event)
  local everything = self.view

  local function handleEvent(event)
    local options = {
      effect = "slideDown",
      time = 1000,
    }
    composer.gotoScene("ui.screens.maps", options)
  end
  local function loadImage(file, scale, x, y)
    -- Load img temporarily using deprecated function to get the dimensions
    local temp = display.newImage(file)
    local sizeX, sizeY = temp.width, temp.height
    display.remove(temp)
    local img = display.newImageRect(file, sizeX * scale, sizeY * scale)
    img.x = x
    img.y = y
    return img
  end
  local function fillWithCloseClouds(group)
    group[1]:insert(loadImage("assets/start_screen/cloud_01.png", 0.12, 80, -170))
    group[1]:insert(loadImage("assets/start_screen/cloud_02.png", 0.12, -80, -200))
    group[2]:insert(loadImage("assets/start_screen/cloud_01.png", 0.12, 80, -170))
    group[2]:insert(loadImage("assets/start_screen/cloud_02.png", 0.12, -80, -200))
    group[2].x = group[2].x - display.actualContentWidth
  end
  local function fillWithMiddleClouds(group)
    group[1]:insert(loadImage("assets/start_screen/cloud_03.png", 0.08, -20, -120))
    group[2]:insert(loadImage("assets/start_screen/cloud_03.png", 0.08, -20, -120))
    group[2].x = group[2].x - display.actualContentWidth
  end
  local function fillWithFarClouds(group)
    group[1]:insert(loadImage("assets/start_screen/cloud_04.png", 0.06, -100, -100))
    group[1]:insert(loadImage("assets/start_screen/cloud_05.png", 0.06, 60, -80))
    group[2]:insert(loadImage("assets/start_screen/cloud_04.png", 0.06, -100, -100))
    group[2]:insert(loadImage("assets/start_screen/cloud_05.png", 0.06, 60, -80))
    group[2].x = group[2].x - display.actualContentWidth
  end
  local function initGroup(parent)
  	local g = display.newGroup()
  	g.x = display.contentCenterX
  	g.y = display.contentCenterY
    parent:insert(g)
  	return g
  end

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
    staticImages = initGroup(everything)
    cloudsClose = {initGroup(everything), initGroup(everything)}
    cloudsMiddle = {initGroup(everything), initGroup(everything)}
    cloudsFar = {initGroup(everything), initGroup(everything)}
  end
  do -- load static images
    staticImages:insert(loadImage("assets/start_screen/background_blue.png", 0.15 , 0, 0))
    staticImages:insert(loadImage("assets/start_screen/tap.png", 0.16, 0, -35))
    staticImages:insert(loadImage("assets/start_screen/road.png", 0.284, 0, 220))
    staticImages:insert(loadImage("assets/start_screen/building_red.png", 0.1, -80, 60))
    staticImages:insert(loadImage("assets/start_screen/building_green.png", 0.1, -20, 70))
    staticImages:insert(loadImage("assets/start_screen/building_blue.png", 0.08, 100, 70))
    staticImages:insert(loadImage("assets/start_screen/building_purple.png", 0.08, 40, 60))
    staticImages:insert(loadImage("assets/start_screen/building_yellow.png", 0.08, -140, 100))
    staticImages:insert(loadImage("assets/start_screen/building_blue.png", 0.08, -90, 120))
    staticImages:insert(loadImage("assets/start_screen/building_red.png", 0.1, 20, 110))
    staticImages:insert(loadImage("assets/start_screen/building_darkgreen.png", 0.08, 130, 100))
    staticImages:insert(loadImage("assets/start_screen/sun.png", 0.06, 100, -220))
  end
  do -- load clouds
    fillWithCloseClouds(cloudsClose)
    fillWithMiddleClouds(cloudsMiddle)
    fillWithFarClouds(cloudsFar)
  end
  fancy_log("Main Menu created")
end

function scene:show(event)
  local everything = self.view
  local phase = event.phase
  local function animateClouds()
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

  if (phase == "will") then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
  elseif (phase == "did") then
    -- Code here runs when the scene is entirely on screen
    animationTimer = timer.performWithDelay(1000 / 60, animateClouds, 0)
    toMapsBtn.isVisible = true
  end
  fancy_log("Main Menu showed")
end

function scene:hide(event)
  local everything = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Code here runs when the scene is on screen (but is about to go off screen)
    toMapsBtn.isVisible = false
  elseif (phase == "did") then
    -- Code here runs immediately after the scene goes entirely off screen
    timer.cancel(animationTimer)
  end
  fancy_log("Main Menu hid")
end

function scene:destroy(event)
  local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view
  fancy_log("Main Menu destroyed")
end

-- local function transition(isGoingToBeCurrent)
--   if isGoingToBeCurrent then
--     init()
--     everything.y = display.actualContentHeight
--   else
--     everything.y = 0
--   end
--   transitionTimer = timer.performWithDelay(1000 / 60,
--     function()
--       if isGoingToBeCurrent then
--         everything.y = everything.y - 3
--         if everything.y <= 0 then
--           timer.cancel(transitionTimer)
--         end
--       else
--         everything.y = everything.y + 3
--         if everything.y >= display.actualContentHeight then
--           hide()
--           timer.cancel(transitionTimer)
--         end
--       end
--     end, 0)
-- end


scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

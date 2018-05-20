--- Main menu scene
-- @module mainMenu

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local staticImages = nil
local toMapsBtn = nil

local cloudGroup = nil
local carGroup = nil
local carLanes = { 420, 440, 470, 490 }
local cloudTimer = nil
local carTimer = nil
local carSpawner = nil

--- This function initiates the main menu clouds
--@param group The group object that contains all elements on this screen
--@param isInit This flag sets if it is the first time this method is called
function createCloud(group, isInit)
    local x = nil
    local y = nil
    local scale = nil
    local picNum = nil

    if isInit then
      x = math.random(display.actualContentWidth)
    else
      x = -100
    end
    y = math.random(-50, 150)
    scale = math.random(10, 15)/100

    picNum = math.random(1,3)

    -- To be able to index children of the group
    local cloudHolder = { group=display.newGroup(), speed=math.random(10,20)/10 }
    cloudHolder.group:insert(loadImage("assets/start_screen/cloud_0"..picNum..".png", scale, 0, 0))
    cloudHolder.group.x = x
    cloudHolder.group.y = y
    scene.view:insert(cloudHolder.group)
    table.insert(group, cloudHolder)
end

--- This function initiates the main menu cars
--@param group The group object that contains all elements on this screen
--@param isInit This flag sets if it is the first time this method is called
function createCar(group)
    local x = nil
    local y = nil
    local scale = nil
    local picNum = nil

    local lane = math.random(1, 4)
    y = carLanes[lane]
    scale = 0.05

    picNum = math.random(1,3)

    -- To be able to index children of the group
    local carHolder = { group=display.newGroup(), speed=0 }

    if lane > 2 then
      x = -50
      carHolder.speed = math.random(16,20)/10
      carHolder.group.xScale = -1
    else
      x = display.actualContentWidth + 50
      carHolder.speed = -1 * math.random(16,20)/10
    end
    carHolder.group:insert(loadImage("assets/start_screen/car_0"..picNum..".png", scale, 0, 0))
    carHolder.group.x = x
    carHolder.group.y = y
    scene.view:insert(carHolder.group)
    table.insert(group, carHolder)
end

--- This function creates a generic group
--@param parent The parent object of this group
function createGroup(parent)
    local g = display.newGroup()
    g.x = 0
    g.y = 0
    parent:insert(g)
    return g
end

--- This function loads a given image file from the assets
--@param file The path of the image file
--@param scale The scaling of the image
--@param x X position of the image
--@param y Y position of the image
function loadImage(file, scale, x, y)
    -- Load img temporarily using deprecated function to get the dimensions
    local temp = display.newImage(file)
    local sizeX, sizeY = temp.width, temp.height
    display.remove(temp)
    local img = display.newImageRect(file, sizeX * scale, sizeY * scale)
    img.x = x
    img.y = y
    return img
end

--- This function creates the scene the first time before it's used
--@param event The event object on which this function was called
function scene:create(event)
    local rootGroup = self.view
    cloudGroup = {} --createGroup(rootGroup)
    carGroup = {}

    local cloudNumber = math.random(4, 6)
    for i=1, cloudNumber do
        createCloud(cloudGroup, true)
    end

    local function handleEvent(event)
        local options = {
        effect = "slideDown",
        time = 1000,
        }
        composer.gotoScene("ui.screens.maps", options)
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

    staticImages = createGroup(rootGroup)

    do -- load static images
        staticImages:insert(loadImage("assets/start_screen/background_blue.png", 0.15 , 160, 240))
        staticImages:insert(loadImage("assets/start_screen/tap.png", 0.16, 160, 205))
        staticImages:insert(loadImage("assets/start_screen/road.png", 0.284, 160, 460))
        staticImages:insert(loadImage("assets/start_screen/building_red.png", 0.1, 80, 300))
        staticImages:insert(loadImage("assets/start_screen/building_green.png", 0.1, 140, 310))
        staticImages:insert(loadImage("assets/start_screen/building_blue.png", 0.08, 260, 310))
        staticImages:insert(loadImage("assets/start_screen/building_purple.png", 0.08, 200, 300))
        staticImages:insert(loadImage("assets/start_screen/building_yellow.png", 0.08, 20, 340))
        staticImages:insert(loadImage("assets/start_screen/building_blue.png", 0.08, 70, 360))
        staticImages:insert(loadImage("assets/start_screen/building_red.png", 0.1, 180, 350))
        staticImages:insert(loadImage("assets/start_screen/building_darkgreen.png", 0.08, 290, 340))
        staticImages:insert(loadImage("assets/start_screen/sun.png", 0.06, 260, 20))
    end

    fancy_log("Main Menu created")
end

--- This function handles what happens when this scene is shown.
-- It always runs after the first create function
--@param event The event object on which this function was called
function scene:show(event)
    local rootGroup = self.view
    local phase = event.phase

    local function cloudAnimation()
        for k,v in pairs(cloudGroup) do
            v.group.x = v.group.x + v.speed
        end
        local count = 0
        for _ in pairs(cloudGroup) do count = count + 1 end
        for i=count, 1, -1 do
            if cloudGroup[i].group.x > display.actualContentWidth + 100 then
                cloudGroup[i].group:removeSelf()
                cloudGroup[i].group = nil
                table.remove(cloudGroup, i)
                createCloud(cloudGroup, false)
            end
        end
    end

    local function carAnimation()
      for k,v in pairs(carGroup) do
          v.group.x = v.group.x + v.speed
      end
      local count = 0
      for _ in pairs(carGroup) do count = count + 1 end
      for i=count, 1, -1 do
          if ((carGroup[i].speed > 0) and (carGroup[i].group.x > display.actualContentWidth + 50)) or ((carGroup[i].speed < 0) and (carGroup[i].group.x < -50)) then
              carGroup[i].group:removeSelf()
              carGroup[i].group = nil
              table.remove(carGroup, i)
          end
      end
    end

    local function spawnScheduler()
      carSpawner = timer.performWithDelay(math.random(1000, 2500), spawnScheduler, 1)
      createCar(carGroup)
    end

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        cloudTimer = timer.performWithDelay(1000 / 60, cloudAnimation, 0)
        carTimer = timer.performWithDelay(1000 / 60, carAnimation, 0)
        carSpawner = timer.performWithDelay(2000, spawnScheduler, 1)
    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
        toMapsBtn.isVisible = true
    end
end

--- This function handles what happens when this scene is going to be hidden
--@param event The event object on which this function was called
function scene:hide(event)
    local rootGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        toMapsBtn.isVisible = false
    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen
        timer.cancel(cloudTimer)
        timer.cancel(carTimer)
        timer.cancel(carSpawner)
    end
	fancy_log("Main Menu is hid")
end

--- This function runs only when this scene is explicitly destroyed
--@param event The event object on which this function was called
function scene:destroy(event)
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
	fancy_log("Main Menu destroyed")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene



local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local staticImages = nil
local toMapsBtn = nil

local cloudGroup = nil
local cloudTimer = nil

function createCloud(group, isInit)
    local x = nil
    local y = nil
    local scale = nil
    local picNum = nil

    if isInit then
      x = math.random(display.actualContentWidth)
    else
      x = math.random(-50, 0)
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
    table.insert(cloudGroup, cloudHolder)
end

function createGroup(parent)
    local g = display.newGroup()
    g.x = 0
    g.y = 0
    parent:insert(g)
    return g
end

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


function scene:create(event)
    local rootGroup = self.view
    cloudGroup = {} --createGroup(rootGroup)

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

    --rootGroup:insert(cloudGroup)

    fancy_log("Main Menu created")
end

function scene:show(event)
    local rootGroup = self.view
    local phase = event.phase

    local function move()
        for k,v in pairs(cloudGroup) do
            v.group.x = v.group.x + v.speed
        end
    end
    local function delete()
        local count = 0
        for _ in pairs(cloudGroup) do count = count + 1 end
        for i=count, 1, -1 do
            if cloudGroup[i].group.x > display.actualContentWidth then
                cloudGroup[i].group:removeSelf()
                cloudGroup[i].group = nil
                table.remove(cloudGroup, i)
                createCloud(cloudGroup, false)
            end
        end
    end

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        cloudTimer = timer.performWithDelay(1000 / 60, function() move() delete() end, 0)
    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
        toMapsBtn.isVisible = true
    end
end

function scene:hide(event)
    local rootGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        toMapsBtn.isVisible = false
    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen
        timer.cancel(cloudTimer)
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end



scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

-- Modified by Nagy Bence
-- 2018.03.15

-- This file contains the UI element objects for the maps screen


local maps  = {}
local initialized = false

local function handleLevelSelect(event)
	if ("ended" == event.phase) then
		-- identify which button was pressed by its id
		screenController.levelScreen(event.target.id)
    end
end

local function handleBackToMainMenu(event)
	if ("ended" == event.phase) then
		screenController.mainScreen()
    end
end

local mapsText = nil
local level1Btn = nil
local level2Btn = nil
local level3Btn = nil
local level4Btn = nil
local mainMenuBtn = nil
local zoomInBtn = nil
local zoomOutBtn = nil
local BcGrWidht = display.contentWidth
local BcGrHeight = display.contentHeight

-- The all item's group
group = display.newGroup()


--Nagyítás ideiglenes
group.xScale = 2 
group.yScale = 2
--Nagyítás ideiglenes



function zoomIn()
    if(group.xScale < 4 ) then
		group.xScale = group.xScale + 0.5  
		group.yScale = group.yScale + 0.5
		BcGrWidht = display.contentWidth * group.xScale
		BcGrHeight = display.contentHeight * group.yScale
	end
end
function zoomOut()
	if(group.xScale > 1) then
   		group.xScale = group.xScale - 0.5  
		group.yScale = group.yScale - 0.5
		BcGrWidht = display.contentWidth * group.xScale
		BcGrHeight = display.contentHeight * group.yScale
	end
end


local function init()
	background = display.newImageRect( "assets/map/map_with_districts.png", 320, 570 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	group:insert(background)
	--[[mapsText = display.newText("MAPS SCREEN", display.contentCenterX, display.contentCenterY + 120, native.systemFont, 30)
	mapsText:setFillColor(12, 230, 90)]]
	alpha=0

	if initialized then
		level1Btn.isVisible = true
		level2Btn.isVisible = true
		level3Btn.isVisible = true
		level4Btn.isVisible = true
		mainMenuBtn.isVisible = true
		zoomInBtn.isVisible = true
		zoomOutBtn.isVisible = true
	else
		-- initialize level buttons

		level1Btn = widget.newButton(
			{
			id = "1",
			x = 80,
			y = 211,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} },
			--start to left upper side clockwise 
			vertices = { -4,-12, 7,-11, 8,12, -2,12, -8,0 },
			shape = "polygon"
			})
		group:insert(level1Btn)
		
		level2Btn = widget.newButton(
			{
			id = "2",
			x = 45,
			y = 209-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} },
			--start to left upper side clockwise 
			vertices = { -37,-33, -5,-33, 21,8, 35,8, 37,33, 1,24, -34,27 },
			shape = "polygon",
			})
		group:insert(level2Btn)

		level3Btn = widget.newButton(
			{
			id = "3",
			x = 69,
			y = display.contentCenterY - 110,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} },
			--start to left upper side clockwise 
			vertices = { -25,-30, 5,-33, -5,-58, 30,-58, 30,-20, 23,25, 0,25 },
			shape = "polygon",
			})
		group:insert(level3Btn)

		level4Btn = widget.newButton(
			{
			id = "4",
			x = 69,
			y = display.contentCenterY - 110,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} },
			--start to left upper side clockwise 
			vertices = { -25,-25, 25,-25, 25,25, -25,25 },
			shape = "polygon",
			})
		group:insert(level4Btn)
	
			
		--[[mainMenuBtn = widget.newButton(
			{
			label = "MAIN MENU",
			x = display.contentCenterX,
			y = display.contentCenterY + 200,
			width = 150,
			height = 35,
			onEvent = handleBackToMainMenu,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})]]

		-- initialize zoom buttons
		zoomInBtn = widget.newButton(
			{
			label = "+",
			x = display.contentWidth-20,
			y =  - 20,
			width = 30,
			height = 30,
			onPress = zoomIn,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect",
			})
		zoomOutBtn = widget.newButton(
			{
			label = "-",
			x = display.contentWidth-20,
			y =  15,
			width = 30,
			height = 30,
			onPress = zoomOut,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect",
			})
		initialized = true
	end
end
maps.init = init

local function dragScreen( event )
 
	local screen = event.target
    local phase = event.phase
    if ( "began" == phase ) then
        -- Set touch focus on the screen
        display.currentStage:setFocus( screen )
        -- Store initial offset position
        screen.touchOffsetX = event.x - screen.x
        screen.touchOffsetY = event.y - screen.y

	elseif ( "moved" == phase  ) then
        -- Move the screen to the new touch position
        screen.x = event.x - screen.touchOffsetX
		screen.y = event.y - screen.touchOffsetY


		--TRING
        --[[if(screen.x < 0) then
            screen.x = 0 
		end
		if(screen.x + screen.touchOffsetX < screen.width*group.xScale) then
            screen.x = 0 
		end
		print("screen.touchOffsetX:(ahol megfogtam)")
		print(screen.touchOffsetX)
		print("screen.x:(megfogashoz kepesti mozddulas)")
		print(screen.x)
		print("event.x:(jelenlegi pozi a sreenen)")
		print(event.x)
		print("screen.width:(konstans)")
		print(screen.width)
		print(BcGrWidht)


		if(screen.y < 0) then
            screen.y = 0
            
		end
		
        if(screen.x > display.contentWidth*screen.xScale-screen.width) then
            screen.x = display.contentWidth-screen.width
            
		end
		if(screen.y > display.contentHeight-screen.height) then
            screen.y = display.contentHeight-screen.height
            
        end]]
        

    elseif ( "ended" == phase or "cancelled" == phase ) then
        -- Release touch focus on the screen
        display.currentStage:setFocus( nil )
    end
    return true
end

group:addEventListener( "touch", dragScreen )

local function hide()
	if initialized then
		display.remove(mapsText)
		level1Btn.isVisible = false
		level2Btn.isVisible = false
		level3Btn.isVisible = false
		level4Btn.isVisible = false
		mainMenuBtn.isVisible = false
		zoomInBtn.isVisible = false
		zoomOutBtn.isVisible = false
	end
end
maps.hide = hide

return maps
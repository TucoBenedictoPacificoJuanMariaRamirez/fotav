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
local level5Btn = nil
local level6Btn = nil
local level7Btn = nil
local level8Btn = nil
local level9Btn = nil
local level10Btn = nil
local level11Btn = nil
local level12Btn = nil
local level13Btn = nil
local level14Btn = nil
local level15Btn = nil
local level16Btn = nil
local level17Btn = nil
local level18Btn = nil
local level19Btn = nil
local level20Btn = nil
local level21Btn = nil
local level22Btn = nil
local level23Btn = nil
local mainMenuBtn = nil
local zoomInBtn = nil
local zoomOutBtn = nil

local BcGrWidht = display.contentWidth
local BcGrHeight = display.contentHeight

-- The all item's group
group = display.newGroup()


--Nagyítás ideiglenes
group.xScale = 1.5 
group.yScale = 1.5
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
	
	--alpha
	alpha=0
	--alpha


	if initialized then
		level1Btn.isVisible = true
		level2Btn.isVisible = true
		level3Btn.isVisible = true
		level4Btn.isVisible = true
		level5Btn.isVisible = true
		level6Btn.isVisible = true
		level7Btn.isVisible = true
		level8Btn.isVisible = true
		level9Btn.isVisible = true
		level10Btn.isVisible = true
		--[[level11Btn.isVisible = true
		level12Btn.isVisible = true
		level13Btn.isVisible = true
		level14Btn.isVisible = true
		level15Btn.isVisible = true
		level16Btn.isVisible = true
		level17Btn.isVisible = true
		level18Btn.isVisible = true
		level19Btn.isVisible = true
		level20Btn.isVisible = true
		level21Btn.isVisible = true
		level22Btn.isVisible = true
		level23Btn.isVisible = true]]
		mainMenuBtn.isVisible = true
		zoomInBtn.isVisible = true
		zoomOutBtn.isVisible = true
	else
		-- initialize level buttons

		level1Btn = widget.newButton(
			{
			id = "1",
			x = 80,
			y = 256-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} , over={1,0,0,alpha} },
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
			fillColor = { default={0,0,1,alpha} , over={0,0,1,alpha}},
			--start to left upper side clockwise 
			vertices = { -37,-33, -5,-33, 21,8, 35,8, 37,33, 20,33, 1,24, -34,27 },
			shape = "polygon",
			})
		group:insert(level2Btn)

		level3Btn = widget.newButton(
			{
			id = "3",
			x = 65,
			y = 175-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { -33,-30, 5,-33, -5,-58, 30,-58, 30,-20, 23,25, 0,25 },
			shape = "polygon",
			})
		group:insert(level3Btn)

		level4Btn = widget.newButton(
			{
			id = "4",
			x = 134,
			y = 174-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { -10,-35, 18,-35, 19,-7, 6,36, -18,27 },
			shape = "polygon",
			})
		group:insert(level4Btn)

		level5Btn = widget.newButton(
			{
			id = "5",
			x = 111.5,
			y = 276-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { -8,-14, 2,-14, 7,2, 8,14, -3,10 },
			shape = "polygon",
			})
		group:insert(level5Btn)

		level6Btn = widget.newButton(
			{
			id = "6",
			x = 125,
			y = 262-45,
			onEvent = handleLevelSelect,
			fillColor = { default={0,0,1,alpha} , over={0,0,1,alpha}},
			--start to left upper side clockwise 
			vertices = { 3,-14, 12,-8, -1,13, -7,-2 },
			shape = "polygon",
			})
		group:insert(level6Btn)

		level7Btn = widget.newButton(
			{
			id = "7",
			x = 133,
			y = 270-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,alpha} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { 2,-14, 12,-4, -7,9, -12,5 },
			shape = "polygon",
			})
		group:insert(level7Btn)

		level8Btn = widget.newButton(
			{
			id = "8",
			x = 144,
			y = 285-45,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,0.3} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { -16,-4, -3,-14, 16,-14, 16,-1, 10,14, -16,4 },
			shape = "polygon",
			})
		group:insert(level8Btn)

		level9Btn = widget.newButton(
			{
			id = "9",
			x = 143,
			y = 312-45,
			onEvent = handleLevelSelect,
			fillColor = { default={0,0,1,alpha} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { -24,-22, 23,-5, -3,29, -28,-16},
			shape = "polygon",
			})
		group:insert(level9Btn)

		level10Btn = widget.newButton(
			{
			id = "10",
			x = 196,
			y = 279-45,
			onEvent = handleLevelSelect,
			fillColor = { default={0,0,1,0.3} , over={1,0,0,alpha}},
			--start to left upper side clockwise 
			vertices = { -33,-12, 0,-25, 37,-16, 24,20, 15,25, -15,20, -37,12 },
			shape = "polygon",
			})
		group:insert(level10Btn)


		--[[level5Btn = widget.newButton(
			{
			id = "5",
			x = 135,
			y = 174,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,0.3} },
			--start to left upper side clockwise 
			vertices = { -25,-25, 25,-25, 25,25, -25,25 },
			shape = "polygon",
			})
		group:insert(level5Btn)]]
	
			
		mainMenuBtn = widget.newButton(
			{
			label = "MAIN MENU",
			x = display.contentCenterX,
			y = display.contentCenterY + 200,
			width = 150,
			height = 35,
			onEvent = handleBackToMainMenu,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})

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
		--[[ level2Btn.isVisible = false
		level3Btn.isVisible = false
		level4Btn.isVisible = false
		level5Btn.isVisible = false
		level6Btn.isVisible = false
		level7Btn.isVisible = false
		level8Btn.isVisible = false
		level9Btn.isVisible = false
		level10Btn.isVisible = false
		--[[level11Btn.isVisible = false
		level12Btn.isVisible = false
		level13Btn.isVisible = false
		level14Btn.isVisible = false
		level15Btn.isVisible = false
		level16Btn.isVisible = false
		level17Btn.isVisible = false
		level18Btn.isVisible = false
		level19Btn.isVisible = false
		level20Btn.isVisible = false
		level21Btn.isVisible = false
		level22Btn.isVisible = false
		level23Btn.isVisible = false]]
		mainMenuBtn.isVisible = false
		zoomInBtn.isVisible = false
		zoomOutBtn.isVisible = false
	end
end
maps.hide = hide

return maps
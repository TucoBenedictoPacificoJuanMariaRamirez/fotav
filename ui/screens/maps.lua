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

-- The all item's group
group1 = display.newGroup()

function zoomIn()
    if(group1.xScale < 4 ) then
		group1.xScale = group1.xScale + 0.5  
		group1.yScale = group1.yScale + 0.5
	end
end
function zoomOut()
	if(group1.xScale ~= 1) then
   		 group1.xScale = group1.xScale - 0.5  
		group1.yScale = group1.yScale - 0.5
	end
end


local function init()
	background = display.newImageRect( "assets/map/map_with_districts.png", 320, 570 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	group1:insert(background)
	mapsText = display.newText("MAPS SCREEN", display.contentCenterX, display.contentCenterY + 120, native.systemFont, 30)
	mapsText:setFillColor(12, 230, 90)
	
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
			x = 60,
			y = display.contentCenterY - 100,
			width = 100,
			height = 30,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,0.2}, over={1,0.1,0.7,0.4} },
			vertices = { 50,-50, 50,0, 45,50, 25,50 ,-20,-20, 20,-20, 20,-50},
			shape = "polygon",
			})
		group1:insert(level1Btn)
		
		--[[level2Btn = widget.newButton(
			{
			label = "LEVEL 2",
			id = "2",
			x = display.contentWidth - 100,
			y = display.contentCenterY - 60,
			width = 100,
			height = 30,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})
		level3Btn = widget.newButton(
			{
			label = "LEVEL 3",
			id = "3",
			x = 100,
			y = display.contentCenterY,
			width = 100,
			height = 30,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})
		level4Btn = widget.newButton(
			{
			label = "LEVEL 4",
			id = "4",
			x = display.contentWidth - 100,
			y = display.contentCenterY,
			width = 100,
			height = 30,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})
			
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

function group1:touch( event )
	if event.phase == "began" then
	
		display.getCurrentStage():setFocus( event.target )
		self.markX = self.x    -- store x location of object
		self.markY = self.y    -- store y location of object
	
	elseif event.phase == "moved" then
	
		local x = (event.x - event.xStart) + self.markX
		local y = (event.y - event.yStart) + self.markY
	
		self.x, self.y = x, y
	
	elseif event.phase == "ended"  or event.phase == "cancelled" then
	
		display.getCurrentStage():setFocus(nil)
	
	end
	return true	
end

local function hide()
	if initialized then
		display.remove(mapsText)
		level1Btn.isVisible = false
		--[[ level2Btn.isVisible = false
		level3Btn.isVisible = false
		level4Btn.isVisible = false
		mainMenuBtn.isVisible = false ]]
		zoomInBtn.isVisible = false
		zoomOutBtn.isVisible = false
	end
end
maps.hide = hide

return maps
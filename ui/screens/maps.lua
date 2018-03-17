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

local function init()
	mapsText = display.newText("MAPS SCREEN", display.contentCenterX, display.contentCenterY + 120, native.systemFont, 30)
	mapsText:setFillColor(12, 230, 90)
	
	if initialized then
		level1Btn.isVisible = true
		level2Btn.isVisible = true
		level3Btn.isVisible = true
		level4Btn.isVisible = true
		mainMenuBtn.isVisible = true
	else
		-- initialize level buttons
		level1Btn = widget.newButton(
			{
			label = "LEVEL 1",
			id = "1",
			x = 100,
			y = display.contentCenterY - 60,
			width = 100,
			height = 30,
			onEvent = handleLevelSelect,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			shape = "roundedRect"
			})
		level2Btn = widget.newButton(
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
			})
		initialized = true
	end
end
maps.init = init

local function hide()
	if initialized then
		display.remove(mapsText)
		level1Btn.isVisible = false
		level2Btn.isVisible = false
		level3Btn.isVisible = false
		level4Btn.isVisible = false
		mainMenuBtn.isVisible = false
	end
end
maps.hide = hide

return maps
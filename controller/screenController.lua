-- Modified by Nagy Bence
-- 2018.03.15

-- This file controls what is currently on the screen
-- Basically the main controller of the app

local screenController = {}

widget = require("widget")

local mainMenuUI = require("ui.screens.mainMenu")
local mapsScreenUI = require("ui.screens.maps")

-- this stores the current level object (from the levels array below)
currentLevel = nil

-- loading levels
local levels = {}
for i = 1, 4 do
	levels[i] = require("ui.levels.level" .. tostring(i))
end

local function initialize()
	mainMenuUI.init()
	mainMenuUI.hide()
	mapsScreenUI.init()
	mapsScreenUI.hide()
end
screenController.initialize = initialize

local function mainScreen()
	mapsScreenUI.transition(false)
	mainMenuUI.transition(true)
end
screenController.mainScreen = mainScreen

local function mapsScreen()
	mainMenuUI.transition(false)
	if currentLevel ~= nil then
		currentLevel.hide()
	end
	mapsScreenUI.transition(true)
end
screenController.mapsScreen = mapsScreen

local function levelScreen(level)
	mapsScreenUI.hide()
	--currentLevel = levels[tonumber(level)]
	--levels[tonumber(level)].init()

	-- Extract number from level parameter
	level = string.match(level, "%d+")
	currentLevel = require("ui.screens.level")
	currentLevel.init(tonumber(level))
	fancy_log("Changed screen to " .. level)
end
screenController.levelScreen = levelScreen

return screenController

-- Modified by Nagy Bence
-- 2018.03.15

-- This file controls what is currently on the screen
-- Basically the main controller of the app

local screenController = {}

widget = require("widget")

local mainMenuUI = require("ui.screens.mainMenu")
local mapsScreenUI = require("ui.screens.maps")

local function mainScreen()
	-- Use pcall in case we get nil error
	mapsScreenUI.hide()
	-- This loads all the objects in the mainMenu.lua
	mainMenuUI.init()
	-- code
end
screenController.mainScreen = mainScreen

local function mapsScreen()
	-- Use pcall in case we get nil error
	mainMenuUI.hide()
	-- This loads all the objects in the maps.lua
	mapsScreenUI.init()
	-- code
end
screenController.mapsScreen = mapsScreen

local function levelScreen()
	-- code
	-- TODO
end
screenController.levelScreen = levelScreen

return screenController
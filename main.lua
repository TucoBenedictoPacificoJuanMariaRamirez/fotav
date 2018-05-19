--- Fotav project main file
-- @module main

-- @author Fehér Szabolcs Gál Martin Nagy Bence Szabó Dániel
-- Fehér Szabolcs
-- Gál Martin
-- Nagy Bence
-- Szabó Dániel

-- This file is the entry point of the whole app

-- The composer manages the screens and everything related to them
local composer = require("composer")

--- This function provied better logging
--@param message A message to print out to the console. nil check is done before printing
function fancy_log(message)
	if message == nil then
		print("----------------------\n\tCannot log nil value, watch out!\t\n----------------------")
	else
		print("----------------------\n\t" .. message .. "\t\n----------------------")
	end
end

-- local background = display.newImageRect( "assets/start_screen/background_blue.png", display.actualContentWidth, display.actualContentHeight )
-- background.x = display.contentCenterX
-- background.y = display.contentCenterY

--local loadingText = display.newText("LOADING", display.contentCenterX, display.contentCenterY, native.systemFont, 30)
--loadingText:setFillColor(255, 255, 255)

-- This is probably unnecessary, later we'll see
--local assetManager = require("controller.assetManager")
--assetManager.loadAssets()


--display.remove(loadingText)
-- Pass control to the screenController file
-- screenController = require("controller.screenController")
-- screenController.initialize()
--screenController.mapsScreen()
-- screenController.mainScreen()
-- local options = {
--     effect = "fromTop",
--     time = 500,
--     params = {
--         someKey = "someValue",
--         someOtherKey = 10
--     }
-- }
composer.gotoScene("ui.screens.mainMenu")

-- Unit tests
-- require "tests.testsmain"

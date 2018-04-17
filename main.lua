-- Modified by Nagy Bence
-- 2018.03.15

-- This file is the entry point of the whole app

function fancy_log(message)
	if message == nil then
		print("----------------------\n\tCannot log nil value, watch out!\t\n----------------------")
	else
		print("----------------------\n\t" .. message .. "\t\n----------------------")
	end
end

local background = display.newImageRect( "assets/start_screen/background_blue.png", display.actualContentWidth, display.actualContentHeight )
background.x = display.contentCenterX
background.y = display.contentCenterY

local loadingText = display.newText("LOADING", display.contentCenterX, display.contentCenterY, native.systemFont, 30)
loadingText:setFillColor(255, 255, 255)

-- This is probably unnecessary, later we'll see
--local assetManager = require("controller.assetManager")
--assetManager.loadAssets()

display.remove(loadingText)
-- Pass control to the screenController file
screenController = require("controller.screenController")
--screenController.mapsScreen()
screenController.mainScreen()


require "tests.testsmain"

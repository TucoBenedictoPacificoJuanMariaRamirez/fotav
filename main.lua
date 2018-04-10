-- Modified by Nagy Bence
-- 2018.03.15

-- This file is the entry point of the whole app

local background = display.newImageRect( "assets/background.png", 360, 570 )
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
screenController.mainScreen()


require "tests.testsmain"

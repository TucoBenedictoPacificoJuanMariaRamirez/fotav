-- This screen apperas after one game finished

local composer = require("composer")
local widget = require("widget")
local endGameScene = composer.newScene()

function handleEvent()
	composer.gotoScene("ui.screens.maps")
end

function endGameScene:create(event)
	local everything = self.view
	local params = event.params
	
	-- Remove level scene, so it will be recreated again for the next game
	composer.removeScene("ui.screens.level")
	text = display.newText("THIS IS THE ENDGAME SCREEN", display.contentCenterX, display.contentCenterY, native.systemFont, 15)
	
	mainMenuBtn = widget.newButton(
		{
		label = "Back to the map",
		labelColor = { default={ 1, 1, 1, 1}, over={ 0, 0, 0, 0.5 } },
		x = display.contentCenterX,
		y = display.contentCenterY + 200,
		width = 150,
		height = 30,
		onPress = handleEvent,
		fillColor = { default={0,0,1,1}, over={1,0.15,0.2,0.5} },
		shape = "roundedRect"
	})
	fancy_log("Endgame created")
end

function endGameScene:show(event)
	local everything = self.view
	
	mainMenuBtn.isVisible = true
	fancy_log("Endgame showed")
end

function endGameScene:hide(event)
	local everything = self.view
	
	mainMenuBtn.isVisible = false
	display.remove(text)
	fancy_log("Endgame hid")
end

function endGameScene:destroy(event)
	local sceneGroup = self.view
	fancy_log("Endgame destroyed")
end

function storeMapResult(map, score)
	local path = system.pathForFile( "mapResults", system.ApplicationSupportDirectory )
	local fh = io.open( path, "r" )
	
	if not fh then -- File open failed, it is the first time, so it must be created
		createGameDataFile(path)
	end
	
	local contents = fh:read( "*a" )
	-- TODO: change values and write them back to file
	  
	io.close( fh )
end

function createGameDataFile(path)
	-- Create file since it doesn't exist yet
	fh = io.open( path, "w" )
 
	if fh then
		for i=1,23 do
		-- first field is the map[i]
		-- second field is the rating, default 0
		-- third field is the best time on that map
		fh:write( "map" .. tostring(i) .. ",0,-1")
		fancy_log("Game Data file created")
	end
	else
		fancy_log("Failed to create Game Data file")
	end
	io.close( fh )
end

endGameScene:addEventListener("create", endGameScene)
endGameScene:addEventListener("show", endGameScene)
endGameScene:addEventListener("hide", endGameScene)
endGameScene:addEventListener("destroy", endGameScene)

return endGameScene
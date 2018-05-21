--- end game scene - This screen apperas after one game finished
--@module endGame

local composer = require("composer")
local widget = require("widget")
local endGameScene = composer.newScene()
local endGameText = nil
local score = nil
local background = nil
local empty_star1, empty_star2, empty_star3 = nil
local star1, star2, star3 = nil

function handleEvent()
	composer.gotoScene("ui.screens.maps")
end

--- This function creates the scene the first time before it's used
--@param event The event object on which this function was called
function endGameScene:create(event)
	local everything = self.view
	local params = event.params
	score = params.score
	
	background = display.newImageRect( "assets/map/background.png", 320, 570 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	everything:insert(background)
	
	empty_star1 = display.newImageRect("assets/endscreen/star_line.png", 80, 80)
	empty_star1.x = 70
	empty_star1.y = 160
	everything:insert(empty_star1)
	
	empty_star2 = display.newImageRect("assets/endscreen/star_line.png", 80, 80)
	empty_star2.x = 150
	empty_star2.y = 160
	everything:insert(empty_star2)
	
	empty_star3 = display.newImageRect("assets/endscreen/star_line.png", 80, 80)
	empty_star3.x = 230
	empty_star3.y = 160
	everything:insert(empty_star3)
	
	star1 = display.newImageRect("assets/endscreen/star.png", 80, 80)
	star1.x = 70
	star1.y = 160
	everything:insert(star1)
	star1.isVisible = false
	
	star2 = display.newImageRect("assets/endscreen/star.png", 80, 80)
	star2.x = 150
	star2.y = 160
	everything:insert(star2)
	star2.isVisible = false
	
	star3 = display.newImageRect("assets/endscreen/star.png", 80, 80)
	star3.x = 230
	star3.y = 160
	everything:insert(star3)
	star3.isVisible = false
	
	-- Remove level scene, so it will be recreated again for the next game
	composer.removeScene("ui.screens.level")
	
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

--- This function handles what happens when this scene is shown.
-- It always runs after the first create function
--@param event The event object on which this function was called
function endGameScene:show(event)
	local everything = self.view
	if score == 0 then
		endGameText = display.newText("Hát ez most nem sikerült :(", display.contentCenterX, display.contentCenterY, native.systemFont, 25)
	elseif score == 1 then
		endGameText = display.newText("Majd legközelebb jobb lesz", display.contentCenterX, display.contentCenterY, native.systemFont, 25)
		star1.isVisible = true
	elseif score == 2 then
		endGameText = display.newText("Szép eredmény", display.contentCenterX, display.contentCenterY, native.systemFont, 25)
		star1.isVisible = true
		star2.isVisible = true
	elseif score == 3 then
		endGameText = display.newText("Tökéletes! :)", display.contentCenterX, display.contentCenterY, native.systemFont, 25)
		star1.isVisible = true
		star2.isVisible = true
		star3.isVisible = true
	end
	everything:insert(endGameText)
	
	endGameText:setTextColor(60, 64, 10)
	
	mainMenuBtn.isVisible = true
	background.isVisible = true
	fancy_log("Endgame showed")
end

--- This function handles what happens when this scene is going to be hidden
--@param event The event object on which this function was called
function endGameScene:hide(event)
	local everything = self.view
	
	mainMenuBtn.isVisible = false
	background.isVisible = false
	display.remove(endGameText)
	
	fancy_log("Endgame hid")
end

--- This function runs only when this scene is explicitly destroyed
--@param event The event object on which this function was called
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
		for i = 1, 23 do
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
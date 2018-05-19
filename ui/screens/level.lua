require("math")

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local logic = require("logic.logic")

local houseTempLabels = {}
local pipeTempLabels = {}
local pipeButtons = {}
local levelTime = nil
local levelTimer = nil
local levelNumber = nil

local housesCount = nil
local pipesCount = nil

local function handleBackToMap(event)
	if ("ended" == event.phase) then
		composer.gotoScene("ui.screens.maps")
	end
end

function scene:create(event)
	local everything = self.view
	local params = event.params
	levelNumber = params.level

	if logic.createLevel(params.level) < 0 then
		print("ERROR: Level could not be loaded.")
		-- for some reason it cannot return to maps (only black screen appears)
		composer.gotoScene("ui.screens.mainMenu")
		composer.removeScene("ui.screens.level")
		return
	end
	
	housesCount = tableLength(logic.houses)
	pipesCount = tableLength(logic.pipes)

	staticBackground = display.newImageRect("assets/map/background.png", display.actualContentWidth, display.actualContentHeight)
	staticBackground.x = display.contentCenterX;
	staticBackground.y = display.contentCenterY;
	everything:insert(staticBackground);
	
	levelImage = display.newImageRect(logic.levelImage, display.actualContentWidth, display.actualContentHeight)
	levelImage.x = display.contentCenterX;
	levelImage.y = display.contentCenterY;
	everything:insert(levelImage);

	do
		for i = 1, housesCount do
			newHouseLabel = display.newText("", logic.houses["h" .. i].tempLabelPos.x, logic.houses["h" .. i].tempLabelPos.y, native.systemFont, 30)
			table.insert(houseTempLabels, newHouseLabel)
			everything:insert(newHouseLabel)
		end
	end
	
	do
		for i = 1, pipesCount do
			newPipeLabel = display.newText(logic.pipes["p" .. i].temp, logic.pipes["p" .. i].tempLabelPos.x, logic.pipes["p" .. i].tempLabelPos.y, native.systemFont, 30)
			table.insert(pipeTempLabels, newPipeLabel)
			everything:insert(newPipeLabel)
			newPipeBtn = widget.newButton({
				id = i,
				x = logic.pipes["p" .. i].btnPos.x,
				y = logic.pipes["p" .. i].btnPos.y,
				radius = 30,
				onEvent = logic.pipeTap,
				fillColor = { default={ 0, 0, 0, 0.01 }, over={ 0, 0, 0, 0.01 } },
				shape = "circle"
			})
			table.insert(pipeButtons, newPipeBtn)
			everything:insert(newPipeBtn)
		end
	end
	
	levelTime = display.newText("", logic.levelTimePos.x, logic.levelTimePos.y, native.systemFont, 18)

	everything:insert(levelTime)
	
	fancy_log("Level " .. tostring(levelNumber) .. " created")
	print("rating: "..rating())
end

function scene:show(event)
	local everything = self.view
	local phase = event.phase

	if (phase == "will") then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
	logic.tappable = true
  elseif (phase == "did") then
    -- Code here runs when the scene is entirely on screen
		local function updateUI()
			for i = 1, housesCount do
				houseTempLabels[i].text = logic.getCurrentTempOf("h" .. i)
			end
			--text.text = logic.getCurrentTempOf("h1")
			if logic.remaining < 0.005 then
				levelTime.text = "--"
			else 
				levelTime.text = math.floor(logic.remaining)
			end
			
			if not logic.tappable then 
				timer.cancel(levelTimer)
				local endGameOptions = {
				  effect = "fromTop",
				  time = 500,
				  params = {
					  score = 2
				  }
				}
				composer.gotoScene("ui.screens.endGame", endGameOptions)
			end
		end

		local ms = 10
		levelTimer = timer.performWithDelay(ms, updateUI, (logic.remaining)*1000/ms)
		logicTimer(logic.time)
		endCheck()
  end
  fancy_log("Level " .. tostring(levelNumber) .. " showed")
end

function scene:hide(event)
	local everything = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is on screen (but is about to go off screen)
	elseif (phase == "did") then
		-- Code here runs immediately after the scene goes entirely off screen
		if (levelTimer ~= nil) then
			timer.cancel(levelTimer)
		end
	end
	fancy_log("Level " .. tostring(levelNumber) .. " hid")
end

function scene:destroy(event)
	local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view
  fancy_log("Level " .. tostring(levelNumber) .. " destroyed")
end


scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

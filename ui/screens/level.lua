require("math")

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

local logic = require("logic.logic")

local text = nil
local levelTime = nil
local levelTimer = nil
local levelNumber = nil

-- TODO: not implemented yet
local mapsBtn = nil
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
	--bg = display.newImageRect("assets/background.png", 360, 570)
	-- load background from logic
	-- load buttons from logic
	cso = widget.newButton({
		id = 1,
		x = display.contentCenterX,
		y = display.contentCenterY + 200,
		width = 150,
		height = 35,
		onEvent = logic.pipeTap,
		fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
		shape = "roundedRect"
	})

	text = display.newText("", display.contentCenterX, cso.y-70, native.systemFont, 30)
	levelTime = display.newText("", display.contentCenterX, 100, native.systemFont, 30)
	everything:insert(text)
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
			text.text = logic.getCurrentTempOf("h1")
			if logic.remaining < 0.005 then
				levelTime.text = "--"
			else 
				levelTime.text = math.floor(logic.remaining)
			end
			
			if not logic.tappable then 
				timer.cancel(levelTimer)
				composer.gotoScene("ui.screens.endGame")
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
		cso.isVisible = false
	elseif (phase == "did") then
		-- Code here runs immediately after the scene goes entirely off screen
		--mapsBtn.isVisible = false
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

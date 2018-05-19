local composer = require("composer")
local widget = require("widget")

local mapNotReadyOverlay = composer.newScene()

function handleEvent()
	composer.gotoScene("ui.screens.maps")
end

function mapNotReadyOverlay:create(event)
	local everything = self.view
	local params = event.params
	
	-- Remove level scene, so it will be recreated again for the next game
	composer.removeScene("ui.screens.level")
	
	mainMenuBtn = widget.newButton(
		{
		label = "Ez a pálya még nincs kész :(",
		labelColor = { default={ 1, 1, 1, 1}, over={ 0, 0, 0, 0.5 } },
		x = 0,
		y = 0,
		width = display.actualContentWidth,
		height = display.actualContentHeight,
		onPress = handleEvent,
		fillColor = { default={0,0,1,0.7}, over={1,0.15,0.2,0.5} },
		shape = "roundedRect"
	})
	fancy_log("Endgame created")
end

function mapNotReadyOverlay:show(event)
	local everything = self.view

	mainMenuBtn.isVisible = true
	fancy_log("Endgame showed")
end

function mapNotReadyOverlay:hide(event)
	local everything = self.view
	
	mainMenuBtn.isVisible = false
	fancy_log("Endgame hid")
end

function mapNotReadyOverlay:destroy(event)
	local sceneGroup = self.view
	fancy_log("Endgame destroyed")
end

mapNotReadyOverlay:addEventListener("create", mapNotReadyOverlay)
mapNotReadyOverlay:addEventListener("show", mapNotReadyOverlay)
mapNotReadyOverlay:addEventListener("hide", mapNotReadyOverlay)
mapNotReadyOverlay:addEventListener("destroy", mapNotReadyOverlay)

return mapNotReadyOverlay
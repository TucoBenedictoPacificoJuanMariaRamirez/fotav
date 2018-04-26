-- 2018.04.15. New button-construction structure implemented	(daszabo)
-- This file contains the UI element objects for the maps screen


local composer = require("composer")
local mapScene = composer.newScene()
local widget = require("widget")

--local mainMenuBtn = nil

--Contains all the buttons over the districts
local districtButtons = {}
--The data for making a button of a district:	{x, y, {vertices}}
local allVertices = {
	{80, 256-45, { -4,-12, 7,-11, 8,12, -2,12, -8,0 }}, --1
	{45, 209-45, {-37,-33, -5,-33, 21,8, 35,8, 37,33, 20,33, 1,24, -34,27 }}, --2
	{64, 175-45, {-38,-33, 3,-36, -6,-58, 30,-58, 32,-20, 23,25, 0,25 }}, --3
	{134, 174-45, {-10,-35, 18,-35, 19,-7, 6,36, -18,27 }}, --4
	{111.5, 276-45, { -8,-14, 2,-14, 7,2, 8,14, -3,10 }}, --5
	{125, 262-45, { 3,-14, 12,-8, -1,13, -7,-2 }}, --6
	{133, 270-45, { 2,-14, 12,-4, -7,9, -12,5 }}, --7
	{144, 285-45, { -16,-4, -3,-14, 16,-14, 16,-1, 10,14, -16,4 }}, --8
	{143, 312-45, { -23,-21, 23,-3, -3,29, -28,-13}}, --9
	{196, 279-45, { -33,-12, 0,-25, 37,-16, 24,20, 14,17, 15,25, -15,20, -37,12 }}, --10 210 296
	{70, 308-45, { -33,-18, 17,-38, 31,-19, 23,25, 4,11, -3,30, -30,34 }}, --11
	{41, 262-45, {-17,-26, 29,-15, 37,12, -4,29, -22,20, -31,-10 }}, --12
	{121, 230-45, {-4,-31, 14,-16, 11,5, -8,22, -20,20, -15,-7 }}, --13
	{158, 242-45, {-13,-24, 20,-10, 31,11, -9,25, -26,5, -18,-4}}, --14
	{175, 188-45, { -13,-46, 14,-31, 29,10, 6,35, -25,21 }}, --15
	{225, 231-45, { -20,-27, 26,-26, 41,4, 14,23, -27,17, -40,-1 }}, --16
	{270, 278-45, { -21,-30, 20,-43, 38,10, 8,45, -52,23.5, -38,-11 }}, --17
	{240, 343-45, { -22,-46, 40,-25, -2,40, -37,8, -28,-5, -35,-18, -31,-35 } }, --18
	{185, 327-45, { -17,-18, 9,-14, 16,14, 7,24, -26,-3 } }, --19
	{166, 343-45, { -8,-24, 24,2, 14,14, 0,17, -19,5, -23,-7 }}, --20
	{126, 362-45, { -10,-29, 2,-29, 23,24, -20,35 } }, --21
	{71, 366-45, { -21,-18, -6,-22, 0,-41, 22,-25, 19,14, -11,24, -29,45, -35,1 }}, --22
	{195, 400-45, { -39,-36, -31,-36, -19,-30, -13,-34, 7,-38, 50,4, 7,44, -29,14 }} --23 153,361, 159,361, 173,367, 179,361, 196,359, 237,401, 196,440, 163,411
}

local zoomInBtn = nil
local zoomOutBtn = nil


local BcGrWidht = display.contentWidth
local BcGrHeight = display.contentHeight


function mapScene:create(event)
  local everything = self.view
  local group = display.newGroup()
  --group.x = display.contentCenterX
  --group.y = display.contentCenterY
  everything:insert(group)
	everything.xScale = 1
	everything.yScale = 1

	local background = display.newImageRect( "assets/map/map_with_districts.png", 320, 570 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	group:insert(background)

	--Gives the control to the level
	function handleLevelSelect(event)
		if ("ended" == event.phase and event.target.id ~= nil and string.match(event.target.id, "levelbtn")) then
			-- currentLevel = require("ui.screens.level")
			-- currentLevel.init(tonumber(level))
			local options = {
				params = {
					level = string.match(event.target.id, "%d+")
				}
			}
			composer.gotoScene("ui.screens.level", options)
			fancy_log("Changed screen to " .. options.params.level)
		end
	end
	function dragScreen( event )
		local screen = group
		local phase = event.phase
		if ( "began" == phase ) then
			-- Set touch focus on the screen
			display.currentStage:setFocus( screen )
			-- Store initial offset position
			screen.touchOffsetX = event.x - screen.x
			screen.touchOffsetY = event.y - screen.y
		elseif ( "moved" == phase  ) then
			-- Move the screen to the new touch position
			screen.x = event.x - screen.touchOffsetX
			screen.y = event.y - screen.touchOffsetY
			print("screen.x")
			print(screen.x)
			print("screen.width")
			print(screen.width)
			print("BcGrWidht")
			print(BcGrWidht)
			if(screen.x < screen.width ) then
				screen.x = screen.width
				
			end
			if(screen.x > BcGrWidht - screen.width ) then
				screen.x = 0
				
			end

			--[[if(screen.y < screen.height) then
				print("up")
				screen.y = screen.height
				
			end
			if(screen.y > display.contentHeight-screen.height) then
				print("down")
				screen.y = display.contentHeight-screen.height
				
			end]]
		elseif ( "ended" == phase or "cancelled" == phase ) then
			-- Release touch focus on the screen
			display.currentStage:setFocus( nil )
			-- SHOULD ONLY TRIGGER IF USER DID NOT DRAG TOO MUCH
			handleLevelSelect(event)
		end
		return true
	end
	--Constructs a button
	function createButton(p_id, p_x, p_y, p_vertices)
		btn = widget.newButton({
			id = p_id,
			x = p_x,
			y = p_y,
			fillColor = { default={1,0,0,0} , over={1,0,0,0} },
			vertices = p_vertices,
			shape = "polygon"
		})
		-- the dragScreen handles both the drag and the tap on buttons
		btn:addEventListener("touch", dragScreen)
		return btn
	end
	do --Initializes and adds buttons to global districtButtons table
		for i=1, 23 do
			btn = createButton("levelbtn" .. tostring(i), allVertices[i][1], allVertices[i][2], allVertices[i][3])
			btn.isVisible = true
			table.insert(districtButtons, {i, btn})
			group:insert(btn)
		end
	end
	

	local function handleEvent(event)
		local options = {
		  effect = "slideUp",
		  time = 3000,
		  params = {
			  someKey = "someValue",
			  someOtherKey = 10
		  }
		}
		composer.gotoScene("ui.screens.mainMenu", options)
	  end

	mainMenuBtn = widget.newButton(
		{
		label = "Main Menu",
		labelColor = { default={ 1, 1, 1, 1}, over={ 0, 0, 0, 0.5 } },
		x = display.contentCenterX/2,
		y = display.contentCenterY + 200,
		width = 110,
		height = 25,
		onPress = handleEvent,
		fillColor = { default={0,0,1,1}, over={1,0.1,0.7,0.4} },
		shape = "roundedRect"
	})

	everything:insert(mainMenuBtn)

	function zoomIn()
	    if(group.xScale < 4 ) then
			--group.xScale = group.xScale + 0.5
			--group.yScale = group.yScale + 0.5
			BcGrWidht = display.contentWidth * group.xScale
			BcGrHeight = display.contentHeight * group.yScale
			transition.to( title, {time=1000, transition=easing.inOutQuad, xScale=group.xScale + 0.5, yScale=group.yScale + 0.5, onComplete=group } )
		end
	end
	zoomInBtn = widget.newButton({
		label = "+",
		labelColor = { default={ 1, 1, 1, 1}, over={ 0, 0, 0, 0.5 } },
		x = display.contentWidth-20,
		y =  display.contentWidth/50,
		width = 30,
		height = 30,
		onPress = zoomIn,
		fillColor = { default={0,0,1,1}, over={1,0.1,0.7,0.4} },
		shape = "roundedRect",
	})
	everything:insert(zoomInBtn)

	function zoomOut()
		if(group.xScale > 1) then
			group.xScale = group.xScale - 0.5
			group.yScale = group.yScale - 0.5
			BcGrWidht = group.contentWidth * group.xScale
			BcGrHeight = group.contentHeight * group.yScale
		end
	end
	zoomOutBtn = widget.newButton(	{
		label = "-",
		labelColor = { default={ 1, 1, 1, 1}, over={ 0, 0, 0, 0.5 } },
		x = display.contentWidth-20,
		y =  (display.contentWidth/50)+40,
		width = 30,
		height = 30,
		onPress = zoomOut,
		fillColor = { default={0,0,1,1}, over={1,0.1,0.7,0.4} },
		shape = "roundedRect",
	})
	everything:insert(zoomOutBtn)

	everything:addEventListener( "touch", dragScreen )
	
	

	fancy_log("Maps loaded")
end

function mapScene:show(event)
	local everything = self.view
	local phase = event.phase

	if (phase == "will") then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
  elseif (phase == "did") then
    -- Code here runs when the scene is entirely on screen
		zoomInBtn.isVisible = true
		zoomOutBtn.isVisible = true
  end
end

function mapScene:hide(event)
	local everything = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		zoomInBtn.isVisible = false
		zoomOutBtn.isVisible = false
	elseif (phase == "did") then
		-- Code here runs immediately after the scene goes entirely off screen
	end
end

function mapScene:destroy(event)
	local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view
end

--[[function keyHandle(event)
	print("Asd")
	if ( event.keyName == "back" ) then
		print("Asd")
		handleEventBack(event)
		print("Asd")
    end
end

mapScene:addEventListener( "key", keyHandle )]]


mapScene:addEventListener("create", mapScene)
mapScene:addEventListener("show", mapScene)
mapScene:addEventListener("hide", mapScene)
mapScene:addEventListener("destroy", mapScene)

return mapScene


--Gives control to the main menu
-- local function handleBackToMainMenu(event)
-- 	if ("ended" == event.phase) then
-- 		screenController.mainScreen()
--     end
-- end

-- local function transition(isGoingToBeCurrent)
--   if isGoingToBeCurrent then
--     init()
--     group.y = -display.actualContentHeight
--   else
--     group.y = 0
--   end
--   transitionTimer = timer.performWithDelay(1000 / 60,
--     function()
--       if isGoingToBeCurrent then
--         group.y = group.y + 3
--         if group.y >= 0 then
--           timer.cancel(transitionTimer)
--         end
--       else
--         group.y = group.y - 3
--         if group.y <= -display.actualContentHeight then
--           hide()
--           timer.cancel(transitionTimer)
--         end
--       end
--     end, 0)
-- end

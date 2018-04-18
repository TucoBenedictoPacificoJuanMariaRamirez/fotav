-- 2018.04.15. New button-construction structure implemented	(daszabo)
-- This file contains the UI element objects for the maps screen


--Contains all the buttons over the districts
districtButtons = {}

--The data for making a button of a district:	{x, y, {vertices}}
allVertices = {
	{80, 256-45, { -4,-12, 7,-11, 8,12, -2,12, -8,0 }}, --1
	{45, 209-45, {-37,-33, -5,-33, 21,8, 35,8, 37,33, 20,33, 1,24, -34,27 }}, --2
	{65, 175-45, {-33,-30, 5,-33, -5,-58, 30,-58, 30,-20, 23,25, 0,25 }}, --3
	{134, 174-45, {-10,-35, 18,-35, 19,-7, 6,36, -18,27 }}, --4
	{111.5, 276-45, { -8,-14, 2,-14, 7,2, 8,14, -3,10 }}, --5
	{125, 262-45, { 3,-14, 12,-8, -1,13, -7,-2 }}, --6
	{133, 270-45, { 2,-14, 12,-4, -7,9, -12,5 }}, --7
	{144, 285-45, { -16,-4, -3,-14, 16,-14, 16,-1, 10,14, -16,4 }}, --8
	{143, 312-45, { -24,-22, 23,-5, -3,29, -28,-16}}, --9
	{196, 279-45, { -33,-12, 0,-25, 37,-16, 24,20, 14,17, 15,25, -15,20, -37,12 }}, --10 210 296
	{70, 308-45, { -33,-18, 17,-38, 31,-19, 23,25, 4,11, -3,30, -30,34 }}, --11
	{41, 262-45, {-17,-26, 29,-15, 37,12, -4,29, -22,20, -31,-10 }}, --12
	{121, 230-45, {-4,-31, 14,-16, 11,5, -8,22, -20,20, -15,-7 }}, --13
	{158, 242-45, {-13,-24, 20,-10, 31,11, -9,25, -26,5, -18,-4}}, --14
	{175, 188-45, { -13,-46, 14,-31, 29,10, 6,35, -25,21 }}, --15
	{225, 231-45, { -20,-27, 26,-26, 41,4, 14,23, -27,17, -40,-1 }}, --16
	{270, 278-45, { -21,-30, 20,-43, 38,10, 8,45, -52,23.5, -38,-11 }}, --17
	{240, 343-45, { -22,-46, 40,-25, -2,40, -37,8, -28,-5, -35,-18, -31,-35 } }, --18
	{}, --19
	{}, --20
	{}, --21
	{}, --22
	{} --23
}

-- The all item's group
group = display.newGroup()

group.xScale = 1.5
group.yScale = 1.5

--Gives the control to the level
local function handleLevelSelect(event)
	if ("ended" == event.phase and event.target.id ~= nil and string.match(event.target.id, "levelbtn")) then
		screenController.levelScreen(event.target.id)
    end
end

local function dragScreen( event )
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

    elseif ( "ended" == phase or "cancelled" == phase ) then
        -- Release touch focus on the screen
        display.currentStage:setFocus( nil )

		-- SHOULD ONLY TRIGGER IF USER DID NOT DRAGGED TOO MUCH
		handleLevelSelect(event)
    end
    return true
end

--Constructs a button
function createButton(p_id, p_x, p_y, p_vertices)
	btn = widget.newButton(
		{
			id = p_id,
			x = p_x,
			y = p_y,
			fillColor = { default={1,0,0,0.5} , over={1,0,0,0.5} },
			vertices = p_vertices,
			shape = "polygon"
		}
	)

	-- the dragScreen handles both the drag and the tap on buttons
	btn:addEventListener("touch", dragScreen)
	return btn
end

--Initializes and adds buttons to global districtButtons table
function initDistrictButtons(initialized)
	if initialized then
		group.isVisible = true
	else
		for i=1, 23 do
			btn = createButton("levelbtn" .. tostring(i), allVertices[i][1], allVertices[i][2], allVertices[i][3])
			btn.isVisible = true
			table.insert(districtButtons, {i, btn})
			group:insert(btn)
		end
	end
end

--Gives control to the main menu
local function handleBackToMainMenu(event)
	if ("ended" == event.phase) then
		screenController.mainScreen()
    end
end

local maps={}
local mainMenuBtn = nil
local zoomInBtn = nil
local zoomOutBtn = nil
local initialized = false

local BcGrWidht = display.contentWidth
local BcGrHeight = display.contentHeight

function zoomIn()
    if(group.xScale < 4 ) then
		group.xScale = group.xScale + 0.5
		group.yScale = group.yScale + 0.5
		BcGrWidht = display.contentWidth * group.xScale
		BcGrHeight = display.contentHeight * group.yScale
	end
end
function zoomOut()
	if(group.xScale > 1) then
   		group.xScale = group.xScale - 0.5
		group.yScale = group.yScale - 0.5
		BcGrWidht = display.contentWidth * group.xScale
		BcGrHeight = display.contentHeight * group.yScale
	end
end


local function init()
	background = display.newImageRect( "assets/map/map_with_districts.png", 320, 570 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	group:insert(background)

	initDistrictButtons(initialized)
	if initialized then
		--mainMenuBtn.isVisible = true
		zoomInBtn.isVisible = true
		zoomOutBtn.isVisible = true
	else
		 --[[mainMenuBtn = widget.newButton()
			{
				label = "MAIN MENU",
				x = display.contentCenterX,
				y = display.contentCenterY + 200,
				width = 150,
				height = 35,
				onEvent = handleBackToMainMenu,
				fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
				shape = "roundedRect"
			}) ]]

		zoomInBtn = widget.newButton(
				{
				label = "+",
				x = display.contentWidth-20,
				y =  - 20,
				width = 30,
				height = 30,
				onPress = zoomIn,
				fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
				shape = "roundedRect",
				})
		zoomOutBtn = widget.newButton(
			{
				label = "-",
				x = display.contentWidth-20,
				y =  15,
				width = 30,
				height = 30,
				onPress = zoomOut,
				fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
				shape = "roundedRect",
			})

		initialized = true
	end
	fancy_log("Maps loaded")
end
maps.init = init

group:addEventListener( "touch", dragScreen )

local function hide()
	if initialized then
		--mainMenuBtn.isVisible = false
		zoomInBtn.isVisible = false
		zoomOutBtn.isVisible = false

		-- This should NEVER be used (breaks the app)
		--display.remove(group)
		-- Instead use this:
		group.isVisible = false
	end
end
maps.hide = hide

local function transition(isGoingToBeCurrent)
  if isGoingToBeCurrent then
    init()
    group.y = -display.actualContentHeight
  else
    group.y = 0
  end
  transitionTimer = timer.performWithDelay(1000 / 60,
    function()
      if isGoingToBeCurrent then
        group.y = group.y + 3
        if group.y >= 0 then
          timer.cancel(transitionTimer)
        end
      else
        group.y = group.y - 3
        if group.y <= -display.actualContentHeight then
          hide()
          timer.cancel(transitionTimer)
        end
      end
    end, 0)
end
maps.transition = transition

return maps

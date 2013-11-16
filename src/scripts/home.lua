local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require("widget")

local menu = {
	{demo = "", message = "Core", isCategory = true},
	{demo = "", message = "Blah"},
	{demo = "", message = "Animation", isCategory = true},
	{demo = "", message = "Animation"},
	{demo = "", message = "UI", isCategory = true},
	{demo = "", message = "Themes"},
	{demo = "button", message = "Buttons"},
	{demo = "", message = "Modules", isCategory = true},
	{demo = "camera", message = "Camera"},
	{demo = "joystick", message = "Joystick"},
}

-- Handle row rendering
local function onRowRender( event )
	local phase = event.phase
	local row = event.row

	local rowTitle = fx.ui.newText(row, fx.i18n.get("Menu-"..menu[row.index].message), 0, 0, nil, 25)
	rowTitle.x = rowTitle.contentWidth * 0.5
	rowTitle.y = row.contentHeight * 0.5
	rowTitle:setTextColor( 0, 0, 0 )
end

-- Handle touches on the row
local function onRowTouch( event )
	local phase = event.phase

	if "press" == phase then
		storyboard.gotoScene("scripts.demos."..menu[event.target.index].demo)
	end
end

function scene:createScene(event)
	local sceneGroup = self.view

	local tableView = widget.newTableView
	{
		left = 0,
		top = 0,
		width = w,
		height = h,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
	}
	sceneGroup:insert(tableView)


	for i = 1, #menu do
		tableView:insertRow
		{
			isCategory = menu[i].isCategory,
			rowHeight  = 50
		}
	end

	-- fx.ui.newButton({
	-- 	id 			= "camera",
	-- 	label		= fx.i18n.get("Demos-Camera"),
	-- 	x 			= w/2,
	-- 	y     		= h*2/5,
	-- 	view		= sceneGroup,
	-- 	onRelease	= buttonPressed
	-- })

	-- fx.ui.newButton({
	-- 	id 			= "joystick",
	-- 	label 		= fx.i18n.get("Demos-Joystick"),
	-- 	x     		= w/2,
	-- 	y     		= h*3/5,
	-- 	view		= sceneGroup,
	-- 	onRelease	= buttonPressed
	-- })
end

function scene:enterScene(event)
	local sceneGroup = self.view

	appGroup:insert(sceneGroup)
end

function scene:exitScene(event)
	local sceneGroup = self.view

end

function scene:destroyScene(event)
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener("createScene", scene)

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener("enterScene", scene)

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener("exitScene", scene)

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener("destroyScene", scene)

---------------------------------------------------------------------------------

return scene
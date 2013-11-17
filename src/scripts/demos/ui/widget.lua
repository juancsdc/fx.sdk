local storyboard = require("storyboard")
local scene = storyboard.newScene()

local widget = require("widget")

fx.ui.getAsset("titleBar.png")

local function buttonPressed(event)
	native.showAlert("", event.target.id)
end

local themes = {
	"ios7",
	"android",
	"candy"
}

-- Handle row rendering
local function onRowRender( event )
	local phase = event.phase
	local row = event.row

	local rowTitle = fx.ui.newText(row, themes[row.index], 0, 0, native.SystemFontBold, 25)
	rowTitle.x = rowTitle.contentWidth * 0.5+10
	rowTitle.y = row.contentHeight * 0.5
end

-- Handle touches on the row
local function onRowTouch( event )
	local phase = event.phase

	if "press" == phase then
		fx.ui.setTheme(themes[event.target.index])
		storyboard.gotoScene("scripts.reload")
	end
end

function scene:createScene(event)
	local sceneGroup = self.view

	local title = fx.ui.newText(sceneGroup, fx.i18n.get("UI-Widget-Theme"), 0, 0, fx.theme.text.font, 40)
	title.x = w/2
	title.y = 20

	-- Create table view with themes
	local tableView = widget.newTableView
	{
		width = w/2,
		height = 300,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
	}
	for i = 1, #themes do
		tableView:insertRow
		{
			rowHeight  = 50,
		}
	end
	tableView.x = w/2
	tableView.y = 50+tableView.height/2
	sceneGroup:insert(tableView)

	-- Create buttons
	local button1 = fx.ui.newButton({
		id 			= "enabled",
		label		= fx.i18n.get("UI-Widget-Button-Enabled"),
		x 			= w/4,
		y     		= h-200,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})

	local button2 = fx.ui.newButton({
		id 			= "disabled",
		label		= fx.i18n.get("UI-Widget-Button-Disabled"),
		x 			= w/4*3,
		y     		= h-200,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})
	button2:setEnabled(false)
end

function scene:enterScene(event)
	local sceneGroup = self.view

	sideBar.content:insert(sceneGroup)
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
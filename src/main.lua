
require("fx.loader")

fx.ui.setStatusBar(display.HiddenStatusBar)

local storyboard = require "storyboard"

local menu = {
	{demo = "", message = "Core", isCategory = true},
	{demo = "", message = "Blah"},
	{demo = "", message = "Animation", isCategory = true},
	{demo = "animation.easing", message = "Easing"},
	{demo = "", message = "UI", isCategory = true},
	{demo = "ui.widget", message = "Widgets"},
	{demo = "", message = "Modules", isCategory = true},
	{demo = "modules.camera", message = "Camera"},
	{demo = "modules.joystick", message = "Joystick"},
}

-- Handle row rendering
local function onRowRender( event )
	local phase = event.phase
	local row = event.row

	local rowTitle = fx.ui.newText(row, fx.i18n.get("Menu-"..menu[row.index].message), 0, 0, native.SystemFontBold, 25)
	rowTitle.x = rowTitle.contentWidth * 0.5+10
	rowTitle.y = row.contentHeight * 0.5
end

-- Handle touches on the row
local function onRowTouch( event )
	local phase = event.phase

	if "release" == phase then
		sideBar:expandCollapse()
		storyboard.gotoScene("scripts.demos."..menu[event.target.index].demo)
	end
end

local function main()

	_G.sideBar = fx.ui.newSideBar({
		contentTitleBar = {
			label = ""
		},
		navigationTitleBar = {
			label = ""
		},
	})

	local tableView = fx.ui.newTableView
	{
		width = sideBar.navigation.width,
		height = sideBar.navigation.height,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
		view = sideBar.navigation
	}

	for i = 1, #menu do
		tableView:insertRow
		{
			isCategory = menu[i].isCategory,
		}
	end
	
	storyboard.gotoScene("scripts.demos.modules.camera", "fade", 100)

	return true
end

main()
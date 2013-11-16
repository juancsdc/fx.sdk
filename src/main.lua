system.setIdleTimer(false); -- turn off device sleeping

require("fx.loader")

fx.ui.setStatusBar(display.HiddenStatusBar)
display.setDefault( "background", unpack(fx.theme.application.bg))

local storyboard = require "storyboard"
local widget = require("widget")

local menu = {
	{demo = "", message = "Core", isCategory = true},
	{demo = "", message = "Blah"},
	{demo = "", message = "Animation", isCategory = true},
	{demo = "animation.easing", message = "Easing"},
	{demo = "", message = "UI", isCategory = true},
	{demo = "widget", message = "Widgets"},
	{demo = "", message = "Modules", isCategory = true},
	{demo = "camera", message = "Camera"},
	{demo = "joystick", message = "Joystick"},
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

	if "press" == phase then
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

	local tableView = widget.newTableView
	{
		left = 0,
		top = 0,
		width = sideBar.navigation.width,
		height = sideBar.navigation.height,
		onRowRender = onRowRender,
		onRowTouch = onRowTouch,
	}
	sideBar.navigation:insert(tableView)


	for i = 1, #menu do
		tableView:insertRow
		{
			isCategory = menu[i].isCategory,
			rowHeight  = 50
		}
	end

	
	storyboard.gotoScene("scripts.demos.animation.easing", "fade", 100)

	return true
end

main()
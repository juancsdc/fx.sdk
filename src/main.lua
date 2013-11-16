system.setIdleTimer(false); -- turn off device sleeping

require("fx.loader")

fx.ui.setStatusBar(display.HiddenStatusBar)
display.setDefault( "background", unpack(fx.theme.application.bg))

local storyboard = require "storyboard"
require "sqlite3"

local function main()

	_G.titleBar = fx.ui.newTitleBar({
		label = appInfo.name,
	})

	_G.appGroup = display.newContainer(w*2, (h-titleBar.height)*2)
	appGroup.y = titleBar.height

	local bg = display.newRect(appGroup, w/2,h/2,w,h)
	bg = fx.theme.bg

	
	storyboard.gotoScene("scripts.home", "fade", 100)

	return true
end

main()
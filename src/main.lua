system.setIdleTimer(false); -- turn off device sleeping

require("fx.loader")

fx.ui.setStatusBar(display.DefaultStatusBar)

local storyboard = require "storyboard"
require "sqlite3"

local function main()
	
	storyboard.gotoScene("scripts.home", "fade", 100)

	return true
end

main()
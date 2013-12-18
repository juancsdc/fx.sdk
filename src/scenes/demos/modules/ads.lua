local storyboard = require("storyboard")
local scene = storyboard.newScene()

local function buttonPressed(event)
	fx.ads.hide()
	if event.target.id == "top" then
		fx.ads.showBanner(0, 0, {})
	elseif event.target.id == "bottom" then
		fx.ads.showBanner(0, _h, {srpH="bottom"})
	end
end

function scene:createScene(event)
	local sceneGroup = self.view

	-- Create buttons
	local button1 = fx.ui.newButton({
		id 			= "top",
		label		= fx.i18n.get("Modules-Ads-ShowTop"),
		x 			= w/2,
		y     		= h*.25,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})

	local button1 = fx.ui.newButton({
		id 			= "bottom",
		label		= fx.i18n.get("Modules-Ads-ShowBottom"),
		x 			= w/2,
		y     		= h*.5,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})

	local button1 = fx.ui.newButton({
		id 			= "hide",
		label		= fx.i18n.get("Modules-Ads-Hide"),
		x 			= w/2,
		y     		= h*.75,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})
end

function scene:enterScene(event)
	local sceneGroup = self.view

end

function scene:exitScene(event)
	local sceneGroup = self.view

	fx.ads.hide()
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
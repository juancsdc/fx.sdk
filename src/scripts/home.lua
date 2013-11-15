local storyboard = require("storyboard")
local scene = storyboard.newScene()

local function buttonPressed(event)
	storyboard.gotoScene("scripts.demos."..event.target.id)
end

function scene:createScene(event)
	local sceneGroup = self.view

	fx.ui.newButton({
		id 			= "camera",
		label		= fx.i18n.get("Demos-Camera"),
		x 			= w/2,
		y     		= h*2/5,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})

	fx.ui.newButton({
		id 			= "joystick",
		label 		= fx.i18n.get("Demos-Joystick"),
		x     		= w/2,
		y     		= h*3/5,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})
end

function scene:enterScene(event)
	local sceneGroup = self.view


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
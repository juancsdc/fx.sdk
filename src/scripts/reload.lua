local storyboard = require("storyboard")
local scene = storyboard.newScene()

function scene:createScene(event)
	local sceneGroup = self.view
end

function scene:enterScene(event)
	local sceneGroup = self.view

	native.setActivityIndicator(true)
	storyboard.purgeAll()
	if event.params then
		storyboard.gotoScene(storyboard.getPrevious(), {params = event.params})
	else
		storyboard.gotoScene(storyboard.getPrevious(), {params = event.params})
	end
end

function scene:exitScene(event)
	local sceneGroup = self.view
	native.setActivityIndicator(false)
	if self.reloadGUI then
		_G.destroySideBar()
		_G.buildSideBar()
	end
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
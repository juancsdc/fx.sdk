local storyboard = require("storyboard")
local scene = storyboard.newScene()

function scene.onEnterFrame()
	scene.player.x = scene.player.x + 10 * math.cos(scene.joystick.joyAngle) * scene.joystick.joyPercent
	scene.player.y = scene.player.y + 10 * math.sin(scene.joystick.joyAngle) * scene.joystick.joyPercent
end

function scene:createScene(event)
	local sceneGroup = self.view

	scene.joystick = fx.joystick:new({
		allowedArea = {
			x = w/2, y = h/2, width = w, height = h
		}
	})

	-- now let's create player
	scene.player = display.newRect(sceneGroup, w/2, h/2, 50, 50)
	scene.player:setFillColor(1, 1, 1)
end

function scene:enterScene(event)
	local sceneGroup = self.view

	Runtime:addEventListener("enterFrame", scene.onEnterFrame)
end

function scene:exitScene(event)
	local sceneGroup = self.view

	Runtime:removeEventListener("enterFrame", scene.onEnterFrame)
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
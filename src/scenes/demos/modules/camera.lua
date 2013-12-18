local storyboard = require("storyboard")
local scene = storyboard.newScene()

function scene.onEnterFrame()
	local dx = 10 * math.cos(scene.joystick.joyAngle) * scene.joystick.joyPercent
	local dy = 10 * math.sin(scene.joystick.joyAngle) * scene.joystick.joyPercent
	scene.player.x = scene.player.x + dx
	scene.player.y = scene.player.y + dy
end

function scene:createScene(event)
	local sceneGroup = self.view

	scene.joystick = fx.joystick:new({
		allowedArea = {
			x = w/2, y = h/2, width = w, height = h
		},
		view = sceneGroup
	})

	-- Create a camera with default parameters (manual camera)
	scene.camera = fx.camera:new({
		view 	= sceneGroup
	})

	-- create the background
	display.setDefault("textureWrapX", "repeat")
	display.setDefault("textureWrapY", "mirroredRepeat")
	local bg = display.newRect(scene.camera, 1000, 1000, 2000, 2000)
	bg.fill = { type="image", filename="assets/space.png" }
	bg.fill.scaleX = 0.05
	bg.fill.scaleY = 0.05


	-- now let's create player
	scene.player = display.newRect(scene.camera, w/2, h/2, 50, 50)
	scene.player:setFillColor(1, 1, 1)
end

function scene:enterScene(event)
	local sceneGroup = self.view

	sideBar.content:insert(sceneGroup)

	Runtime:addEventListener("enterFrame", scene.onEnterFrame)

	scene.camera:attach(scene.player, {
		mode 	= "lazy",
		bounds	= {w/10, h/10, w-w/10, h-h/10}
	})
end

function scene:exitScene(event)
	local sceneGroup = self.view

	Runtime:removeEventListener("enterFrame", scene.onEnterFrame)
end

function scene:destroyScene(event)
	local sceneGroup = self.view

	scene.joystick:removeSelf()
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
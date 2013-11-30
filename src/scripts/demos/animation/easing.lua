local storyboard = require("storyboard")
local scene = storyboard.newScene()

local effects = {
	{time = 2500, fx = fx.animation.ease.outElastic},
	{time = 1500, fx = fx.animation.ease.outBounce},
	{time = 1000, fx = fx.animation.ease.outBack},
	{time = 2500, fx = fx.animation.ease.inElastic},
	{time = 1500, fx = fx.animation.ease.inBounce},
	{time = 1000, fx = fx.animation.ease.inBack},
	{time = 2500, fx = fx.animation.ease.inOutElastic},
	{time = 1500, fx = fx.animation.ease.inOutBounce},
	{time = 1000, fx = fx.animation.ease.inOutBack},
}

local colors = {
	{1, 0, 0},
	{0, 1, 0},
	{0, 0, 1},
}

local anim = 1

function nextAnimation()
	if anim > #effects then
		scene.startButton:setEnabled(true)
		return
	end

	if anim > #effects/3 and anim <= #effects*2/3 then
		transition.to(scene.balls[anim-#effects/3], {time = effects[anim].time, y = 120, transition=effects[anim].fx, onComplete = nextAnimation})
	elseif anim > #effects*2/3 then
		transition.to(scene.balls[anim-#effects*2/3], {time = effects[anim].time, y = h-500, transition=effects[anim].fx, onComplete = nextAnimation})
	else
		transition.to(scene.balls[anim], {time = effects[anim].time, y = h-500, transition=effects[anim].fx, onComplete = nextAnimation})
	end
	anim = anim + 1
	if anim == 3 then
		scene.startButton:setEnabled(true)
	end
end

function buttonPressed(event)
	scene.startButton:setEnabled(false)
	for i=1, #effects/3 do
		scene.balls[i].y = 120
	end
	anim = 1
	fx.timer.performWithDelay(500, nextAnimation)
end

function scene:createScene(event)
	local sceneGroup = self.view

	scene.balls = {}
	for i=1, #effects/3 do
		scene.balls[i] = display.newCircle(sceneGroup, (i)*w/(#effects/3+1), 120, w/(#effects/3+2)/2)
		scene.balls[i].fill = colors[i]
	end

	scene.startButton = fx.ui.newButton({
		id 			= "start",
		label		= fx.i18n.get("Button-Start"),
		x 			= w/2,
		y     		= h-200,
		view		= sceneGroup,
		onRelease	= buttonPressed
	})
end

function scene:enterScene(event)
	local sceneGroup = self.view

	-- put the scene in the container
	sideBar.content:insert(sceneGroup)
	sideBar:setContentTitle(fx.i18n.get("Animation-Easing-Title"))
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
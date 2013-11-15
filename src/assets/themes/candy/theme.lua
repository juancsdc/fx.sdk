_G.fx.themes["candy"] = {
	name = "candy",
	base = "android",

	button = {
		defaultFile = fx.ui.getAsset("images/button.png"),
		audio 		= "button",
		width 		= 250,
		height 		= 100,
		labelColor 	= {
			default = {1, 1, 1},
			over = {0.2, 0.2, 0.2}
		},
		onPressBehave = {
			color={0.2,0.2,0.2},
			transitionTo={time=500, xScale=0.8, yScale=0.8, transition=fx.animation.ease.outBack},
			animation = "theme",
			animationLoop = -1,
			animationOptions = {
				{time=800, xScale=0.7, yScale=0.75},
				{time=800, xScale=0.8, yScale=0.8}
			}
		},
		onReleaseBehave = {
			color={1,1,1},
			transitionTo={time=1000, xScale=1, yScale=1, transition=fx.animation.ease.outElastic},
			animation = "theme",
			animationLoop = -1,
			animationOptions = {
				{time=800, xScale=0.9, yScale=0.95},
				{time=800, xScale=1, yScale=1}
			}
		}
	},

	tableView = {
		audio 	= "button",
	},

	loadSounds = function()
		fx.sounds.addEffect("button-onPress", fx.ui.getAsset("sounds/button-onPress.wav"))
		fx.sounds.addEffect("button-onRelease", fx.ui.getAsset("sounds/button-onRelease.wav"))
		fx.sounds.addEffect("button-onCancel", fx.ui.getAsset("sounds/button-onCancel.wav"))
	end
}
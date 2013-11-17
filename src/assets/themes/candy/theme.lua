_G.fx.themes["candy"] = {
	name = "candy",
	base = "ios7",

	-- application background
	application = {
		bg = {0, 1, 0},
	},

	button = {
		defaultFile = fx.ui.getAsset("images/button.png"),
		overFile 	= fx.ui.getAsset("images/button.png"),
		audio 		= "button",
		width 		= 250,
		height 		= 100,
		labelColor 	= {
			default = {1, 1, 1},
			over = {0.2, 0.2, 0.2}
		},
		onPressBehave = {
			color={0.95,0.95,0.95},
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

	-- title bar
	titleBar = {
		fill		= {type="image", filename=fx.ui.getAsset("images/titleBar.png")},
		stroke  	= {0.7, 0.7, 0.7},	
		strokeWidth = 2,
		width		= w,
		height 		= iif(fx.device.isTablet, 44, 44*1.8),
		title 		= {
			embossed		= true,
			fontSize		= iif(fx.device.isTablet, 20, 20*1.8),
			color 			= {0, 0, 0},
			font 			= native.SystemFontBold,
		},
	},

	-- side bar
	sideBar = {
		navigation = {
			width = iif(fx.device.isTablet, w*0.5, w*0.5)
		},

		expandAnimation = {time = 300, transition = fx.animation.ease.outBounce},
		collapseAnimation = {time = 300, transition = fx.animation.ease.outBounce},
	},

	loadSounds = function()
		fx.sounds.addEffect("button-onPress", fx.ui.getAsset("sounds/button-onPress.wav"))
		fx.sounds.addEffect("button-onRelease", fx.ui.getAsset("sounds/button-onRelease.wav"))
		fx.sounds.addEffect("button-onCancel", fx.ui.getAsset("sounds/button-onCancel.wav"))
	end
}
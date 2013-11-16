_G.fx.themes["ios7"] = {
	name 		= "ios7",
	coronaTheme	= "ios7",

	-- application background
	application = {
		bg = {1, 1, 1},
	},

	-- texts
	text 	= {
		fontColor	= {0, 0, 0},
	},

	-- buttons
	button = {
		type = {
			textOnly = {
				padding = 0
			},
			image = {

			},
		},
		fontSize = iif(fx.device.isTablet, 21.7, 21.7*1.8),
	},

	-- title bar
	bar = {
		fill		= {0.95, 0.95, 0.95},
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
		textButton 	= {
			fontSize 		= iif(fx.device.isTablet, 21.7, 21.7*1.8),
			height 			= iif(fx.device.isTablet, 5, 25*1.8),
			fxType			= "textOnly",
		},
		iconButton 	= {
			fontSize 		= iif(fx.device.isTablet, 21.7, 21.7*1.8),
			width			= iif(fx.device.isTablet, 5, 25*1.8),
			height 			= iif(fx.device.isTablet, 5, 25*1.8),
			fxType			= "image",
		}
	},
}
_G.fx.themes["android"] = {
	name 		= "android",
	coronaTheme	= "android",

	-- application background
	application = {
		bgColor = {1, 1, 1}
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
		stroke  	= {0.7, 0.7, 0.7, effect="generator.marchingAnts"},
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
}
_G.fx.themes["android"] = {
	name 		= "android",
	coronaTheme	= "android",

	-- application background
	application = {
		bg = {1, 1, 1},
	},

	-- texts
	text 	= {
		font 		= native.systemFontBold,
		fontColor	= {0, 0, 0},
	},

	-- buttons
	button = {
		fontSize = iif(fx.device.isTablet, 21.7, 21.7*1.8),

		disabledBehave = {
			color={0.2,0.2,0.2},
		}
	},

	-- title bar
	titleBar = {
		fill		= {0.99, 0.99, 0.99},
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
			width = iif(fx.device.isTablet, w*3/10, w*4/10)
		},

		expandAnimation = {time = 200, transition = fx.animation.ease.outBack},
		collapseAnimation = {time = 200, transition = fx.animation.ease.outBack},
	},

	-- table view
	tableView = {
		
	},

	tableViewRow = {
		normal = {
			
		},
		selected = {
			
		}
	},
}
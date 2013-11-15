_G.fx.themes["android"] = {
	name 		= "android",
	coronaTheme	= "ios7",

	-- application background
	application = {
		bgColor = {255, 255, 255}
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
		bgColor		= {248, 248, 248},
		width		= w,
		height 		= iif(fx.device.isTablet, 44, 44*1.8),
		headline 	= {
			bgColor = {178, 178, 178},
			height 	= 1
		},
		paddingBottom	= 9,
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

	-- side bar
	sideBar 		= {
		navigation	= {
			width 	= iif(fx.device.isTablet, w * 0.4, w * 0.7),
			height	= h,

		},
		content 	= {
			division	= {
				bgColor = {178, 178, 178},
				width 	= 1
			},
			hider		= {
				bgColor = {178, 178, 178, 100},
			}
		},
		transition 	= {time = 100}
	},

	-- table view
	tableView	= {
		category 	= {
			lineColor	= {178, 178, 178},
			params		= {fontSize	= iif(fx.device.isTablet, 22, 33)},
			textColor = {default = { 0, 0, 0 }},
			rowHeight	= iif(fx.device.isTablet, 50, 90)
		},
		item		= {
			rowColor = {
			    default = { 255, 255, 255},
			    over = { 76, 161, 255},
			    selected = { 76, 161, 255},
			},
			textColor = {
			    default = { 0, 0, 0 },
			    over = { 255, 255, 255 },
			},
			lineColor	= {178, 178, 178},
			params		= {fontSize	= iif(fx.device.isTablet, 22, 33)},
			rowHeight	= iif(fx.device.isTablet, 50, 90)
		},
		transition = {time = 200}
	}
}
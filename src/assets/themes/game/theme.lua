_G.fx.themes["game"] = {
	name = "game",
	base = "ios7",

	button = {
		audio = "button",
	},

	tableView = {
		audio 	= "button",
	},

	loadSounds = function()
		fx.sounds.addEffect("button-onRelease", fx.ui.getAsset("sounds/button-onRelease.mp3"))
	end
}
local ainfo = {
	name = "FX.SDK Demo Game",
	
	facebookAppId = "",
	facebookPermissions = {"publish_stream"},

	link = "http://thedopplerfx.com/",
	seller = "The Doppler FX",
	sellerLink = "http://thedopplerfx.com",
	
	marketInfo = {
		iOSAppId = "",
		nookAppEAN =  "",
		androidAppPackageName =  "com.thedopplerfx.games.blah", 
		supportedAndroidStores = { "google", "samsung", "amazon", "nook"}
	},

	themes = {
		iosDefault 		= "game",
		androidDefault	= "game"
	},

	modules = {
		"social",
		"ads",
		"io",
		"camera",
		"joystick"
	},

	ads = {
		iAds 	= "",
		adMob 	= "",
	},

	mode = "TESTING" -- TESTING, PRODUCTION
}
return ainfo;
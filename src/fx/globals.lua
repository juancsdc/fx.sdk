-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Globals
-- =============================================================
-- Short and Sweet License: 
-- 1. You may use anything you find in the CoronaFX library and sampler to make apps and games for free or $$.
-- 2. You may not sell or distribute CoronaFX or the sampler as your own work.
-- 3. If you intend to use the art or external code assets, you must read and follow the licenses found in the
--    various associated readMe.txt files near those assets.
--
-- Credit?:  Mentioning CoronaFX library and/or The Doppler FX. in your credits is not required, but it would be nice.  Thanks!
--
-- ================================================================================
-- This module initialices global variables to be used afterwards in your code
-- ================================================================================
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

_G.debugLevel  = 1

_G.themeDir = "assets.themes.{theme}.theme"
_G.assetsDir = "assets/themes/{theme}/"
_G.soundsDir = "audio/"
_G.i18nDir = "i18n/"
_G.settingsDir = "db/"

-- DO NOT MODIFY BELOW (Used In Framework); EXPERTS ONLY
-- DO NOT MODIFY BELOW (Used In Framework); EXPERTS ONLY
-- DO NOT MODIFY BELOW (Used In Framework); EXPERTS ONLY
_G.startH = 0

_G.w = display.contentWidth
_G.h = display.contentHeight

_G._w = display.contentWidth
_G._h = display.contentHeight

_G.centerX = w/2
_G.centerY = h/2

_G.scaleX = 1/display.contentScaleX
_G.scaleY = 1/display.contentScaleY

_G.displayWidth = (display.contentWidth - display.screenOriginX*2)
_G.displayHeight = (display.contentHeight - display.screenOriginY*2)

_G.unusedWidth = _G.displayWidth - _G.w
_G.unusedHeight = _G.displayHeight - _G.h

_G.luaVersion = _G._VERSION

fx.device = {
	isSimulator 	= system.getInfo("environment") == "simulator",
	model 			= system.getInfo("model"),

	width  			= math.floor((displayWidth/display.contentScaleX) + 0.5),
	height 			= math.floor((displayHeight/display.contentScaleY) + 0.5),

	isApple 		= false,
	isAndroid		= false,
	isGoogle		= false,
	isNook			= false,
	isKindleFire	= false,

	isTablet		= false,

	platformName	= system.getInfo("platformName"),
	platformVersion = system.getInfo("platformVersion"),
}

if string.sub(fx.device.model, 1, 2) == "iP" then
	fx.device.isApple = true

	-- Are we on a tablet?
	if string.sub(fx.device.model, 1, 4) == "iPad" then
		fx.device.isTablet = true
	end
elseif fx.device.platformName == "Android" or fx.device.isSimulator then
	-- Simulator? There's no way to know if the sim. is android, so let's assume that
	
	fx.device.isAndroid = true

	-- If it is android let's assume it is google
	fx.device.isGoogle = true

	-- All of the Kindles start with "K", although Corona builds before #976 returned
   -- "WFJWI" instead of "KFJWI" (this is now fixed, and our clause handles it regardless)
   if model == "Kindle Fire" or model == "WFJWI" or string.sub(fx.device.model, 1, 2) == "KF" then
      fx.device.isKindleFire = true
      fx.device.isGoogle = false  --revert Google Play to false
   end
 
   -- Are we on a Nook?
   if string.sub(fx.device.model, 1 ,4) == "Nook" or string.sub(fx.device.model, 1, 4) == "BNRV" then
      fx.device.isNook = true
      fx.device.isGoogle = false  --revert Google Play to false
   end

   -- Are we on a tablet?
   if system.getInfo("androidDisplayWidthInInches") then
		if(system.getInfo("androidDisplayWidthInInches") > 5 or system.getInfo("androidDisplayHeightInInches" ) > 5) then
			fx.device.isTablet = true
		end
	end
else
	print("Unknown device")
end

if (display.pixelHeight/display.pixelWidth) > 1.5 then
	fx.device.isTall = true
end
-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Ads
-- =============================================================
-- Short and Sweet License: 
-- 1. You may use anything you find in the CoronaFX library and sampler to make apps and games for free or $$.
-- 2. You may not sell or distribute CoronaFX or the sampler as your own work.
-- 3. If you intend to use the art or external code assets, you must read and follow the licenses found in the
--    various associated readMe.txt files near those assets.
--
-- Credit?:  Mentioning CoronaFX library and/or The Doppler FX. in your credits is not required, but it would be nice.  Thanks!
--
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

if( not _G.fx.ads ) then
    _G.fx.ads = {height = 0, rateShown = false}
end
local fxAds = _G.fx.ads

local ads = require("ads")

local function fxAdListener(event)
	table.dump(event)
end

function fxAds.init()
	print('initializing ads')
	-- Load Corona 'ads' library
	if fx.device.isApple then
		if fx.device.isTablet then
			fxAds.bannerHeight = w / 320 * 50
		else
			fxAds.bannerHeight = w / 320 * 66
		end

		-- The name of the ad provider.
		local adNetwork = "iads"
		local appID = appInfo.ads.iAds
		ads.init(adNetwork, appID, fxAdListener)

	elseif fx.device.isAndroid then
		if fx.device.isTablet then
			fxAds.bannerHeight = w / 320 * 90
		else
			fxAds.bannerHeight = w / 320 * 50
		end

		-- The name of the ad provider.
		local adNetwork = "admob"
		local appID = appInfo.ads.adMob
		ads.init(adNetwork, appID, fxAdListener)
	end
end

function fxAds.showBanner(x, y, params)
	if fx.device.isSimulator then
		if params.srpH == "bottom" then
			y = y - fxAds.bannerHeight
		end
		fxAds.adBox = display.newGroup()

		local o = display.newRect(fxAds.adBox, x, y, w, fxAds.bannerHeight)
		o:setFillColor(255, 0, 0)

		o = fx.ui.newText(fxAds.adBox, "Ads Here", 0, 0, native.systemFont, iif(fx.device.isTablet, 30, 25))
		o.x = w/2
		o.y = y + fxAds.bannerHeight/2
	elseif fx.device.isApple then
		ads.show("banner", {x=x, y=y, testMode=appInfo.mode == "TESTING"})

	elseif fx.device.isAndroid then
		if params.srpH == "bottom" then
			y = y - fxAds.bannerHeight
		end
		ads.show("banner", {x=x, y=y, testMode=appInfo.mode == "TESTING"})
	end
end

function fxAds.hide()
	ads.hide()
end

function fxAds.rateUsPopUp()
	if fx.settings.p.fx.timesPlayed % fx.settings.p.fx.promptRateDays == 0 and fx.settings.p.fx.promptRate and not fxAds.rateShown then
		fxAds.rateShown = true
		native.showAlert(fx.i18n.get("Menu-RateUs-Title"), fx.i18n.get("Menu-RateUs-Msg"), {
			fx.i18n.get("Menu-RateUs-Rate"),
			fx.i18n.get("Menu-RateUs-Later"),
			fx.i18n.get("Menu-RateUs-Never")
		}, function(event)
			if "clicked" == event.action then
				local i = event.index
				if 1 == i then
					native.showPopup("rateApp", appInfo.marketInfo)
					fx.settings.p.fx.promptRate = false
				elseif 2 == i then
					if fx.settings.p.fx.promptRateDays < 6 then
						fx.settings.p.fx.promptRateDays = 9
					end
				else
					fx.settings.p.fx.promptRate = false
				end
				fx.settings:save()
			end
		end)
	end
end

fxAds.init()
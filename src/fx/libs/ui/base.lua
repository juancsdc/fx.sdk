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
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

if( not _G.fx.ui ) then
	_G.fx.ui = {}
end
local fxUI = _G.fx.ui

local widget = require("widget")


-- ==
--    fx.ui.getAsset(asset) - loads the asset path depending on the selected theme
-- ==
function fxUI.getAsset(asset)
	return assetsDir:replace("{theme}", fxUI.getTheme()) .. asset
end

-- ==
--    fx.ui.setTheme(thene) - set FX widgets theme
-- ==
function fxUI.setTheme(theme)
	fx.settings.p.fx.theme = theme
	fx.settings:save()
	fxUI.loadTheme()
end

-- ==
--    fx.ui.getTheme(thene) - gets FX widgets theme
-- ==
function fxUI.getTheme()
	local theme
	if not fx.themes then fx.themes = {} end
	if(fx.settings.p.fx.theme == "device") then
		if(fx.device.isAndroid) then
			theme = appInfo.themes.androidDefault
		else
			theme = appInfo.themes.iosDefault
		end
	else
		theme = fx.settings.p.fx.theme
	end
	return theme
end

-- ==
--    fx.ui.loadTheme(thene) - load FX widgets theme
-- ==
function fxUI.loadTheme()
	local theme = fxUI.getTheme()

	if theme == "ios7" or theme == "android" then -- native themes
		-- Load the user's theme
		require("fx.theme."..theme..".theme")
		fx.theme = table.copy(fx.themes[theme])
		-- Set the widget's theme
		widget.setTheme("widget_theme_" .. fx.theme.coronaTheme)
	else
		-- Load the user's theme
		require(themeDir:replace("{theme}", theme))
		fx.theme = table.copy(fx.themes[theme])
		-- Load the base theme
		require("fx.theme."..fx.theme.base..".theme")
		-- Merge the 2 themes together
		table.merge(fx.themes[fx.theme.base], fx.theme)
		-- Set the widget's theme
		widget.setTheme("widget_theme_" .. fx.theme.coronaTheme)
	end
	-- load theme sounds
	if fx.theme.loadSounds then
		fx.theme.loadSounds()
	end

	-- draw the background accordingly
	display.setDefault("background", unpack(fx.theme.application.bg))
	if fx.theme.application.bg.type == "image" then
		local bg = display.newImageRect(fx.theme.application.bg.filename, w, h)
		bg.x = w/2
		bg.y = h/2
	end
end

-- ==
--    fx.ui.setStatusBar(thene) - set FX widgets theme
-- ==
function fxUI.setStatusBar(statusBar)
	if statusBar == display.HiddenStatusBar then
		_G.startH = 0
	else
		if onSimulator then
			_G.startH = 60
		else
			_G.startH = display.topStatusBarContentHeight
		end
	end
	display.setStatusBar(statusBar);
end

fxUI.loadTheme()

-- ==
--    fx.ui.newText(displayGroup, text, x, y, fontFamily, fontSize, params) - create a new text
-- ==
function fxUI.newText(...)
	if(not _G.fx.ui.text) then
		require("fx.libs.ui.text")
	end
	return fx.ui.text:new(unpack(arg))
end

-- ==
--    fx.ui.newButton(params) - create a new button
-- ==
function fxUI.newButton(params)
	if( not _G.fx.ui.button ) then
		require("fx.libs.ui.button")
	end
	return fx.ui.button:new(params)
end

-- ==
--    fx.ui.newTitleBar(params) - create a new title bar
-- ==
function fxUI.newTitleBar(params)
	if( not _G.fx.ui.titleBar ) then
		require("fx.libs.ui.titleBar")
	end
	return fx.ui.titleBar:new(params)
end

-- ==
--    fx.ui.newSideBar(params) - create a new title bar
-- ==
function fxUI.newSideBar(params)
	if( not _G.fx.ui.sideBar ) then
		require("fx.libs.ui.sideBar")
	end
	return fx.ui.sideBar:new(params)
end

-- ==
--    fx.ui.newSideBar(params) - create a new title bar
-- ==
function fxUI.newTableView(params)
	if( not _G.fx.ui.tableView ) then
		require("fx.libs.ui.tableView")
	end
	return fx.ui.tableView:new(params)
end

-- ==
--    fx.ui.fill( obj ) - Apply the fill property of the theme to an object
--    obj - The object to test.
-- == 
function fxUI.fill(obj, fill)
	if not fill then return end
	if fill.fill then
		obj.fill = fill.fill
	end
	if fill.effect then
		obj.fill.effect = fill.effect
		table.shallowCopy(fill.effectProperties, obj.fill.effect)
	end
	if fill.alpha then
		obj.alpha = fill.alpha
	end
end

-- ==
--    fx.ui.stroke( obj ) - Apply the stroke property of the theme to an object
--    obj - The object to test.
-- == 
function fxUI.stroke(obj, stroke)
	if not stroke then return end
	if stroke.fill then
		obj.stroke = stroke.fill
	end
	if stroke.effect then
		obj.stroke.effect = stroke.effect
	end
	if stroke.width then
		obj.strokeWidth = stroke.width
	end
end
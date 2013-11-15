-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Button
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

if( not _G.fx.ui.text ) then
	_G.fx.ui.text = {}
end
local text = _G.fx.ui.text

local widget = require("widget")

-- ==
--    fx.ui.text:new(displayGroup, text, x, y, fontFamily, fontSize, params) - Core builder function for creating new texts
-- ==
function text:new(...)
	--if not params then params = {} end
	--table.merge(table.merge(fx.theme.text, params.class), params)

	local text = display.newText(unpack(arg))
	text.id = "fxText" .. math.random(0, w)

	setTextColor(text, fx.theme.text.fontColor)

	return text
end
-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Title Bar
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

if( not _G.fx.ui.titleBar ) then
	_G.fx.ui.titleBar = {}
end
local fxTitleBar = _G.fx.ui.titleBar

-- ==
--    fx.ui.titleBar:new(params) - Core builder function for creating title bars
-- ==
function fxTitleBar:new(params)
	local titleBar = display.newGroup()
	local params = table.merge(fx.theme.bar, params)

	local bar = display.newRect(titleBar, params.width/2, startH+params.height/2, params.width+fnn(params.strokeWidth, 0)*2, startH+params.height+fnn(params.strokeWidth, 0))
	bar.fill = params.fill
	bar.stroke = params.stroke
	bar.strokeWidth = params.strokeWidth

	if(params.label) then
		local title = nil
		if fnn(params.title.embossed, false) then
			title = display.newEmbossedText(titleBar, params.label, 0, 0, params.title.font, params.title.fontSize)
		else
			title = fx.ui.newText(titleBar, params.label, 0, 0, params.title.font, params.title.fontSize)
		end
		title.y = bar.height/2
		title.x = params.width/2
		setTextColor(title, params.title.color)
	end

	titleBar.id = "fxTitleBar" .. math.random(0, w)
	titleBar.params = params
	titleBar.x = fnn(params.x, 0)
	titleBar.y = fnn(params.y, 0)
	if(params.view) then params.view:insert(titleBar) end

	return titleBar
end
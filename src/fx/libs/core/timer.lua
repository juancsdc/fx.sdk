-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Timer
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

if( not _G.fx.timer ) then
    _G.fx.timer = {}
end
local fxTimer = _G.fx.timer

local storyboard = require("storyboard")

-- ==
--	fx.timer.performWithDelayGlobal(...) 	Regular timer.performWithDelay
-- ==
function fxTimer.performWithDelayGlobal(...)
	return timer.performWithDelay(unpack(arg))
end


-- ==
--	fx.timer.performWithDelay(...)	timer.performWithDelay that automatically cancels at the end of an scene
-- ==
function fxTimer.performWithDelay(...)
	local scene = storyboard.getScene(storyboard.getCurrentSceneName())
	if not scene.fxTimers then
		scene.fxTimers = {}
		scene:addEventListener("exitScene", fxTimer.endScene)
	end

	local removed = 0
	local total = #scene.fxTimers
	for i=1, total do
		if scene.fxTimers[i-removed]._removed or scene.fxTimers[i-removed]._expired then
			table.remove(scene.fxTimers, i-removed)
			removed = removed + 1
		end
	end

	local _t = timer.performWithDelay(unpack(arg))

	table.insert(scene.fxTimers, _t)

	return _t;
end

function fxTimer.endScene(event)
	local scene = storyboard.getScene(storyboard.getCurrentSceneName())
	if scene.fxTimers then
		while #scene.fxTimers > 0 do
			timer.cancel(scene.fxTimers[1])
			table.remove(scene.fxTimers, 1)
		end
	end
end
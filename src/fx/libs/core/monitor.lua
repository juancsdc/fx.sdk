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

if( not _G.fx.monitor ) then
    _G.fx.monitor = {}
end
local _monitor = _G.fx.monitor

function _monitor:printMemUsage()
	print("---------------------------------------- @ " .. system.getTimer() .. " ms" )
    collectgarbage()
    print( "MemUsage: " .. fx.math.round(collectgarbage("count"),4) .. " KB")

    local textMem = system.getInfo( "textureMemoryUsed" ) / (1024 * 1024)
    print( "TexMem:   " .. textMem .. " MB" )
end
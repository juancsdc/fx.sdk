-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- io
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

if( not _G.fx.io ) then
    _G.fx.io = {}
end
local io = _G.fx.io

local lfs = require "lfs"

function io.exists(fileName, base)
	local fileName = fileName
	if( base ) then
		fileName = system.pathForFile(fileName, base)
	end
	if not fileName then return false end
	local f=io.open(fileName,"r")
	if (f == nil) then 
		return false
	end
	io.close(f)
	return true 
end
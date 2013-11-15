-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- CoronaFX Loader
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
-- Load this module in main.lua to load all of the FX library with just one call.
-- ================================================================================
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

-- ==
-- CoronaFX super object; Most libraries will be attached to this.
-- ==
local fx = {}
_G.fx = fx

-- ==
--    Early Loads: This stuff is used by subsequently loaded content and must be loaded FIRST.
-- ==
_G.appInfo = require("appInfo")
if(not _G.appInfo) then
	error("Please define the appInfo to get the SDK working")
end
require("fx.globals")
require("fx.libs.global")
require("fx.libs.debugPrinter")

-- ==
--    Extensions (To existing Lua Classes)
-- ==
require("fx.libs.extension.math")
require("fx.libs.extension.string")
require("fx.libs.extension.table")

-- ==
--    Core (i.e. Used a lot and often by other SSK Classes)
-- ==
require("fx.libs.core.settings")
require("fx.libs.core.i18n")
require("fx.libs.core.sound")
require("fx.libs.core.timer")
require("fx.libs.core.animation")

-- ==
--    Modules
-- ==
for i=1, #appInfo.modules do
	require("fx.libs.module."..appInfo.modules[i])
end

-- ==
--    UI
-- ==
require("fx.libs.ui.base")

-- ==
--    Load Default Presets
-- ==

-- ==
--    External Libraries (Stuff Made By Others)
-- ==

-- ==
--    Do some stuff
-- ==
fx.settings.p.fx.timesPlayed = fx.settings.p.fx.timesPlayed + 1
fx.settings:save()
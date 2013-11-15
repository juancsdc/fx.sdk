-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Debug Printer
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
-- 
-- ================================================================================
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

if( not _G.fx.debugPrinter ) then
	_G.fx.debugPrinter = {}
end
local debugPrinter = _G.fx.debugPrinter

-- ==
--    debugPrinter.newPrinter( debugLevel ) - Creates a new debug printer that only prints messages at the specified debugLevel or higher.
-- ==
function debugPrinter.newPrinter(debugLevel)

	if(debugLevel == nil) then
		print("Warning: Passed nil when initializing debugLevel in debugPrinter.newPrinter()")
	end

	local printerInstance = {}

	-- Debug messaging level: 
	-- 0  - None
	-- 1  - Basic messages
	-- 2  - Intermediate debug output
	-- 3+ - Full debug output (may be very noisy)
	printerInstance.debugLevel = debugLevel or 0

	-- ==
	--    printerInstance:setLevel( debugLevel ) - Changes the debug level for this debug printer instance.
	-- ==
	function printerInstance:setLevel(level)
		self.debugLevel = level			
	end

	-- ==
	--    printerInstance:print( level, ... ) - Changes the debug level for this debug printer instance.
	-- ==
	function printerInstance.print(level, ...)
		if(printerInstance.debugLevel >= level) then
			print(unpack(arg));
		end
	end

	return printerInstance
end
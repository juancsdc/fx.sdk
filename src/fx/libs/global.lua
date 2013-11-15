-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- CoronaFX Global Functions
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
-- This module provides global functions to simplify your life
-- ================================================================================
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

-- ==
--    noErrorAlerts(  ) - Turns off those annoying error popups! :)
-- ==
function _G.noErrorAlerts()
	Runtime:hideErrorAlerts( )
end

-- ==
--    fnn( ... ) - Return first argument from list that is not nil.
--    ... - Any number of any type of arguments.
-- ==
function _G.fnn( ... ) 
	for i = 1, #arg do
		local rArg = arg[i]
		if(rArg ~= nil) then return rArg end
	end
	return nil
end

-- ==
--    iif(condition, _true, _false) - Return second argument if the first is true, otherwise the tird argument is returned.
--    ... - Any number of any type of arguments.
-- ==
function _G.iif(condition, _true, _false) 
	if(condition) then 
		return _true
	else
		return _false
	end
end

-- ==
--    isDisplayObject( obj ) - Check if an object is valid and has NOT had removeSelf() called yet.
--    obj - The object to test.
-- == 
function _G.isDisplayObject(obj)
	if( obj and obj.removeSelf and type(obj.removeSelf) == "function") then return true end
	return false
end

-- ==
--    setFillColor( obj ) - Apply setFillColor to an object
--    obj - The object to test.
-- == 
function _G.setFillColor(obj, colorArray)
	obj:setFillColor(colorArray[1], colorArray[2], colorArray[3], fnn(colorArray[4], 255))
end

-- ==
--    setTextColor( obj ) - Apply setFillColor to an object
--    obj - The object to test.
-- == 
function _G.setTextColor(obj, colorArray)
	obj:setTextColor(colorArray[1], colorArray[2], colorArray[3], fnn(colorArray[4], 255))
end

--==
--   safeRemove(obj) - (More) safely remove a displayObject.
--   obj - Object to remove.
-- ==
function _G.safeRemove(obj)
	if( obj and obj.removeSelf and type(obj.removeSelf) == "function") then 
		obj:removeSelf()
		-- If this function is called on joints, type(obj) returns "userdata"
		-- Userdata don't have metatables :)
		if(type(obj) == "table") then
			setmetatable(obj, nil)  -- This happens automatically on the next simcycle/frame, but let's force it now
		end
		obj.removeSelf = nil
	end
	obj = nil
end
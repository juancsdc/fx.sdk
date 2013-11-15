-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Camera
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

if( not _G.fx.camera ) then
    _G.fx.camera = {}
end
local fxCamera = _G.fx.camera

--
-- Creates a new camera function
-- There are 3 types of cameras:
-- 	centered:	keep the object at the center of the screen
--  lazy:		move the camera when the object reaches the screen borders
--  delayed:	follows the object with some delay
--  manual:		follows the object, but it's only updated manually
--
function fxCamera:new(params)
	local camera = display.newGroup()

	params.type = fnn(params.type, "manual")
	
	table.merge(camera, params)

	if(params.view) then params.view:insert(camera) end

	function camera.onEnterFrame()
		if camera.mode == "centered" then
			camera:goTo(w/2-camera.follow.x, h/2-camera.follow.y)
		elseif camera.mode == "lazy" then
			local bx = camera.follow.x+camera.x
			local by = camera.follow.y+camera.y

			camera.follow.onCameraX = bx;
			camera.follow.onCameraY = by;

			if bx < camera.bounds[1] then
				camera:move(camera.bounds[1]-bx, 0)
			end
			if by < camera.bounds[2] then
				camera:move(0, camera.bounds[2]-by)
			end
			if bx > camera.bounds[3] then
				camera:move(camera.bounds[3]-bx, 0)
			end
			if by > camera.bounds[4] then
				camera:move(0, camera.bounds[4]-by)
			end
		end
	end

	function camera:attach(obj, params)
		camera.follow = obj
		table.merge(params, camera)
		if camera.mode == "centered" or camera.mode == "lazy" then
			Runtime:addEventListener("enterFrame", camera.onEnterFrame)
		else
			Runtime:removeEventListener("enterFrame", camera.onEnterFrame)
		end
	end

	function camera:update()
		camera.x = camera.follow.x
		camera.y = camera.follow.y
	end

	function camera:move(dx, dy)
		camera.x = camera.x + dx
		camera.y = camera.y + dy
	end

	function camera:goTo(x, y)
		camera.x = x
		camera.y = y
	end

	return camera
end
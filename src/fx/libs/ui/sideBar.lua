-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Side Bar
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

if( not _G.fx.ui.sideBar ) then
	_G.fx.ui.sideBar = {}
end
local fxSideBar = _G.fx.ui.sideBar

-- ==
--    fx.ui.titleBar:new(params) - Core builder function for creating title bars
-- ==
function fxSideBar:new(params)
	local sideBar = display.newGroup()
	local params = table.merge(fx.theme.sideBar, params)

	sideBar.id = "fxSideBar" .. math.random(0, w)
	sideBar.params = params
	sideBar.x = fnn(params.x, 0)
	sideBar.y = fnn(params.y, 0)
	if(params.view) then params.view:insert(sideBar) end

	-- Create 2 containers
	--sideBar.navigator = display.newContainer(params.navigation.width*2, _h*2)
	--sideBar.container = display.newContainer(_w*2, _h*2)
	sideBar.navigator = display.newGroup()
	sideBar.container = display.newGroup()
	local r = display.newRect(sideBar.container, -fx.theme.titleBar.strokeWidth, h/2, fx.theme.titleBar.strokeWidth, h)
	r.fill = fx.theme.titleBar.stroke


	-- Add the event for the expand collapse with touch event
	sideBar._expandCollapseEvent = function(event)
		local phase 	= event.phase
		local target 	= event.target

		if phase == "began" then
			display.getCurrentStage():setFocus(target);
			target.direction = nil
			target.prevTouch = {x = event.x, y = event.y}
			if sideBar.tr1 then transition.cancel(sideBar.tr1); sideBar.tr1 = nil end
			if sideBar.tr2 then transition.cancel(sideBar.tr2); sideBar.tr2 = nil end
		elseif phase == "moved" then
			if not target.prevTouch then
				display.getCurrentStage():setFocus(nil);
				return true
			end
			
			if sideBar.collapsed then
				sideBar.container.x = - (event.xStart - event.x)
			else
				sideBar.container.x = params.navigation.width - (event.xStart - event.x)
			end

			if(sideBar.container.x > params.navigation.width) then sideBar.container.x = params.navigation.width end
			if(sideBar.container.x < 0) then sideBar.container.x = 0 end

			sideBar.navigator.x = -1 * sideBar.navigation.width / 2 + sideBar.container.x

			target.direction = iif(target.prevTouch.x - event.x > 0, -1, 1)
			target.prevTouch = {x = event.x, y = event.y}
		elseif phase == "ended" or phase == "cancelled" then
			target.prevTouch = nil
			display.getCurrentStage():setFocus(nil);

			if target.direction == -1 then
				sideBar.collapsed = false
			elseif target.direction == 1 then
				sideBar.collapsed = true
			else
				sideBar.collapsed = not sideBar.collapsed
			end
		

			sideBar:expandCollapse()
		end
		return true
	end

	-- Create title and user content container
	if params.contentTitleBar then
		sideBar.contentTitleBar = fx.ui.newTitleBar(params.contentTitleBar)
		
		sideBar.content = display.newContainer(_w*2, _h*2-sideBar.contentTitleBar.height*2)
		sideBar.content.y = sideBar.contentTitleBar.height
		sideBar.container:insert(sideBar.content)

		sideBar.container:insert(sideBar.contentTitleBar)
	else
		sideBar.content = display.newContainer(sideBar.container.width, h*2)
		sideBar.container:insert(sideBar.content)
	end
	
	-- Create title and user navigation container
	if params.navigationTitleBar then
		sideBar.navigationTitleBar = fx.ui.newTitleBar(table.merge({width=params.navigation.width}, params.navigationTitleBar))

		sideBar.navigation = display.newContainer(params.navigation.width*2, _h*2-sideBar.navigationTitleBar.height*2)
		sideBar.navigation.y = sideBar.navigationTitleBar.height
		sideBar.navigator:insert(sideBar.navigation)

		sideBar.navigator:insert(sideBar.navigationTitleBar)

		h = _h-sideBar.navigationTitleBar.height
	else
		sideBar.navigation = display.newContainer(params.navigation.width*2, h*2)
		sideBar.navigator:insert(sideBar.navigation)
	end

	sideBar.navigator.x = -1 * sideBar.navigation.width / 2
	sideBar.collapsed = true
	sideBar.container:addEventListener("touch", sideBar._expandCollapseEvent)

	function sideBar:expandCollapse()
		if sideBar.tr1 then transition.cancel(sideBar.tr1); sideBar.tr1 = nil end
		if sideBar.tr2 then transition.cancel(sideBar.tr2); sideBar.tr2 = nil end
		if sideBar.collapsed then
			sideBar.collapsed = false
			sideBar.tr1 = transition.to(sideBar.navigator, table.merge(fx.theme.sideBar.expandAnimation,{x = 0}))
			sideBar.tr2 = transition.to(sideBar.container, table.merge(fx.theme.sideBar.expandAnimation,{x = params.navigation.width+fx.theme.titleBar.strokeWidth}))
		else
			sideBar.collapsed = true
			sideBar.tr1 = transition.to(sideBar.navigator, table.merge(fx.theme.sideBar.collapseAnimation,{x = -1 * params.navigation.width}))
			sideBar.tr2 = transition.to(sideBar.container, table.merge(fx.theme.sideBar.collapseAnimation,{x = 0}))
		end
	end

	function sideBar:setContentTitle(title)
		sideBar.contentTitleBar:setLabel(title)
	end

	return sideBar
end
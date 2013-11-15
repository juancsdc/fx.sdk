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

if( not _G.fx.ui.button ) then
	_G.fx.ui.button = {}
end
local fxButton = _G.fx.ui.button

local widget = require("widget")

-- ==
--    fx.ui.button:new(params) - Core builder function for creating new buttons
-- ==
function fxButton:new(params)
	params._onRelease = params.onRelease
	params.onRelease = nil
	params.onEvent = function(event) event.target:_onCustomEvent(event) end

	table.merge(table.merge(fx.theme.button, params.class), params)

	if not params.width and params.fxType == 'textOnly' then 
		local txtTmp = display.newText(params.label, 0, 0, params.font, params.fontSize)
		params.width = txtTmp.contentWidth + fnn(fx.theme.button.type.textOnly.padding, 0)
		safeRemove(txtTmp)
	end

	local button = widget.newButton(params)
	
	button.id = fnn(params.id, "fxButton" .. math.random(0, w))
	button.params = params
	button.x = fnn(params.x, 0)
	button.y = fnn(params.y, 0)
	if(params.view) then params.view:insert(button) end

	function button:_setStatus(status)
		local cp = self.params[status.."Behave"]
		if (status == "onCancel" and (not cp)) then cp = self.params["onReleaseBehave"] end
		if not cp then return end
		if(cp and cp.color and self._view._over) then self._view._over:setFillColor(unpack(cp.color)) end

		fx.animation.forceStop(self, cp.animation)

		if(self.tr) then transition.cancel(self.tr) end
		if(cp.transitionTo) then
			cp.transitionTo.onComplete=function()
				if(cp.animation) then
					fx.animation.add(self, cp.animation, cp.animationLoop, cp.animationOptions)
				end
			end
			self.tr = transition.to(self, cp.transitionTo)
		else
			if(cp.animation) then
				fx.animation.add(self, cp.animation, cp.animationLoop, cp.animationOptions)
			end
		end
	end

	function button:_onCustomEvent(event)
		local phase = event.phase
		if (phase == "began") then
			if(self.params.audio) then fx.sounds.play(self.params.audio..'-onPress') end
			self:_setStatus("onPress")
		elseif (phase == "ended") then
			if(self.params.audio) then fx.sounds.play(self.params.audio..'-onRelease') end
			self:_setStatus("onRelease")
			if (self.params._onRelease) then
				self.params._onRelease(event)
			end
		elseif (phase == "cancelled") then
			if(self.params.audio) then fx.sounds.play(self.params.audio..'-onCancel') end
			self:_setStatus("onCancel")
		end
	end

	button:_setStatus("onRelease")

	return button
end
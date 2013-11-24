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

if( not _G.fx.joystick ) then
    _G.fx.joystick = {}
end
local joystick = _G.fx.joystick

local pi = math.pi
local sqrt = math.sqrt
local atan2 = math.atan2
local rad = math.rad

function joystick:new(params)
  local obj = display.newGroup()

  local defaultParams = {
    outterRadio   = 90,
    innerRadio    = 45,
    allowedArea   = {
      x = w/2, y = h*0.9, width = w, height = h*0.2
    }
  }
  table.merge(defaultParams, params)

  obj.params = params
  
  obj.allowedArea = display.newRect(obj, params.allowedArea.x, params.allowedArea.y, params.allowedArea.width, params.allowedArea.height)
  obj.allowedArea.alpha = 0.01
  
  if obj.params.outterImage then
    obj.outterPad = display.newImageRect(obj, obj.params.outterImage, obj.params.outterRadio*2, obj.params.outterRadio*2)
  else
    obj.outterPad = display.newCircle(obj, 0, 0, obj.params.outterRadio)
  end
  obj.outterPad.alpha = 0.2
  
  obj.innerPad = display.newCircle(obj, 0, 0, obj.params.innerRadio)
  obj.innerPad.alpha = 0.6
  obj.innerPad:setFillColor(200, 200, 200)
  
  obj.alpha = 0.01
  
  obj.joyAngle = 0
  obj.joyPercent = 0
  
  obj.isDragging = false
  
  obj.touchHandler = function(event)
    local phase = event.phase
    obj.isDragging = true

    if "began" == phase then
      display.getCurrentStage():setFocus(obj.allowedArea)
      obj:_setPosition(event.x, event.y)
      obj.alpha = 1
    elseif "moved" == phase then
      obj:_movePad(event.x, event.y)
    elseif "ended" == phase or "cancelled" == phase then
      display.getCurrentStage():setFocus(nil)
      obj.isDragging = false
      obj:_setPosition(event.x, event.y)
      obj.alpha = 0.01
      obj.joyAngle = 0
      obj.joyPercent = 0
    end
    
    return true
  end

  function obj:_setPosition(x, y)
    obj.outterPad.x, obj.outterPad.y = x, y
    obj.innerPad.x, obj.innerPad.y = x, y
  end

  function obj:_movePad(x, y)
    dx = (x-obj.outterPad.x)
    dy = (y-obj.outterPad.y)
    local distance = sqrt(dx*dx+ dy*dy)
    
    obj.joyAngle = rad(atan2(dy, dx) * (180 / pi))
    
    if(distance > obj.params.outterRadio) then
      obj.joyPercent = 1
      if(dx > 0) then
        obj.outterPad.x = obj.outterPad.x+distance-obj.params.outterRadio
      else
        obj.outterPad.x = obj.outterPad.x-distance+obj.params.outterRadio
      end
      if(dy > 0) then
        obj.outterPad.y = obj.outterPad.y+distance-obj.params.outterRadio
      else
        obj.outterPad.y = obj.outterPad.y-distance+obj.params.outterRadio
      end
    else
      obj.joyPercent = distance / obj.params.outterRadio
    end
    obj.innerPad.x, obj.innerPad.y = x, y
  end
  
  obj.allowedArea:addEventListener("touch", obj.touchHandler)
 
  if params.view then params.view:insert(obj.allowedArea) end

  return obj
end
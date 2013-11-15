-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Globals
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

if( not _G.fx.animation ) then
    _G.fx.animation = {}
end
local fxAnimation = _G.fx.animation

function fxAnimation.add(obj, animation, loop, options)
    -- FIXME: if it is not a display object then this should throw an exception instead of returning false
    if(not isDisplayObject(obj)) then return false end
    
    local _animation = {}
    _animation.id = animation
    _animation.loop = loop
    _animation.options = options

    -- Append the fxAnimation object to the display object
    if(obj.fxAnimation and obj.fxAnimation[animation]) then
        fxAnimation.remove(obj, animation)
    end
    if(obj.fxAnimation == nil) then obj.fxAnimation = {} end

    obj.fxAnimation[animation] = _animation

    fxAnimation.start(obj, animation)
end

function fxAnimation.start(obj, animation)
    obj.fxAnimation[animation]._index = 1
    obj.fxAnimation[animation].stopAtLoop = false
    fxAnimation.play(obj, animation)
end

function fxAnimation.play(obj, animation)
    if obj.fxAnimation[animation].stopAtLoop then
        obj.fxAnimation[animation].tr = nil
        return
    end
    obj.fxAnimation[animation].options[obj.fxAnimation[animation]._index].onComplete = function()
        obj.fxAnimation[animation]._index = obj.fxAnimation[animation]._index + 1
        if(obj.fxAnimation[animation]._index > #obj.fxAnimation[animation].options) then
            obj.fxAnimation[animation]._index = 1
        end
        fxAnimation.play(obj, animation)
    end
    obj.fxAnimation[animation].tr = transition.to(obj, obj.fxAnimation[animation].options[obj.fxAnimation[animation]._index]);
end

function fxAnimation.stop(obj, animation)
    if(obj.fxAnimation and obj.fxAnimation[animation]) then
        if(obj.fxAnimation[animation].tr) then
           obj.fxAnimation[animation].stopAtLoop = true
        end
    end
end

function fxAnimation.forceStop(obj, animation)
    if(obj.fxAnimation and obj.fxAnimation[animation]) then
    	if(obj.fxAnimation[animation].tr) then
           transition.cancel(obj.fxAnimation[animation].tr)
           obj.fxAnimation[animation].tr = nil;
        end
    end
end

function fxAnimation.remove(obj, animation)
    if(obj.fxAnimation and obj.fxAnimation[animation]) then
        fxAnimation.forceStop(obj, animation)
        fxAnimation[animation] = nil;
    end
end

--
-- easing options
--
_G.fx.animation.ease = {}
 
local pow = math.pow
local sin = math.sin
local pi = math.pi
 
local easeIn, easeOut, easeInOut, easeOutIn
local easeInBack, easeOutBack, easeInOutBack, easeOutInBack
local easeInElastic, easeOutElastic, easeInOutElastic, easeOutInElastic
local easeInElasticSoft, easeOutElasticSoft, easeInOutElasticSoft, easeOutInElasticSoft
local easeInBounce, easeOutBounce, easeInOutBounce, easeOutInBounce
 
-- module exports
 
function _G.fx.animation.ease._in(t, tMax, start, delta)
    return start + (delta * easeIn(t / tMax))
end
 
function _G.fx.animation.ease._out(t, tMax, start, delta)
    return start + (delta * easeOut(t / tMax))
end
 
function _G.fx.animation.ease.inOut(t, tMax, start, delta)
    return start + (delta * easeInOut(t / tMax))
end
 
function _G.fx.animation.ease.outIn(t, tMax, start, delta)
    return start + (delta * easeOutIn(t / tMax))
end
 
function _G.fx.animation.ease.inBack(t, tMax, start, delta)
    return start + (delta * easeInBack(t / tMax))
end
 
function _G.fx.animation.ease.outBack(t, tMax, start, delta)
    return start + (delta * easeOutBack(t / tMax))
end
 
function _G.fx.animation.ease.inOutBack(t, tMax, start, delta)
    return start + (delta * easeInOutBack(t / tMax))
end
 
function _G.fx.animation.ease.outInBack(t, tMax, start, delta)
    return start + (delta * easeOutInBack(t / tMax))
end
 
function _G.fx.animation.ease.inElastic(t, tMax, start, delta)
    return start + (delta * easeInElastic(t / tMax))
end
 
function _G.fx.animation.ease.outElastic(t, tMax, start, delta)
    return start + (delta * easeOutElastic(t / tMax))
end
 
function _G.fx.animation.ease.inOutElastic(t, tMax, start, delta)
    return start + (delta * easeInOutElastic(t / tMax))
end
 
function _G.fx.animation.ease.outInElastic(t, tMax, start, delta)
    return start + (delta * easeOutInElastic(t / tMax))
end

function _G.fx.animation.ease.inElasticSoft(t, tMax, start, delta)
    return start + (delta * easeInElasticSoft(t / tMax))
end
 
function _G.fx.animation.ease.outElasticSoft(t, tMax, start, delta)
    return start + (delta * easeOutElasticSoft(t / tMax))
end
 
function _G.fx.animation.ease.inOutElasticSoft(t, tMax, start, delta)
    return start + (delta * easeInOutElasticSoft(t / tMax))
end
 
function _G.fx.animation.ease.outInElasticSoft(t, tMax, start, delta)
    return start + (delta * easeOutInElasticSoft(t / tMax))
end
 
function _G.fx.animation.ease.inBounce(t, tMax, start, delta)
    return start + (delta * easeInBounce(t / tMax))
end
 
function _G.fx.animation.ease.outBounce(t, tMax, start, delta)
    return start + (delta * easeOutBounce(t / tMax))
end
 
function _G.fx.animation.ease.inOutBounce(t, tMax, start, delta)
    return start + (delta * easeInOutBounce(t / tMax))
end
 
function _G.fx.animation.ease.outInBounce(t, tMax, start, delta)
    return start + (delta * easeOutInBounce(t / tMax))
end
 
-- local easing functions
 
easeInBounce = function(ratio)
    return 1.0 - easeOutBounce(1.0 - ratio)
end
 
easeOutBounce = function(ratio)
    local s = 7.5625
    local p = 2.75
    local l
    if ratio < (1.0 / p) then
        l = s * pow(ratio, 2.0)
    else
        if ratio < (2.0 / p) then
            ratio = ratio - (1.5 / p)
            l = s * pow(ratio, 2.0) + 0.75
        else
            if ratio < (2.5 / p) then
                ratio = ratio - (2.25 / p)
                l = s * pow(ratio, 2.0) + 0.9375
            else
                ratio = ratio - (2.65 / p)
                l = s * pow(ratio, 2.0) + 0.984375
            end
        end
    end
    return l
end
 
easeInOutBounce = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInBounce(ratio * 2.0)
    else
        return 0.5 * easeOutBounce((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInBounce = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutBounce(ratio * 2.0)
    else
        return 0.5 * easeInBounce((ratio - 0.5) * 2.0) + 0.5
    end
end
 
 
easeInElastic = function(ratio)
    if ratio == 0 or ratio == 1.0 then return ratio end
 
    local p = 0.3
    local s = p / 4.0
    local invRatio = ratio - 1.0
    return -1 * pow(2.0, 10.0 * invRatio) * sin((invRatio - s) * 2 * pi / p)
end
 
easeOutElastic = function(ratio)
    if ratio == 0 or ratio == 1.0 then return ratio end
 
    local p = 0.3
    local s = p / 4.0
    return -1 * pow(2.0, -10.0 * ratio) * sin((ratio + s) * 2 * pi / p) + 1.0
end
 
easeInOutElastic = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInElastic(ratio * 2.0)
    else
        return 0.5 * easeOutElastic((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInElastic = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutElastic(ratio * 2.0)
    else
        return 0.5 * easeInElastic((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeIn = function(ratio)
    return ratio * ratio * ratio
end
 
easeOut = function(ratio)
    local invRatio = ratio - 1.0
    return (invRatio * invRatio * invRatio) + 1.0
end
 
easeInOut = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeIn(ratio * 2.0)
    else
        return 0.5 * easeOut((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutIn = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOut(ratio * 2.0)
    else
        return 0.5 * easeIn((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeInBack = function(ratio)
    local s = 1.70158
    return pow(ratio, 2.0) * ((s + 1.0) * ratio - s)
end
 
easeOutBack = function(ratio)
    local invRatio = ratio - 1.0
    local s = 1.70158
    return pow(invRatio, 2.0) * ((s + 1.0) * invRatio + s) + 1.0
end
 
easeInOutBack = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInBack(ratio * 2.0)
    else
        return 0.5 * easeOutBack((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInBack = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutBack(ratio * 2.0)
    else
        return 0.5 * easeInBack((ratio - 0.5) * 2.0) + 0.5
    end
end


easeInElasticSoft = function(ratio)
    if ratio == 0 or ratio == 1.0 then return ratio end
 
    local p = 0.3
    local s = p / 4.0
    local invRatio = ratio - 1.0
    return -1 * pow(2.0, 20 * invRatio) * sin((invRatio - s) * 2 * pi / p)
end
 
easeOutElasticSoft = function(ratio)
    if ratio == 0 or ratio == 1.0 then return ratio end
 
    local p = 0.3
    local s = p / 4.0
    return -1 * pow(2.0, -20 * ratio) * sin((ratio + s) * 2 * pi / p) + 1.0
end
 
easeInOutElasticSoft = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeInElasticSoft(ratio * 2.0)
    else
        return 0.5 * easeOutElasticSoft((ratio - 0.5) * 2.0) + 0.5
    end
end
 
easeOutInElasticSoft = function(ratio)
    if (ratio < 0.5) then
        return 0.5 * easeOutElasticSoft(ratio * 2.0)
    else
        return 0.5 * easeInElasticSoft((ratio - 0.5) * 2.0) + 0.5
    end
end
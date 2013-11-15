-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Social
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
-- This module provides additional math helpers / functions
-- ================================================================================
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

if( not _G.fx.social ) then
    _G.fx.social = {}
end
local M = _G.fx.social

local facebook = require("facebook")
local json = require("json")
local url = require("socket.url")

M.FB_Access_Token = "CAACEdEose0cBANh0iaZCPZAuBZAEvmmAbd0BcuU3sIhYfgBW6l8W6SpFJvfi8Xy6ZC7YzjAyrFPjC6k9MKgUR7VoWOaKoBbAhGRVMwZCaf2DVLRl55THN8fOZCsurm2pyWakoR63ZBCqXlnXaWgdC1kWBzsCJdV4TgjoubbqdvLqxsZCgZC4AgcxoCx34liGJSPcKNwuJSx0yIQZDZD"

local fbLoggedIn = false

-- Current request being processed (next response to be handled below)
--
local fbNextRequest = nil
local function setNextRequest( path, httpMethod, params, onRequestComplete )
    fbNextRequest = {
        path = path,
        method = httpMethod,
        params = params,
        listener = onRequestComplete,
    }
end

-- listener for all "fbconnect" events
--
local function fbListener( event )

    -- Response event attributes:
    --
    --   event.name is "fbconnect"
    --   event.type is one of: "session" or "request" or "dialog"
    --   [For event.type "session"]
    --       event.phase is one of: "login", "loginFailed", "loginCancelled", "logout"
    --       [For event.phase "login"]
    --           event.token is the access token for the session
    --   [For event.type "dialog"]
    --       event.didComplete is false if dialog did not complete (user cancelled)
    --   event.isError is true if request failed (network failure)
    --   event.response is either an error string (if isError) or a json encoded response

    -- Do some pre-processing of the response
    --    
    if event.isError then
        -- This is a local (API call or connection) error.  We are going to convert it into the
        -- same kind of error structure that a Graph API error produces to make it easier for the
        -- listener to handle all errors in a uniform way.
        local error_message = "Unknown Error"
        if event.response and type(event.response) == "string" and event.response:len() > 0 then
            error_message = event.response
        end
        
        local error_response = {}
        error_response["message"] = error_message
        error_response["type"]    = "CallError"
        error_response["code"]    = -1
        
        event.response_raw = event.response
        event.response = {}
        event.response["error"] = error_response
    else
        if event.response and event.response:len() > 0 then
            event.response_raw = event.response
            if event.response_raw:sub(1,1) == "{" then
                -- event.response is a JSON object from the FB server - decode it for convenience
                event.response = json.decode(event.response_raw)
            end
            if event.response["error"] then
                -- This is a Graph API error response.  We set isError to make it easier for the
                -- listener to detect all errors in a uniform way.
                event.isError = true
            end
        end

        -- Track logged-in state.  We check isError again here, because it could have gotten set
        -- above in the case of a Graph API error.
        --
        if not event.isError then 
            if event.type == "session" then
                -- Track login state
                if event.phase == "login" then
                    --carrot.validateUser(event.token)
                    fbLoggedIn = true
                elseif event.phase == "logout" then 
                    fbLoggedIn = false
                end
            end
        elseif event.response["error"].type == "OAuthException" then
            settings.game.isInFacebook = false
            settings:save()
            fbLoggedIn = false
        end
    end
    
    if fbNextRequest == nil then
        error("Facebook request completed, but no pending request state was available")
    else
        -- Call the supplied listener
        event.request = fbNextRequest
        fbNextRequest = nil
        event.request.listener(event)
    end
end

------------------------------------------------------------------------------------
-- Simulator support methods
--
local function simulatorLogin( )
    local fbEvent = { }
    fbEvent["name"]  = "fbconnect"
    fbEvent["type"]  = "session"
    fbEvent["phase"] = "login"
    fbEvent["token"] = M.FB_Access_Token
    fbListener(fbEvent)
end

local function simulatorRequest( path, httpMethod, params )

    local params = params or {}
    if M.FB_Access_Token then
        params["access_token"] = M.FB_Access_Token
    else
        error("Facebook functionality in the simulator requires that FB_Access_Token be set in facebook.lua")
    end

    -- Build request and submit using network.request

    local queryString
    for k, v in pairs(params) do
        if queryString then
            queryString = queryString .. "&"
        else
            queryString = "?"            
        end
        queryString = queryString .. k .. "=" .. url.escape(v)
    end

    local url = "https://graph.facebook.com/" .. path .. queryString
    --dbg("Simulator Facebook request: " .. url)
    
    local function onRequestComplete( event )
        local fbEvent = { }
        fbEvent["name"]     = "fbconnect"
        fbEvent["type"]     = "request"
        fbEvent["isError"]  = event.isError
        fbEvent["response"] = event.response
        fbListener(fbEvent)
    end
    
    network.request(url, httpMethod, onRequestComplete)
end

local function simulatorLogout( )
    local fbEvent = { }
    fbEvent["name"]  = "fbconnect"
    fbEvent["type"]  = "session"
    fbEvent["phase"] = "logout"
    fbListener(fbEvent)
end

------------------------------------------------------------------------------------
-- For all listeners used below:
------------------------------------------------------------------------------------
--
-- local function onXxxxxxComplete( event )
--
-- The request parameters cooresponding to the request are provided to the listener
-- in event.request, as follows:
--
--     event.request.path
--     event.request.method
--     event.request.params
--
-- The error state and response are provided as follows:
--
--     event.isError         - true if an error occurred (see below)
--     event.response        - The decoded response table
--     event.response_raw    - The raw response
--
-- If event.isError, then event.response.error contains the error details table.  
-- This is consistent for both call/connection errors and Graph API errors.  The 
-- details provided include:
--
--     event.response.error.message - The error message
--     event.response.error.type    - The error type for Graph API errors, or "CallError"
--     event.response.error.code    - The error code, or -1 if not known
--
-- If there is no error, then event.response contains a table with response data 
-- from the facebook Graph API request.
--
-- The raw data returned from the Facebook call can be found in event.response_raw.
-- This may contain an error message string, in the case of call/connection errors,
-- or an undecoded JSON string in the case of a completed Graph API request.
--
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- libFacebook.isLoggedIn( )
--
function M.isLoggedIn( )
    return fbLoggedIn
end

function M.setLoggedIn(p)
    fbLoggedIn = p
end

------------------------------------------------------------------------------------
-- libFacebook.login( permissions, onLoginComplete )
--
--   permissions - see http://developers.facebook.com/docs/reference/api/permissions/
--
--   onLoginComplete - function onLoginComplete( event )
--
--     event.name        - "fbconnect"
--     event.type        - "session"
--     event.phase       - One of: "login", "loginFailed", "loginCancelled"
--     event.token       - The access token for the session
--     event.isError     - true if an error occurred, error in event.response
--     event.response    - If error, the error details
--
-- Usage:
--
--   local libFacebook = require("lib_facebook")
--   libFacebook.FB_App_ID = "your_app_id"
--
--   local function onLoginComplete( event )
--       if event.phase ~= "login" then
--           print("Facebook login not successful")
--       elseif event.isError then
--           print("Facebook login error: " .. event.response.error.message)
--       else
--           -- Success - Now you can make Facebook requests!
--       end
--   end
--
--   libFacebook.login({"publish_stream"}, onLoginComplete)
--
function M.login(onLoginComplete)
    --dbg("Preparing to log in")
    
    setNextRequest("login", nil, appInfo.facebookPermissions, onLoginComplete)
    
    if onSimulator then
        simulatorLogin()
    else
        facebook.login(appInfo.facebookAppId, fbListener, appInfo.facebookPermissions)
    end
end

------------------------------------------------------------------------------------
-- libFacebook.request( path, httpMethod, params, onRequestComplete )
--
--   onRequestComplete - function onRequestComplete( event )
--
--     event.name        - "fbconnect"
--     event.type        - "request"
--     event.isError     - true if an error occurred, error in event.response
--     event.response    - The decoded response table
--
-- Usage:
--
--   local function onRequestComplete( event )
--       if event.isError then
--           print("Facebook request error: " .. event.response.error.message)
--       else
--           -- Success - process event.response here!
--       end
--   end
--
--   libFacebook.request("me/friends", "GET", {fields = "name", limit = "10"}, onRequestComplete)
--
function M.request( path, httpMethod, params, onRequestComplete )
    --dbg("Preparing to send request: " .. httpMethod .. " " .. path)

    if fbNextRequest ~= nil then
        error("Error processing Facebook request: " .. httpMethod .. " " .. path .. ", a previous request is still being processed")
    else
        setNextRequest(path, httpMethod, params, onRequestComplete)
    end
    
    if not fbLoggedIn then
        error("Error processing Facebook request: " .. httpMethod .. " " .. path .. ", not currently logged in")
    else
        if onSimulator then
            simulatorRequest(path, httpMethod, params)
        else
            facebook.request(path, httpMethod, params)
        end
    end
end

------------------------------------------------------------------------------------
-- libFacebook.post( path, httpMethod, params, onRequestComplete )
--
--   onRequestComplete - function onRequestComplete( event )
--
--     event.name        - "fbconnect"
--     event.type        - "request"
--     event.isError     - true if an error occurred, error in event.response
--     event.response    - The decoded response table
--
-- Usage:
--
--   local function onRequestComplete( event )
--       if event.isError then
--           print("Facebook request error: " .. event.response.error.message)
--       else
--           -- Success - process event.response here!
--       end
--   end
--
--   libFacebook.post({type = "feed", message = "pepe"}, onRequestComplete)
--
function M.post(params, onRequestComplete)
    if not fbLoggedIn then
        error("Error processing Facebook request: " .. httpMethod .. " " .. path .. ", not currently logged in")
    else
        params.link = params.link or appInfo.link
        params.name = name or appInfo.name
        params.caption = caption or appInfo.seller
        params.description = description or appInfo.description

        if(params.type == "photo") then
            fxFacebook.request("me/photos", "POST", params, onRequestComplete)
        elseif(params.type == "feed") then
            actions = json.encode({{name = "Learn More", link = appInfo.sellerLink}})
            fxFacebook.request("me/feed", "POST", params, onRequestComplete)
        end
    end
end

------------------------------------------------------------------------------------
-- libFacebook.showDialog( type, param, onDialogComplete )
--
--   onDialogComplete - function onDialogComplete( event )
--
--     event.name        - "fbconnect"
--     event.type        - "dialog"
--     event.didComplete - Is false if dialog did not complete (user cancelled)
--     event.isError     - true if an error occurred, error in event.response
--     event.response    - The decoded response table
--
function M.showDialog(type,  params, onDialogComplete )
    --dbg("Preparing to show dialog")

    if fbNextRequest ~= nil then
        error("Error processing Facebook show dialog, a previous request is still being processed")
    else
        setNextRequest("showdialog", nil, params, onDialogComplete)
    end
    
    if not fbLoggedIn then
        error("Error processing Facebook show dialog, not currently logged in")
    else
        if onSimulator then
            error("Facebook showDialog not supported in simulator")
        else
            facebook.showDialog(type, params)
        end
    end
end
-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- i18n
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

if( not _G.fx.i18n ) then
	_G.fx.i18n = {
		resource = resource or "strings",
		deviceLanguage = system.getPreference("locale", "language") or system.getPreference("ui", "language"),
		deviceCountry = system.getPreference( "locale", "country" ),   
	}
end
local i18n = _G.fx.i18n

local json = require("json")

function i18n.getLanguage()
--FIXME: add configuration for this
-- if (settings.game.loadLanguage) then
--   return  settings.game.loadLanguage
-- else
	local files = {
		{file = i18n.resource.."_"..i18n.deviceLanguage.."_"..i18n.deviceCountry..".i18n", id = i18n.deviceLanguage.."_"..i18n.deviceCountry},
		{file = i18n.resource.."_"..i18n.deviceLanguage..".i18n", id = i18n.deviceLanguage},
		{file = i18n.resource..".i18n", id = "en"}
	};
	local strmap = {}
	for i = 1, #files do
		local path = system.pathForFile(i18nDir..files[i].file, system.ResourcesDirectory);
		if path then
			local file = io.open(path, "r");      
			if file then -- nil if no file found
				io.close(file);
				return files[i].id;
			end
		end
	end
end


function i18n.loadLanguage()
	if (fx.settings.p.fx.language and fx.settings.p.fx.language ~= "device") then
	 	i18n.files = {
	 		i18n.resource.."_"..settings.game.loadLanguage..".i18n",
	 		i18n.resource..".i18n"
	 	}
	else
		i18n.files = {
			i18n.resource.."_"..i18n.deviceLanguage.."_"..i18n.deviceCountry..".i18n",
			i18n.resource.."_"..i18n.deviceLanguage..".i18n",
			i18n.resource..".i18n"
		}
	end

	-- Files are processed in order so that finer grained 
	-- message override ones that are more general.
	local strmap = {}
	for i = 1, #i18n.files do
		local path = system.pathForFile(i18nDir..i18n.files[i], system.ResourcesDirectory)
		if path then
			local file = io.open(path, "r")      
			if file then -- nil if no file found
				local contents = file:read("*a")
				io.close(file)
				if(contents ~= "") then
					local resmap = json.decode(contents)
					for key, value in pairs(resmap) do
						strmap[key] = value
					end
					break
				else
					os.remove(path)
				end
			end
		end
	end

	i18n.strings = strmap
end

function i18n.get(key, vars)
	if i18n.strings[key] then
		if(vars == nil) then
			return i18n.strings[key]
		else
			local s = i18n.strings[key]
			for i = 1, #vars do
				s = string.gsub(s, '{'..i..'}', vars[i])
			end
			return s
		end
	else
		return "Missing translation: ".. key
	end
end

function i18n.dump()
	return "i18n [resource="..i18n.resource..", language="..i18n.language..", country="..i18n.country.."]"
end

i18n.loadLanguage()
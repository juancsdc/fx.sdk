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

if( not _G.fx.settings) then
	_G.fx.settings = {}
end
local settings = _G.fx.settings

local json = require "json";
require "sqlite3";
local db = {};

function settings:init()
	local g = nil
	local path = system.pathForFile("settings.sqlite", system.DocumentsDirectory)
	path = system.pathForFile("settings.sqlite", system.DocumentsDirectory);
	db = sqlite3.open(path)

	local sql = 'CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY, key UNIQUE, value);'
	db:exec(sql);
	
	self.p = nil;
	self:load()
	
	if not self.p then
		self.p = require("defaultSettings")
	else
		local tmp = require("defaultSettings")
		table.merge(tmp, self.p)
	end

	self:save()
end

function settings:reset()
	local g=require("defaultSettings");
	game = copy(g.game);
	save();
end

function settings:close()
  db:close();
end

function settings:load()
	local val = nil;
	for result in db:nrows('SELECT value FROM settings WHERE key="config"') do
		val =  json.decode(result.value);
		val = val[1];
	end
	self.p = val
end

function settings:save()
	local sql = 'INSERT OR REPLACE INTO settings(key, value) VALUES ("config", \''..json.encode({self.p})..'\')';
	db:exec(sql);
end

settings:init();
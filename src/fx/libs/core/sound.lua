-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Sound Manager
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

if( not _G.fx.sounds ) then
	_G.fx.sounds = {}
	_G.fx.sounds.soundsCatalog = {}
	_G.fx.sounds.effectsVolume = 0.8
	_G.fx.sounds.musicVolume   = 0.8
	_G.fx.sounds.musicChannels = {}
end

local sounds = _G.fx.sounds

audio.setMinVolume( 0.0 )
audio.setMaxVolume( 1.0 )


--EFM need more channels and way of handling volume
--EFM need error checking code too

-- ==
--    fx.sounds.addEffect( name, file, stream, preload  ) - Creates a record for a new sound effect and optionally prepares it.
-- ==
function sounds.addEffect(name, file, stream, volume, preload, loops)
	local entry = {}
	sounds.soundsCatalog[name] = entry

	entry.name     = name
	entry.file     = file
	entry.stream   = fnn(stream,false)
	entry.preload  = fnn(preload,false)
	entry.volume   = volume
	entry.isEffect = true
	entry.loops    = fnn(loops, 0)

	if(entry.preload) then
		if(entry.stream) then
			entry.handle = audio.loadStream( entry.file )
		else
			entry.handle = audio.loadSound( entry.file )
		end
	end

	return name
end

-- ==
--    fx.sounds:addMusic( name, file, preload, fadein, stream  ) - Creates a record for a new music track and optionally prepares it.
-- ==
function sounds.addMusic(name, file, stream, volume, preload, fadein, fadeout)
	if(sounds.soundsCatalog[name] == nil) then
		local entry = {}
		sounds.soundsCatalog[name] = entry

		entry.name     = name
		entry.file     = file
		entry.stream   = fnn(stream,true)
		entry.preload  = fnn(preload,false)
		entry.fadein   = fnn(fadein, 500 )
		entry.fadeout  = fnn(fadeout, 0 )
		entry.volume  = volume
		entry.stream   = true
		entry.isEffect = false

		if(entry.preload) then
			entry.handle = audio.loadStream( entry.file )
		end
	end
	return name
end

-- ==
--    fx.sounds.setEffectsVolume( value ) - Set the volume level for all sound effects played through the sound manager.
-- ==
function sounds.setEffectsVolume( value )
	sounds.effectsVolume = fnn(value or 1.0)
	if(sounds.effectsVolume < 0) then sounds.effectsVolume = 0 end
	if(sounds.effectsVolume > 1) then sounds.effectsVolume = 1 end
	return sounds.effectsVolume
end

-- ==
--    fx.sounds.getEffectsVolume( ) - Gets the volume level for all sound effects played through the sound manager.
-- ==
function sounds.getEffectsVolume( )
	return sounds.effectsVolume
end

-- ==
--    fx.sounds.setMusicVolume( value ) - Set the volume level for all music tracks played through the sound manager.
-- ==
function sounds.setMusicVolume( value )
	sounds.musicVolume = fnn(value or 1.0)
	if(sounds.musicVolume < 0) then sounds.musicVolume = 0 end
	if(sounds.musicVolume > 1) then sounds.musicVolume = 1 end

	for k,v in pairs(sounds.musicChannels) do
		if(sounds.soundsCatalog[k]) then
			if(sounds.musicVolume == 0) then
				audio.setVolume(0, {channel = v } )
			else
				audio.setVolume(fnn(sounds.soundsCatalog[k].volume, sounds.musicVolume), {channel = v } )
			end
		end
	end
	return sounds.musicVolume
end

-- ==
--    fx.sounds.getMusicVolume( ) - Gets the volume level for all music tracks played through the sound manager.
-- ==
function sounds.getMusicVolume(  )
	return sounds.musicVolume
end

-- ==
--    fx.sounds.play( name ) - Plays a named sound effect or music track.
-- ==
function sounds.play( name )
	local entry = sounds.soundsCatalog[name]

	if(not entry) then
		print("Sound Manager - ERROR: Unknown sound: " .. name )
		return false
	end

	if(not entry.handle) then
		if(entry.stream) then
			entry.handle = audio.loadStream( entry.file )
		else
			entry.handle = audio.loadSound( entry.file )
		end
	end

	if(not entry.handle) then
		print("Sound Manager - ERROR: Failed to load sound: " .. name, entry.file )
		return false
	end

	if(entry.isEffect) then
		if(sounds.effectsVolume == 0) then return true; end
		local channel = audio.findFreeChannel() 
		
		local oldName = sounds.musicChannels[channel]
		
		if( oldName ) then
			sounds.musicChannels[oldName] = nil
			sounds.musicChannels[channel] = nil
		end
		--print(entry.volume, sounds.effectsVolume, fnn(entry.volume, sounds.effectsVolume));
		audio.setVolume(fnn(entry.volume, sounds.effectsVolume), {channel = channel} )
		audio.play( entry.handle, {channel = channel, loops = entry.loops} )
	else
		local channel = sounds.musicChannels[name]
		if( channel ) then
			if(sounds.musicVolume == 0) then
				audio.setVolume(0, {channel=channel});
			else
				audio.setVolume(fnn(entry.volume, sounds.musicVolume), {channel = channel} )
			end
		else
			local channel = audio.findFreeChannel() 
			sounds.musicChannels[channel] = channel
			sounds.musicChannels[name] = channel
			if(sounds.musicVolume == 0) then
				audio.setVolume(0, {channel=channel});
			else
				audio.setVolume(fnn(entry.volume, sounds.musicVolume), {channel = channel} )
			end
			audio.play( entry.handle, {channel = channel, loops = -1, fadein=entry.fadein} )
		end
		--print("PLAYED MUSIC",sounds.musicChannels[name], channel)
	end

	return true

end

-- ==
--    fx.sounds.stop( name ) - Stops a currently-playing named sound effect or music track.
-- ==
function sounds.stop( name )
	local entry = sounds.soundsCatalog[name]

	if(not entry) then
		print("Sound Manager - ERROR: Unknown sound: " .. name )
		return false
	end

	if(entry.isEffect) then
		-- Do nothing, can't stop sound effects
		-- Note: Sound effects should not be long.
	else
		local channel = sounds.musicChannels[name];
		if(channel) then
			if(entry.fadeout > 0) then
				audio.fadeOut({time=entry.fadeout, channel=channel});
				sounds.musicChannels[name] = nil;
				sounds.musicChannels[channel] = nil;
			else
				audio.stop(channel);
				sounds.musicChannels[name] = nil;
				sounds.musicChannels[channel] = nil;
			end
			--print("STOPPED MUSIC")
		end
	end

	return true

end

-- ==
--    fx.sounds.stopMusc(butName) - Stops all playing music but one
-- ==
function sounds.stopMusic(butName)
	for k,v in pairs(sounds.musicChannels) do
		if(k ~= butName) then
			sounds.stop(k);
		end
	end
end
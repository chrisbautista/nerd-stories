-- story lib

local story = {}

-- switches

story.bgOn = true
story.soundOn = true
story.autoOn = true


-- Language

story.titleText = "The Fox and the Grapes"
story.subtitleText = ""

story.btnNext = "Next"
story.btnPrev = "Previous"

story.btnSettings  = "Settings"
story.btnStart = "Start"
story.btnReadme = "Read to Me"

story.btnSoundOn = "Sound On"
story.btnSoundOff = "Sound Off"




-- Directories 
story.imgPath = "_assets/img"
story.imgBgPath = story.imgPath .. "/background"
story.imgBtnPath = story.imgPath .. "/buttons"
story.imgSprPath = story.imgPath .. "/sprites"

story.voicePath = "_assets/voice"
story.musicPath = "_assets/music"
story.soundPath = "_assets/sound"


-- TRANSITION TYPES : PAGES
-- "fade"
-- "crossFade"
-- "zoomOutIn"
-- "zoomOutInFade"
-- "zoomInOut"
-- "zoomInOutFade"
-- "flip"
-- "flipFadeOutIn"
-- "zoomOutInRotate"
-- "zoomOutInFadeRotate"
-- "zoomInOutRotate"
-- "zoomInOutFadeRotate"
-- "fromRight" — over current scene
-- "fromLeft" — over current scene
-- "fromTop" — over current scene
-- "fromBottom" — over current scene
-- "slideLeft" — pushes current scene off
-- "slideRight" — pushes current scene off
-- "slideDown" — pushes current scene off
-- "slideUp" — pushes current scene off



function story.bg( _sceneGroup, _file_ )

	 local _background = display.newImageRect( _sceneGroup, story.imgBgPath .. "/" .. _file_ , display.contentWidth, display.contentHeight )
	 _background.anchorX = 0
	 _background.anchorY = 0
	 _background.x, _background.y = 0, 0

	return _background;

end

function story.spryte(  _file_ )

	return story.imgSprPath .. "/" .. _file_;

end	

function story.title( _string_ )

	local _box = display.newRect( display.contentWidth * 0.5, (display.contentHeight/2)-150, display.contentWidth-50, 200 )
	_box:setFillColor( 0,0,0,0.3 )

	local pageText = display.newText( _string_, 0, 0, native.systemFont, 70 )
	pageText.x = display.contentWidth * 0.5
	pageText.y = ( display.contentHeight / 2 ) - 150

	local titleBlock = display.newGroup( )

	titleBlock:insert( _box )
	titleBlock:insert( pageText )

 return titleBlock;
end

-----------------------------------------------------------------
--  story.button
--  param:  ( text , x , y )
--			( text, x, y , function () end )	
--			( text, x, y , function () end , {width and height} )	

function story.button( ... )

	local arg = {n=select('#', ... ), ... }
	-- arg.n is the real size

	print(arg.n)

	if(arg.n < 3) then
		error( "error: missing parameters" )
		return false;
	end

	local pageText = display.newText( arg[1] , 0, 0, native.systemFont, 70 )
	pageText.x = arg[2]
	pageText.y = arg[3]

	local _box 
	if(arg.n > 4 ) then

		_box = display.newRect( pageText.x, pageText.y, arg[5][1]+20, arg[5][2]+10 )
	else	
		_box = display.newRect( pageText.x, pageText.y, pageText.width+20, pageText.height+10 )

	end
	_box:setFillColor( 0,0,0,0.3 )



	local btnGrp = display.newGroup( )

	btnGrp:insert( _box )
	btnGrp:insert( pageText )

	if(arg.n>3) then
		btnGrp:addEventListener( "tap", arg[4] )
	end

	return btnGrp;
end


function story.loadBg(...)

	if (not story.soundOn) then
		audio.setVolume( 0 )
	end 
	local arg = {n=select('#', ... ), ... }

	if(arg.n < 1) then
		error( "error: missing parameters" )
		return false;
	end

	local bgm = audio.loadStream( story.musicPath .. "/" .. arg[1] );

		local options =
		{
		    channel=1,
		    loops=-1,
			fadein=2000,
		}

		--audio.setVolume( 0.5 , 1 )
	    local bgmChannel = audio.play( bgm , options)

	    return bgmChannel;

end

function story.stopBg(bgmChannel)
	if(story.soundOn)then
		audio.setVolume( 0.5 )
	end
		if(bgmChannel) then 
			print("bgm is OK")
			if(audio.isChannelPlaying(1)) then
				audio.stop( 1 )
			end
		end 
	--end
end

function story.loadVoice(...)

	if (not story.soundOn) then
		audio.setVolume( 0 )
	end 
	local arg = {n=select('#', ... ), ... }

	if(arg.n < 1) then
		error( "error: missing parameters" )
		return false;
	end

	local bgm = audio.loadSound( story.voicePath .. "/" .. arg[1] );

		local options =
		{
		    channel=2,
		    --loops=1,
			fadein=2000,
		}

		--audio.setVolume( 0.5 , 1 )
	    local voiceChannel = audio.play( bgm , options)

	    return voiceChannel;

end

function story.stopVoice(voiceChannel)
	if(story.soundOn)then
		audio.setVolume( 1 )
	end
		if(voiceChannel) then 
			print("voice is OK")
			if(audio.isChannelPlaying(2)) then
				audio.stop( 2 )
			end
		end 
	--end
end

function story.addText(...)

	local arg = {n=select('#', ... ), ... }

	if(arg.n < 1) then
		error( "error: missing parameters" )
		return false;
	end

    local pageText = display.newText( book.text[5] , 0, 0, 550 , 400 , native.systemFont, 35 )
    pageText.x =  display.contentWidth/2 + 150  
    pageText.y = 270 --display.contentHeight 300


end


-- return




return story
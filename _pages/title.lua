-- title.lua


-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------

local story = require("_lib.story")
local composer = require( "composer" )
local scene = composer.newScene()

--------------------------------------------

-- forward declaration
local background

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	background = story.bg( sceneGroup, "title.png")
	
	-- Add more text
	local pageText = story.title(story.titleText)

	local btn1 = story.button(story.btnStart, display.contentWidth * 0.5, (display.contentHeight *0.5) + 50 , 
		function () 
			local options = {
		    	effect = "slideLeft",
		    	time = 500,
		    	params = { level="Level 1", score=currentScore }
			}

			composer.gotoScene( "_pages.page1", options )

			return true;	-- indicates successful touch
		end , 
		{230 , 100}	);


	-- play music here
	-- story.bgm("title")

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( pageText )
	sceneGroup:insert( btn1 )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- -- Called when the scene is now on screen
		
		-- -- INSERT code here to make the scene come alive
		-- -- e.g. start timers, begin animation, play audio, etc.
		
		--  background.touch = onBackgroundTouch
		--  background:addEventListener( "touch", background )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- -- Called when the scene is on screen and is about to move off screen
		-- --
		-- -- INSERT code here to pause the scene
		-- -- e.g. stop timers, stop animation, unload sounds, etc.)

		-- -- remove event listener from background
		-- background:removeEventListener( "touch", background )
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
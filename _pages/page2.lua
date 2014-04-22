--page 2
local story = require( "_lib.story" )
local book = require( "_lib.book" )

local composer = require( "composer" )
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local background

local function dashOne(_sceneGroup, _func)

	local grp  = display.newGroup( )

	local spryte = display.newImageRect( _sceneGroup,  story.spryte("page2-grapes.png") , 336 , 160 )
	spryte.x = display.contentWidth/2 + 30
	spryte.y = 80
	local spryte1 = display.newImageRect( _sceneGroup,  story.spryte("page2-jump1.png") , 300 , 250 )
	spryte1.x = 220
	spryte1.y = 571
	local spryte2 = display.newImageRect( _sceneGroup,  story.spryte("page2-jump2.png") , 300 , 250 )
	spryte2.x = 472
	spryte2.y = 270
	local spryte3 = display.newImageRect( _sceneGroup,  story.spryte("page2-jump3.png") , 300 , 250 )
	spryte3.x = 780
	spryte3.y = 560

	local pageText = display.newText( book.text[3] , 0, 0, 300 , 400 , native.systemFont, 35 )
	pageText.x =  200 
	pageText.y = 300

	local pageText2 = display.newText( book.text[4] , 0, 0, 300 , 500 , native.systemFont, 35 )
	pageText2.x =  display.contentWidth - 200 
	pageText2.y = 400

	--_sceneGroup:insert(spryte)
	--_func()
	grp:insert( spryte )
	grp:insert( spryte1 )
	grp:insert( spryte2 )
	grp:insert( spryte3 )
	grp:insert( pageText )
	grp:insert( pageText2 )


	return grp

end


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    print("page1")

    -- load bg
   background = story.bg( sceneGroup, "pagebg.png")

   local d1;
   local d2;

   d1 = dashOne(sceneGroup, function ()  end)


	local btn1 = story.button(story.btnNext, display.contentWidth - 160 , display.contentHeight - 80 , 
		function () 
			local options = {
		    	effect = "slideLeft",
		    	time = 500,
		    	params = { level="Level 1", score=currentScore }
			}

			composer.gotoScene( "_pages.page3", options );

			return true;	-- indicates successful touch
		end , 
		{230 , 100}	);




   sceneGroup:insert( background )
   sceneGroup:insert( d1 )
   sceneGroup:insert( btn1 )

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
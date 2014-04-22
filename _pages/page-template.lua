--page 1
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

  local grp = display.newGroup( )

	local spryte = display.newImageRect( _sceneGroup,  story.spryte("page1-1.png") , 250 , 250 )
	spryte.x = 250
	spryte.y = 207

	local pageText = display.newText( book.text[1] , 0, 0, 450 , 150 , native.systemFont, 30 )
	pageText.x = display.contentWidth * 0.5 + 80 
	pageText.y = ( display.contentHeight / 2 ) - 200

	--_sceneGroup:insert(spryte)
	_func()

 grp:insert( spryte );
 grp:insert( pageText );
 
	return grp;

end

local function dashTwo(_sceneGroup, _func)

  local grp = display.newGroup( )

	local spryte = display.newImageRect( _sceneGroup,  story.spryte("page1-2.png") , 722 , 722 )
	spryte.x = display.contentCenterX
	spryte.y = display.contentCenterY

	local pageText = display.newText( book.text[2] , 0, 0, 890 , 150 , native.systemFont, 30 )
	pageText.x = display.contentWidth * 0.5 + 40 
	pageText.y = ( display.contentHeight / 2 ) + 200

	--_sceneGroup:insert(spryte)
	_func()

  grp:insert( spryte );
grp:insert( pageText );
  
  return grp;

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

    d1 = dashOne( sceneGroup, function ()

   		 d2 = dashTwo( sceneGroup, function () 


   		  end)

   	end);

	local btn1 = story.button(story.btnNext, display.contentWidth - 230 , display.contentHeight - 110 , 
		function () 
			local options = {
		    	effect = "flipFadeOutIn",
		    	time = 500,
		    	params = { level="Level 1", score=currentScore }
			}

			composer.gotoScene( "_pages.page2", options );

			return true;	-- indicates successful touch
		end , 
		{230 , 100}	);




   sceneGroup:insert( background )
   sceneGroup:insert( d2 )
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
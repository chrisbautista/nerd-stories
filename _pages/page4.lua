--page 3
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

local bgmChannel
local voice

local d1



function dashOne()
  local grp = display.newGroup( )


  print(book.lesson)


  return grp;
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    print("page4")

    -- load bg
   background = story.bg( sceneGroup, "pagebg.png")


   d1 = dashOne()


   sceneGroup:insert( background )

    -- add menu
    local btnHome = display.newImageRect( sceneGroup, story.imgBtnPath .. "/" .. "home.png", 90, 90 )
    btnHome.x = display.contentWidth - 100;
    btnHome.y = 60
    sceneGroup:insert( btnHome )

    btnHome:addEventListener( "tap", function (event) 

      local options = {
          effect = "slideRight",
          time = 500,
          params = {  }
      }

      composer.gotoScene("_pages.title",options)

     end );


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

        --bgmChannel = story.loadBg("pages2.wav")


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

        --story.stopBg(bgmChannel)

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
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
local bgmChannel

local voice 

local d1;
local d2;
local btn1;

print("----")
print(story.soundOn)

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
    local params  = event.params

    -- Initialize the scene here.
    print("page1")

    -- load bg
   background = story.bg( sceneGroup, "pagebg.png")


    d1 = dashOne( sceneGroup, function ()

 
   	end);

    d2 = dashTwo( sceneGroup, function () 


      end)


	 btn1 = story.button(story.btnNext, display.contentWidth - 230 , display.contentHeight - 110 , 
		function () 
			local options = {
		    	effect = "slideLeft",
		    	time = 500,
		    	params = { }
			}

			composer.gotoScene( "_pages.page2", options );

			return true;	-- indicates successful touch
		end , 
		{230 , 100}	);


   sceneGroup:insert( background )
   sceneGroup:insert( d2 )
   sceneGroup:insert( d1 )
   sceneGroup:insert( btn1 )

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

    local function onStartOfScene (event) 
      d2.alpha = 0
      d2.isVisible = true;
      transition.to( d2, { time=1000, delay=8000, alpha=1.0 , onComplete = function(event)

        --btn1.alpha = 0;
        --btn1.isVisible = true
        --transition.to( btn1, { time=1000, delay=8000, alpha=1.0})

      end}  )

    end


    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
      --  bgmChannel = story.loadBg("title.wav")

        -- hide all objects
          d1.isVisible = false;
          d2.isVisible = false;
         -- btn1.isVisible = false;



    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        d1.alpha = 0
        d1.isVisible = true;
        voice = story.loadVoice("page1.m4a");
        transition.to( d1, { time=500, delay=2500, alpha=1.0, onComplete=onStartOfScene }  )
        


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

        -- showEverything
        d1.isVisible = true
        d2.isVisible  = true
        d1.alpha  = 1
        d2.alpha  = 1 

        story.stopVoice(voice)
       -- story.stopBg(bgmChannel)


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
module(..., package.seeall);

function new()
	local localGroup = display.newGroup();
	local backGroup = display.newGroup();
	
	localGroup:insert(backGroup);
	
	local bg = display.newImage("images/back/tutorial.png");
	bg.xScale = maxScale;
	bg.yScale = maxScale;
	bg.x = _W/2;
	bg.y = _H/2;
	backGroup:insert(bg);
	
	local function touchHandler(event)
		local phase = event.phase
		localGroup:removeAllListeners();
		showGame()
	end
	
	function localGroup:removeAllListeners()
		Runtime:removeEventListener("touch", touchHandler);
	end
	
	Runtime:addEventListener( "touch", touchHandler );
	
	return localGroup
end
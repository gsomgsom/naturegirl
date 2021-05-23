module(..., package.seeall);

function new()
	musicStop()
	musicPlay( "musicMainMenu" )
	local localGroup = display.newGroup();
	local backGroup = display.newGroup();
	local faceGroup = display.newGroup();
	
	local arButtons = {};
	local bWindow = false; -- открыто окно или нет
	
	localGroup:insert(backGroup);
	localGroup:insert(faceGroup);
	
	local bg = display.newImage("images/back/bgMenu.jpg");
	bg.xScale = maxScale;
	bg.yScale = maxScale;
	bg.x = _W/2;
	bg.y = _H/2;
	backGroup:insert(bg);
	local logo = display.newImage("images/back/logoGame.png");
	logo.xScale = scaleGraphics;
	logo.yScale = scaleGraphics;
	logo.x = _W/2;
	logo.y = 350*scaleGraphics;
	backGroup:insert(logo);
	
	local btnStart = addButtonTexture("btnPlay");
	scaleObjects(btnStart, 0.75*scaleGraphics);
	btnStart.x = _W/2;
	btnStart.y = _H - 300*scaleGraphics;
	faceGroup:insert(btnStart)
	table.insert(arButtons, btnStart);
	
	local btnExit = addButtonTexture("btnExit");
	scaleObjects(btnExit, 0.6*scaleGraphics)
	btnExit.x = btnExit.w/2 + 25*scaleGraphics;
	btnExit.y = _H - btnExit.h/2 - 25*scaleGraphics;
	faceGroup:insert(btnExit)
	table.insert(arButtons, btnExit);
	local btnSoundOff = addButtonTexture("btnSoundOff");
	scaleObjects(btnSoundOff, 0.6*scaleGraphics)
	btnSoundOff.x = _W - btnSoundOff.w/2 - 25*scaleGraphics;
	btnSoundOff.y = _H - btnSoundOff.h/2 - 25*scaleGraphics;
	faceGroup:insert(btnSoundOff)
	table.insert(arButtons, btnSoundOff);
	local btnSound = addButtonTexture("btnSound");
	scaleObjects(btnSound, 0.6*scaleGraphics)
	btnSound.x = btnSoundOff.x;
	btnSound.y = btnSoundOff.y;
	faceGroup:insert(btnSound)
	table.insert(arButtons, btnSound);
	
	local function refreshSound()
		btnSoundOff.isVisible = (greenSounds:getMusicBol() == false);
		btnSound.isVisible = greenSounds:getMusicBol();
	end
	refreshSound();
	
	local function closeGame( event )
		if ( event.action == "clicked" ) then
			local i = event.index
			if ( i == 1 ) then
				-- Do nothing; dialog will simply dismiss
			elseif ( i == 2 ) then
				localGroup:removeAllListeners();
				native.requestExit();
			end
		end
	end
	
	-------------- touchHandler ----------------
	local function checkButtons(event)
		if(bWindow)then
			return;
		end
		for i=1,#arButtons do
			local item_mc = arButtons[i];
			local _x, _y = item_mc:localToContent(0, 0); -- localToGlobal
			local dx = event.x - _x;
			local dy = event.y - _y;
			local w = item_mc.w;
			local h = item_mc.h;

			if(math.abs(dx)<w/2 and math.abs(dy)<h/2 and item_mc.isVisible)then
				if(item_mc._selected and event.isPrimaryButtonDown)then
					if(item_mc.img)then
						item_mc.img:stopAtFrame(2);
					end
				elseif(item_mc._selected == false)then
					item_mc._selected = true;
					if(item_mc._over)then
						item_mc._over.alpha = 0.3;
					elseif(item_mc.img)then
						item_mc.img:stopAtFrame(2);
					end
				end
			else
				if(item_mc._selected)then
					item_mc._selected = false;
					if(item_mc._over)then
						item_mc._over.alpha = 0;
					elseif(item_mc.img)then
						item_mc.img:stopAtFrame(1);
					end
				end
			end
		end
	end
	
	local function touchHandler(event)
		local phase = event.phase;
		if(phase=='began')then
			checkButtons(event);
		elseif(phase=='moved')then
			checkButtons(event);
		else
			for i=1,#arButtons do
				local item_mc = arButtons[i];
				if(item_mc._selected)then
					item_mc._selected = false;
					if(item_mc._over)then
						item_mc._over.alpha = 0;
					elseif(item_mc.img)then
						item_mc.img:stopAtFrame(1);
						if(item_mc.tf)then
							item_mc.tf.y = item_mc.tf.tgY;
						end
					end
					if(item_mc.onRelease)then
						item_mc:onRelease();
						soundPlay("click_approve");
						return true;
					elseif(item_mc.act == "btnPlay")then
						soundPlay("click_approve");
						showGame();
						return true;
					elseif(item_mc.act == "btnSound" or item_mc.act == "btnSoundOff")then
						soundPlay("click_approve");
						musicSwith();
						refreshSound();
						return true;
					elseif(item_mc.act == "btnExit")then
						soundPlay("click_approve");
						-- localGroup:removeAllListeners();
						-- native.requestExit();
						native.showAlert( "Quit", "Are you sure you want quit?", { "No", "Yes" }, closeGame )
						return true;
					end
				end
			end
		end
	end
	
	local function onKeyEvent(event)
		local phase = event.phase
		local keyName = event.keyName
		if(phase == 'up' and (keyName == "back" or keyName == "escape")) then
			localGroup:removeAllListeners();
			native.requestExit();
			return true;
		end
		return false;
	end
	
	function localGroup:removeAllListeners()
		Runtime:removeEventListener("touch", touchHandler);
		Runtime:removeEventListener( "key", onKeyEvent )
	end
	
	Runtime:addEventListener( "touch", touchHandler );
	Runtime:addEventListener( "key", onKeyEvent )
	
	return localGroup;
end
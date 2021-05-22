module(..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local backGroup = display.newGroup()
	local gameGroup = display.newGroup()
	local faceGroup = display.newGroup()
	
	local ANGLE = 60
	local SCORE = 1
	local TIME_SPEED_MAX = 3000
	
	local _arButtons = {}
	local _arTiles = {}
	local _arImgTiles = {}
	local _gameObj = {}
	local _bWindow = false -- открыто окно или нет
	local _bGameOver = false
	local _character = nil
	local _grass = nil
	local _posChar = 0
	local _floorObj = nil
	local _wndOptions = nil
	local _wndGameOver = nil
	local _oldTime = getTimer()
	local _timeGame = 0
	local _countTileY = 0
	local _score = 0
	local _closeTime = 0
	local _levelTileY = 0
	local _speedGame = 10*scaleGraphics
	local _offsetFloor = 2500*scaleGraphics
	
	localGroup:insert(gameGroup)
	localGroup:insert(faceGroup)
	gameGroup:insert(backGroup)
	
	local rect = display.newRect( _W/2, _H/2, _W, _H )
	rect:setFillColor(0,0,0)
	backGroup:insert(rect)
	
	local tfTitle = createText("", 80*scaleGraphics, {1,1,1})
	tfTitle.x = _W/2
	tfTitle.y = 400*scaleGraphics
	faceGroup:insert(tfTitle)
	
	local bgScore = addObj("score")
	bgScore.xScale = 0.65*scaleGraphics
	bgScore.yScale = bgScore.xScale
	bgScore.x = _W/2 
	bgScore.y = 120*scaleGraphics 
	faceGroup:insert(bgScore)
	
	local tfScore = createText(_score, 80*scaleGraphics, {128/255,137/255,137/255})
	tfScore.x = _W/2
	tfScore.y = 100*scaleGraphics
	faceGroup:insert(tfScore)
	
	local function restartGame()
		_G.options_pause = false
		localGroup:removeAllListeners()
		_character.isVisible = true
		_grass.isVisible = true
		showGame()
	end
	
	local function closeGame()
		_G.options_pause = false
		localGroup:removeAllListeners()
		_character.isVisible = false
		_grass.isVisible = false
		showMenu()
	end
	
	local function closeOptions()
		_character.isVisible = true
		_grass.isVisible = true
		if(_wndOptions)then
			_wndOptions.isVisible = false
		end
		_G.options_pause = false
		_closeTime = 100
	end
	
	local function clickOptions()
		if(_bWindow)then
			return
		end
		if(_wndOptions == nil)then
			_wndOptions = require("src.WindowOptions").new(restartGame, closeGame)
			_wndOptions.xScale = minScale*mobileScale
			_wndOptions.yScale = _wndOptions.xScale
			faceGroup:insert(_wndOptions)
		end
		
		_wndOptions.isVisible = true
		_wndOptions.x = _W/2
		_wndOptions.y = _H/2
		
		_bWindow = true
		_G.options_pause = true
		_character.isVisible = false
		_grass.isVisible = false
	end
	
	local function closeGameOver()
		if(_wndGameOver)then
			_wndGameOver.isVisible = false
		end
		_G.options_pause = false
		_closeTime = 100
	end
	
	local function refreshSkinCharacter(value)
		--[[
		value = tostring(value)
		_character.skin1.isVisible = false
		_character.skin2.isVisible = false
		_character.skin3.isVisible = false
		_character.skin4.isVisible = false
		_character["skin" .. value].isVisible = true
		]]--
	end
	
	local function showGameOver()
		if(_wndGameOver and _wndGameOver.isVisible)then
			return
		end
		if(_bWindow)then
			closeOptions()
		end
		
		setItemCount("score", _score)
		if(_score> getItemCount("scoreRecord"))then
			setItemCount("scoreRecord", _score)
		end
		addItemCount("countDeath", 1)
		soundPlay("soundDie")
		refreshSkinCharacter(4)
		
		if(_wndGameOver == nil)then
			_wndGameOver = require("src.WindowGameOver").new(restartGame, closeGame)
			_wndGameOver.xScale = minScale*mobileScale
			_wndGameOver.yScale = _wndGameOver.xScale
			faceGroup:insert(_wndGameOver)
		end
		
		_wndGameOver.isVisible = true
		_wndGameOver.x = _W/2
		_wndGameOver.y = _H/2
		
		saveData()
		
		_bWindow = true
		_character.isVisible = false
		_grass.isVisible = false
	end

	local function createBackground()
		local size = 254*scaleGraphics
		local countX = math.ceil(_W/size) + 1
		local countY = math.ceil(_H/size) + 1
		local count = countX * countY
		local posX = 0
		local posY = _levelTileY
		_countTileY = countY
		
		for i=1, countY do
			local tileGroup = display.newGroup()
			posX = 0
			
			for i=1, countX do
				local tile = addObj("bgSand")
				tile.xScale = scaleGraphics
				tile.yScale = scaleGraphics
				tile.w = tile.width*tile.xScale
				tile.h = tile.height*tile.yScale
				tile.x = tile.w*posX - tile.w / 2
				tile.y = 0
				tileGroup:insert(tile)
				posX = posX + 1
				table.insert(_arImgTiles, tile)
			end
			tileGroup.y = tileGroup.height*posY
			backGroup:insert(tileGroup)
			table.insert(_arTiles, tileGroup)
			posY = posY + 1
		end
	end
	
	local function pauseGame()
		_character.isVisible = false
		_grass.isVisible = false
		if(options_pause)then
			closeOptions()
		else
			clickOptions()
		end
	end
	
	local function filterGame(value)
		for i=1,#_arImgTiles do
			local obj = _arImgTiles[i]
			if(value)then
				obj.fill.effect = "filter.exposure"
				obj.fill.effect.exposure = 1.2
			else
				obj.fill.effect = nil
			end
		end
	end
	
	local function gameOver()
		_bGameOver = true
		_levelTileY = _levelTileY + _countTileY - 1
		refreshSkinCharacter(2)
		local angle = math.atan2((_character.y - 50*scaleGraphics)-(_character.y), _W/2-(_character.x))
		local cosAngle = math.cos(angle)
		local sinAngle = math.sin(angle)
		_character.status = 1
		_character.speed = 70*scaleGraphics
		_character.xMov = (_character.speed)*cosAngle
		_character.yMov = (_character.speed)*sinAngle
		_character.isVisible = false
		_grass.isVisible = false
	end
	
	local function createGrass()
		_grass = addObj("grass")
		_grass.x = _grass.width / 2 - 150
		_grass.y = _H - _grass.height / 2 + 50
	end


	local function createSkinCharacter(value)
--[[
		value = tostring(value)
		_character["skin" .. value] = addObj("character_" .. value)
		_character["skin" .. value].xScale = 0.5
		_character["skin" .. value].yScale = _character["skin" .. value].xScale
		_character:insert(_character["skin" .. value])
]]--
	end
	
	local function createCharacter()
		local girlTexture = require( "images.sprites.girl" )
		local girlSheet = graphics.newImageSheet( "images/sprites/girl.png", girlTexture:getSheet() )
		_character = display.newSprite( girlSheet, { start = 1, count = 31, time = 500 } )
		_character.xScale = 1.5*scaleGraphics*0.5
		_character.yScale = _character.xScale
		_character.x = _W/2
		_character.y = _H - 300*scaleGraphics - _character.height/2
		_character.speedMax = 180*scaleGraphics
		_character.timeMax = 0
		_character.speedNormal = 90*scaleGraphics
		_character.speed = _character.speedNormal
		_character.xMov = 0
		_character.yMov = 0
		_character.status = 0
		_character.move = false
		_character.w = _character.width*_character.xScale
		_character.h = _character.height*_character.yScale
		_posChar = _character.y
		_character:play()
--[[
		_character = display.newGroup()
		createSkinCharacter(1)
		createSkinCharacter(2)
		createSkinCharacter(3)
		createSkinCharacter(4)
		refreshSkinCharacter(2)
		_character.xScale = 1.5*scaleGraphics
		_character.yScale = _character.xScale
		_character.x = _W/2
		_character.y = _H - 300*scaleGraphics - _character.height/2
		_character.speedMax = 180*scaleGraphics
		_character.timeMax = 0
		_character.speedNormal = 90*scaleGraphics
		_character.speed = _character.speedNormal
		_character.xMov = 0
		_character.yMov = 0
		_character.status = 0
		_character.move = false
		_character.w = _character.width*_character.xScale
		_character.h = _character.height*_character.yScale
		--gameGroup:insert(_character)
		--_floorObj.y = _character.y + _offsetFloor
		_posChar = _character.y
]]--
		
	end
	
	local function createButtons()
		local btnPause = addButtonTexture("btnPause")
		scaleObjects(btnPause, 0.6*scaleGraphics)
		btnPause.x = _W - btnPause.w/2 - 15*scaleGraphics
		btnPause.y = btnPause.h/2 + 15*scaleGraphics
		localGroup:insert(btnPause)
		table.insert(_arButtons, btnPause)
	end
	
	local function refreshCharacter()
		refreshSkinCharacter(3)
		_gameObj["countWall"] = _gameObj["countWall"] + 1		
		_speedGame = math.min((1 + _gameObj["countWall"]/10)*scaleGraphics, 5*scaleGraphics)
	end
	
	local function init()
		_gameObj["countTorch"] = 0
		_gameObj["countSaw"] = 0
		_gameObj["countWall"] = 0
		
		createBackground()
		createCharacter()
		createButtons()
		createGrass()
		
		_grass.isVisible = true
		_character.isVisible = true
		_grass.isVisible = true
	end
	
	init()
	
	local function touchCharacter(event)
		if (options_pause or _bGameOver) then
			return
		end
		
		print(greenInspect.inspect(event))
		if (event.x < _W / 2) then
			print('left')
		else
			print('right')
		end
		_character.x = event.x
		refreshSkinCharacter(1)
		soundPlay("soundHook")
	end
	
	local function updateTiles()
		for i=1,#_arTiles do
			local tile = _arTiles[i]
			if(_bGameOver)then
				if(tile.y + gameGroup.y < - tile.height)then
					_levelTileY = _levelTileY + 1
					tile.y = tile.height*_levelTileY
				end
			else
				if(tile.y + gameGroup.y > _H + tile.height)then
					_levelTileY = _levelTileY - 1
					tile.y = tile.height*_levelTileY
				end
			end
		end
	end

	local function fallCharacter()
		if(_character.status == 1)then
			if (math.abs(standart.mathRound(_character.x) - _W/2) > 50*scaleGraphics)then
				_character.x = _character.x + standart.mathRound(_character.xMov)
				_character.y = _character.y + standart.mathRound(_character.yMov)
			else
				_character.status = 2
				_character.speed = _character.speedNormal
				local angle = math.atan2((_H- 200*scaleGraphics)-(_character.y), _W/2-(_character.x))
				local cosAngle = math.cos(angle)
				local sinAngle = math.sin(angle)
				_character.xMov = (_character.speed)*cosAngle
				_character.yMov = (_character.speed)*sinAngle
			end
		elseif(_character.status == 2)then
			if (math.abs(standart.mathRound(_character.y) - _floorObj.y) > _character.h - 150*scaleGraphics)then
				_character.x = _character.x + standart.mathRound(_character.xMov)
				_character.y = _character.y + standart.mathRound(_character.yMov)
			else
				showGameOver()
			end
		end
	end
	
	local function moveCharacter()
		if(_bGameOver)then
			fallCharacter()
			return
		end
		
		gameGroup.y = gameGroup.y + _speedGame
		
		_score = _score + SCORE
		tfScore.text = _score
		
		_character.x = _character.x + standart.mathRound(_character.xMov)
		_character.y = _character.y + standart.mathRound(_character.yMov)
		
		if(math.ceil(_posChar - gameGroup.y) < math.ceil(_character.y))then
			
		else
			gameGroup.y = -_character.y + _posChar
			_floorObj.y = _character.y + _offsetFloor
		end
		
		if(_character.x < 0 or _character.x > _W)then
			gameOver()
		end
		_character.isVisible = true
		_grass.isVisible = true
	end
	
	local function update()
		if (options_pause) then
			return
		end
		
		local diffTime = getTimer() - _oldTime
		
		_timeGame = _timeGame + diffTime
		
		updateTiles()
		moveCharacter()
		
		if(_character.timeMax > 0)then
			_character.timeMax = _character.timeMax - diffTime
			if(_character.timeMax < 0)then
				_character.speed = _character.speedNormal
				filterGame(false)
			end
		end

		if(_closeTime > 0)then
			_closeTime = _closeTime - diffTime
			if(_closeTime < 1)then
				_bWindow = false
			end
		end
		
		_oldTime = getTimer()
	end
	
	-------------- touchHandler ----------------
	local function checkButtons(event)
		if(_bWindow)then
			-- return
		end
		for i=1,#_arButtons do
			local item_mc = _arButtons[i]
			local _x, _y = item_mc:localToContent(0, 0) -- localToGlobal
			local dx = event.x - _x
			local dy = event.y - _y
			local w = item_mc.w
			local h = item_mc.h

			if(math.abs(dx)<w/2 and math.abs(dy)<h/2 and item_mc.isVisible)then
				if(item_mc._selected and event.isPrimaryButtonDown)then
					if(item_mc.img)then
						item_mc.img:stopAtFrame(2)
					end
				elseif(item_mc._selected == false)then
					item_mc._selected = true
					if(item_mc._over)then
						item_mc._over.alpha = 0.3
					elseif(item_mc.img)then
						item_mc.img:stopAtFrame(2)
					end
				end
			else
				if(item_mc._selected)then
					item_mc._selected = false
					if(item_mc._over)then
						item_mc._over.alpha = 0
					elseif(item_mc.img)then
						item_mc.img:stopAtFrame(1)
					end
				end
			end
		end
	end
	
	local function touchHandler(event)
		local phase = event.phase
		if(phase=='began')then
			checkButtons(event)
		elseif(phase=='moved')then
			checkButtons(event)
		else
			for i=1,#_arButtons do
				local item_mc = _arButtons[i]
				if(item_mc._selected)then
					item_mc._selected = false
					if(item_mc._over)then
						item_mc._over.alpha = 0
					elseif(item_mc.img)then
						item_mc.img:stopAtFrame(1)
						if(item_mc.tf)then
							item_mc.tf.y = item_mc.tf.tgY
						end
					end
					if(item_mc.onRelease)then
						item_mc:onRelease()
						soundPlay("click_approve")
						return true
					elseif(item_mc.act == "btnPause")then
						soundPlay("click_approve")
						pauseGame()
						return true
					end
				end
			end
			
			touchCharacter(event)
		end
	end
	
	local function onKeyEvent(event)
		local phase = event.phase
		local keyName = event.keyName
		local nativeKeyCode = event.nativeKeyCode
		local isShiftDown = event.isShiftDown
		if(phase == 'up') then
			if(keyName == "escape" or keyName == "back") then
				if(_bWindow)then
					if(_wndOptions and _wndOptions.isVisible)then
						closeOptions()
						return true
					end
				else
					if(_wndOptions and _wndOptions.isVisible == false)then
						clickOptions()
						return true
					end
				end
			end
		end
		return false
	end
	
	function localGroup:removeAllListeners()
		Runtime:removeEventListener( "enterFrame", update )
		Runtime:removeEventListener( "touch", touchHandler )
		Runtime:removeEventListener( "key", onKeyEvent )
		if _wndOptions then
			_wndOptions:removeAllListeners()
			_wndOptions = nil
		end
		if _wndGameOver then
			_wndGameOver:removeAllListeners()
			_wndGameOver = nil
		end
	end
	
	Runtime:addEventListener( "enterFrame", update )
	Runtime:addEventListener( "touch", touchHandler )
	Runtime:addEventListener( "key", onKeyEvent )
	
	return localGroup
end
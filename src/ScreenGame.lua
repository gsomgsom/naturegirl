module(..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local backGroup = display.newGroup()
	local gameGroup = display.newGroup()
	local faceGroup = display.newGroup()
	
	local ANGLE = 60
	local HP = 5
	local SCORE = 5
	local TIME_SPEED_MAX = 3000
	local SPEED_MULTIPLIER = 20
	local CELL_DIVIDER = 5
	
	local _drops = {}
	local _blocks = {}
	local _seedsOrangeObj = {}
	local _seedsGreenObj = {}
	local _traps = {}
	local _objCollided = {}

	local _arButtons = {}
	local _arTiles = {}
	local _arImgTiles = {}
	local _gameObj = {}
	local _bWindow = false -- открыто окно или нет
	local _bGameOver = false
	local _character = nil
	local _grass = nil
	local _posChar = 0
	local _wndOptions = nil
	local _wndGameOver = nil
	local _oldTime = getTimer()
	local _timeGame = 0
	local _countTileY = 0
	local _score = 0
	local _hp = 0
	local _seedsOrange = 0
	local _seedsGreen = 0
	local _closeTime = 0
	local _levelTileY = 0
	local _speedGame = SPEED_MULTIPLIER * scaleGraphics
	local _offsetFloor = 2500*scaleGraphics
	local _pointX = 0
	local _levelRow = 0
	
	localGroup:insert(gameGroup)
	localGroup:insert(faceGroup)
	gameGroup:insert(backGroup)
	
	local rect = display.newRect( _W/2, _H/2, _W, _H )
	rect:setFillColor(0,0,0)
	backGroup:insert(rect)
	
--[[
	local tfTitle = createText("", 80*scaleGraphics, {1,1,1})
	tfTitle.x = _W/2
	tfTitle.y = 400*scaleGraphics
	faceGroup:insert(tfTitle)
]]--
	
	local bgHP1 = addObj("hpBG")
	bgHP1.xScale = scaleGraphics
	bgHP1.yScale = bgHP1.xScale
	bgHP1.x = 50
	bgHP1.y = 120*scaleGraphics 
	bgHP1.width = 100
	bgHP1.height = 100
	faceGroup:insert(bgHP1)
	
	local bgHP2 = addObj("hpBG")
	bgHP2.xScale = scaleGraphics
	bgHP2.yScale = bgHP2.xScale
	bgHP2.x = 50 + 105 * 1
	bgHP2.y = 120*scaleGraphics 
	bgHP2.width = 100
	bgHP2.height = 100
	faceGroup:insert(bgHP2)

	local bgHP3 = addObj("hpBG")
	bgHP3.xScale = scaleGraphics
	bgHP3.yScale = bgHP1.xScale
	bgHP3.x = 50 + 105 * 2
	bgHP3.y = 120*scaleGraphics 
	bgHP3.width = 100
	bgHP3.height = 100
	faceGroup:insert(bgHP3)

	local bgHP4 = addObj("hpBG")
	bgHP4.xScale = scaleGraphics
	bgHP4.yScale = bgHP4.xScale
	bgHP4.x = 50 + 105 * 3
	bgHP4.y = 120*scaleGraphics 
	bgHP4.width = 100
	bgHP4.height = 100
	faceGroup:insert(bgHP4)

	local bgHP5 = addObj("hpBG")
	bgHP5.xScale = scaleGraphics
	bgHP5.yScale = bgHP5.xScale
	bgHP5.x = 50 + 105 * 4
	bgHP5.y = 120*scaleGraphics 
	bgHP5.width = 100
	bgHP5.height = 100
	faceGroup:insert(bgHP5)

	local hp1 = addObj("hp")
	hp1.xScale = scaleGraphics
	hp1.yScale = bgHP1.xScale
	hp1.x = 51
	hp1.y = 123*scaleGraphics 
	hp1.width = 80
	hp1.height = 80
	hp1.isVisible = false
	faceGroup:insert(hp1)

	local hp2 = addObj("hp")
	hp2.xScale = scaleGraphics
	hp2.yScale = bgHP2.xScale
	hp2.x = 51 + 105 * 1
	hp2.y = 123*scaleGraphics 
	hp2.width = 80
	hp2.height = 80
	hp2.isVisible = false
	faceGroup:insert(hp2)

	local hp3 = addObj("hp")
	hp3.xScale = scaleGraphics
	hp3.yScale = bgHP3.xScale
	hp3.x = 51 + 105 * 2
	hp3.y = 123*scaleGraphics 
	hp3.width = 80
	hp3.height = 80
	hp3.isVisible = false
	faceGroup:insert(hp3)

	local hp4 = addObj("hp")
	hp4.xScale = scaleGraphics
	hp4.yScale = bgHP4.xScale
	hp4.x = 51 + 105 * 3
	hp4.y = 123*scaleGraphics 
	hp4.width = 80
	hp4.height = 80
	hp4.isVisible = false
	faceGroup:insert(hp4)

	local hp5 = addObj("hp")
	hp5.xScale = scaleGraphics
	hp5.yScale = bgHP5.xScale
	hp5.x = 51 + 105 * 4
	hp5.y = 123*scaleGraphics 
	hp5.width = 80
	hp5.height = 80
	hp5.isVisible = false
	faceGroup:insert(hp5)


	local bgWaterPlank = addObj("waterPlank")
	bgWaterPlank.xScale = 0.50*scaleGraphics
	bgWaterPlank.yScale = bgWaterPlank.xScale
	bgWaterPlank.x = bgWaterPlank.width * bgWaterPlank.xScale / 2 
	bgWaterPlank.y = 250*scaleGraphics 

	local bgWater = addObj("water")
	bgWater.anchorX = 0
	bgWater.xScale = 0.49*scaleGraphics
	bgWater.yScale = bgWater.xScale
	bgWater.x = bgWaterPlank.x - bgWaterPlank.width * bgWaterPlank.xScale / 2 + 10
	bgWater.y = bgWaterPlank.y
	bgWater.width = 0
	bgWater.height = bgWaterPlank.height
	faceGroup:insert(bgWater)
	faceGroup:insert(bgWaterPlank)
	
	local tfScore = createText(_score, 80*scaleGraphics, {0/255,120/255,200/255})
	tfScore.x = bgWaterPlank.width * bgWaterPlank.xScale / 2 
	tfScore.y = 250*scaleGraphics
	faceGroup:insert(tfScore)
	

	local bgSeedsOrangeBG = addObj("seedsBG")
	bgSeedsOrangeBG.xScale = 0.7*scaleGraphics
	bgSeedsOrangeBG.yScale = bgSeedsOrangeBG.xScale
	bgSeedsOrangeBG.x = bgSeedsOrangeBG.width / 2 
	bgSeedsOrangeBG.y = 500*scaleGraphics 
	faceGroup:insert(bgSeedsOrangeBG)
	
	local tfSeedsOrange = createText(_seedsOrange, 80*scaleGraphics, {128/255,64/255,0/255})
	tfSeedsOrange.x = bgSeedsOrangeBG.width / 2 
	tfSeedsOrange.y = 500*scaleGraphics
	faceGroup:insert(tfSeedsOrange)


	local bgSeedsGreenBG = addObj("seedsBG")
	bgSeedsGreenBG.xScale = 0.7*scaleGraphics
	bgSeedsGreenBG.yScale = bgSeedsGreenBG.xScale
	bgSeedsGreenBG.x = bgSeedsGreenBG.width / 2 
	bgSeedsGreenBG.y = 700*scaleGraphics 
	faceGroup:insert(bgSeedsGreenBG)
	
	local tfSeedsGreen = createText(_seedsGreen, 80*scaleGraphics, {0/255,128/255,0/255})
	tfSeedsGreen.x = bgSeedsGreenBG.width / 2 
	tfSeedsGreen.y = 700*scaleGraphics
	faceGroup:insert(tfSeedsGreen)


	local function restartGame()
		_G.options_pause = false
		localGroup:removeAllListeners()
		_character.isVisible = true
		_character:removeSelf()
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

	function createLevelObjects()
		local rowCount = #levels[ 1 ].data

		for r = 1, rowCount do
			for c = 1, CELL_DIVIDER do
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 1 then
					local drop = addObj( "drop" )
					drop.xScale = 1.2
					drop.yScale = 1.2
					drop.w = drop.width * drop.xScale
					drop.h = drop.height * drop.yScale
					drop.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					drop.y = - r * ( _W / CELL_DIVIDER )
					gameGroup:insert( drop )
					table.insert(_drops, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 2 then
					local stone = addObj( "smallStones" )
					stone.xScale = 1.2
					stone.yScale = 1.2
					stone.w = stone.width * stone.xScale
					stone.h = stone.height * stone.yScale
					stone.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					stone.y = - r * ( _W / CELL_DIVIDER )
					gameGroup:insert( stone )
					table.insert(_blocks, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 3 then
					local bones = addObj( "bones" )
					bones.xScale = 1.2
					bones.yScale = 1.2
					bones.w = bones.width * bones.xScale
					bones.h = bones.height * bones.yScale
					bones.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					bones.y = - r * ( _W / CELL_DIVIDER )
					gameGroup:insert( bones )
					table.insert(_blocks, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 4 then
					local seedOrange = addObj( "seedOrange" )
					seedOrange.xScale = 1.2
					seedOrange.yScale = 1.2
					seedOrange.w = seedOrange.width * seedOrange.xScale
					seedOrange.h = seedOrange.height * seedOrange.yScale
					seedOrange.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					seedOrange.y = - r * ( _W / CELL_DIVIDER )
					gameGroup:insert( seedOrange )
					table.insert(_seedsOrangeObj, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 5 then
					local seedGreen = addObj( "seedGreen" )
					seedGreen.xScale = 1.2
					seedGreen.yScale = 1.2
					seedGreen.w = seedGreen.width * seedGreen.xScale
					seedGreen.h = seedGreen.height * seedGreen.yScale
					seedGreen.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					seedGreen.y = - r * ( _W / CELL_DIVIDER )
					gameGroup:insert( seedGreen )
					table.insert(_seedsGreenObj, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 6 then
					local trap = addObj( "skull" )
					trap.xScale = 1.2
					trap.yScale = 1.2
					trap.w = trap.width * trap.xScale
					trap.h = trap.height * trap.yScale
					trap.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					trap.y = - r * ( _W / CELL_DIVIDER )
					gameGroup:insert( trap )
					table.insert(_traps, gameGroup.numChildren)
				end
			end
		end
		--print(greenInspect.inspect(#gameGroup))
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
		_grass.x = _W / 2
		_grass.y = _H - _grass.height / 2
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
		_character.y = _H - 150*scaleGraphics - _character.height/2
		_character.speedMax = 180*scaleGraphics
		_character.timeMax = 0
		_character.speedNormal = 40*scaleGraphics
		_character.speed = _character.speedNormal
		_character.xMov = 0
		_character.yMov = 0
		_character.status = 0
		_character.move = false
		_character.w = _character.width*_character.xScale
		_character.h = _character.height*_character.yScale
		_posChar = _character.y
		_character:play()
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
	
	local function updateScore( newScore )
		_score = newScore
		tfScore.text = tostring( _score )
		bgWater.width = math.min( _score / 100 * bgWaterPlank.width, bgWaterPlank.width )
	end

	local function updateHP( newHP )
		_hp = newHP
		hp1.isVisible = false
		hp2.isVisible = false
		hp3.isVisible = false
		hp4.isVisible = false
		hp5.isVisible = false
		if _hp > 0 then
			hp1.isVisible = true
		end
		if _hp > 1 then
			hp2.isVisible = true
		end
		if _hp > 2 then
			hp3.isVisible = true
		end
		if _hp > 3 then
			hp4.isVisible = true
		end
		if _hp > 4 then
			hp5.isVisible = true
		end
	end

	local function updateSeedsOrange( value )
		_seedsOrange = value
		tfSeedsOrange.text = tostring( _seedsOrange )
	end

	local function updateSeedsGreen( value )
		_seedsGreen = value
		tfSeedsGreen.text = tostring( _seedsGreen )
	end

	local function init()
		_gameObj["countTorch"] = 0
		_gameObj["countSaw"] = 0
		_gameObj["countWall"] = 0
		_pointX = _W/2
		_levelRow = 1
		
		createBackground()
		createLevelObjects()
		createCharacter()
		createButtons()
		createGrass()
		
		updateScore( 0 )
		updateHP( HP )
		updateSeedsOrange( 0 )
		updateSeedsGreen( 0 )

		_grass.isVisible = true
		_character.isVisible = true
		_grass.isVisible = true
	end
	
	init()
	
	local function touchCharacter(event)
		if (options_pause or _bGameOver) then
			return
		end
		
		-- print(greenInspect.inspect(event))
		if (event.x < _character.x) then
			_character.xMov = - _character.speed
			_character.move = true
			print('left')
		else
			_character.xMov = _character.speed
			_character.move = true
			print('right')
		end
		_pointX = event.x
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
--[[
		elseif(_character.status == 2)then
			if (math.abs(standart.mathRound(_character.y) - _floorObj.y) > _character.h - 150*scaleGraphics)then
				_character.x = _character.x + standart.mathRound(_character.xMov)
				_character.y = _character.y + standart.mathRound(_character.yMov)
			else
				showGameOver()
			end
]]--
		end
	end

	local function moveCharacter()
		if(_bGameOver)then
			fallCharacter()
			return
		end
		
		gameGroup.y = gameGroup.y + _speedGame

		_character.x = _character.x + standart.mathRound(_character.xMov)
		_character.y = _character.y + standart.mathRound(_character.yMov)
		
		if _character.xMov < 0 and _character.x < _pointX then
			_character.xMov = 0
			_character.move = false
		end
		if _character.xMov > 0 and _character.x > _pointX then
			_character.xMov = 0
			_character.move = false
		end

		if(math.ceil(_posChar - gameGroup.y) < math.ceil(_character.y))then
			
		else
			gameGroup.y = -_character.y + _posChar
		end

		if _character.x < 0 then
			_character.x = 0
		end
		if _character.x > _W then
			_character.x = _W
		end

		for i = 1, gameGroup.numChildren do
			local child = gameGroup[ i ]
			if standart.hasCollidedRect(child, _character) then
				if not table.includes( _objCollided, i ) and table.includes( _drops, i ) then
					table.insert( _objCollided, i )
					soundPlay("pickup")
					-- fx.screenFlash( { 0, 0, 1 } )
					gameGroup[ i ].isVisible = false
					updateScore( _score + 1 )
				end
				if not table.includes( _objCollided, i ) and table.includes( _traps, i ) then
					table.insert( _objCollided, i )
					soundPlay("electric_trap")
					-- fx.screenFlash( { 1, 0, 1 } )
					updateScore( 0 )
				end
				if not table.includes( _objCollided, i ) and table.includes( _blocks, i ) then
					table.insert( _objCollided, i )
					soundPlay("stone_hit")
					-- fx.screenFlash( { 1, 0, 0 } )
					updateHP( _hp - 1 )
					if _hp <= 0 then
						soundPlay("game_over")
						gameOver()
						showGameOver()
					end
				end
				if not table.includes( _objCollided, i ) and table.includes( _seedsOrangeObj, i ) then
					table.insert( _objCollided, i )
					soundPlay("seed_pickup")
					-- fx.screenFlash( { 1, 0.5, 0 } )
					updateSeedsOrange( _seedsOrange + 1 )
					gameGroup[ i ].isVisible = false
				end
				if not table.includes( _objCollided, i ) and table.includes( _seedsGreenObj, i ) then
					table.insert( _objCollided, i )
					soundPlay("seed_pickup")
					updateSeedsGreen( _seedsGreen + 1 )
					-- fx.screenFlash( { 0, 1, 0 } )
					gameGroup[ i ].isVisible = false
					-- @TODO:green seed +1
				end
			end
		end
--[[
		if(_character.x < 0 or _character.x > _W)then
			gameOver()
		end
]]--
		_character.isVisible = true
		_grass.isVisible = true
	end
	
	local function update()
		if (options_pause) then
			return
		end
		
		local diffTime = getTimer() - _oldTime
		
		_timeGame = _timeGame + diffTime


		_levelRow = _levelRow + 1
		-- print(_levelRow)

--[[
		if _levelRow == 1000 then
			print(_levelRow)
			fx.screenFlash({1,0,0})
		end
]]--

		if gameGroup.y > ( _W / CELL_DIVIDER ) * #levels[ 1 ].data + _H then
			soundPlay("victory")
			gameOver()
		end
		
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
						_character.xMov = 0
						_character.move = false
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
module(..., package.seeall)

function new()
	local localGroup = display.newGroup()
	local backGroup = display.newGroup()
	local gameGroup = display.newGroup()
	local faceGroup = display.newGroup()

	local HP = 5
	local SCORE = 5
	local TIME_SPEED_MAX = 3000
	local SPEED_MULTIPLIER = 20
	local CELL_DIVIDER = 5
	local MAX_PLANTS = 6
	local BOSS_LIGHTING_TIMER = 3000
	local PLANT_ATTACK_TIMER = 1000
	local BOSS_HP = 30

	local gameMode = "normal"
	local cellHeight = ( _W / CELL_DIVIDER ) * 0.5
	local maxGameGroupY = cellHeight * #levels[ 1 ].data + _H
	--maxGameGroupY = 2000 -- DEBUG BOSS FIGHT
	
	local _drops = {}
	local _blocks = {}
	local _seedsOrangeObj = {}
	local _seedsGreenObj = {}
	local _traps = {}
	local _objCollided = {}
	local _plants = {}
	local _plantsLeft = 0
	local _lightning = nil
	local _hit_by_lightning = false
	local _shootingPlant = 1
	local _bossHP = 0

	local _arButtons = {}
	local _arTiles = {}
	local _arImgTiles = {}
	local _gameObj = {}
	local _bWindow = false -- открыто окно или нет
	local _bGameOver = false
	local _fakeCharacter = nil
	local _character = nil
	local _grass = nil
	local _posChar = 0
	local _wndOptions = nil
	local _wndGameOver = nil
	local _wndVictory = nil
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
	local btnGrow = nil
	
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
	bgHP1.x = 50*scaleGraphics
	bgHP1.y = 120*scaleGraphics 
	bgHP1.width = 100*scaleGraphics
	bgHP1.height = 100*scaleGraphics
	faceGroup:insert(bgHP1)
	
	local bgHP2 = addObj("hpBG")
	bgHP2.xScale = scaleGraphics
	bgHP2.yScale = bgHP2.xScale
	bgHP2.x = 50*scaleGraphics + 105 * 1*scaleGraphics
	bgHP2.y = 120*scaleGraphics 
	bgHP2.width = 100*scaleGraphics
	bgHP2.height = 100*scaleGraphics
	faceGroup:insert(bgHP2)

	local bgHP3 = addObj("hpBG")
	bgHP3.xScale = scaleGraphics
	bgHP3.yScale = bgHP1.xScale
	bgHP3.x = 50*scaleGraphics + 105 * 2*scaleGraphics
	bgHP3.y = 120*scaleGraphics 
	bgHP3.width = 100*scaleGraphics
	bgHP3.height = 100*scaleGraphics
	faceGroup:insert(bgHP3)

	local bgHP4 = addObj("hpBG")
	bgHP4.xScale = scaleGraphics
	bgHP4.yScale = bgHP4.xScale
	bgHP4.x = 50*scaleGraphics + 105 * 3*scaleGraphics
	bgHP4.y = 120*scaleGraphics 
	bgHP4.width = 100*scaleGraphics
	bgHP4.height = 100*scaleGraphics
	faceGroup:insert(bgHP4)

	local bgHP5 = addObj("hpBG")
	bgHP5.xScale = scaleGraphics
	bgHP5.yScale = bgHP5.xScale
	bgHP5.x = 50*scaleGraphics + 105 * 4*scaleGraphics
	bgHP5.y = 120*scaleGraphics 
	bgHP5.width = 100*scaleGraphics
	bgHP5.height = 100*scaleGraphics
	faceGroup:insert(bgHP5)

	local hp1 = addObj("hp")
	hp1.xScale = scaleGraphics
	hp1.yScale = bgHP1.xScale
	hp1.x = 50*scaleGraphics
	hp1.y = 120*scaleGraphics 
	hp1.width = 100*scaleGraphics
	hp1.height = 100*scaleGraphics
	hp1.isVisible = false
	faceGroup:insert(hp1)

	local hp2 = addObj("hp")
	hp2.xScale = scaleGraphics
	hp2.yScale = bgHP2.xScale
	hp2.x = 50*scaleGraphics + 105 * 1*scaleGraphics
	hp2.y = 120*scaleGraphics 
	hp2.width = 100*scaleGraphics
	hp2.height = 100*scaleGraphics
	hp2.isVisible = false
	faceGroup:insert(hp2)

	local hp3 = addObj("hp")
	hp3.xScale = scaleGraphics
	hp3.yScale = bgHP3.xScale
	hp3.x = 50*scaleGraphics + 105 * 2*scaleGraphics
	hp3.y = 120*scaleGraphics 
	hp3.width = 100*scaleGraphics
	hp3.height = 100*scaleGraphics
	hp3.isVisible = false
	faceGroup:insert(hp3)

	local hp4 = addObj("hp")
	hp4.xScale = scaleGraphics
	hp4.yScale = bgHP4.xScale
	hp4.x = 50*scaleGraphics + 105 * 3*scaleGraphics
	hp4.y = 120*scaleGraphics 
	hp4.width = 100*scaleGraphics
	hp4.height = 100*scaleGraphics
	hp4.isVisible = false
	faceGroup:insert(hp4)

	local hp5 = addObj("hp")
	hp5.xScale = scaleGraphics
	hp5.yScale = bgHP5.xScale
	hp5.x = 50*scaleGraphics + 105 * 4*scaleGraphics
	hp5.y = 120*scaleGraphics 
	hp5.width = 100*scaleGraphics
	hp5.height = 100*scaleGraphics
	hp5.isVisible = false
	faceGroup:insert(hp5)


	local bgWaterPlank = addObj("waterPlank")
	bgWaterPlank.xScale = 0.50*scaleGraphics
	bgWaterPlank.yScale = bgWaterPlank.xScale
	bgWaterPlank.x = bgWaterPlank.width * bgWaterPlank.xScale / 2 
	bgWaterPlank.y = 300*scaleGraphics 

	local bgWater = addObj("water")
	bgWater.anchorX = 0
	bgWater.xScale = 0.49*scaleGraphics
	bgWater.yScale = bgWater.xScale
	bgWater.x = bgWaterPlank.x - bgWaterPlank.width * bgWaterPlank.xScale / 2 + 10*scaleGraphics
	bgWater.y = bgWaterPlank.y
	bgWater.width = 0
	bgWater.height = bgWaterPlank.height
	faceGroup:insert(bgWater)
	faceGroup:insert(bgWaterPlank)
	
	local tfScore = createText(_score, 80*scaleGraphics, {0/255,120/255,200/255})
	tfScore.x = bgWaterPlank.width * bgWaterPlank.xScale / 2 
	tfScore.y = 300*scaleGraphics
	faceGroup:insert(tfScore)


	local bgBossPlank = addObj("waterPlank")
	bgBossPlank.xScale = 0.50*scaleGraphics
	bgBossPlank.yScale = bgBossPlank.xScale
	bgBossPlank.x = _W - bgBossPlank.width * bgBossPlank.xScale / 2 
	bgBossPlank.y = 300*scaleGraphics 

	local bgBossHP = addObj("bossHP")
	bgBossHP.anchorX = 0
	bgBossHP.xScale = 0.49*scaleGraphics
	bgBossHP.yScale = bgBossHP.xScale
	bgBossHP.x = bgBossPlank.x - bgBossPlank.width * bgBossPlank.xScale / 2
	bgBossHP.y = bgBossPlank.y
	bgBossHP.width = 0
	bgBossHP.height = bgBossPlank.height
	faceGroup:insert(bgBossHP)
	faceGroup:insert(bgBossPlank)
	
	local tfBossHP = createText(_score, 80*scaleGraphics, {0/255,120/255,200/255})
	tfBossHP.x = _W - (bgBossPlank.width * bgBossPlank.xScale / 2 + 10*scaleGraphics)
	tfBossHP.y = 300*scaleGraphics
	faceGroup:insert(tfBossHP)
	

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


	local function updateScore( newScore )
		_score = newScore
		tfScore.text = tostring( _score )
		bgWater.width = math.min( _score / 100 * bgWaterPlank.width, bgWaterPlank.width )
	end

	local function updateBossHP( value )
		_bossHP = value
		tfBossHP.text = tostring( value )
		bgBossHP.width = math.min( _bossHP / BOSS_HP * bgBossPlank.width, bgBossPlank.width )
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

	local function changeGameMode( mode )
		print( "changing mode to " .. mode )
		gameMode = mode
		if gameMode == "bossFight" then
			updateScore( 100 ) -- fake score
			updateSeedsOrange( 10 ) -- fake seeds
			updateSeedsGreen( 10 ) -- fake seeds
			if _plantsLeft > 0 then
				btnGrow.isVisible = true
			end
			for i = 2, gameGroup.numChildren do
				gameGroup[ i ].isVisible = false
			end

			musicStop()
			musicPlay( "musicBossFight" )
			_boss.isVisible = true
			_boss:play()
			_character:setSequence( "idle" )
			_character:play()

			timer.performWithDelay( 2000, function()
				if _boss ~= nil then
					_boss:setSequence( "idle" )
					_boss:play()
				end
			end, 1 )
		else
			_boss.isVisible = false
			btnGrow.isVisible = false
			musicStop()
			musicPlay( "musicGameLevel" )
		end
	end
	
	local function restartGame()
		_G.options_pause = false
		localGroup:removeAllListeners()
		_character.isVisible = true
		_character:removeSelf()
		_boss.isVisible = false
		_boss:removeSelf()
		_grass.isVisible = true
		_grass:removeSelf()
		showGame()
	end
	
	local function closeGame()
		_G.options_pause = false
		localGroup:removeAllListeners()
		_character.isVisible = false
		_character:removeSelf()
		_boss.isVisible = false
		_boss:removeSelf()
		_grass.isVisible = false
		_grass:removeSelf()
		showMenu()
	end
	
	local function closeOptions()
		_character.isVisible = true
		if gameMode == "bossFight" then
			_boss.isVisible = true
			if _plantsLeft > 0 then
				btnGrow.isVisible = true
			end
		end
		_grass.isVisible = true
		if #_plants > 0 then
			for i = 1, #_plants do
				_plants[ i ].isVisible = true
			end
		end
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
		_boss.isVisible = false
		_grass.isVisible = false
		if #_plants > 0 then
			for i = 1, #_plants do
				_plants[ i ].isVisible = false
			end
		end
	end
	
	local function closeGameOver()
		if(_wndGameOver)then
			_wndGameOver.isVisible = false
		end
		_G.options_pause = false
		_closeTime = 100
	end
	
	local function closeVictory()
		if(_wndVictory)then
			_wndVictory.isVisible = false
		end
		_G.options_pause = false
		_closeTime = 100
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
		_boss.isVisible = false
		_grass.isVisible = false
		if #_plants > 0 then
			for i = 1, #_plants do
				_plants[ i ].isVisible = false
			end
		end
	end

	local function showVictory()
		if(_wndVictory and _wndVictory.isVisible)then
			return
		end
		if(_bWindow)then
			closeOptions()
		end
		
		if(_wndVictory == nil)then
			_wndVictory = require("src.WindowVictory").new(restartGame, closeGame)
			_wndVictory.xScale = minScale*mobileScale
			_wndVictory.yScale = _wndVictory.xScale
			faceGroup:insert(_wndVictory)
		end
		
		_wndVictory.isVisible = true
		_wndVictory.x = _W/2
		_wndVictory.y = _H/2
		
		saveData()
		
		_bWindow = true
		_character.isVisible = false
		_boss.isVisible = false
		_grass.isVisible = false
		if #_plants > 0 then
			for i = 1, #_plants do
				_plants[ i ].isVisible = false
			end
		end
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
					drop.xScale = 0.5*scaleGraphics
					drop.yScale = 0.5*scaleGraphics
					drop.w = drop.width * drop.xScale
					drop.h = drop.height * drop.yScale
					drop.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					drop.y = - r * cellHeight
					gameGroup:insert( drop )
					table.insert(_drops, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 2 then
					local stone = addObj( "smallStones" )
					stone.xScale = 1.2*scaleGraphics
					stone.yScale = 1.2*scaleGraphics
					stone.w = stone.width * stone.xScale
					stone.h = stone.height * stone.yScale
					stone.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					stone.y = - r * cellHeight
					gameGroup:insert( stone )
					table.insert(_blocks, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 3 then
					local bones = addObj( "skull" )
					bones.xScale = 1*scaleGraphics
					bones.yScale = 1*scaleGraphics
					bones.w = bones.width * bones.xScale
					bones.h = bones.height * bones.yScale
					bones.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					bones.y = - r * cellHeight
					gameGroup:insert( bones )
					table.insert(_blocks, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 4 then
					local seedOrange = addObj( "seedOrange" )
					seedOrange.xScale = 0.2*scaleGraphics
					seedOrange.yScale = 0.2*scaleGraphics
					seedOrange.w = seedOrange.width * seedOrange.xScale
					seedOrange.h = seedOrange.height * seedOrange.yScale
					seedOrange.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					seedOrange.y = - r * cellHeight
					gameGroup:insert( seedOrange )
					table.insert(_seedsOrangeObj, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 5 then
					local seedGreen = addObj( "seedGreen" )
					seedGreen.xScale = 0.2*scaleGraphics
					seedGreen.yScale = 0.2*scaleGraphics
					seedGreen.w = seedGreen.width * seedGreen.xScale
					seedGreen.h = seedGreen.height * seedGreen.yScale
					seedGreen.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					seedGreen.y = - r * cellHeight
					gameGroup:insert( seedGreen )
					table.insert(_seedsGreenObj, gameGroup.numChildren)
				end
				if levels[ 1 ].data[ rowCount - r + 1 ][ c ] == 6 then
					local trap = addObj( "trap" )
					trap.xScale = 1.1*scaleGraphics
					trap.yScale = 1.1*scaleGraphics
					trap.w = trap.width * trap.xScale
					trap.h = trap.height * trap.yScale
					trap.x = ( _W / CELL_DIVIDER ) * ( c - 1 ) + ( ( _W / CELL_DIVIDER ) / 2 )
					trap.y = - r * cellHeight
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
		btnGrow.isVisible = false
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
		local angle = math.atan2((_character.y - 50*scaleGraphics)-(_character.y), _W/2-(_character.x))
		local cosAngle = math.cos(angle)
		local sinAngle = math.sin(angle)
		_character.status = 1
		_character.speed = 70*scaleGraphics
		_character.xMov = (_character.speed)*cosAngle
		_character.yMov = (_character.speed)*sinAngle
		_character.isVisible = false
		_boss.isVisible = false
		_grass.isVisible = false
		if #_plants > 0 then
			for i = 1, #_plants do
				_plants[ i ].isVisible = false
			end
		end
	end
	
	local function createGrass()
		_grass = addObj("grass")
		_grass.xScale = 1*maxScale
		_grass.yScale = _grass.xScale
		_grass.x = _W / 2
		_grass.y = _H - _grass.height*scaleGraphics / 2
		localGroup:insert(_grass)
	end

	local function createCharacter()
		local girlTexture = require( "images.sprites.girl" )
		local girlSheet = graphics.newImageSheet( "images/sprites/girl.png", girlTexture:getSheet() )
		_character = display.newSprite( girlSheet, {
			{
				name = "run", start = 1, count = 31, time = 500, loopCount = 0,
			},
			{
				name = "idle", start = 16, count = 3, time = 1500, loopCount = 0,
			},
		} )
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
		_fakeCharacter = display.newRect( _character.x, _character.y, _character.w * 0.7, _character.h * 0.8 )
		_fakeCharacter.isVisible = false
		_posChar = _character.y
		_character:setSequence( "run" )
		_character:play()
	end

	local function createBoss()
		local bossTexture = require( "images.sprites.boss" )
		local bossSheet = graphics.newImageSheet( "images/sprites/boss.png", bossTexture:getSheet() )
		_boss = display.newSprite( bossSheet, {
			{
				name = "start", start = 1, count = 28, time = 1500, loopCount = 1,
			},
			{
				name = "fight", frames = { 19,20,21,22,23,24,25,26,27,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18, }, time = BOSS_LIGHTING_TIMER, loopCount = 0,
			},
			{
				name = "idle", start = 1, count = 12, time = 500, loopCount = 0,
			},
		} )
		_boss.xScale = 1*scaleGraphics
		_boss.yScale = _boss.xScale
		_boss.x = _W/2
		_boss.y = _H/2 - _boss.height*scaleGraphics + 50*scaleGraphics
		_boss.w = _boss.width*_boss.xScale
		_boss.h = _boss.height*_boss.yScale
		_boss.isVisible = false
	end

	local function createButtons()
		local btnPause = addButtonTexture("btnPause")
		scaleObjects(btnPause, 0.6*scaleGraphics)
		btnPause.x = _W - btnPause.w/2 - 15*scaleGraphics
		btnPause.y = btnPause.h/2 + 15*scaleGraphics
		localGroup:insert(btnPause)
		table.insert(_arButtons, btnPause)

		btnGrow = addButtonTexture("btnGrow")
		scaleObjects(btnGrow, 0.6*scaleGraphics)
		btnGrow.x = btnGrow.w/2 + 25*scaleGraphics
		btnGrow.y = _H - btnGrow.h/2 - 25*scaleGraphics
		localGroup:insert(btnGrow)
		table.insert(_arButtons, btnGrow)
		btnGrow.isVisible = false
	end
	
	local function refreshCharacter()
		_gameObj["countWall"] = _gameObj["countWall"] + 1		
		_speedGame = math.min((1 + _gameObj["countWall"]/10)*scaleGraphics, 5*scaleGraphics)
	end
	
	local function init()
		_gameObj["countTorch"] = 0
		_gameObj["countSaw"] = 0
		_gameObj["countWall"] = 0
		_pointX = _W/2
		_levelRow = 1
		_plantsLeft = MAX_PLANTS
		if #_plants > 0 then
			for i = #_plants, 1 do
				_plants[ i ]:removeSelf()
			end
		end
		_plants = {}
		
		createBackground()
		createLevelObjects()
		createCharacter()
		createBoss()
		createGrass()
		createButtons()
		
		updateScore( 0 )
		updateHP( HP )
		updateBossHP( BOSS_HP )
		updateSeedsOrange( 0 )
		updateSeedsGreen( 0 )

		changeGameMode( "normal" )

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
				_fakeCharacter.x = _character.x
				_fakeCharacter.y = _character.y
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
		
		if gameMode == "normal" then
			gameGroup.y = gameGroup.y + _speedGame
		end

		_character.x = _character.x + standart.mathRound(_character.xMov)
		_character.y = _character.y + standart.mathRound(_character.yMov)
		_fakeCharacter.x = _character.x
		_fakeCharacter.y = _character.y
		
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
		_fakeCharacter.x = _character.x
		_fakeCharacter.y = _character.y

		for i = 1, gameGroup.numChildren do
			local child = gameGroup[ i ]
			if standart.hasCollidedRect(child, _fakeCharacter) then
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
					fx.screenFlash( { 0, 0, 1 } )
					updateScore( 0 )
				end
				if not table.includes( _objCollided, i ) and table.includes( _blocks, i ) then
					table.insert( _objCollided, i )
					soundPlay("player_hit")
					fx.screenFlash( { 1, 0, 0 } )
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

		if gameGroup.y > maxGameGroupY and gameMode ~= "bossFight" then
			changeGameMode( "bossFight" )
		end

		updateTiles()
		moveCharacter()

		if not _bGameOver and _lightning ~= nil and not _hit_by_lightning and standart.hasCollidedRect(_lightning, _fakeCharacter) then
			_hit_by_lightning = true
			soundPlay("player_hit")
			fx.screenFlash( { 1, 0, 0 } )
			updateHP( _hp - 1 )
			if _hp <= 0 then
				soundPlay("game_over")
				gameOver()
				showGameOver()
			end
		end
		
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

	local function createPlantObject( kind )
		local plantTexture = require( "images.sprites." .. kind .. "Animation" )
		local plantSheet = graphics.newImageSheet( "images/sprites/" .. kind .. "Animation.png", plantTexture:getSheet() )
		local newPlant = display.newSprite( plantSheet, {
			{
				name = "grow", start = 1, count = 17, time = 500, loopCount = 1,
			},
		} )
		newPlant.xScale = 0.5*scaleGraphics
		newPlant.yScale = newPlant.xScale
		if _plantsLeft >= 3 then
			newPlant.y = _H - 300*scaleGraphics - newPlant.height/2
		else
			newPlant.y = _H - 500*scaleGraphics - newPlant.height/2
		end
		newPlant.x = _W/3 * (_plantsLeft % 3) + _W/6
		newPlant.w = newPlant.width*newPlant.xScale
		newPlant.h = newPlant.height*newPlant.yScale
		newPlant:setSequence( "run" )
		newPlant:play()
		return newPlant
	end

	local function createLightning()
		local lightningTexture = require( "images.texture.lightning" )
		local lightningSheet = graphics.newImageSheet( "images/texture/lightning.png", lightningTexture:getSheet() )
		local newLightning = display.newSprite( lightningSheet, {
			{
				name = "default", start = 1, count = 11, time = 300, loopCount = 0,
			},
		} )
		newLightning.xScale = 1*scaleGraphics
		newLightning.yScale = newLightning.xScale
		newLightning.x = math.random( 0, _W )
		newLightning.y = _boss.y
		newLightning.w = newLightning.width*newLightning.xScale
		newLightning.h = newLightning.height*newLightning.yScale
		newLightning:setSequence( "default" )
		newLightning:play()
		return newLightning
	end

	local function createPlantBullet( x, y )
		local newBullet = addObj("bullet")
		newBullet.xScale = 3*scaleGraphics
		newBullet.yScale = newBullet.xScale
		newBullet.x = x
		newBullet.y = y
		newBullet.w = newBullet.width*newBullet.xScale
		newBullet.h = newBullet.height*newBullet.yScale
		return newBullet
	end

	-- very fake seeds grow
	local function spawnPlant()
		if gameMode == "bossFight" and _plantsLeft > 0 then
			_plantsLeft = _plantsLeft - 1
			if math.random(0, 100) > 50 then
				updateScore( _score - 5 )
				updateSeedsOrange( _seedsOrange - 1 )
				table.insert( _plants, createPlantObject( "flowerYellow" ) )
			else
				updateScore( _score - 10 )
				updateSeedsGreen( _seedsGreen - 1 )
				table.insert( _plants, createPlantObject( "flowerGreen" ) )
			end
		
			if _plantsLeft <= 0 then
				soundPlay( "fightvoice" )
				_boss:setSequence( "fight" )
				_boss:play()

				timer.performWithDelay( BOSS_LIGHTING_TIMER, function()
					if not _bGameOver and gameMode == "bossFight" and _plantsLeft == 0 and not options_pause then
						_hit_by_lightning = false
						fx.screenFlash( { 0, 0, 1 } )
						soundPlay( "electric_trap" )
						_lightning = createLightning()
						transition.to( _lightning, { time = 2000, y = _H, onComplete = function( obj )
							_hit_by_lightning = true
							obj:removeSelf()
						end } )
					end
				end, 0 )

				timer.performWithDelay( PLANT_ATTACK_TIMER, function()
					if not _bGameOver and gameMode == "bossFight" and _plantsLeft == 0 and not options_pause then
						soundPlay( "squash" )
						_plantBullet = createPlantBullet( _plants[ _shootingPlant ].x, _plants[ _shootingPlant ].y )
						transition.to( _plantBullet, { time = 500, x = _boss.x, y = _boss.y, onComplete = function( obj )
							obj:removeSelf()
							soundPlay( "boss_hit" )
							updateBossHP( _bossHP - 1 )
							if _bossHP <= 0 then
								soundPlay("victory")
								gameOver()
								showVictory()
							end
						end } )

						_shootingPlant = _shootingPlant + 1
						if _shootingPlant > #_plants then
							_shootingPlant = 1
						end

					end
				end, 0 )

				btnGrow.isVisible = false
			end
		end
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
					elseif(item_mc.act == "btnPause") then
						soundPlay("click_approve")
						pauseGame()
						return true
					elseif(item_mc.act == "btnGrow") then
						soundPlay("pwwt")
						spawnPlant()
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
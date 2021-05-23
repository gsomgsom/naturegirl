--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:665b3517b661cef49039f527fd1dc06d:5f1865b090815f655855a96316a10e78:d11cd4bea17aadd3936ef7f00a0d2916$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- flowerGreen_00
            x=599,
            y=1,
            width=297,
            height=423,

            sourceX = 6,
            sourceY = 3,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_01
            x=898,
            y=1,
            width=297,
            height=421,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_02
            x=900,
            y=424,
            width=297,
            height=421,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_03
            x=1197,
            y=1,
            width=297,
            height=419,

            sourceX = 6,
            sourceY = 7,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_04
            x=900,
            y=847,
            width=297,
            height=419,

            sourceX = 6,
            sourceY = 7,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_05
            x=1498,
            y=422,
            width=297,
            height=417,

            sourceX = 7,
            sourceY = 9,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_06
            x=1498,
            y=841,
            width=297,
            height=417,

            sourceX = 7,
            sourceY = 9,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_07
            x=601,
            y=851,
            width=297,
            height=415,

            sourceX = 7,
            sourceY = 11,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_08
            x=300,
            y=851,
            width=299,
            height=415,

            sourceX = 6,
            sourceY = 11,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_09
            x=1199,
            y=843,
            width=297,
            height=417,

            sourceX = 8,
            sourceY = 9,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_10
            x=1496,
            y=1,
            width=297,
            height=419,

            sourceX = 8,
            sourceY = 7,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_11
            x=1199,
            y=422,
            width=297,
            height=419,

            sourceX = 8,
            sourceY = 7,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_12
            x=300,
            y=428,
            width=299,
            height=421,

            sourceX = 7,
            sourceY = 5,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_13
            x=601,
            y=426,
            width=297,
            height=423,

            sourceX = 9,
            sourceY = 3,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_14
            x=1,
            y=430,
            width=297,
            height=425,

            sourceX = 9,
            sourceY = 1,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_15
            x=300,
            y=1,
            width=297,
            height=425,

            sourceX = 9,
            sourceY = 1,
            sourceWidth = 309,
            sourceHeight = 427
        },
        {
            -- flowerGreen_16
            x=1,
            y=1,
            width=297,
            height=427,

            sourceX = 9,
            sourceY = 0,
            sourceWidth = 309,
            sourceHeight = 427
        },
    },

    sheetContentWidth = 1796,
    sheetContentHeight = 1267
}

SheetInfo.frameIndex =
{

    ["flowerGreen_00"] = 1,
    ["flowerGreen_01"] = 2,
    ["flowerGreen_02"] = 3,
    ["flowerGreen_03"] = 4,
    ["flowerGreen_04"] = 5,
    ["flowerGreen_05"] = 6,
    ["flowerGreen_06"] = 7,
    ["flowerGreen_07"] = 8,
    ["flowerGreen_08"] = 9,
    ["flowerGreen_09"] = 10,
    ["flowerGreen_10"] = 11,
    ["flowerGreen_11"] = 12,
    ["flowerGreen_12"] = 13,
    ["flowerGreen_13"] = 14,
    ["flowerGreen_14"] = 15,
    ["flowerGreen_15"] = 16,
    ["flowerGreen_16"] = 17,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:5557d78ed1d88550812174cbec691359:de7b89ae76f2eacbe85c23924f8203bf:0c0d310326608b278403d19b7711782e$
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
            -- flowerYellow_00
            x=1,
            y=554,
            width=420,
            height=549,

            sourceX = 14,
            sourceY = 3,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_01
            x=845,
            y=1105,
            width=418,
            height=549,

            sourceX = 11,
            sourceY = 1,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_02
            x=1267,
            y=1,
            width=418,
            height=549,

            sourceX = 7,
            sourceY = 0,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_03
            x=1,
            y=1,
            width=420,
            height=551,

            sourceX = 5,
            sourceY = 8,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_04
            x=1265,
            y=1105,
            width=418,
            height=549,

            sourceX = 6,
            sourceY = 18,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_05
            x=1,
            y=1105,
            width=420,
            height=549,

            sourceX = 12,
            sourceY = 18,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_06
            x=1687,
            y=1,
            width=418,
            height=549,

            sourceX = 21,
            sourceY = 18,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_07
            x=1685,
            y=1105,
            width=418,
            height=549,

            sourceX = 25,
            sourceY = 13,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_08
            x=845,
            y=552,
            width=418,
            height=551,

            sourceX = 28,
            sourceY = 5,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_09
            x=2105,
            y=1105,
            width=418,
            height=549,

            sourceX = 24,
            sourceY = 4,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_10
            x=423,
            y=1,
            width=420,
            height=549,

            sourceX = 17,
            sourceY = 2,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_11
            x=423,
            y=552,
            width=420,
            height=549,

            sourceX = 12,
            sourceY = 3,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_12
            x=423,
            y=1103,
            width=420,
            height=549,

            sourceX = 7,
            sourceY = 4,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_13
            x=1265,
            y=552,
            width=418,
            height=551,

            sourceX = 4,
            sourceY = 8,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_14
            x=1685,
            y=552,
            width=418,
            height=551,

            sourceX = 0,
            sourceY = 13,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_15
            x=2105,
            y=552,
            width=418,
            height=551,

            sourceX = 6,
            sourceY = 15,
            sourceWidth = 446,
            sourceHeight = 567
        },
        {
            -- flowerYellow_16
            x=845,
            y=1,
            width=420,
            height=549,

            sourceX = 10,
            sourceY = 18,
            sourceWidth = 446,
            sourceHeight = 567
        },
    },

    sheetContentWidth = 2524,
    sheetContentHeight = 1655
}

SheetInfo.frameIndex =
{

    ["flowerYellow_00"] = 1,
    ["flowerYellow_01"] = 2,
    ["flowerYellow_02"] = 3,
    ["flowerYellow_03"] = 4,
    ["flowerYellow_04"] = 5,
    ["flowerYellow_05"] = 6,
    ["flowerYellow_06"] = 7,
    ["flowerYellow_07"] = 8,
    ["flowerYellow_08"] = 9,
    ["flowerYellow_09"] = 10,
    ["flowerYellow_10"] = 11,
    ["flowerYellow_11"] = 12,
    ["flowerYellow_12"] = 13,
    ["flowerYellow_13"] = 14,
    ["flowerYellow_14"] = 15,
    ["flowerYellow_15"] = 16,
    ["flowerYellow_16"] = 17,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

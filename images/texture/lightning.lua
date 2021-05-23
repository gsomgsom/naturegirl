--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:c4b30403fbc4a91c15853539c802ee2a:8091f4360b938ea3c3fe37f8fb071cf7:74a6ee1732652fa474489b658ff699e6$
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
            -- lightning_00
            x=1,
            y=701,
            width=267,
            height=325,

            sourceX = 17,
            sourceY = 3,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_01
            x=539,
            y=1030,
            width=267,
            height=327,

            sourceX = 17,
            sourceY = 5,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_02
            x=1,
            y=1030,
            width=267,
            height=329,

            sourceX = 17,
            sourceY = 7,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_03
            x=270,
            y=705,
            width=267,
            height=333,

            sourceX = 16,
            sourceY = 9,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_04
            x=1,
            y=364,
            width=265,
            height=335,

            sourceX = 17,
            sourceY = 12,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_05
            x=541,
            y=691,
            width=265,
            height=337,

            sourceX = 17,
            sourceY = 15,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_06
            x=541,
            y=348,
            width=265,
            height=341,

            sourceX = 16,
            sourceY = 17,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_07
            x=541,
            y=1,
            width=265,
            height=345,

            sourceX = 16,
            sourceY = 18,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_08
            x=272,
            y=356,
            width=267,
            height=347,

            sourceX = 15,
            sourceY = 21,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_09
            x=272,
            y=1,
            width=267,
            height=353,

            sourceX = 16,
            sourceY = 24,
            sourceWidth = 299,
            sourceHeight = 389
        },
        {
            -- lightning_10
            x=1,
            y=1,
            width=269,
            height=361,

            sourceX = 15,
            sourceY = 25,
            sourceWidth = 299,
            sourceHeight = 389
        },
    },

    sheetContentWidth = 807,
    sheetContentHeight = 1360
}

SheetInfo.frameIndex =
{

    ["lightning_00"] = 1,
    ["lightning_01"] = 2,
    ["lightning_02"] = 3,
    ["lightning_03"] = 4,
    ["lightning_04"] = 5,
    ["lightning_05"] = 6,
    ["lightning_06"] = 7,
    ["lightning_07"] = 8,
    ["lightning_08"] = 9,
    ["lightning_09"] = 10,
    ["lightning_10"] = 11,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

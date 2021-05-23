--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:116ba64f30f61fa3e58a69dae740fc86:c0bdaa8d19b8733c371ae815b9b53eed:2f9aa7ed53d9dd429372ba2a00184b66$
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
            -- btnAd
            x=910,
            y=303,
            width=300,
            height=300,

        },
        {
            -- btnExit
            x=1,
            y=503,
            width=301,
            height=300,

        },
        {
            -- btnGrow
            x=910,
            y=605,
            width=300,
            height=300,

        },
        {
            -- btnMenu
            x=304,
            y=503,
            width=301,
            height=300,

        },
        {
            -- btnPause
            x=503,
            y=1,
            width=301,
            height=300,

        },
        {
            -- btnPlay
            x=1,
            y=1,
            width=500,
            height=500,

        },
        {
            -- btnRetry
            x=806,
            y=1,
            width=301,
            height=300,

        },
        {
            -- btnSound
            x=607,
            y=303,
            width=301,
            height=300,

        },
        {
            -- btnSoundOff
            x=607,
            y=605,
            width=301,
            height=300,

        },
    },

    sheetContentWidth = 1211,
    sheetContentHeight = 906
}

SheetInfo.frameIndex =
{

    ["btnAd"] = 1,
    ["btnExit"] = 2,
    ["btnGrow"] = 3,
    ["btnMenu"] = 4,
    ["btnPause"] = 5,
    ["btnPlay"] = 6,
    ["btnRetry"] = 7,
    ["btnSound"] = 8,
    ["btnSoundOff"] = 9,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

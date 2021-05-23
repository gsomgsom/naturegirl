--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:774f139814823373636fa408004ee7d2:4edc9ccc5e3b5534aecd3c20bfbb8104:2f9aa7ed53d9dd429372ba2a00184b66$
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
            x=1109,
            y=303,
            width=300,
            height=300,

        },
        {
            -- btnExit
            x=803,
            y=1,
            width=301,
            height=300,

        },
        {
            -- btnGrow
            x=1109,
            y=605,
            width=300,
            height=300,

        },
        {
            -- btnHardmode
            x=1,
            y=1,
            width=800,
            height=300,

        },
        {
            -- btnMenu
            x=503,
            y=303,
            width=301,
            height=300,

        },
        {
            -- btnPause
            x=503,
            y=605,
            width=301,
            height=300,

        },
        {
            -- btnPlay
            x=1,
            y=303,
            width=500,
            height=500,

        },
        {
            -- btnRetry
            x=1106,
            y=1,
            width=301,
            height=300,

        },
        {
            -- btnSound
            x=806,
            y=303,
            width=301,
            height=300,

        },
        {
            -- btnSoundOff
            x=806,
            y=605,
            width=301,
            height=300,

        },
    },

    sheetContentWidth = 1410,
    sheetContentHeight = 906
}

SheetInfo.frameIndex =
{

    ["btnAd"] = 1,
    ["btnExit"] = 2,
    ["btnGrow"] = 3,
    ["btnHardmode"] = 4,
    ["btnMenu"] = 5,
    ["btnPause"] = 6,
    ["btnPlay"] = 7,
    ["btnRetry"] = 8,
    ["btnSound"] = 9,
    ["btnSoundOff"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

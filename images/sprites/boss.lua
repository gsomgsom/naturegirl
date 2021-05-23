--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:c40540159edc32034f12fdae269eb926:2510da54adbe7a701ad137b92e5b3788:05506c40c5a6370373c34b7ad9a8efcf$
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
            -- boss_00
            x=1,
            y=516,
            width=339,
            height=423,

            sourceX = 19,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_01
            x=1,
            y=941,
            width=339,
            height=423,

            sourceX = 19,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_02
            x=380,
            y=1,
            width=337,
            height=423,

            sourceX = 20,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_03
            x=719,
            y=1,
            width=337,
            height=423,

            sourceX = 20,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_04
            x=1058,
            y=1,
            width=335,
            height=423,

            sourceX = 21,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_05
            x=342,
            y=516,
            width=333,
            height=423,

            sourceX = 23,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_06
            x=342,
            y=941,
            width=331,
            height=423,

            sourceX = 24,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_07
            x=675,
            y=941,
            width=331,
            height=423,

            sourceX = 24,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_08
            x=677,
            y=426,
            width=329,
            height=423,

            sourceX = 25,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_09
            x=1008,
            y=426,
            width=327,
            height=423,

            sourceX = 27,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_10
            x=1008,
            y=851,
            width=327,
            height=423,

            sourceX = 27,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_11
            x=1337,
            y=426,
            width=325,
            height=423,

            sourceX = 28,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_12
            x=1337,
            y=851,
            width=325,
            height=423,

            sourceX = 28,
            sourceY = 42,
            sourceWidth = 377,
            sourceHeight = 513
        },
        {
            -- boss_13
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_14
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_15
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_16
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_17
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_18
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_19
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_20
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_21
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_22
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_23
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_24
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_25
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_26
            x=1,
            y=1,
            width=377,
            height=513,

        },
        {
            -- boss_27
            x=1,
            y=1,
            width=377,
            height=513,

        },
    },

    sheetContentWidth = 1663,
    sheetContentHeight = 1365
}

SheetInfo.frameIndex =
{

    ["boss_00"] = 1,
    ["boss_01"] = 2,
    ["boss_02"] = 3,
    ["boss_03"] = 4,
    ["boss_04"] = 5,
    ["boss_05"] = 6,
    ["boss_06"] = 7,
    ["boss_07"] = 8,
    ["boss_08"] = 9,
    ["boss_09"] = 10,
    ["boss_10"] = 11,
    ["boss_11"] = 12,
    ["boss_12"] = 13,
    ["boss_13"] = 14,
    ["boss_14"] = 15,
    ["boss_15"] = 16,
    ["boss_16"] = 17,
    ["boss_17"] = 18,
    ["boss_18"] = 19,
    ["boss_19"] = 20,
    ["boss_20"] = 21,
    ["boss_21"] = 22,
    ["boss_22"] = 23,
    ["boss_23"] = 24,
    ["boss_24"] = 25,
    ["boss_25"] = 26,
    ["boss_26"] = 27,
    ["boss_27"] = 28,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- hpBG
            x=1,
            y=1,
            width=232,
            height=132,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 232,
            sourceHeight = 132
        },
    },

    sheetContentWidth = 232,
    sheetContentHeight = 132
}

SheetInfo.frameIndex =
{

    ["hpBG"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

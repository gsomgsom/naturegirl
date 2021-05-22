local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- smallStones
            x=1,
            y=1,
            width=200,
            height=113,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 200,
            sourceHeight = 113
        },
    },

    sheetContentWidth = 200,
    sheetContentHeight = 113
}

SheetInfo.frameIndex =
{

    ["smallStones"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

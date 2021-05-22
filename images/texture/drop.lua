local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- drop
            x=1,
            y=1,
            width=70,
            height=110,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 70,
            sourceHeight = 110
        },
    },

    sheetContentWidth = 70,
    sheetContentHeight = 110
}

SheetInfo.frameIndex =
{

    ["drop"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

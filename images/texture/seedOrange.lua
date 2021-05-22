local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- seedOrange
            x=1,
            y=1,
            width=70,
            height=42,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 70,
            sourceHeight = 42
        },
    },

    sheetContentWidth = 70,
    sheetContentHeight = 42
}

SheetInfo.frameIndex =
{

    ["seedOrange"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

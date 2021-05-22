local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- bones
            x=1,
            y=1,
            width=166,
            height=81,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 166,
            sourceHeight = 81
        },
    },

    sheetContentWidth = 166,
    sheetContentHeight = 81
}

SheetInfo.frameIndex =
{

    ["bones"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

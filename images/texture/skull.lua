local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- skull
            x=1,
            y=1,
            width=152,
            height=105,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 152,
            sourceHeight = 105
        },
    },

    sheetContentWidth = 152,
    sheetContentHeight = 105
}

SheetInfo.frameIndex =
{

    ["skull"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

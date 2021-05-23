local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- bullet
            x=1,
            y=1,
            width=32,
            height=32,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 32,
            sourceHeight = 32
        },
    },

    sheetContentWidth = 32,
    sheetContentHeight = 32
}

SheetInfo.frameIndex =
{

    ["bullet"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- frass
            x=1,
            y=1,
            width=572,
            height=168,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 572,
            sourceHeight = 168
        },
    },

    sheetContentWidth = 572,
    sheetContentHeight = 168
}

SheetInfo.frameIndex =
{

    ["grass"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- drop
            x=1,
            y=1,
            width=171,
            height=300,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 171,
            sourceHeight = 300
        },
    },

    sheetContentWidth = 171,
    sheetContentHeight = 300
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

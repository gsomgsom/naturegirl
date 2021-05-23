local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- trap
            x=1,
            y=1,
            width=200,
            height=191,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 200,
            sourceHeight = 191
        },
    },

    sheetContentWidth = 200,
    sheetContentHeight = 191
}

SheetInfo.frameIndex =
{

    ["trap"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

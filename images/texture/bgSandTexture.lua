local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- bgSand
            x=1,
            y=1,
            width=1080,
            height=3240,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 1080,
            sourceHeight = 3240
        },
    },

    sheetContentWidth = 1080,
    sheetContentHeight = 3240
}

SheetInfo.frameIndex =
{

    ["bgSand"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

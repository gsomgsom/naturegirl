local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- flowerYellow
            x=1,
            y=1,
            width=726,
            height=1060,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 725,
            sourceHeight = 1060
        },
    },

    sheetContentWidth = 725,
    sheetContentHeight = 1060
}

SheetInfo.frameIndex =
{

    ["flowerYellow"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- bossHP
            x=1,
            y=1,
            width=100,
            height=10,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 100,
            sourceHeight = 10
        },
    },

    sheetContentWidth = 100,
    sheetContentHeight = 10
}

SheetInfo.frameIndex =
{

    ["bossHP"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

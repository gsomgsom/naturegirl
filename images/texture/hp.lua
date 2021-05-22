local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- hp
            x=1,
            y=1,
            width=200,
            height=199,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 200,
            sourceHeight = 199
        },
    },

    sheetContentWidth = 200,
    sheetContentHeight = 199
}

SheetInfo.frameIndex =
{

    ["hp"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

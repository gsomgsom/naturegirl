local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- frass
            x=1,
            y=1,
            width=1080,
            height=200,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 1080,
            sourceHeight = 200
        },
    },

    sheetContentWidth = 1080,
    sheetContentHeight = 200
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

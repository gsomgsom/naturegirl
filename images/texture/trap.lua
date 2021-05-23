local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- trap
            x=1,
            y=1,
            width=296,
            height=200,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 296,
            sourceHeight = 200
        },
    },

    sheetContentWidth = 296,
    sheetContentHeight = 200
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

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- seedsBG
            x=1,
            y=1,
            width=201,
            height=232,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 201,
            sourceHeight = 232
        },
    },

    sheetContentWidth = 201,
    sheetContentHeight = 232
}

SheetInfo.frameIndex =
{

    ["seedsBG"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

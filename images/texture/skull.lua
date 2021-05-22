local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- skull
            x=1,
            y=1,
            width=214,
            height=232,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 214,
            sourceHeight = 232
        },
    },

    sheetContentWidth = 214,
    sheetContentHeight = 232
}

SheetInfo.frameIndex =
{

    ["skull"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- seedOrange
            x=1,
            y=1,
            width=671,
            height=462,
            sourceX = 671,
            sourceY = 462,
            sourceWidth = 671,
            sourceHeight = 462
        },
    },

    sheetContentWidth = 671,
    sheetContentHeight = 462
}

SheetInfo.frameIndex =
{

    ["seedOrange"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

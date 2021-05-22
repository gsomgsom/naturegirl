local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- waterPlank
            x=1,
            y=1,
            width=1036,
            height=249,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 1036,
            sourceHeight = 249
        },
    },

    sheetContentWidth = 1036,
    sheetContentHeight = 249
}

SheetInfo.frameIndex =
{

    ["waterPlank"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

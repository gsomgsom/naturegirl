local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
        {
            -- hpBG
            x=1,
            y=1,
            width=94,
            height=95,
            sourceX = 0,
            sourceY = 0,
            sourceWidth = 94,
            sourceHeight = 95
        },
    },

    sheetContentWidth = 94,
    sheetContentHeight = 95
}

SheetInfo.frameIndex =
{

    ["hpBG"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo

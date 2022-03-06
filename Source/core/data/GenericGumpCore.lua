GenericGumpCore = {}

function GenericGumpCore:new()
    self.__index = self
    return setmetatable(WindowData.GG_Core, self)
end

function GenericGumpCore:getStringPageIndex()
    return self.stringPageIndex
end

function GenericGumpCore:getToolTipPageIndex()
    return self.toolTipPageIndex
end

function GenericGumpCore:getLocalizedDataCount()
    return self.localizedDataCount
end

function GenericGumpCore:getButtonIdData()
    return self.buttonIdData
end

function GenericGumpCore:getStringDataCount()
    return self.stringDataCount
end

function GenericGumpCore:getButtonIdDataCount()
    return self.buttonIdDataCount
end

function GenericGumpCore:getGumpId()
    return self.GumpId
end

function GenericGumpCore:getStringData()
    return self.stringData
end

function GenericGumpCore:getDescCount()
    return self.descCount
end

function GenericGumpCore:getTokenPageIndex()
    return self.tokenPageIndex
end

function GenericGumpCore:getDescPageIndex()
    return self.descPageIndex
end

function GenericGumpCore:getObjectId()
    return self.ObjectId
end

function GenericGumpCore:getDesc()
    return self.desc
end

function GenericGumpCore:getTextHueDataCount()
    return self.textHueDataCount
end

function GenericGumpCore:getTextHueData()
    return self.textHueData
end

function GenericGumpCore:getHuePageIndex()
    return self.huePageIndex
end

function GenericGumpCore:getPortImgData()
    return self.portImgData
end

function GenericGumpCore:getPortPageIndex()
    return self.portPageIndex
end

function GenericGumpCore:getTilePageIndex()
    return self.tilePageIndex
end

function GenericGumpCore:getGumpPicNumDataCount()
    return self.gumppicNumDataCount
end

function GenericGumpCore:getButtonPageIndex()
    return self.buttonPageIndex
end


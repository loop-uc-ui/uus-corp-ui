MobileHealthBar = setmetatable(UusCorpComposable.asView("MobileHealthBar"):asWindow(), {__index = UusCorpWindow})
MobileHealthBar.__index = MobileHealthBar

function MobileHealthBar:new(mobileId)
    local this = setmetatable(
        UusCorpComposable.asView(self.name .. mobileId):asWindow(
            nil,
            self.name
        ),
        MobileHealthBar
    )
    this.mobileId = mobileId
    return this
end

function MobileHealthBar:onInitialize()
    self:addData(
        MobileData.statusType(),
        self.mobileId
    )
    UusCorpWindow.onInitialize(self)
end


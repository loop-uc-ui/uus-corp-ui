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

    this:addData(
        MobileData.statusType(),
        mobileId
    ):addData(
        MobileData.nameType(),
        mobileId
    ):addData(
        MobileData.healthBarColorType(),
        mobileId
    )

    return this
end

function MobileHealthBar:onInitialize()
    self:addChild(
        UusCorpComposable.asView(self.name .. "Name"):asLabel():setText(
            MobileData.status(self.mobileId).MobName
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "HealthBar"):asStatusBar():setCurrentValue(
            MobileData.status(self.mobileId).CurrentHealth
        ):setMaximumValue(
            MobileData.status(self.mobileId).MaxHealth
        ):setForegroundTint(
            Colors.Red
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "HealthBarPerc"):asLabel():setText(
            tostring(
                (MobileData.status(self.mobileId).CurrentHealth / MobileData.status(self.mobileId).MaxHealth) * 100
            ) .. "%"
        )
    )
    UusCorpWindow.onInitialize(self)
end


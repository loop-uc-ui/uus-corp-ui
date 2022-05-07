MobileHealthBar = setmetatable(UusCorpComposable.asView("MobileHealthBar"):asWindow(), {__index = UusCorpWindow})
MobileHealthBar.__index = MobileHealthBar

local function healthText(mobileId)
    return tostring(
        (MobileData.status(mobileId).CurrentHealth / MobileData.status(mobileId).MaxHealth) * 100
    ) .. "%"
end

function MobileHealthBar:new(mobileId)
    local this = setmetatable(
        UusCorpComposable.asView(self.name .. mobileId):asWindow(
            nil,
            self.name
        ),
        MobileHealthBar
    )

    this.mobileId = mobileId

    this:datum(
        UusCorpWindowData.new(
            MobileData.statusType(),
            mobileId
        )
    ):datum(
        UusCorpWindowData.new(
            MobileData.nameType(),
            mobileId
        )
    ):datum(
        UusCorpWindowData.new(
            MobileData.healthBarColorType(),
            mobileId
        )
    )

    return this
end

function MobileHealthBar:onInitialize()
    local health = UusCorpComposable.asView(self.name .. "HealthBarPerc"):asLabel()

    health:event(UusCorpViewEvent.new(WindowData.MobileStatus.Event, function ()
        health:setText(healthText(self.mobileId))
    end))

    self:child(
        UusCorpComposable.asView(self.name .. "Name"):asLabel():setText(
            MobileData.status(self.mobileId).MobName
        )
    ):child(
        UusCorpComposable.asView(self.name .. "HealthBar"):asStatusBar():setCurrentValue(
            MobileData.status(self.mobileId).CurrentHealth
        ):setMaximumValue(
            MobileData.status(self.mobileId).MaxHealth
        ):setForegroundTint(
            Colors.Red
        )
    ):child(
        health
    )
    UusCorpWindow.onInitialize(self)
end

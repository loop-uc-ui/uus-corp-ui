MobileHealthBar = setmetatable(UusCorpWindow.new("MobileHealthBar"), {__index = UusCorpWindow})
MobileHealthBar.__index = MobileHealthBar

function MobileHealthBar.offset(mobileId)
    WindowApi.setOffsetFromParent(
        MobileHealthBar.name .. mobileId,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end

function MobileHealthBar:new(mobileId)
    local this = setmetatable(
        UusCorpWindow.new(
            self.name .. mobileId,
            nil,
            self.name
        ),
        MobileHealthBar
    ):data(
        MobileData.statusType(),
        mobileId
    ):data(
        MobileData.nameType(),
        mobileId
    ):data(
        MobileData.healthBarColorType(),
        mobileId
    )

    this.mobileId = mobileId

    return this
end

function MobileHealthBar:loadPosition()
    return self
end

function MobileHealthBar:create(doShow)
    if self:doesExist() then
        return self
    end

    self:child(
        self:healthLabel()
    ):child(
        self:statusBar()
    ):child(
        self:nameLabel()
    ):event(
        UusCorpViewEvent.new(
            MobileData.statusEvent()
        )
    ):event(
        UusCorpViewEvent.new(
            Events.enableHealthBar()
        )
    ):event(
        UusCorpViewEvent.new(
            Events.disableHealthBar(),
            function ()
                self:destroy()
            end
        )
    )
    UusCorpWindow.create(self, doShow)
    return self
end

function MobileHealthBar:healthLabel()
    return UusCorpLabel.new(self.name .. "HealthBarPerc"):setText(
        function ()
            return tostring(
                math.floor(
                    (MobileData.currentHealth(self.mobileId) / MobileData.maxHealth(self.mobileId) * 100
                )
            ) .. "%")
        end
    )
end

function MobileHealthBar:nameLabel()
    return UusCorpLabel.new(self.name .. "Name"):setText(
        function ()
            return MobileData.name(self.mobileId)
        end
    ):event(
        UusCorpViewEvent.new(
            MobileData.nameEvent()
        )
    )
end

function MobileHealthBar:statusBar()
    return UusCorpStatusBar.new(self.name .. "HealthBar"):setCurrentValue(
        function ()
            return MobileData.currentHealth(self.mobileId)
        end
    ):setMaximumValue(
        function ()
            return MobileData.maxHealth(self.mobileId)
        end
    ):setForegroundTint(
        function ()
            return Colors.Red
        end
    )
end

MobileHealthBar = {}
MobileHealthBar.Name = "MobileHealthBar"

local function healthText(mobileId)
    return tostring(
        math.floor(
            (MobileData.status(mobileId).CurrentHealth / MobileData.status(mobileId).MaxHealth) * 100
        )
    ) .. "%"
end

function MobileHealthBar:new(mobileId)
    local name = MobileHealthBar.Name .. mobileId

    local healthLabel =  UusCorpLabel.new(name .. "HealthBarPerc"):setText(
        function ()
            return healthText(mobileId)
        end
    )

    local mobileName = UusCorpLabel.new(name .. "Name"):setText(
        function ()
            return MobileData.name(mobileId)
        end
    ):event(
        UusCorpViewEvent.new(
            MobileData.nameEvent()
        )
    )

    local healthBar = UusCorpStatusBar.new(name .. "HealthBar"):setCurrentValue(
        function ()
            return MobileData.currentHealth(mobileId)
        end
    ):setMaximumValue(
        function ()
            return MobileData.maxHealth(mobileId)
        end
    ):setForegroundTint(
        function ()
            return Colors.Red
        end
    )

    return UusCorpWindow.new(
        name,
        nil,
        MobileHealthBar.Name
    ):data(
        MobileData.statusType(),
        mobileId
    ):data(
       MobileData.nameType(),
       mobileId
    ):data(
        MobileData.healthBarColorType(),
        mobileId
    ):child(
        healthLabel
    ):child(
        mobileName
    ):child(
        healthBar
    ):event(
        UusCorpViewEvent.new(
            MobileData.statusEvent(),
            function ()
                healthBar:update()
                mobileName:update()
                healthLabel:update()
            end
        )
    )
end

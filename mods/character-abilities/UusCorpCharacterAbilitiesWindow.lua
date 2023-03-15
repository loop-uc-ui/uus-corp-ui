UusCorpCharacterAbilitiesWindow = {}

UusCorpCharacterAbilitiesWindow.Name = "CharacterAbilitiesWindow"

UusCorpCharacterAbilitiesWindow.RacialList = UusCorpCharacterAbilitiesWindow.Name .. "RacialList"

UusCorpCharacterAbilitiesWindow.ActiveList = UusCorpCharacterAbilitiesWindow.Name .. "ActiveList"

UusCorpCharacterAbilitiesWindow.InactiveList = UusCorpCharacterAbilitiesWindow.Name .. "InactiveList"

UusCorpCharacterAbilitiesWindow.RacialAbilities = {}

UusCorpCharacterAbilitiesWindow.ActiveAbilities = {}

UusCorpCharacterAbilitiesWindow.InactiveAbilities = {}

function UusCorpCharacterAbilitiesWindow.initialize()
    UusCorpCore.loadResources(
        "/mods/character-abilities",
        "UusCorpCharacterAbilitiesWindow.xml"
    )
end

function UusCorpCharacterAbilitiesWindow.onInitialize()
    WindowDataApi.registerData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.RightHand
    )

    WindowDataApi.registerData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.LeftHand
    )

    WindowApi.registerEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        PlayerStatus.event(),
        "UusCorpCharacterAbilitiesWindow.onUpdateRacialAbilities"
    )

    WindowApi.registerEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        Events.displayActiveAbilities(),
        "UusCorpCharacterAbilitiesWindow.onDisplayActiveAbilities"
    )

    WindowApi.registerEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        Events.resetAbilities(),
        "UusCorpCharacterAbilitiesWindow.onResetAbilities"
    )

    WindowApi.registerEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        PlayerEquipment.event(),
        "UusCorpCharacterAbilitiesWindow.onUpdateAbilities"
    )

    UusCorpCharacterAbilitiesWindow.onUpdateRacialAbilities()
    UusCorpCharacterAbilitiesWindow.onUpdateAbilities()

    LabelApi.setText(
        UusCorpCharacterAbilitiesWindow.Name .. "RacialTitle",
        "Racial"
    )

    LabelApi.setText(
        UusCorpCharacterAbilitiesWindow.Name .. "ActiveTitle",
        "Active"
    )

    LabelApi.setText(
        UusCorpCharacterAbilitiesWindow.Name .. "InactiveTitle",
        "Inactive"
    )
end

function UusCorpCharacterAbilitiesWindow.onShutdown()
    UusCorpCharacterAbilitiesWindow.RacialAbilities = {}
    UusCorpCharacterAbilitiesWindow.ActiveAbilities = {}
    UusCorpCharacterAbilitiesWindow.InactiveAbilities = {}

    WindowDataApi.unregisterData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.RightHand
    )

    WindowDataApi.unregisterData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.LeftHand
    )

    WindowApi.unregisterEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        PlayerStatus.event()
    )

    WindowApi.unregisterEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        Events.displayActiveAbilities()
    )

    WindowApi.unregisterEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        Events.resetAbilities()
    )

    WindowApi.unregisterEventHandler(
        UusCorpCharacterAbilitiesWindow.Name,
        PlayerEquipment.event()
    )
end

function UusCorpCharacterAbilitiesWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpCharacterAbilitiesWindow.onUpdateAbilities()
    UusCorpCharacterAbilitiesWindow.onDisplayActiveAbilities()
    UusCorpCharacterAbilitiesWindow.onResetAbilities()
end

function UusCorpCharacterAbilitiesWindow.onUpdateRacialAbilities()
    UusCorpCharacterAbilitiesWindow.RacialAbilities = {}
    local order = {}

    for i = 1, AbilityApi.getMaxRacialAbilities() do
        local _, _, tid  = AbilityApi.getAbilityData(
            AbilityApi.getRacialAbilityId(i)
        )

        table.insert(
            UusCorpCharacterAbilitiesWindow.RacialAbilities,
            i,
            {
                text = StringFormatter.fromTid(tid)
            }
        )
    end

    table.sort(
        UusCorpCharacterAbilitiesWindow.RacialAbilities,
        function (a, b)
            return a.text < b.text
        end
    )

    for i = 1, #UusCorpCharacterAbilitiesWindow.RacialAbilities do
        table.insert(
            order,
            i
        )
    end

    ListBoxApi.setDisplayOrder(
        UusCorpCharacterAbilitiesWindow.RacialList,
        order
    )
end

function UusCorpCharacterAbilitiesWindow.onDisplayActiveAbilities()
    UusCorpCharacterAbilitiesWindow.ActiveAbilities = {}

    local _, _, tid = AbilityApi.getAbilityData(
        AbilityApi.getWeaponAbilityId(
            Equipment.WEAPONABILITY_PRIMARY
        )
    )

    table.insert(
        UusCorpCharacterAbilitiesWindow.ActiveAbilities,
        {
            text = StringFormatter.fromTid(tid)
        }
    )

    _, _, tid = AbilityApi.getAbilityData(
        AbilityApi.getWeaponAbilityId(
            Equipment.WEAPONABILITY_SECONDARY
        )
    )

    table.insert(
        UusCorpCharacterAbilitiesWindow.ActiveAbilities,
        {
            text = StringFormatter.fromTid(tid)
        }
    )

    local order = {}
    order[1] = 1
    order[2] = 2

    ListBoxApi.setDisplayOrder(
        UusCorpCharacterAbilitiesWindow.ActiveList,
        order
    )
end

function UusCorpCharacterAbilitiesWindow.onResetAbilities()
    UusCorpCharacterAbilitiesWindow.InactiveAbilities = {}

    for i = 1, AbilityApi.WeaponAbilitiesCount do
        local _, _, tid = AbilityApi.getAbilityData(
            i + AbilityApi.WeaponAbilityOffset
        )

        table.insert(
            UusCorpCharacterAbilitiesWindow.InactiveAbilities,
            i,
            {
                text = StringFormatter.fromTid(tid)
            }
        )
    end

    --Remove active abilities
    for i = 1, #UusCorpCharacterAbilitiesWindow.InactiveAbilities do
        local ability = UusCorpCharacterAbilitiesWindow.InactiveAbilities[i]

        if ability ~= nil then --May be nil since we're modifying the table concurrently
            local text = ability.text

            for j = 1, #UusCorpCharacterAbilitiesWindow.ActiveAbilities do
                if text == UusCorpCharacterAbilitiesWindow.ActiveAbilities[j].text then
                    table.remove(
                        UusCorpCharacterAbilitiesWindow.InactiveAbilities,
                        i
                    )
                    break
                end
            end
        end
    end

    table.sort(
        UusCorpCharacterAbilitiesWindow.InactiveAbilities,
        function (a, b)
            return a.text < b.text
        end
    )

    for i = 1, #UusCorpCharacterAbilitiesWindow.InactiveAbilities do
        WindowApi.createFromTemplate(
            UusCorpCharacterAbilitiesWindow.InactiveList .. i,
            "CharacterAbilitiesRowTemplate",
            UusCorpCharacterAbilitiesWindow.InactiveList .. "ScrollChild"
        )

        LabelApi.setText(
            UusCorpCharacterAbilitiesWindow.InactiveList .. i .. "ItemName",
            UusCorpCharacterAbilitiesWindow.InactiveAbilities[i].text
        )

        if i > 1 then
            WindowApi.addAnchor(
                UusCorpCharacterAbilitiesWindow.InactiveList .. i,
                "bottom",
                UusCorpCharacterAbilitiesWindow.InactiveList .. i - 1,
                "top",
                0,
                8
            )
        end
    end

    ScrollWindowApi.updateScrollRect(UusCorpCharacterAbilitiesWindow.InactiveList)
end
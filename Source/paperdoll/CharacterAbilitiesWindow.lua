CharacterAbilitiesWindow = {}

CharacterAbilitiesWindow.Name = "CharacterAbilitiesWindow"

CharacterAbilitiesWindow.RacialList = CharacterAbilitiesWindow.Name .. "RacialList"

CharacterAbilitiesWindow.ActiveList = CharacterAbilitiesWindow.Name .. "ActiveList"

CharacterAbilitiesWindow.InactiveList = CharacterAbilitiesWindow.Name .. "InactiveList"

CharacterAbilitiesWindow.RacialAbilities = {}

CharacterAbilitiesWindow.ActiveAbilities = {}

CharacterAbilitiesWindow.InactiveAbilities = {}

function CharacterAbilitiesWindow.onInitialize()
    WindowDataApi.registerData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.RightHand
    )

    WindowDataApi.registerData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.LeftHand
    )

    WindowApi.registerEventHandler(
        CharacterAbilitiesWindow.Name,
        PlayerStatus.event(),
        "CharacterAbilitiesWindow.onUpdateRacialAbilities"
    )

    WindowApi.registerEventHandler(
        CharacterAbilitiesWindow.Name,
        Events.displayActiveAbilities(),
        "CharacterAbilitiesWindow.onDisplayActiveAbilities"
    )

    WindowApi.registerEventHandler(
        CharacterAbilitiesWindow.Name,
        Events.resetAbilities(),
        "CharacterAbilitiesWindow.onResetAbilities"
    )

    WindowApi.registerEventHandler(
        CharacterAbilitiesWindow.Name,
        PlayerEquipment.event(),
        "CharacterAbilitiesWindow.onUpdateAbilities"
    )

    CharacterAbilitiesWindow.onUpdateRacialAbilities()
    CharacterAbilitiesWindow.onUpdateAbilities()
end

function CharacterAbilitiesWindow.onShutdown()
    CharacterAbilitiesWindow.RacialAbilities = {}
    CharacterAbilitiesWindow.ActiveAbilities = {}
    CharacterAbilitiesWindow.InactiveAbilities = {}

    WindowDataApi.unregisterData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.RightHand
    )

    WindowDataApi.unregisterData(
        PlayerEquipment.type(),
        PlayerEquipment.Slots.LeftHand
    )

    WindowApi.unregisterEventHandler(
        CharacterAbilitiesWindow.Name,
        PlayerStatus.event()
    )

    WindowApi.unregisterEventHandler(
        CharacterAbilitiesWindow.Name,
        Events.displayActiveAbilities()
    )

    WindowApi.unregisterEventHandler(
        CharacterAbilitiesWindow.Name,
        Events.resetAbilities()
    )

    WindowApi.unregisterEventHandler(
        CharacterAbilitiesWindow.Name,
        PlayerEquipment.event()
    )
end

function CharacterAbilitiesWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function CharacterAbilitiesWindow.onUpdateAbilities()
    CharacterAbilitiesWindow.onDisplayActiveAbilities()
    CharacterAbilitiesWindow.onResetAbilities()
end

function CharacterAbilitiesWindow.onUpdateRacialAbilities()
    CharacterAbilitiesWindow.RacialAbilities = {}
    local order = {}

    for i = 1, AbilityApi.getMaxRacialAbilities() do
        local _, _, tid  = AbilityApi.getAbilityData(
            AbilityApi.getRacialAbilityId(i)
        )

        table.insert(
            CharacterAbilitiesWindow.RacialAbilities,
            i,
            {
                text = StringFormatter.fromTid(tid)
            }
        )
    end

    table.sort(
        CharacterAbilitiesWindow.RacialAbilities,
        function (a, b)
            return a.text < b.text
        end
    )

    for i = 1, #CharacterAbilitiesWindow.RacialAbilities do
        table.insert(
            order,
            i
        )
    end

    ListBoxApi.setDisplayOrder(
        CharacterAbilitiesWindow.RacialList,
        order
    )
end

function CharacterAbilitiesWindow.onDisplayActiveAbilities()
    CharacterAbilitiesWindow.ActiveAbilities = {}

    local _, _, tid = AbilityApi.getAbilityData(
        AbilityApi.getWeaponAbilityId(
            Equipment.WEAPONABILITY_PRIMARY
        )
    )

    table.insert(
        CharacterAbilitiesWindow.ActiveAbilities,
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
        CharacterAbilitiesWindow.ActiveAbilities,
        {
            text = StringFormatter.fromTid(tid)
        }
    )

    local order = {}
    order[1] = 1
    order[2] = 2

    ListBoxApi.setDisplayOrder(
        CharacterAbilitiesWindow.ActiveList,
        order
    )
end

function CharacterAbilitiesWindow.onResetAbilities()
    CharacterAbilitiesWindow.InactiveAbilities = {}
    local order = {}

    for i = 1, AbilityApi.WeaponAbilitiesCount do
        local _, _, tid = AbilityApi.getAbilityData(
            i + AbilityApi.WeaponAbilityOffset
        )

        table.insert(
            CharacterAbilitiesWindow.InactiveAbilities,
            i,
            {
                text = StringFormatter.fromTid(tid)
            }
        )
    end

    --Remove active abilities
    for i = 1, #CharacterAbilitiesWindow.InactiveAbilities do
        local ability = CharacterAbilitiesWindow.InactiveAbilities[i]

        if ability ~= nil then --May be nil since we're modifying the table concurrently
            local text = ability.text

            for j = 1, #CharacterAbilitiesWindow.ActiveAbilities do
                if text == CharacterAbilitiesWindow.ActiveAbilities[j].text then
                    table.remove(
                        CharacterAbilitiesWindow.InactiveAbilities,
                        i
                    )
                    break
                end
            end
        end
    end

    table.sort(
        CharacterAbilitiesWindow.InactiveAbilities,
        function (a, b)
            return a.text < b.text
        end
    )

    for i = 1, #CharacterAbilitiesWindow.InactiveAbilities do
        table.insert(
            order,
            i
        )
    end

    ListBoxApi.setDisplayOrder(
        CharacterAbilitiesWindow.InactiveList,
        order
    )
end
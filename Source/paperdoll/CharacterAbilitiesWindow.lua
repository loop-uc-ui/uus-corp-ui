CharacterAbilitiesWindow = {}

CharacterAbilitiesWindow.Name = "CharacterAbilitiesWindow"

CharacterAbilitiesWindow.RacialList = CharacterAbilitiesWindow.Name .. "RacialList"

CharacterAbilitiesWindow.ActiveList = CharacterAbilitiesWindow.Name .. "ActiveList"

CharacterAbilitiesWindow.InactiveList = CharacterAbilitiesWindow.Name .. "InactiveList"

CharacterAbilitiesWindow.RacialAbilities = {}

CharacterAbilitiesWindow.ActiveAbilities = {}

CharacterAbilitiesWindow.InactiveAbilities = {}

function CharacterAbilitiesWindow.onInitialize()
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

    CharacterAbilitiesWindow.onUpdateRacialAbilities()
    CharacterAbilitiesWindow.onDisplayActiveAbilities()
    CharacterAbilitiesWindow.onResetAbilities()
end

function CharacterAbilitiesWindow.onShutdown()
    CharacterAbilitiesWindow.RacialAbilities = {}
    CharacterAbilitiesWindow.ActiveAbilities = {}
    CharacterAbilitiesWindow.InactiveAbilities = {}

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
end

function CharacterAbilitiesWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function CharacterAbilitiesWindow.onUpdateRacialAbilities()
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
CharacterAbilitiesWindow = {}
CharacterAbilitiesWindow.Name = "CharacterAbilitiesWindow"
CharacterAbilitiesWindow.RacialList = CharacterAbilitiesWindow.Name .. "RacialList"
CharacterAbilitiesWindow.ActiveList = CharacterAbilitiesWindow.Name .. "ActiveList"
CharacterAbilitiesWindow.RacialAbilities = {}
CharacterAbilitiesWindow.ActiveAbilities = {}

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
end

function CharacterAbilitiesWindow.onShutdown()
    CharacterAbilitiesWindow.RacialAbilities = {}
end

function CharacterAbilitiesWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function CharacterAbilitiesWindow.onUpdateRacialAbilities()
    local order = {}

    for i = 1, AbilityApi.getMaxRacialAbilities() do
        local icon, server, tid  = AbilityApi.getAbilityData(
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

function CharacterAbilitiesWindow.onRacialPopulate()

end

function CharacterAbilitiesWindow.onActivePopulate()

end

function CharacterAbilitiesWindow.onDisplayActiveAbilities()
    local icon, server, tid = AbilityApi.getAbilityData(
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

    icon, server, tid = AbilityApi.getAbilityData(
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

end
CharacterAbilitiesWindow = {}
CharacterAbilitiesWindow.Name = "CharacterAbilitiesWindow"
CharacterAbilitiesWindow.RacialList = CharacterAbilitiesWindow.Name .. "RacialList"
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

function CharacterAbilitiesWindow.onDisplayActiveAbilities()
    local order = {}

    
end

function CharacterAbilitiesWindow.onPopulateRacialAbilities()

end

function CharacterAbilitiesWindow.onDisplayActiveAbilities()

end

function CharacterAbilitiesWindow.onResetAbilities()

end
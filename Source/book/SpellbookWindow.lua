--Another case where the UI creates this automatically
--when we click a spellbook.
SpellbookWindow = {}

SpellbookWindow.Name = "Spellbook_"

SpellbookWindow.Spells = {}

SpellbookWindow.Lists = {
    Magery = "MageryList",
    Necro = "NecroList",
    Ninja = "NinjaList"
}

function SpellbookWindow.onInitialize()
    local id = Active.dynamicWindowId()
    WindowApi.setId(Active.window(), id)

    WindowDataApi.registerData(
        Spells.bookDataType(),
        id
    )

    WindowApi.registerEventHandler(
        Active.window(),
        Spells.bookDataEvent(),
        "SpellbookWindow.onUpdateSpells"
    )
end

function SpellbookWindow.onUpdateSpells()
    local id = WindowApi.getId(Active.window())
    local data = Spells.bookData(id)
    Debug.Print(data)
    local order = {}

    for k, v in ipairs(data.spells) do
        if v == 1 then
            local spell = k + data.firstSpellNum - 1
            local _, _, tid, _, _, _ = AbilityApi.getAbilityData(spell)

            table.insert(
                SpellbookWindow.Spells,
                k,
                {
                    id = k,
                    text = StringFormatter.fromTid(tid)
                }
            )

            table.insert(
                order,
                k
            )
        end
    end

    local list = SpellbookWindow.Lists.Magery

    if Spells.isNecro(id) then
        list = SpellbookWindow.Lists.Necro
    elseif Spells.isNinjitsu(id) then
        list = SpellbookWindow.Lists.Ninja
    end

    for _, v in pairs(SpellbookWindow.Lists) do
        if v ~= list then
            WindowApi.destroyWindow(
                SpellbookWindow.Name .. id .. v
            )
        end
    end

    ListBoxApi.setDisplayOrder(
        SpellbookWindow.Name .. id .. list,
        order
    )
end

function SpellbookWindow.onShutdown()
    SpellbookWindow.Spells = {}
    WindowApi.unregisterEventHandler(
        Active.window(),
        Spells.bookDataEvent()
    )
    WindowDataApi.unregisterData(
        Spells.bookDataType(),
        0
    )
end

function SpellbookWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end
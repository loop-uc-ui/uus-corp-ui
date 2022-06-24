--Another case where the UI creates this automatically
--when we click a spellbook.
SpellbookWindow = {}
SpellbookWindow.Name = "Spellbook_"
SpellbookWindow.List = "List"
SpellbookWindow.Spells = {}

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

    local order = {}

    for k, _ in ipairs(data.spells) do
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

    ListBoxApi.setDisplayOrder(
        SpellbookWindow.Name .. id .. SpellbookWindow.List,
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
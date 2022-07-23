--Another case where the UI creates this automatically
--when we click a spellbook.
SpellbookWindow = {}

SpellbookWindow.Name = "Spellbook_"

SpellbookWindow.Spells = {}

SpellbookWindow.List = "List"

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
    SpellbookWindow.Spells[id] = {}

    for k, v in ipairs(data.spells) do
        if v == 1 then
            local spell = k + data.firstSpellNum - 1
            local _, serverId, tid, _, _, _ = AbilityApi.getAbilityData(spell)

            table.insert(
                SpellbookWindow.Spells[id],
                k,
                {
                    id = serverId,
                    text = StringFormatter.fromTid(tid)
                }
            )

            table.insert(
                order,
                k
            )
        end
    end

    local list = SpellbookWindow.Name .. id .. SpellbookWindow.List

    ListBoxApi.setDataTable(
        list,
        "SpellbookWindow.Spells.[" .. id .. "]"
    )

    ListBoxApi.setDisplayOrder(
        list,
        order
    )
end

function SpellbookWindow.onShutdown()
    local id = WindowApi.getId(
        Active.window()
    )

    SpellbookWindow.Spells[id] = nil

    WindowApi.unregisterEventHandler(
        Active.window(),
        Spells.bookDataEvent()
    )

    WindowDataApi.unregisterData(
        Spells.bookDataType(),
        id
    )
end

function SpellbookWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function SpellbookWindow.onDoubleClick()
    UserAction.castSpell(WindowApi.getId(Active.window()))
end
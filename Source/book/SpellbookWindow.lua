--Another case where the UI creates this automatically
--when we click a spellbook.
SpellbookWindow = {}

SpellbookWindow.Name = "Spellbook_"

SpellbookWindow.List = "List"

local activeBook = nil

function SpellbookWindow.onInitialize()
    if activeBook ~= nil then
        WindowApi.destroyWindow(
            activeBook
        )
    end

    activeBook = Active.window()

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
    local spells = {}

    for k, v in ipairs(data.spells) do
        if v == 1 then
            local spell = k + data.firstSpellNum - 1
            local _, serverId, tid, _, _, _ = AbilityApi.getAbilityData(spell)

            table.insert(
                spells,
                k,
                {
                    id = serverId,
                    text = StringFormatter.fromTid(tid)
                }
            )
        end
    end

    local list = SpellbookWindow.Name .. id .. SpellbookWindow.List

    for i = 1, #spells do
        local spell = spells[i]
        local row = list .. "Row" .. spell.id

        WindowApi.createFromTemplate(
            row,
            "SpellbookRowTemplate",
            list .. "ScrollChild"
        )

        WindowApi.setId(
            row,
            spell.id
        )

        LabelApi.setText(
            row .. "ItemName",
            spell.text
        )

        if i > 1 then
            WindowApi.addAnchor(
                row,
                "bottomleft",
                list .. "Row" .. spells[i - 1].id,
                "topleft",
                0,
                8
            )
        end
    end

    ScrollWindowApi.updateScrollRect(
        list
    )
end

function SpellbookWindow.onShutdown()
    activeBook = nil

    local id = WindowApi.getId(
        Active.window()
    )

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
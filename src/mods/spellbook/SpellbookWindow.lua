--Another case where the UI creates this automatically
--when we click a spellbook.
SpellbookWindow = {}

SpellbookWindow.Name = "Spellbook_"

SpellbookWindow.List = "List"

local activeBook = nil

local spells = {}

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

    for k, v in ipairs(data.spells) do
        local spell = k + data.firstSpellNum - 1
        local _, serverId, tid, _, _, _ = AbilityApi.getAbilityData(spell)

        if serverId ~= nil then
            table.insert(
                spells,
                k,
                {
                    id = serverId,
                    text = StringFormatter.fromTid(tid),
                    isDisabled = v ~= 1
                }
            )
        end
    end

    local list = SpellbookWindow.Name .. id .. SpellbookWindow.List
    local previous = nil

    for _, v in ipairs(spells) do
        local row = list .. "Row" .. v.id

        WindowApi.createFromTemplate(
            row,
            "SpellbookRowTemplate",
            list .. "ScrollChild"
        )

        WindowApi.setId(
            row,
            v.id
        )

        LabelApi.setText(
            row .. "ItemName",
            v.text
        )

        if v.isDisabled then
            LabelApi.setTextColor(
                row .. "ItemName",
                Colors.DarkGray
            )
        end

        if previous ~= nil then
            WindowApi.addAnchor(
                row,
                "bottomleft",
                list .. "Row" .. previous.id,
                "topleft",
                0,
                8
            )
        end

        previous = v
    end

    ScrollWindowApi.updateScrollRect(
        list
    )
end

function SpellbookWindow.onShutdown()
    activeBook = nil
    spells = {}

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
    local id = WindowApi.getId(Active.window())

    for _, v in ipairs(spells) do
        if v.id == id and v.isDisabled then
            return
        end
    end

    UserAction.castSpell(id)
end
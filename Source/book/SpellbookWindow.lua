--Another case where the UI creates this automatically
--when we click a spellbook.
SpellbookWindow = {}

SpellbookWindow.Name = "Spellbook_"

SpellbookWindow.Spells = {}

SpellbookWindow.Lists = {
    Magery = "MageryList",
    Necro = "NecroList",
    Ninja = "NinjaList",
    Spellweaving = "SpellweavingList",
    Chivalry = "ChivalryList",
    Bushido = "BushidoList",
    Mysticism = "MysticList",
    Masteries = "MasteriesList"
}

SpellbookWindow.List = SpellbookWindow.Lists.Magery

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

    for k, v in ipairs(data.spells) do
        if v == 1 then
            local spell = k + data.firstSpellNum - 1
            local _, serverId, tid, _, _, _ = AbilityApi.getAbilityData(spell)

            table.insert(
                SpellbookWindow.Spells,
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

    if Spells.isNecro(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Necro
    elseif Spells.isNinjitsu(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Ninja
    elseif Spells.isSpellweaving(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Spellweaving
    elseif Spells.isChivalry(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Chivalry
    elseif Spells.isBushido(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Bushido
    elseif Spells.isMysticism(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Mysticism
    elseif Spells.isMasteries(id) then
        SpellbookWindow.List = SpellbookWindow.Lists.Masteries
    end

    for _, v in pairs(SpellbookWindow.Lists) do
        if v ~= SpellbookWindow.List then
            WindowApi.destroyWindow(
                SpellbookWindow.Name .. id .. v
            )
        end
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

function SpellbookWindow.onPopulate(data)
    for i = 1, #data do
        local row = Active.window() .. SpellbookWindow.List .. "Row" .. i
        WindowApi.setId(row, SpellbookWindow.Spells[i].id)
    end
end

function SpellbookWindow.onDoubleClick()
    UserAction.castSpell(WindowApi.getId(Active.window()))
end
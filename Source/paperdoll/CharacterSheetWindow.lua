CharacterSheetWindow = {}

CharacterSheetWindow.Name = "CharacterSheetWindow"

CharacterSheetWindow.List = CharacterSheetWindow.Name .. "List"

CharacterSheetWindow.Data = {}

function CharacterSheetWindow.onInitialize()
    WindowDataApi.registerData(PlayerStatus.type())

    WindowApi.registerEventHandler(
        CharacterSheetWindow.Name,
        PlayerStatus.event(),
        "CharacterSheetWindow.onUpdate"
    )

    CharacterSheetWindow.onUpdate()
end

function CharacterSheetWindow.onShutdown()
    CharacterSheetWindow.Data = {}
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowApi.unregisterEventHandler(
        CharacterSheetWindow.Name,
        PlayerStatus.event()
    )
end

function CharacterSheetWindow.onRightClick()
    WindowApi.destroyWindow(CharacterSheetWindow.Name)
end

function CharacterSheetWindow.onUpdate()
    CharacterSheetWindow.Data = {}
    local order = {}

    for _, v in ipairs(PlayerStatus.stats()) do
        if v.tid ~= nil and v.tid ~= 0 then
            local name = StringFormatter.fromTid(
                v.tid
            )

            local value = 0

            for i, j in pairs(PlayerStatus.data()) do
                if i == StringFormatter.fromWString(v.name) then
                    value = j
                    break
                end
            end

            table.insert(
                CharacterSheetWindow.Data,
                #CharacterSheetWindow.Data + 1,
                {
                    name = name,
                    value = value
                }
            )

            table.insert(
                order,
                #order + 1,
                #order + 1
            )
        end
    end

    ListBoxApi.setDisplayOrder(
        CharacterSheetWindow.List,
        order
    )
end
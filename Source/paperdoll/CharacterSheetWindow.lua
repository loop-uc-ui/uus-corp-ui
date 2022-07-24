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

    for k, v in ipairs(PlayerStatus.stats()) do
        local name = ""

        if v.tid ~= nil and v.tid ~= 0 then
            name = StringFormatter.fromTid(
                v.tid
            )
        end

        table.insert(
            CharacterSheetWindow.Data,
            k,
            {
                name = name
            }
        )

        table.insert(
            order,
            k,
            k
        )
    end

    ListBoxApi.setDisplayOrder(
        CharacterSheetWindow.List,
        order
    )
end

function CharacterSheetWindow.onPopulate(data)
    
end
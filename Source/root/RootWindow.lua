RootWindow = {}
RootWindow.Name = "Root"

local function registerEvent(eventName, func)
    WindowApi.registerEventHandler(RootWindow.Name, eventName, RootWindow.Name .. "Window." .. func)
end

function RootWindow.create()
    ViewportApi.update(
        ScreenResolution.x(),
        ScreenResolution.y(),
        ScreenResolution.x(),
        ScreenResolution.y()
    )

    CSVUtilities.initialize()
    WindowDataApi.registerData(PlayerStatus.type())
    WindowDataApi.registerData(PlayerEquipment.type(), PlayerEquipment.Slots.Backpack)
    registerEvent(Events.showNamesUpdated(), "onShowNamesUpdated")
    registerEvent(Events.showNamesFlashTemp(),"onShowNamesFlashTemp")
    registerEvent(Events.togglePaperdoll(), "togglePaperdoll")
    registerEvent(Events.toggleBackpack(), "toggleBackpack")
    registerEvent(Events.toggleSkills(), "toggleSkills")
    registerEvent(Events.textArrived(), "onTextArrived")
    WindowApi.createWindow(ObjectHandleRootOverlayWindow.Name, true)
    WindowApi.createWindow(HealthBarRootOverlayWindow.Name, true)
    WindowApi.createWindow(ContextMenuWindow.Name, false)
end

function RootWindow.shutdown()
    CSVUtilities.shutdown()
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowDataApi.unregisterData(Paperdoll.type(), PlayerStatus.id())
    WindowDataApi.unregisterData(PlayerEquipment.type(), PlayerEquipment.Slots.Backpack)
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.showNamesUpdated())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.showNamesFlashTemp())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.togglePaperdoll())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.toggleSkills())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.textArrived())
    WindowApi.destroyWindow(ObjectHandleRootOverlayWindow.Name)
    WindowApi.destroyWindow(HealthBarRootOverlayWindow.Name)
end

function RootWindow.onShowNamesUpdated()

end

function RootWindow.onShowNamesFlashTemp()

end

function RootWindow.togglePaperdoll()
    local paperdoll = PaperdollWindow.Name .. PlayerStatus.id()

    if WindowApi.doesExist(paperdoll) then
        WindowApi.destroyWindow(paperdoll)
    else
        UserAction.useItem(
            PlayerStatus.id(),
            false
        )
    end
end

function RootWindow.toggleBackpack()
    local window = ContainerWindow.Name .. PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack)

    if WindowApi.doesExist(window) then
        WindowApi.destroyWindow(window)
    else
        WindowApi.createFromTemplate(
            ContainerWindow.Name .. PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack),
            ContainerWindow.Template,
            RootWindow.Name
        )
    end
end

function RootWindow.toggleSkills()
    if WindowApi.doesExist(SkillsWindow.Name) then
        WindowApi.destroyWindow(SkillsWindow.Name)
    else
        WindowApi.createWindow(SkillsWindow.Name, true)
    end
end

function RootWindow.onTextArrived()
    if not Chat.isOverhead(Chat.chatChannel()) or Chat.sourceId() == 0 then
        return
    end

    OverheadChatWindow.create()

    local window = OverheadChatWindow.Name .. Chat.sourceId()

    local rows = {
        window .. OverheadChatWindow.ChatOne,
        window .. OverheadChatWindow.ChatTwo,
        window .. OverheadChatWindow.ChatThree
    }

    if WindowApi.doesExist(rows[3]) and WindowApi.doesExist(rows[1]) then
        LabelApi.setText(rows[1], LabelApi.getText(rows[2]))
        LabelApi.setText(rows[2], LabelApi.getText(rows[3]))
        LabelApi.setText(rows[3], Chat.chatText())
        OverheadChatWindow.restartAnimation(rows[3])
    end

    for _, v in ipairs(rows) do
        if not WindowApi.doesExist(v) then
            WindowApi.createFromTemplate(
                v,
                "OverheadChatTemplate",
                window
            )
            break
        end
    end
end
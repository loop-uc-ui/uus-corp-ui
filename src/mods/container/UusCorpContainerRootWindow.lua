--Container windows are not create explicitly by the UI.
--They are create by client when containers are clicked.
UusCorpContainerRootWindow = {}

---@type table<string, UusCorpContainerWindow>
local Containers = {}

local function activeSlot()
    local scroll = WindowApi.getParent(WindowApi.getParent(Active.window()))
    local slots = Containers[WindowApi.getParent(scroll)].slots
    for i = 1, #slots do
        if slots[i].name == Active.window() then
            return slots[i]
        end
    end
end

function UusCorpContainerRootWindow.Initialize()
    local id = tonumber(string.gsub(Active.window(), UusCorpContainerWindow.name, ""), 10)
    local container = UusCorpContainerWindow:new(id):onInitialize(id)
    Containers[container.name] = container
end

function UusCorpContainerRootWindow.onUpdate()
    Containers[Active.window()]:onUpdate()
end

function UusCorpContainerRootWindow.updateContainer()
    Containers[Active.window()]:onUpdateContainer()
end

function UusCorpContainerRootWindow.updateObject()

end

function UusCorpContainerRootWindow.onRightClick()
    if not string.match(Active.mouseOverWindow(), "GridViewScrollChild") then
        WindowApi.destroyWindow(Active.window())
    end
end

function UusCorpContainerRootWindow.onShutdown()
    Containers[Active.window()]:onShutdown()
    Containers[Active.window()] = nil
end

function UusCorpContainerRootWindow.onLootAll()
    local container = Containers[WindowApi.getParent(Active.window())]
    container:registerCoreEvent("OnUpdate",  "UusCorpContainerRootWindow.onUpdate")
end

function UusCorpContainerRootWindow.onSlotSingleClick()
    activeSlot():onSingleClick()
end

function UusCorpContainerRootWindow.onSlotSingleClickUp()
    activeSlot():onSingleClickUp()
end

function UusCorpContainerRootWindow.onSlotDoubleClick()
    activeSlot():onDoubleClick()
end

function UusCorpContainerRootWindow.onSlotRightClick(flags)
    activeSlot():onRightClick(flags)
end

function UusCorpContainerRootWindow.onSlotMouseOver()
    activeSlot():onMouseOver()
end

function UusCorpContainerRootWindow.onToggleView()
    UserContainerSettings.legacyContainers(
        not UserContainerSettings.legacyContainers()
    )
    SettingsApi.settingsChanged()
    UusCorpContainerRootWindow.reopenContainer(
        Containers[WindowApi.getParent(Active.window())]
    )
end

function UusCorpContainerRootWindow.reopenContainer(container)
    container:destroyWindow()
    UserAction.useItem(container:getId(), false)
end

function UusCorpContainerRootWindow.onSearchClick()
    local container = Containers[WindowApi.getParent(Active.window())]
    container.searchBox:setShowing(not container.searchBox:isShowing())
    container.searchBox:assignFocus(container.searchBox:isShowing())
    container.searchLine:setShowing(container.searchBox:isShowing())
    container.title:setShowing(not container.searchBox:isShowing())
end

function UusCorpContainerRootWindow.onTextChanged(text)
    local container = Containers[WindowApi.getParent(Active.window())]

    for i = 1, #container.slots do
        local slot = container.slots[i]
        local properties = slot:properties()
        local isFound = properties == "" or string.find(
            string.lower(properties),
            string.lower(StringFormatter.fromWString(text))
        ) ~= nil
        slot:setShowing(isFound)
    end
end
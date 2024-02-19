--Container windows are not create explicitly by the UI.
--They are create by client when containers are clicked.
UusCorpContainerRootWindow = {}

---@type table<string, UusCorpContainerWindow>
local Containers = {}

local function activeSlot(isMouseOver)
    local window = Active.window()

    if isMouseOver then
        window = Active.mouseOverWindow()
    end

    local scroll = WindowApi.getParent(WindowApi.getParent(window))
    local slots = Containers[WindowApi.getParent(scroll)].slots
    for i = 1, #slots do
        if slots[i].name == window then
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

function UusCorpContainerRootWindow.onRightClick(flags)
    if not string.match(Active.mouseOverWindow(), "Slot") then
        Containers[Active.window()]:destroy()
    else
        local slot = activeSlot(true)
        slot:onRightClick(flags)
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
    local container = Containers[WindowApi.getParent(Active.window())]
    container.isLegacy = not container.isLegacy
    container:toggleState(container.isLegacy)
end

function UusCorpContainerRootWindow.onSearchClick()
    local container = Containers[WindowApi.getParent(Active.window())]
    container.searchBox:setShowing(not container.searchBox:isShowing())
    container.searchBox:assignFocus(container.searchBox:isShowing())
    container.searchLine:setShowing(container.searchBox:isShowing())
    container.title:setShowing(not container.searchBox:isShowing())

    if not container.searchBox:isShowing() then
        container.searchBox:setText("")
    end
end

function UusCorpContainerRootWindow.onTextChanged(text)
    Containers[WindowApi.getParent(Active.window())]:onSearchUpdate(text)
end
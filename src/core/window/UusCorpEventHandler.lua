
---@class UusCorpEventHandler
---@field Views table<string, UusCorpView>
UusCorpEventHandler = {
    Views = {}
}

function UusCorpEventHandler.onInitialize()
    local window = Active.window()
    for k, v in pairs(UusCorpCore.Windows) do
        if string.match(window, k) then
            local id = tonumber(string.gsub(window, k, ""), 10) or 0
            local view = v(window, id)
            UusCorpEventHandler.Views[window] = view
            if id ~= 0 then
                view:setId(id)
            end
            view:onInitialize()
            break
        end
    end
end

function UusCorpEventHandler.onShutdown()
    UusCorpEventHandler.Views[Active.window()]:onShutdown()
    UusCorpEventHandler.Views[Active.window()] = nil
end

function UusCorpEventHandler.onRButtonUp(flags, x, y)
    UusCorpEventHandler.Views[Active.window()]:onRButtonUp(flags, x, y)
end

function UusCorpEventHandler.onRButtonDown(flags, x, y)
    UusCorpEventHandler.Views[Active.window()]:onRButtonDown(flags, x, y)
end

function UusCorpEventHandler.onLButtonDown(flags, x, y)
    UusCorpEventHandler.Views[Active.window()]:onLButtonDown(flags, x, y)
end

function UusCorpEventHandler.onUpdate(timePassed)
    UusCorpEventHandler.Views[Active.window()]:onUpdate(timePassed)
end

function UusCorpEventHandler.onUpdateContainer()
    local view = UusCorpEventHandler.Views[Active.window()]
    local id = view:getId()
    view:onUpdateContainer(Container.data(id))
end

function UusCorpEventHandler.onUpdateObjectInfo()
    local view = UusCorpEventHandler.Views[Active.window()]
    local id = view:getId()
    view:onUpdateContainer(ObjectInfo.iconId(id))
end

function UusCorpEventHandler.onUpdatePlayerStatus()
    local view = UusCorpEventHandler.Views[Active.window()]
    view:onUpdatePlayerStatus(PlayerStatus.data())
end

function UusCorpEventHandler.onLButtonDblClk()
    UusCorpEventHandler.Views[Active.window()]:onLButtonDblClk()
end

function UusCorpEventHandler.onMouseOver()
    UusCorpEventHandler.Views[Active.window()]:onMouseOver()
end

function UusCorpEventHandler.onMouseOverEnd()
    UusCorpEventHandler.Views[Active.window()]:onMouseOverEnd()
end
UusCorp = {}

local function eventHandler()
    local _eventHandler = {}
    function _eventHandler.onInitialize() end
    function _eventHandler.onShutdown() end
    function _eventHandler.onLButtonUp() end
    function _eventHandler.onLButtonDown() end
    function _eventHandler.onRButtonUp() end
    function _eventHandler.onRButtonDown() end
    function _eventHandler.onUpdate() end
    function _eventHandler.onMouseOver() end
    function _eventHandler.onMouseOverEnd() end
    return _eventHandler
end

local function window(name)
    local _window = {}
    local eventHandler = eventHandler()
    local delegates = {}

    function _window.registerEventHandler(event, func)
        WindowApi.registerEventHandler(name, event, func)
    end

    function _window.unregisterEventHandler(event)
        WindowApi.unregisterEventHandler(name, event)
    end

    function _window.getName()
        return name
    end

    function _window.isShowing()
        return WindowApi.isShowing(name)
    end

    function _window.setShowing(show)
        WindowApi.setShowing(name, show)
    end

    function _window.getEventHandler()
        return eventHandler
    end

    function _window.setEventHandler(nEventHandler)
        eventHandler = nEventHandler
    end

    function _window.getDelegates()
        return delegates
    end

    function _window.setDelegates(nDelegates)
        delegates = nDelegates
    end

    function window.bind(views)
        if views == nil then
            for i = 1, #delegates do
                delegates[i](_window)
            end
        elseif views[1] == nil then
            for _, v in pairs(views) do
                v.bind()
            end
        else
            for i = 1, #views do
                views[i].bind()
            end
        end
    end

    return _window
end

local function button(name)
    local _button = window(name)

    function _button.getText()
        return ButtonApi.getText(name)
    end

    function _button.setText(text)
        ButtonApi.setText(name, text)
    end

    return _button
end

local function label(name)
    local _label = window(name)

    function _label.getText()
        return LabelApi.getText(name)
    end

    function _label.setText(text)
        LabelApi.setText(name, text)
    end

    return _label
end

function UusCorp.window(name)
    local builder = {}
    builder.window = window(name)
    local eventHandler = eventHandler()
    local delegates = {}

    function builder.asLabel()
        builder.window = label(name)
        return builder
    end

    function builder.asButton()
        builder.window = button(name)
        return builder
    end

    function builder.doOnLeftButtonUp(func)
        eventHandler.onLButtonUp = function ()
            func(builder.window)
        end
        return builder
    end

    function builder.doOnInitialize(func)
        eventHandler.onInitialize = function ()
            func(builder.window)
        end
        return builder
    end

    function builder.doOnRButtonUp(func)
        eventHandler.onRButtonUp = function ()
            func(builder.window)
        end
        return builder
    end

    function builder.delegate(func)
        table.insert(
            delegates,
            func
        )
        return builder
    end

    function builder.build()
        builder.window.setDelegates(delegates)
        builder.window.setEventHandler(eventHandler)
        return builder.window
    end

    return builder
end
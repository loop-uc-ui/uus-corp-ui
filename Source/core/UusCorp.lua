UusCorp = {}

local function eventHandler()
    local eventHandler = {}
    function eventHandler.onInitialize() end
    function eventHandler.onShutdown() end
    function eventHandler.onLButtonUp() end
    function eventHandler.onLButtonDown() end
    function eventHandler.onRButtonUp() end
    function eventHandler.onRButtonDown() end
    function eventHandler.onUpdate() end
    function eventHandler.onMouseOver() end
    function eventHandler.onMouseOverEnd() end
    return eventHandler
end

local function window(name)
    local window = {}
    local eventHandler = eventHandler()
    local delegates = {}

    function window.registerEventHandler(event, func)
        WindowApi.registerEventHandler(name, event, func)
    end

    function window.unregisterEventHandler(event)
        WindowApi.unregisterEventHandler(name, event)
    end

    function window.getName()
        return name
    end

    function window.isShowing()
        return WindowApi.isShowing(name)
    end

    function window.setShowing(show)
        WindowApi.setShowing(name, show)
    end

    function window.getEventHandler()
        return eventHandler
    end

    function window.setEventHandler(nEventHandler)
        eventHandler = nEventHandler
    end

    function window.getDelegates()
        return delegates
    end

    function window.setDelegates(nDelegates)
        delegates = nDelegates
    end

    function window.bind(views)
        if views == nil then
            for i = 1, #delegates do
                delegates[i](window)
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

    return window
end

local function button(name)
    local button = window(name)

    function button.getText()
        return ButtonApi.getText(name)
    end

    function button.setText(text)
        ButtonApi.setText(name, text)
    end

    return button
end

local function label(name)
    local label = window(name)

    function label.getText()
        return LabelApi.getText(name)
    end

    function label.setText(text)
        LabelApi.setText(name, text)
    end

    return label
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
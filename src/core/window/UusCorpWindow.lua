UusCorpWindow = {}

function UusCorpWindow.new(name)
    local window = {}

    function window.getName()
        return name
    end

    function window.setId(id)
        WindowApi.setId(name, id)
    end

    function window.getId()
        return WindowApi.getId(name)
    end

    function window.doesExist()
        return WindowApi.doesExist(name)
    end

    function window.isShowing()
        return WindowApi.isShowing(name)
    end

    function window.setShowing(doShow)
        WindowApi.setShowing(name, doShow)
    end

    function window.createFromTemplate(template, parent)
        return WindowApi.createFromTemplate(name, template, parent or "Root")
    end

    function window.create(doShow)
        return WindowApi.createWindow(name, doShow == nil or doShow)
    end

    function window.destroy()
        return WindowApi.destroyWindow(name)
    end

    function window.addAnchor(anchor)
        WindowApi.addAnchor(name, anchor.anchorPoint, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
    end

    function window.addLabel(label)
        return UusCorpLabel.new(name .. label)
    end

    function window.setUpdateFrequency(frequency)
        WindowApi.setUpdateFrequency(name, frequency)
    end

    function window.getDimensions()
        return WindowApi.getDimensions(name)
    end

    function window.setOffsetFromParent(x, y)
        return WindowApi.setOffsetFromParent(name, x, y)
    end

    function window.registerEvent(id, callback)
        WindowApi.registerEventHandler(name, id, name .. "." .. callback)
    end

    function window.registerData(type, id)
        WindowDataApi.registerData(type, id)
    end

    function window.unregisterEvent(id)
        WindowApi.unregisterEventHandler(name, id)
    end

    function window.unregisterData(type, id)
        WindowDataApi.unregisterData(type, id)
    end

    function window.registerCoreEvent(id)
        WindowApi.registerCoreEventHandler(name, id)
    end

    function window.unregisterCoreEvent(id)
        WindowApi.unregisterCoreEventHandler(name, id)
    end

    function window.attachToWorldObject(id)
        WindowApi.attachWindowToWorldObject(id, name)
    end

    function window.detatchFromWorlObject(id)
        WindowApi.detachWindowFromWorldObject(id, name)
    end

    function window.setScale(scale)
        WindowApi.setScale(name, scale)
    end

    function window.setColor(color)
        WindowApi.setColor(name, color)
    end

    function window.savePosition()
        WindowUtilsWrapper.saveWindowPosition(name)
    end

    function window.restorePosition()
        WindowUtilsWrapper.restoreWindowPosition(name)
    end

    return window
end
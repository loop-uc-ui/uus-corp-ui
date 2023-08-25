UusCorpWindow = {}

function UusCorpWindow.new(name)
    local window = { name = name }

    window.isShowing = function ()
        return WindowApi.isShowing(name)
    end

    window.setShowing = function (doShow)
        WindowApi.setShowing(name, doShow)
    end

    window.createFromTemplate = function (template, parent)
        return WindowApi.createFromTemplate(name, template, parent)
    end

    window.create = function (doShow)
        return WindowApi.createWindow(name, doShow == nil or doShow)
    end

    window.destroy = function ()
        return WindowApi.destroyWindow(name)
    end

    window.addAnchor = function (anchor)
        WindowApi.addAnchor(name, anchor.anchorPoint, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
    end

    window.addLabel = function (label)
        return UusCorpLabel.new(name .. label)
    end

    window.setUpdateFrequency = function (frequency)
        WindowApi.setUpdateFrequency(name, frequency)
    end

    window.getDimensions = function ()
        return WindowApi.getDimensions(name)
    end

    window.setOffsetFromParent = function (x, y)
        return WindowApi.setOffsetFromParent(name, x, y)
    end

    return window
end

function UusCorpWindow.active()
    return UusCorpWindow.new(Active.window)()
end
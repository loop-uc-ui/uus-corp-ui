UusCorpContainerMod = {}

function UusCorpContainerMod.onInitialize()
    UusCorpCore.loadResources(
        "/src/mods/container",
        "UusCorpContainerWindow.xml"
    )

    if not UserContainerSettings.legacyContainers() then
        UserContainerSettings.legacyContainers(true)
        EventApi.broadcast(Events.userSettingsUpdated())
    end

    UusCorpCore.registerWindow(
        "ContainerWindow_",
        function (activeWindow)
            return UusCorpContainerWindow:new(
                tonumber(string.gsub(activeWindow, "ContainerWindow_", ""), 10)
            )
        end
    )
end
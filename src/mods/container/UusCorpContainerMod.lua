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
end
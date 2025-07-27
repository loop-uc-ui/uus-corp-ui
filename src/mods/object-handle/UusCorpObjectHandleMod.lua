UusCorpObjectHandleMod = UusCorp.Mod {
    Name = "UusCorpObjectHandle",

    Path = "/src/mods/object-handle",

    OnInitialize = function ()
        local oldWindow = UusCorp.Interface.Defaults.ObjectHandleWindow

        oldWindow.CreateObjectHandles = function ()
            UusCorp.Utils.Table.ForEach(
                UusCorp.ObjectHandles().getHandles(),
                function (_, v)
                    UusCorpObjectHandle(v):create()
                end
            )
        end

        -- Store the original function before overriding it
        local originalItemProperties = UusCorp.Interface.Defaults.ItemProperties

        ---@diagnostic disable-next-line: duplicate-set-field
        UusCorp.Interface.Defaults.ItemProperties.UpdateItemPropertiesData = function()
            if (string.find(UusCorp.MouseOver().getWindow(), oldWindow.Name)) then
                UusCorp.Interface.Defaults.ItemPropertiesData.clearActiveItem()
            else
                -- Call the original function
                originalItemProperties.UpdateItemPropertiesData()
            end
        end
    end
}
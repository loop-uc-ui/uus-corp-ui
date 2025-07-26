UusCorpObjectHandleMod = UusCorp.Mod {
    Name = "UusCorpObjectHandle",

    Path = "/src/mods/object-handle",

    OnInitialize = function ()
        UusCorp.Interface.Defaults.ObjectHandleWindow:getDefault().CreateObjectHandles = function ()
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
            if (string.find(UusCorp.MouseOver().getWindow(), UusCorpObjectHandleWindow:getName())) then
                UusCorp.Interface.Defaults.ItemPropertiesData.clearActiveItem()
            else
                -- Call the original function
                originalItemProperties.UpdateItemPropertiesData()
            end
        end
    end
}
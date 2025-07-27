UusCorpObjectHandleMod = UusCorp.Mod {
    Name = "UusCorpObjectHandle",

    Path = "/src/mods/object-handle",

    OnInitialize = function ()
        local oldWindow = UusCorp.Interface.Defaults.ObjectHandleWindow

        oldWindow:getDefault().CreateObjectHandles = function ()
            UusCorp.Utils.Table.ForEach(
                UusCorp.Data.ObjectHandles():getHandles(),
                function (_, v)
                    UusCorpObjectHandle(v):create()
                end
            )
        end

        -- Store the original function before overriding it
        local copy = UusCorp.Utils.Table.Copy(UusCorp.Interface.Defaults.ItemProperties)

        ---@diagnostic disable-next-line: duplicate-set-field
        UusCorp.Interface.Defaults.ItemProperties.UpdateItemPropertiesData = function()
            if (string.find(UusCorp.Data.MouseOver():getWindow(), oldWindow:getName())) then
                UusCorp.Interface.Defaults.ItemPropertiesData.clearActiveItem()
            else
                -- Call the original function
                copy--[[@as ItemProperties]].UpdateItemPropertiesData()
            end
        end
    end
}
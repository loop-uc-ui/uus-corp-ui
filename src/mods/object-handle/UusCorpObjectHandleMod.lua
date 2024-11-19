UusCorpObjectHandleMod = UusCorp.Mod {
    Name = "UusCorpObjectHandle",

    Path = "/src/mods/object-handle",

    OnInitialize = function ()
        UusCorp.Interface.Defaults.ObjectHandleWindow.CreateObjectHandles = function ()
            UusCorp.Utils.Table.ForEach(
                UusCorp.ObjectHandles().getHandles(),
                function (_, v)
                    UusCorpObjectHandle(v).create()
                end
            )
        end

        local copy = UusCorp.Utils.Table.Copy(UusCorp.Interface.Defaults.ItemProperties --[[@as table]])

        UusCorp.Interface.Defaults.ItemProperties = function ()
            if (string.find(UusCorp.MouseOver().getWindow(), UusCorpObjectHandleWindow.Name)) then
                UusCorp.Interface.Defaults.ItemPropertiesData.clearActiveItem()
            else
                copy--[[@as ItemProperties]].UpdateItemPropertiesData()
            end
        end
    end
}
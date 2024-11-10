UusCorpObjectHandleMod = UusCorp.Mod {
    Name = "UusCorpObjectHandle",

    Path = "/src/mods/object-handle",

    OnInitialize = function ()
        UusCorp.Interface.Defaults.ObjectHandleWindow.CreateObjectHandles = function ()
            UusCorp.Utils.Array.ForEach(
                UusCorp.Data.Window().ObjectHandle.ObjectId,
                function (item, _)
                    if UusCorp.Api.Object.IsValid(item) then
                        UusCorpObjectHandle(item).create()
                    end
                end
            )
        end

        UusCorp.Interface.Defaults.ObjectHandleWindow.DestroyObjectHandles = function ()
            UusCorp.Utils.Array.ForEach(
                UusCorp.Data.Window().ObjectHandle.ObjectId,
                function (item, _)
                    UusCorp.Api.Window.Destroy(UusCorpObjectHandleWindow.Name .. item)
                end
            )
        end

        local copy = UusCorp.Utils.Table.Copy(UusCorp.Interface.Defaults.ItemProperties --[[@as table]])

        UusCorp.Interface.Defaults.ItemProperties = function ()
            if (string.find(UusCorp.Data.System().MouseOverWindow.name, UusCorpObjectHandleWindow.Name)) then
                UusCorp.Interface.Defaults.ItemPropertiesData.clearActiveItem()
            else
                copy--[[@as ItemProperties]].UpdateItemPropertiesData()
            end
        end
    end
}
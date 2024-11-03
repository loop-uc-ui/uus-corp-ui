UusCorpObjectHandleWindow = {}

local function Label(index, id)
    return UusCorp.Interface.Button {
        template = "UusCorpButton18",
        events = {
            ---@param self Button
            OnInitialize = function (self, _, windowData)
                local name = tostring(windowData.ObjectHandle.Names[index])
                name = name:sub(1, 32)
                self.setText(name)
                local parent = self.getParent()
                self.setDimensions(#name * 11, 32)
                parent.setDimensions(#name * 11, 36)
                self.setId(id)
            end,

            OnRButtonUp = function (self)
                self.getParent().destroy()
            end,

            OnLButtonDblClk = function (self)
                UusCorp.Api.UserAction.UseItem(
                    self.getId(),
                    false
                )
            end
        }
    }
end

local function Handle(id)
    return UusCorp.Interface.Window {
        name = "ObjectHandleWindow" .. id,
        events = {
            OnInitialize = function (self, _, windowData)
                self.setAlpha(0.75)
                local index = UusCorp.Utils.Array.IndexOf(
                    windowData.ObjectHandle.ObjectId,
                    function (item)
                        return item == self.getId()
                    end
                )
                local label = Label(index, id)
                self.setChildren { label }
                self.attachToObject()
            end,

            OnUpdate = function (self)
                if not UusCorp.Api.Object.IsValid(self.getId()) then
                    self.destroy()
                end
            end
        }
    }
end

UusCorpObjectHandleWindow.Name = "ObjectHandleWindow"
UusCorpObjectHandleWindow.Label = "Name"

function UusCorpObjectHandleWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/object-handle",
        "UusCorpObjectHandleWindow.xml"
    )

    UusCorp.Interface.Defaults.ObjectHandleWindow.CreateObjectHandles = function ()
        UusCorp.Utils.Array.ForEach(
            UusCorp.Data.Window().ObjectHandle.ObjectId,
            function (item, _)
                if UusCorp.Api.Object.IsValid(item) then
                    Handle(item).create()
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
        if (string.find(Active.mouseOverWindow(), UusCorpObjectHandleWindow.Name)) then
            ItemPropertiesData.clearActiveItem()
        else
            copy--[[@as ItemProperties]].UpdateItemPropertiesData()
        end
    end
end

function UusCorpObjectHandleWindow.onDoubleClick()
    UserActionApi.useItem(
        WindowApi.getId(Active.window()),
        false
    )
end

function UusCorpObjectHandleWindow.onMouseDrag()
    local id = WindowApi.getId(Active.window())
    if ObjectApi.isMobile(id) then
        Active.setMobile(id)
        EventApi.broadcast(Events.beginHealthBarDrag())
    elseif ObjectApi.isValid(id) then
        DragApi.setObjectMouseClickData(id, Drag.sourceObject())
    end
end
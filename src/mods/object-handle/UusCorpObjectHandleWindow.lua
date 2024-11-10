UusCorpObjectHandleWindow = {
    Name = "ObjectHandleWindow"
}

local function Label(index, id)
    return UusCorp.Interface.Button {
        template = "UusCorpButton18",
        events = {
            ---@param self Button
            OnInitialize = function (self)
                local name = tostring(UusCorp.Data.Window().ObjectHandle.Names[index])
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
            end,

            OnMouseOver = function (self)
                self.getParent().setAlpha(1.0)
                self.getParent().setLayer(UusCorp.Constants.WindowLayers.Default)
            end,

            OnMouseOverEnd = function (self)
                self.getParent().setAlpha(0.65)
                self.getParent().setLayer(UusCorp.Constants.WindowLayers.Background)
            end,

            OnMouseDrag = function (_)
                if UusCorp.Api.Object.IsMobile(id) then
                    UusCorp.Data.System().ActiveMobile.Id = id
                    UusCorp.Api.Event.Broadcast(UusCorp.Constants.Broadcasts.BeginHealthBarDrag())
                elseif UusCorp.Api.Object.IsValid(id) then
                    UusCorp.Api.Drag.SetObjectMouseClickData(id, UusCorp.Constants.DragSource.Object())
                end
            end
        }
    }
end

function UusCorpObjectHandle(id)
    return UusCorp.Interface.Window {
        name = UusCorpObjectHandleWindow.Name .. id,
        events = {
            OnInitialize = function (self)
                self.setAlpha(0.65)
                self.setLayer(UusCorp.Constants.WindowLayers.Background)
                local index = UusCorp.Utils.Array.IndexOf(
                    UusCorp.Data.Window().ObjectHandle.ObjectId,
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
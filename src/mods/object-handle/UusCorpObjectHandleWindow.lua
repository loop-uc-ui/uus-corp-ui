---@param objectHandle ObjectHandle
local function Label(objectHandle)
    return UusCorp.Interface.Button {
        template = "UusCorpButton18",
        events = {
            OnInitialize = function (self)
                local name = objectHandle.name:sub(1, 32)
                self:setText(name)
                local parent = self:getParent()
                self:setDimensions(#name * 11, 32)
                parent:setDimensions(#name * 11, 36)
                self:setId(objectHandle.id)
            end,

            OnRButtonUp = function (self)
                self:getParent():destroy()
            end,

            OnLButtonDblClk = function (self)
                UusCorp.Api.UserAction.UseItem(
                    self:getId(),
                    false
                )
            end,

            OnMouseOver = function (self)
                self:getParent():setAlpha(1.0)
                self:getParent():setLayer(UusCorp.Constants.WindowLayers.Default)
            end,

            OnMouseOverEnd = function (self)
                self:getParent():setAlpha(0.65)
                self:getParent():setLayer(UusCorp.Constants.WindowLayers.Background)
            end,

            OnMouseDrag = function (_)
                if objectHandle.isMobile then
                    UusCorp.Data.ActiveMobile():setId(objectHandle.id)
                    UusCorp.Api.Event.Broadcast(UusCorp.Constants.Broadcasts.BeginHealthBarDrag())
                elseif objectHandle.isValid() then
                    UusCorp.Api.Drag.SetObjectMouseClickData(objectHandle.id, UusCorp.Constants.DragSource.Object())
                end
            end
        }
    }
end

---@param objectHandle ObjectHandle
function UusCorpObjectHandle(objectHandle)
    return UusCorp.Interface.Window {
        name = "ObjectHandleWindow" .. objectHandle.id,
        events = {
            OnInitialize = function (self)
                self:setAlpha(0.65)
                self:setLayer(UusCorp.Constants.WindowLayers.Background)
                local label = Label(objectHandle)
                self:setChildren { label }
                self:attachToObject()
            end,

            OnUpdate = function (self)
                if not objectHandle.isValid() then
                    self:destroy()
                end
            end
        }
    }
end
---@param context Context
---@param objectHandle ObjectHandle
local function Label(context, objectHandle)
    return context.Views.Button {
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
                context.Api.UserAction.UseItem(
                    self:getId(),
                    false
                )
            end,

            OnMouseOver = function (self)
                self:getParent():setAlpha(1.0)
                self:getParent():setLayer(context.Constants.WindowLayers.Default)
            end,

            OnMouseOverEnd = function (self)
                self:getParent():setAlpha(0.65)
                self:getParent():setLayer(context.Constants.WindowLayers.Background)
            end,

            OnMouseDrag = function (_)
                if objectHandle.isMobile then
                    context.Data.ActiveMobile():setId(objectHandle.id)
                    context.Api.Event.Broadcast(context.Constants.Broadcasts.BeginHealthBarDrag())
                elseif objectHandle.isValid() then
                    context.Api.Drag.SetObjectMouseClickData(objectHandle.id, context.Constants.DragSource.Object())
                end
            end
        }
    }
end

---@param context Context
---@param objectHandle ObjectHandle
local function UusCorpObjectHandle(context, objectHandle)
    return context.Views.Window {
        name = "ObjectHandleWindow" .. objectHandle.id,
        events = {
            OnInitialize = function (self)
                self:setAlpha(0.65)
                self:setLayer(context.Constants.WindowLayers.Background)
                local label = Label(context, objectHandle)
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

UusCorpObjectHandleMod = UusCorp.Mod {
    Name = "UusCorpObjectHandle",

    Path = "/src/mods/object-handle",

    OnInitialize = function (context)
        local oldWindow = context.Views.Defaults.ObjectHandleWindow

        oldWindow:getDefault().CreateObjectHandles = function ()
            context.Utils.Table.ForEach(
                context.Data.ObjectHandles():getHandles(),
                function (_, v)
                    UusCorpObjectHandle(context, v):create()
                end
            )
        end

        -- Store the original function before overriding it
        local copy = context.Utils.Table.Copy(context.Views.Defaults.ItemProperties)

        ---@diagnostic disable-next-line: duplicate-set-field
        context.Views.Defaults.ItemProperties.UpdateItemPropertiesData = function()
            if (string.find(context.Data.MouseOver():getWindow(), oldWindow:getName())) then
                context.Views.Defaults.ItemPropertiesData.clearActiveItem()
            else
                -- Call the original function
                copy--[[@as ItemProperties]].UpdateItemPropertiesData()
            end
        end
    end
}
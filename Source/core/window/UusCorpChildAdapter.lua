UusCorpChildAdapter = {}
UusCorpChildAdapter.__index = UusCorpChildAdapter

function UusCorpChildAdapter:init()
    local this = setmetatable({}, self)
    this.children = {}
    return this
end

function UusCorpChildAdapter:addChild(view) table.insert(self.children, view) end

function UusCorpChildAdapter:register()
    for _, value in pairs(self.children) do
        value.eventAdapter:register()

        if value.create then
            value:create()
        else
            value.eventAdapter.initialize.windowCallback()
        end

        if value.dataAdapter then value.dataAdapter:register() end
    end
end

function UusCorpChildAdapter:unregister()
    for _, value in pairs(self.children) do
        value.eventAdapter:unregister()
        if value.destroy then value:destroy() end
    end
    self.children = {}
end

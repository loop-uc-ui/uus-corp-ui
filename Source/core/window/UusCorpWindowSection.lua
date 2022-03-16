UusCorpWindowSection = setmetatable({}, {__index = UusCorpWindow})
UusCorpWindowSection.__index = UusCorpWindowSection

function UusCorpWindowSection.new(name, root, parent, template) 
    local self = setmetatable(
        UusCorpWindow.new(name),
        UusCorpWindowSection
    )
    self.root = root
    self.parent = parent
    self.template = template
    return self
end

function UusCorpWindowSection:create(doShow)
    if self:doesExist() then
        return
    end

    UusCorpWindowManager.Windows[self.root].children[self.name] = self

    WindowApi.createFromTemplate(
        self.name,
        self.template,
        self.parent
    )

    self:setShowing(doShow)
end
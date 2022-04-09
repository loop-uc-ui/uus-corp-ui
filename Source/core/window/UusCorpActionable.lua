
UusCorpActionable = {}
UusCorpActionable.__index = UusCorpActionable

function UusCorpActionable:addAction(action)
    if not self.actions then
        self.actions = {}
    end

    self.actions[action.name] = action
    return self
end
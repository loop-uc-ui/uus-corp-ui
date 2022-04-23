UusCorpComposable = {}
UusCorpComposable.__index = UusCorpComposable

function UusCorpComposable:asView(name)
    self = setmetatable({
        name = name
    }, UusCorpView)
    return self
end
UusCorpComposable = {}
UusCorpComposable.__index = UusCorpComposable

function UusCorpComposable:asView(name)
    return setmetatable({
        name = name
    }, UusCorpView)
end
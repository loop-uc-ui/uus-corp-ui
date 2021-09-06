SkillsListItemWindow = ListWindow:new("SkillsListItemWindow", false)

local SKILLS_LIST_ITEM_WINDOW = "SkillsListItemWindow"

local function formatValue(value)
    local whole = tostring(value)
    local lastDigit = StringFormatter.toWString(string.sub(whole, -1, -1))
    whole = StringFormatter.toWString(string.sub(whole, 0, string.len(whole) - 1))
    if whole == L"" then
        whole = L"0"
    end
    local output = whole..L"."..lastDigit
    return output
end

function SkillsListItemWindow:new(
        index,
        name,
        csvId,
        iconId,
        realValue,
        baseValue,
        capValue,
        state
)
    local this = {}
    this.index = index
    this.id = SKILLS_LIST_ITEM_WINDOW..index
    this.adapter = WindowAdapter:new(this.id)
    this.eventRegister = WindowEventRegister:new(this.id)
    this.isScrollable = false
    this.name = name
    this.realValue = formatValue(realValue)
    this.modifiedValue = formatValue(baseValue)
    this.capValue = formatValue(capValue)
    this.state = state
    self.__index = self
    return setmetatable(this, self)
end

function SkillsListItemWindow:initialize()
    self.adapter:addLabel(self.id.."Name", self.name)
        :addLabel(self.id.."RealValue", self.realValue)
        :addLabel(self.id.."ModifiedValue", self.modifiedValue)
        :addLabel(self.id.."CapValue", self.capValue)
    if self.index > 1 then
        self:clearAnchors()
        self:addAnchor(
                "topleft",
                SKILLS_LIST_ITEM_WINDOW..(self.index - 1),
                "bottomleft",
                0,
                32
        )
    end
end
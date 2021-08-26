SkillsListItemWindow = ListWindow:new("SkillsListItemWindow", false)

local SKILLS_LIST_ITEM_WINDOW = "SkillsListItemWindow"

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
    this.realValue = StringFormatter.toWString(realValue)
    this.modifiedValue = StringFormatter.toWString(baseValue)
    this.capValue = StringFormatter.toWString(capValue)
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
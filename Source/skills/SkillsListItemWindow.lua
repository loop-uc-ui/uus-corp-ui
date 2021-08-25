SkillsListItemWindow = ListWindow:new("SkillsListItemWindow", false)

local SKILLS_LIST_ITEM_WINDOW = "SkillsListItemWindow"

function SkillsListItemWindow:new(index)
    local this = {}
    this.index = index
    this.id = SKILLS_LIST_ITEM_WINDOW..index
    this.adapter = WindowAdapter:new(this.id)
    this.eventRegister = WindowEventRegister:new(this.id)
    this.isScrollable = false
    this.name = Skills:name(index)
    this.realValue = StringFormatter.toWString(Skills:realValue(index))
    this.modifiedValue = StringFormatter.toWString(Skills:tempValue(index))
    this.capValue = StringFormatter.toWString(Skills:cap(index))
    this.state = Skills:state(index)
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
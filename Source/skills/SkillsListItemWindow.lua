SkillsListItemWindow = ListWindow:new("SkillsListItemWindow", false)

local SKILLS_LIST_ITEM_WINDOW = "SkillsListItemWindow"

local STATE_UP = 0
local STATE_DOWN = 1
local STATE_LOCKED = 2

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
        csvId,
        name,
        realValue,
        baseValue,
        capValue,
        state
)
    local this = {}
    this.index = index
    this.id = SKILLS_LIST_ITEM_WINDOW..index
    this.csvId = csvId
    this.adapter = WindowAdapter:new(this.id)
    this.eventRegister = WindowEventRegister:new(this.id)
    this.isScrollable = false
    this.name = name
    this.realValue = formatValue(realValue)
    this.modifiedValue = formatValue(baseValue)
    this.capValue = formatValue(capValue)
    this.state = state
    this.dragIcon = Skills.dragIcon(csvId)
    this.serverId = Skills.serverId(csvId)
    this.iconId = Skills.icon(csvId)
    self.__index = self
    return setmetatable(this, self)
end

function SkillsListItemWindow:initialize()
    self.adapter:addLabel(self.id.."Name", self.name)
        :addLabel(self.id.."RealValue", self.realValue)
        :addLabel(self.id.."ModifiedValue", self.modifiedValue)
        :addLabel(self.id.."CapValue", self.capValue)
        :addButton(self.id.."ButtonBackground")

    WindowApi.createFromTemplate(
            self.id.."LockButton",
            "SkillsLockButtonWindow",
            self.id.."LockButtonWindow"
    )
    local button = SkillsLockButtonWindow:new(
            self.id.."LockButton",
            self.state,
            function()
                Debug.Print("test")
            end
    )
    button:setButtonTexture()
    self.adapter.views[button.id] = button

    if self.index > 1 then
        self:clearAnchors()
        self:addAnchor(
                "topleft",
                SKILLS_LIST_ITEM_WINDOW..(self.index - 1),
                "bottomleft",
                0,
                46
        )
    end

    self.adapter.views[self.id.."ButtonBackground"]:setColor(Colors.OffBlack)
end

function SkillsListItemWindow.OnLock()
    local button = self.adapter.views[self.id.."LockButton"]
    if self.state == STATE_UP then
        button:setTexture("arrowup", 24, 0)
    elseif self.state == STATE_DOWN then
        button:setTexture("arrowdown", 24, 0)
    elseif self.state == STATE_LOCKED then
        button:setTexture("Lock_Button", 24, 0)
    end
end

function SkillsListItemWindow.onLeftClick()
    if Drag.isNone() then
        local button = SkillsListItemWindow.getActiveWindow()
        if button.dragIcon == 1 and button.serverId ~= nil then
            Drag.setActionMouseClickData(
                    UserAction.typeSkill(),
                    button.serverId,
                    button.iconId
            )
        end
    end
end

function SkillsListItemWindow.getActiveWindow()
    return SkillsWindow.adapter.views[string.gsub(ActiveWindow.name(), "ButtonBackground", "")]
end

function SkillsListItemWindow.onDoubleClick()
    UserAction.useSkill(SkillsListItemWindow.getActiveWindow().serverId)
end

function SkillsListItemWindow:update(baseValue, modifiedValue, capValue)
    self.adapter.views[self.id.."RealValue"]:setText(
            formatValue(baseValue)
    )
    self.adapter.views[self.id.."ModifiedValue"]:setText(
            formatValue(modifiedValue)
    )
    self.adapter.views[self.id.."CapValue"]:setText(
            formatValue(capValue)
    )
end

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

function SkillsListItemWindow.OnDrag(flags)
    if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
        -- Player is dragging an icon

        -- button number is its location on the screen (1 = top of left column, 2 = 2nd in left column, etc with left column done first before starting through the right column)
        local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
        local skill = SkillsWindow.adapter.views[buttonNum]

        -- skillIndex is the line index in the csv file for this skill
        local skillIndex = activeContent[buttonNum]
        local skillId = Skills.serverId(skill.index)
        local iconId = Skills.icon(skill.index)

        --Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): iconId = "..StringToWString(tostring(iconId)))

        if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
            if( skillId ~= nil ) then
                if flags == SystemData.ButtonFlags.CONTROL then -- SINGLE HOTBAR ICON
                    local blockBar = HotbarSystem.GetNextHotbarId()
                    Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
                    HotbarSystem.SpawnNewHotbar()

                    HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SKILL, skillId,iconId, blockBar,  1)

                    local scaleFactor = 1/InterfaceCore.scale

                    local propWindowWidth = Hotbar.BUTTON_SIZE
                    local propWindowHeight = Hotbar.BUTTON_SIZE

                    -- Set the position
                    local mouseX = SystemData.MousePosition.x - 30
                    if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
                        propWindowX = mouseX - (propWindowWidth / scaleFactor)
                    else
                        propWindowX = mouseX
                    end

                    local mouseY = SystemData.MousePosition.y - 15
                    if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
                        propWindowY = mouseY - (propWindowHeight / scaleFactor)
                    else
                        propWindowY = mouseY
                    end

                    WindowSetOffsetFromParent("Hotbar" .. blockBar, propWindowX * scaleFactor, propWindowY * scaleFactor)
                    WindowSetMoving("Hotbar" .. blockBar, true)

                else
                    DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SKILL,skillId,iconId)
                end
            end
        else
            --Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): Not allowed to drag index = "..StringToWString(tostring(skillIndex)))

        end
    end
end

function SkillsListItemWindow.SkillLButtonDown(flags)
    if Drag.isNone() then
        local button = SkillsWindow.adapter.views[string.gsub(ActiveWindow.name(), "ButtonBackground", "")]
        local skillIndex = button.index
        local skillId = Skills.serverId(skillIndex)
        local iconId = Skills.icon(skillIndex)

        if Skills.dragIcon(skillIndex) == 1 and skillId ~= nil then
            DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SKILL,skillId,iconId)
        end
    end
end

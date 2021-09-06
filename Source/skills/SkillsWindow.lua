SkillsWindow = ListWindow:new("SkillsWindow", true)

local SORT_NAME_ASC = 1
local SORT_NAME_DESC = 2
local SORT_REAL_ASC = 3
local SORT_REAL_DESC = 4
local SORT_BASE_ASC = 5
local SORT_BASE_DESC = 6
local SORT_CAP_ASC = 7
local SORT_CAP_DESC = 8

local NAME_LABEL = "SkillsWindowNameLabel"
local NAME_BUTTON = "SkillsWindowNameSortButton"

local REAL_LABEL = "SkillsWindowRealLabel"
local REAL_BUTTON = "SkillsWindowRealSortButton"

local BASE_LABEL = "SkillsWindowBaseLabel"
local BASE_BUTTON = "SkillsWindowBaseSortButton"

local CAP_LABEL = "SkillsWindowCapLabel"
local CAP_BUTTON = "SkillsWindowCapSortButton"

local ARROW_UP = "arrowup"
local ARROW_DOWN = "arrowdown"

local mode = SORT_NAME_DESC

local function mapSkills()
	local skills = {}
	for i = 0, #Skills.list() - 1 do
		table.insert(
				skills,
				{
					name = Skills:name(i),
					csvId = Skills:csvId(i),
					icon = Skills:iconId(i),
					realValue = Skills:realValue(i),
					baseValue = Skills:tempValue(i),
					cap = Skills:cap(i),
					state = Skills:state(i)
				}
		)
	end
	return skills
end

local function clearSkills()
	for key, value in pairs(SkillsWindow.adapter.views) do
		if string.find(key, "SkillsListItemWindow") then
			value:destroy()
		end
	end
end

local function addSkills(list)
	for i = 1, #list do
		local skill = list[i]
		WindowApi.createFromTemplate(
				"SkillsListItemWindow"..i,
				"SkillsListItemWindow",
				"Skills"
		)
		local item = SkillsListItemWindow:new(
				i,
				skill.name,
				skill.csvId,
				skill.iconId,
				skill.realValue,
				skill.baseValue,
				skill.cap,
				skill.state
		)
		item:initialize()
		SkillsWindow.adapter.views[item.id] = item
	end
end

local function applyUpDownTexture(button, isDown)
	local arrow = ARROW_UP
	if isDown then
		arrow = ARROW_DOWN
	end

	button:setTexture(
			InterfaceCore.ButtonStates.STATE_NORMAL,
			arrow,
			0,
			0
	):setTexture(
			InterfaceCore.ButtonStates.STATE_PRESSED,
			arrow,
			0,
			0
	):setTexture(
			InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE,
			arrow,
			24,
			0
	):setTexture(
			InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE,
			arrow,
			24,
			0
	):setShowing(true)
end

local function setSortButtonTexture(sortMode)
	if sortMode == SORT_NAME_DESC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				true
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
	elseif sortMode == SORT_NAME_ASC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
	elseif sortMode == SORT_REAL_DESC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
	elseif sortMode == SORT_REAL_ASC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				true
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
	elseif sortMode == SORT_BASE_DESC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
	elseif sortMode == SORT_BASE_ASC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				true
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
	elseif sortMode == SORT_CAP_DESC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
	elseif sortMode == SORT_CAP_ASC then
		applyUpDownTexture(
				SkillsWindow.adapter.views[CAP_BUTTON],
				true
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[REAL_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[NAME_BUTTON],
				false
		)
		applyUpDownTexture(
				SkillsWindow.adapter.views[BASE_BUTTON],
				false
		)
	else
		setSortButtonTexture(SORT_NAME_ASC)
	end
end

local function sortSkills(sortMode)
	local list = mapSkills()
	mode = sortMode
	if mode == SORT_NAME_DESC then
		table.sort(
				list,
				function (a, b)
					return a.name < b.name
				end
		)
	elseif mode == SORT_NAME_ASC then
		table.sort(
				list,
				function (a, b)
					return a.name > b.name
				end
		)
	elseif mode == SORT_REAL_ASC then
		table.sort(
				list,
				function (a, b)
					return a.realValue > b.realValue
				end
		)
	elseif mode == SORT_REAL_DESC then
		table.sort(
				list,
				function (a, b)
					return a.realValue < b.realValue
				end
		)
	elseif mode == SORT_BASE_ASC then
		table.sort(
				list,
				function (a, b)
					return a.baseValue > b.baseValue
				end
		)
	elseif mode == SORT_BASE_DESC then
		table.sort(
				list,
				function (a, b)
					return a.baseValue < b.baseValue
				end
		)
	elseif mode == SORT_CAP_ASC then
		table.sort(
				list,
				function (a, b)
					return a.cap > b.cap
				end
		)
	elseif mode == SORT_CAP_DESC then
		table.sort(
				list,
				function (a, b)
					return a.cap < b.cap
				end
		)
	else
		sortSkills(SORT_NAME_DESC)
	end

	clearSkills()
	addSkills(list)
	setSortButtonTexture(mode)
end

function SkillsWindow.Initialize()
	for i = 0, #Skills.list() - 1 do
		SkillsWindow:registerData(
				Skills.dynamicDataType(),
				i
		)
	end

	SkillsWindow:registerData(
			Skills.listDataType(),
			0
	)

	SkillsWindow.adapter:addLabel(
			NAME_LABEL,
			"Name"
	):addLabel(
			REAL_LABEL,
			"Real"
	):addLabel(
			BASE_LABEL,
			"Base"
	):addLabel(
			CAP_LABEL,
			"Cap"
	):addButton(
			NAME_BUTTON
	):addButton(
			REAL_BUTTON
	):addButton(
			CAP_BUTTON
	):addButton(
			BASE_BUTTON
	)
	SkillsWindow.adapter.views[NAME_BUTTON]:setShowing(false)
	sortSkills(mode)
end

function SkillsWindow.ToggleSkillsWindow()
	SkillsWindow:setShowing(not SkillsWindow:isShowing())
end

function SkillsWindow.OnNameSort()
	if mode == SORT_NAME_ASC then
		mode = SORT_NAME_DESC
	else
		mode = SORT_NAME_ASC
	end
	sortSkills(mode)
end

function SkillsWindow.OnRealSort()
	if mode == SORT_REAL_ASC then
		mode = SORT_REAL_DESC
	else
		mode = SORT_REAL_ASC
	end
	sortSkills(mode)
end

function SkillsWindow.OnBaseSort()
	if mode == SORT_BASE_ASC then
		mode = SORT_BASE_DESC
	else
		mode = SORT_BASE_ASC
	end
	sortSkills(mode)
end

function SkillsWindow.OnCapSort()
	if mode == SORT_CAP_ASC then
		mode = SORT_CAP_DESC
	else
		mode = SORT_CAP_ASC
	end
	sortSkills(mode)
end

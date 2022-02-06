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

local mode = SORT_NAME_DESC

local function createSortButton(id, parent, state, onSort)
	WindowApi.createFromTemplate(id, "SkillsLockButtonWindow", parent)
	local button = SkillsLockButtonWindow:new(
			id,
			state,
			onSort
	)
	button:setButtonTexture()
	SkillsWindow.adapter.views[id] = button
end

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
				skill.csvId,
				skill.name,
				skill.realValue,
				skill.baseValue,
				skill.cap,
				skill.state
		)
		item:initialize()
		SkillsWindow.adapter.views[item.id] = item
	end
end

local function sortSkills(sortMode)
	local list = mapSkills()
	if sortMode == SORT_NAME_DESC then
		table.sort(
				list,
				function (a, b)
					return a.name < b.name
				end
		)
	elseif sortMode == SORT_NAME_ASC then
		table.sort(
				list,
				function (a, b)
					return a.name > b.name
				end
		)
	elseif sortMode == SORT_REAL_ASC then
		table.sort(
				list,
				function (a, b)
					if a.realValue == b.realValue then
						return a.name < b.name
					else
						return a.realValue > b.realValue
					end
				end
		)
	elseif sortMode == SORT_REAL_DESC then
		table.sort(
				list,
				function (a, b)
					if a.realValue == b.realValue then
						return a.name < b.name
					else
						return a.realValue < b.realValue
					end
				end
		)
	elseif sortMode == SORT_BASE_ASC then
		table.sort(
				list,
				function (a, b)
					if a.baseValue == b.baseValue then
						return a.name < b.name
					else
						return a.baseValue > b.baseValue
					end
				end
		)
	elseif sortMode == SORT_BASE_DESC then
		table.sort(
				list,
				function (a, b)
					if a.baseValue == b.baseValue then
						return a.name < b.name
					else
						return a.baseValue < b.baseValue
					end
				end
		)
	elseif sortMode == SORT_CAP_ASC then
		table.sort(
				list,
				function (a, b)
					if a.cap == b.cap then
						return a.name < b.name
					else
						return a.cap > b.cap
					end
				end
		)
	elseif sortMode == SORT_CAP_DESC then
		table.sort(
				list,
				function (a, b)
					if a.cap == b.cap then
						return a.name < b.name
					else
						return a.cap < b.cap
					end
				end
		)
	else
		sortSkills(SORT_NAME_DESC)
	end

	clearSkills()
	addSkills(list)
end

local function onNameSort()
	if mode == SORT_NAME_ASC then
		mode = SORT_NAME_DESC
	elseif mode == SORT_NAME_DESC then
		mode = SORT_NAME_ASC
	else
		mode = SORT_NAME_ASC
	end
	sortSkills(mode)
end

local function onRealSort()
	if mode == SORT_REAL_ASC then
		mode = SORT_REAL_DESC
	elseif mode == SORT_REAL_DESC then
		mode = SORT_REAL_ASC
	else
		mode = SORT_REAL_ASC
	end
	sortSkills(mode)
end

local function onBaseSort()
	if mode == SORT_BASE_ASC then
		mode = SORT_BASE_DESC
	elseif mode == SORT_BASE_DESC then
		mode = SORT_BASE_ASC
	else
		mode = SORT_BASE_ASC
	end
	sortSkills(mode)
end

local function onCapSort()
	if mode == SORT_CAP_ASC then
		mode = SORT_CAP_DESC
	elseif mode == SORT_CAP_DESC then
		mode = SORT_CAP_ASC
	else
		mode = SORT_CAP_ASC
	end
	sortSkills(mode)
end

local function toggleButton(button, state)
	for key, value in pairs(SkillsWindow.adapter.views) do
		if string.find(key, "SortButton") then
			if key == button then
				value.canLock = false
				value.state = state
			else
				value.canLock = true
				value.state = SkillsLockButtonWindow.STATE_LOCKED
			end
			value:setButtonTexture()
		end
	end
end

local function toggleButtonTextures()
	if mode == SORT_NAME_ASC then
		toggleButton(NAME_BUTTON, SkillsLockButtonWindow.STATE_UP)
	elseif mode == SORT_NAME_DESC then
		toggleButton(NAME_BUTTON, SkillsLockButtonWindow.STATE_DOWN)
	elseif mode == SORT_REAL_ASC then
		toggleButton(REAL_BUTTON, SkillsLockButtonWindow.STATE_UP)
	elseif mode == SORT_REAL_DESC then
		toggleButton(REAL_BUTTON, SkillsLockButtonWindow.STATE_DOWN)
	elseif mode == SORT_BASE_ASC then
		toggleButton(BASE_BUTTON, SkillsLockButtonWindow.STATE_UP)
	elseif mode == SORT_BASE_DESC then
		toggleButton(BASE_BUTTON, SkillsLockButtonWindow.STATE_DOWN)
	elseif mode == SORT_CAP_ASC then
		toggleButton(CAP_BUTTON, SkillsLockButtonWindow.STATE_UP)
	elseif mode == SORT_CAP_DESC then
		toggleButton(CAP_BUTTON, SkillsLockButtonWindow.STATE_DOWN)
	end
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
	)

	createSortButton(
			NAME_BUTTON,
			"SkillsWindowNameSortWindow",
			SkillsLockButtonWindow.STATE_DOWN,
			function ()
				onNameSort()
				toggleButtonTextures()
			end
	)
	createSortButton(
			REAL_BUTTON,
			"SkillsWindowRealSortWindow",
			SkillsLockButtonWindow.STATE_LOCKED,
			function()
				onRealSort()
				toggleButtonTextures()
			end
	)
	createSortButton(
			CAP_BUTTON,
			"SkillsWindowCapSortWindow",
			SkillsLockButtonWindow.STATE_LOCKED,
			function ()
				onCapSort()
				toggleButtonTextures()
			end
	)
	createSortButton(
			BASE_BUTTON,
			"SkillsWindowBaseSortWindow",
			SkillsLockButtonWindow.STATE_LOCKED,
			function()
				onBaseSort()
				toggleButtonTextures()
			end
	)
	sortSkills(mode)
end

function SkillsWindow.ToggleSkillsWindow()
	if SkillsWindow:isShowing() then
		SkillsWindow:destroy()
	else
		CreateWindow("SkillsWindow", false)
		SkillsWindow:setShowing(true)
	end
end

function SkillsWindow.onUpdate()
	local views = SkillsWindow.adapter.views

	for i = 0, #Skills.dynamicData() - 1 do
		for _, value in pairs(views) do
			if value.csvId ~= nil and value.csvId == Skills:csvId(i) then
				value:update(
						Skills:realValue(i),
						Skills:tempValue(i),
						Skills:cap(i)
				)
			end
		end
	end
end

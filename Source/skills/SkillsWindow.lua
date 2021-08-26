SkillsWindow = ListWindow:new("SkillsWindow", true)

local SORT_NAME_ASC = 1
local SORT_NAME_DESC = 2
local SORT_REAL_ASC = 3
local SORT_REAL_DESC = 4
local SORT_BASE_ASC = 5
local SORT_BASE_DESC = 6
local SORT_CAP_ASC = 7
local SORT_CAP_DESC = 8

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
			"SkillsWindowNameLabel",
			"Name"
	):addLabel(
			"SkillsWindowRealLabel",
			"Real"
	):addLabel(
			"SkillsWindowBaseLabel",
			"Base"
	):addLabel(
			"SkillsWindowCapLabel",
			"Cap"
	)

	sortSkills(mode)
end

function SkillsWindow.ToggleSkillsWindow()
	SkillsWindow:setShowing(not SkillsWindow:isShowing())
end

function SkillsWindow.OnNameSort()
	if mode == SORT_NAME_ASC then
		sortSkills(SORT_NAME_DESC)
	else
		sortSkills(SORT_NAME_ASC)
	end
end

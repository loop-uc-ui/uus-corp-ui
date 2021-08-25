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

local function sort(mode)
	local list = Skills.dynamicData()
	if mode == SORT_NAME_DESC then
		list = Skills.list()
		table.sort(
				list,
				function (a, b)
					return a.skillName < b.skillName
				end
		)
	elseif mode == SORT_NAME_ASC then
		list = Skills.list()
		table.sort(
				list,
				function (a, b)
					return a.skillName > b.skillName
				end
		)
	elseif mode == SORT_REAL_ASC then
		table.sort(
				list,
				function (a, b)
					return a.RealSkillValue > b.RealSkillValue
				end
		)
	elseif mode == SORT_REAL_DESC then
		table.sort(
				list,
				function (a, b)
					return a.RealSkillValue < b.RealSkillValue
				end
		)
	elseif mode == SORT_BASE_ASC then
		table.sort(
				list,
				function (a, b)
					return a.TempSkillValue > b.TempSkillValue
				end
		)
	elseif mode == SORT_BASE_DESC then
		table.sort(
				list,
				function (a, b)
					return a.TempSkillValue < b.TempSkillValue
				end
		)
	elseif mode == SORT_CAP_ASC then
		table.sort(
				list,
				function (a, b)
					return a.SkillCap > b.SkillCap
				end
		)
	elseif mode == SORT_CAP_DESC then
		table.sort(
				list,
				function (a, b)
					return a.SkillCap < b.SkillCap
				end
		)
	else
		return sort(SORT_NAME_DESC)
	end

	return list
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

	local list = sort(mode)

	for i = 1, #list do
		WindowApi.createFromTemplate(
				"SkillsListItemWindow"..i,
				"SkillsListItemWindow",
				"Skills"
		)
		local item = SkillsListItemWindow:new(i)
		SkillsWindow.adapter.views[item.id] = item
		item:initialize()
	end

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
end

function SkillsWindow.ToggleSkillsWindow()
	SkillsWindow:setShowing(not SkillsWindow:isShowing())
end

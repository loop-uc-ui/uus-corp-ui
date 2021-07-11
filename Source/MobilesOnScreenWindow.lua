MobilesOnScreen = {}
MobilesOnScreen.IsInTable = {}
MobilesOnScreen.MobilesSort = {}

MobilesOnScreen.MobilesSortReverse = {}
MobilesOnScreen.NeedsUpdate = false
MobilesOnScreen.DeltaClean = 0
MobilesOnScreen.STRFilter = ""
MobilesOnScreen.DistanceSort = false
MobilesOnScreen.locked = false
MobilesOnScreen.isDirty = false
--DO NOT CHANGE
MobilesOnScreen.CappedNumServerHealthBars = 20
MobilesOnScreen.CurrentHandledCount = 0
MobilesOnScreen.ManagedMobilesList = {}
MobilesOnScreen.ManagedMobilesMap = {}
MobilesOnScreen.QueuedMobilesForDelete = {}
MobilesOnScreen.QueuedDelta = 0
MobilesOnScreen.QueuedDeltaLimit = 60

MobilesOnScreen.Mobiles = {}
MobilesOnScreen.BarsY = 55
MobilesOnScreen.BarScale = 1 
MobilesOnScreen.windowOffset = 0

MobilesOnScreen.Hidden = false
MobilesOnScreen.Filter = {}
MobilesOnScreen.Filter[1] =	GetStringFromTid(1011051)
MobilesOnScreen.Filter[2] =	GetStringFromTid(1154822)
MobilesOnScreen.Filter[3] =	GetStringFromTid(1078866)
MobilesOnScreen.Filter[4] =	GetStringFromTid(1154823)
MobilesOnScreen.Filter[5] =	GetStringFromTid(1153802)
MobilesOnScreen.Filter[6] =	GetStringFromTid(1095164)
MobilesOnScreen.Filter[7] =	GetStringFromTid(1154824)
MobilesOnScreen.Filter[8] =	GetStringFromTid(3000509)
MobilesOnScreen.Filter[9] =	GetStringFromTid(1154825)
MobilesOnScreen.Filter[10] = GetStringFromTid(1154826)
MobilesOnScreen.SavedFilter = {}

MobilesOnScreen.PetUpdateTime = 0
MobilesOnScreen.PetUpdateFreq = 1
MobilesOnScreen.ReversePet = {}

MobilesOnScreen.YellowEnabled = false
MobilesOnScreen.GreyEnabled = false
MobilesOnScreen.BlueEnabled = false
MobilesOnScreen.RedEnabled = false
MobilesOnScreen.GreenEnabled = false
MobilesOnScreen.OrangeEnabled = false

MobilesOnScreen.UnsortedWindows = 0
MobilesOnScreen.YellowWindows = 0
MobilesOnScreen.GreyWindows = 0
MobilesOnScreen.BlueWindows = 0
MobilesOnScreen.RedWindows = 0
MobilesOnScreen.GreenWindows = 0
MobilesOnScreen.OrangeWindows = 0

MobilesOnScreen.UnSorted = {}

MobilesOnScreen.MobilesYellow = {}
MobilesOnScreen.MobilesGrey = {}
MobilesOnScreen.MobilesBlue = {}
MobilesOnScreen.MobilesRed = {}
MobilesOnScreen.MobilesGreen = {}
MobilesOnScreen.MobilesOrange = {}

MobilesOnScreen.MobilesOrange = {}

MobilesOnScreen.Dockspotlocked = false

MobilesOnScreen.AnchorUpdateRequest = false
MobilesOnScreen.delta = 0
MobilesOnScreen.InUpdate = false

MobilesOnScreen.UpdateLimit = 1

MobilesOnScreen.FarmNames = {
["a dog"] = true, ["a hind"] = true, ["a boar"] = true, ["a cat"] = true, ["a bull"] = true, ["a chicken"] = true, ["a cow"] = true, ["a goat"] = true, ["a jack rabbit"] = true, 
["a pig"] = true, ["a rabbit"] = true, ["a sheep"] = true, ["a black bear"] = true, ["a brown bear"] = true, ["a cougar"] = true, ["an eagle"] = true, ["a gorilla"] = true, ["a great hart"] = true, ["a grey wolf"] = true, 
["a grizzly bear"] = true, ["a horse"] = true, ["a llama"] = true, ["a mountain goat"] = true, ["a panther"] = true, ["a timber wolf"] = true,
["a crane"] = true, ["a gaman"] = true, ["a tropical bird"] = true, ["a crow"] = true, ["a bird"] = true, ["a magpie"] = true, ["a raven"] = true, ["a squirrel"] = true, ["a ferret"] = true, ["a tern"] = true, ["a swift"] = true, ["a wren"] = true,
["a swallow"] = true, ["a warbler"] = true, ["a nuthatch"] = true, ["a chickadee"] = true, ["a thrush"] = true, ["a nightingale"] = true, ["a starling"] = true, ["a skylark"] = true, ["a finch"] = true, ["a crossbill"] = true, ["a canary"] = true,
["a sparrow"] = true, ["a towhee"] = true, ["a shrike"] = true, ["a woodpecker"] = true, ["a kingfisher"] = true, ["a plover"] = true, ["a lapwing"] = true, ["a hawk"] = true, ["a dove"] = true, ["a cuckoo"] = true, ["a skittering hopper"] = true }

MobilesOnScreen.Summons = { ["a revenant"] = true, ["an energy vortex"] = true, ["a blade spirit"] = true, ["a rising colossus"] = true, ["a nature's fury"] = true
}

MobilesOnScreen.CloseLeft = true

----------------------------------------------------------------
-- MobilesOnScreen Functions
----------------------------------------------------------------
function MobilesOnScreen.Initialize()
end

function MobilesOnScreen.Sort()
	MobilesOnScreen.CleanMobileSortCache()
end

function MobilesOnScreen.Clear()	
	local endNumber = table.getn(MobilesOnScreen.MobilesSort)
	for pos=1, endNumber do
		local mob = MobilesOnScreen.MobilesSort[pos]
		if not (MobilesOnScreen.IsPet(mob)) then
			local windowName = "MobileHealthBar_"..mob
			if (MobilesOnScreen.IsManagedMobileOnScreen(mob) and DoesWindowExist(windowName)) then
				MobilesOnScreen.RemoveHealthBar(mob)
			end
		end
	end
	
	MobileHealthBar.Forced = nil
	MobilesOnScreen.UnsortedWindows = 0
	MobilesOnScreen.YellowWindows = 0
	MobilesOnScreen.GreyWindows = 0
	MobilesOnScreen.BlueWindows = 0
	MobilesOnScreen.RedWindows = 0
	MobilesOnScreen.GreenWindows = 0
	MobilesOnScreen.OrangeWindows = 0
	
	MobilesOnScreen.UnSorted = {}
	MobilesOnScreen.MobilesYellow = {}
	MobilesOnScreen.MobilesGrey = {}
	MobilesOnScreen.MobilesBlue = {}
	MobilesOnScreen.MobilesRed = {}
	MobilesOnScreen.MobilesGreen = {}
	MobilesOnScreen.MobilesOrange = {}
end

function MobilesOnScreen.IsPet(mobileId)
	return IsObjectIdPet(mobileId)	
end

function MobilesOnScreen.IsFarm(name)
	if (name == nil or name == L"" or name == "") then
		return false
	end
	local convName = string.gsub(WStringToString(name), "^%s*(.-)%s*$", "%1")
	convName = string.lower(convName)
	if (MobilesOnScreen.FarmNames[convName]) then
		return true
	end
	return false
end

function MobilesOnScreen.IgnoredMobile(name)
	if (name == nil or name == L"" or name == "") then
		return true
	end

	return wstring.find(name, L"A Mannequin") ~= nil or wstring.find(name, L"The Parrot") ~= nil
end

function MobilesOnScreen.IsSummon(name, mobileId)
	if (name == nil or name == L"" or name == "") then
		return false
	end
	if type(name) == "wstring" then 
		name = WStringToString(name)
	end
	if name and mobileId then
		if MobilesOnScreen.IsPet(mobileId) then --only for personal summons			
			local summonNameFix = string.gsub(name, "^%s*(.-)%s*$","%1")
			summonNameFix = string.lower(summonNameFix)
			if summonNameFix == "a revenant" then
				if Interface.LastSpell ~= 114 then 
					return false
				end				
			elseif summonNameFix == "an energy vortex" then	
				if Interface.LastSpell ~= 58 then 
					return false
				end
			elseif summonNameFix == "a blade spirit" then	
				if Interface.LastSpell ~= 33 then 
					return false
				end
			elseif summonNameFix == "an earth elemental" then
				if Interface.LastSpell ~= 62 then 
					return false
				end
			elseif summonNameFix == "an air elemental" then
				if Interface.LastSpell ~= 60 then 
					return false
				end	
			elseif summonNameFix == "a water elemental" then
				if Interface.LastSpell ~= 64 then 
					return false
				end	
			elseif summonNameFix == "a fire elemental" then	
				if Interface.LastSpell ~= 63 then 
					return false
				end
			elseif summonNameFix == "a rising colossus" then	
				if Interface.LastSpell ~= 693 then 
					return false
				end
			elseif summonNameFix == "an animated weapon" then
				if Interface.LastSpell ~= 684 then 
					return false
				end
			
			elseif summonNameFix == "a nature's fury" then	
				if Interface.LastSpell ~= 606 then 
					return false
				end			
			elseif summonNameFix == "an imp"  then	
				if Interface.LastSpell ~= 608 then 
					return false
				end		
			end	
			if not CreaturesDB.SummonTimes[summonNameFix] or Interface.LastSpell == 40 then
				if Interface.LastSpell == 607 then
					if (CreaturesDB.IsPixie(summonNameFix)) then
						summonNameFix="fey"
					end
				end				
				if Interface.LastSpell == 40 then
					summonNameFix="summon creature"
				end				
				if Interface.LastSpell == 61 then
					if (CreaturesDB.IsDaemon(summonNameFix)) and not CreaturesDB.SummonTimes[summonNameFix] then
						summonNameFix="daemon"
					end
				end				
				local PlayerName = tostring(wstring.lower(wstring.trim(WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName)))
				local props = ItemProperties.GetObjectProperties( mobileId, nil, "Mobiles on screen - check summon")
				if Interface.LastSpell == 508 then
					if string.find(PlayerName, summonNameFix) and (not props or #props == 1) and not CreaturesDB.SummonTimes[summonNameFix] then
						summonNameFix = "mirror image"
					end
				end
				if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
					local taliId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][12].slotId
					if taliId ~= 0 and Interface.LastItem == taliId then
						if not string.find(PlayerName, summonNameFix) and (not props or #props == 1) and not CreaturesDB.SummonTimes[summonNameFix]  then
							summonNameFix = "talisman summon"
						end
					end
				end				
			end
			if CreaturesDB.SummonTimes[summonNameFix] then
				return true, summonNameFix
			end
		end
	end
	local convName
	if (type(name) == "wstring") then
		convName =string.gsub(tostring(name), "^%s*(.-)%s*$", "%1")
	else
		convName =string.gsub(name, "^%s*(.-)%s*$", "%1")
	end
	convName = string.lower(convName)
				
	if (MobilesOnScreen.Summons[convName]) then
		return true, convName
	end
	return false
end

function MobilesOnScreen.RemoveFromMobilesSort(mobileId)
	local index = MobilesOnScreen.MobilesSortReverse[mobileId]		
	if index ~= nil then
		--Debug.Print("Removing : "..mobileId.." Index: "..index)		
		table.remove(MobilesOnScreen.MobilesSort, index)
		MobilesOnScreen.MobilesSortReverse[mobileId] = nil
	end
end

function MobilesOnScreen.SortByDistance()	
	local pos = 1
	local endNumber = table.getn(MobilesOnScreen.MobilesSort)	
	while pos < endNumber do		
		if (pos == 1 or GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[pos]) >= GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[pos-1])) then
			pos = pos + 1
		else
			local swap = MobilesOnScreen.MobilesSort[pos]
			MobilesOnScreen.MobilesSort[pos] = MobilesOnScreen.MobilesSort[pos-1]
			MobilesOnScreen.MobilesSort[pos-1] = swap
			pos = pos - 1
		end
	end	
end

function MobilesOnScreen.HidePet()
	local windowName = "MobilesOnScreenWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	WindowSetAlpha(hideName .. "ShowButton",0.5)
	WindowSetAlpha(hideName .. "ShowButtonR",0.5)
	
	WindowSetShowing(showName, false)
	WindowSetShowing(hideName, true)
	
	SnapUtils.SnappableWindows[showName] = nil
	
	MobilesOnScreen.Hidden = true
	Interface.SaveBoolean( "MobilesOnScreenWindowVisible", false )
	
	if (not MobilesOnScreen.GetVisible()) then
		MobilesOnScreen.Clear()
	else
		for mob, _ in pairs(MobileHealthBar.Handled) do
			if not (MobilesOnScreen.IsPet(mob)) then
				if (MobilesOnScreen.UnSorted[mob] and MobilesOnScreen.IsManagedMobileOnScreen(mob)) then
					MobilesOnScreen.RemoveHealthBar(mob)
					MobilesOnScreen.UnSorted[mob] = nil
					MobilesOnScreen.UnsortedWindows = MobilesOnScreen.UnsortedWindows -1
				end
			end
		end		
		MobilesOnScreen.UpdateAnchors()
	end
end

function MobilesOnScreen.AddMobileOnScreenCount(mobileId)
	local index = MobilesOnScreen.ManagedMobilesMap[mobileId]
	if(index == nil)then
		table.insert(MobilesOnScreen.ManagedMobilesList,mobileId)		
		MobilesOnScreen.ManagedMobilesMap[mobileId] = table.getn(MobilesOnScreen.ManagedMobilesList)
	end
end

function MobilesOnScreen.RemoveMobileOnScreenCount(mobileId)
	local index = MobilesOnScreen.ManagedMobilesMap[mobileId]
	if(index ~= nil)then
		table.remove(MobilesOnScreen.ManagedMobilesList,index)
		MobilesOnScreen.ManagedMobilesMap[mobileId] = nil	
	end
end

function MobilesOnScreen.IsManagedMobileOnScreen(mobileId)
	if(MobileHealthBar.Handled[mobileId] ~= true) then
		return true
	else
		return false
	end
end

function MobilesOnScreen.CleanMobileSortCache()	
	MobilesOnScreen.MobilesSort = {}
	MobilesOnScreen.MobilesSortReverse = {}
	local mobileTargetList = GetAllMobileTargets();	
	if( mobileTargetList == nil ) then
		return
	end
	for _, mobileId in pairs(mobileTargetList) do
		if not (MobilesOnScreen.IsPet(mobileId)) then
			local data = WindowData.MobileName[mobileId]
			if(data and data.MobName ~= nil) then
				if (WindowData.PlayerStatus.PlayerId ~= mobileId and MobilesOnScreen.GetVisible() and not HealthBarManager.IsPartyMember(mobileId)) then
					if (MobilesOnScreen.MobilesSortReverse[mobileId] == nil) then
						table.insert(MobilesOnScreen.MobilesSort, mobileId)
						MobilesOnScreen.MobilesSortReverse[mobileId] = table.getn(MobilesOnScreen.MobilesSort)
					end
					MobilesOnScreen.isDirty = true
				end
			end
		end
	end	
end

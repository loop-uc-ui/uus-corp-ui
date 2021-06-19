TargetWindow = ListWindow:new("TargetWindow", false)

local adapter = TargetWindow.adapter

TargetWindow.TargetId = 0
TargetWindow.HasTarget = false
TargetWindow.TargetType = 0
TargetWindow.MobileType = 2
TargetWindow.ObjectType = 3
TargetWindow.CorpseType = 4

TargetWindow.Delta = 0
TargetWindow.DeltaC = 0

TargetWindow.CurrentCreature = nil

TargetWindow.RegisterTime = {}
TargetWindow.PreviousTargets = {}

TargetWindow.KnownPlayers = {} 
TargetWindow.KnownTamable = {}

function TargetWindow.Initialize()
	adapter:addStatusBar(
			"TargetWindowHealthBar",
			100,
			0,
			Colors.Red
	)
	WindowDataApi.registerData(CurrentTarget.dataType(), 0)
	TargetWindow.eventRegister:registerEventHandler(
			CurrentTarget.event(),
			"TargetWindow.UpdateTarget"
	):registerEventHandler(
			WindowData.MobileStatus.Event,
			"TargetWindow.MobileStatusUpdate"
	):registerEventHandler(
			WindowData.MobileName.Event,
			"TargetWindow.HandleUpdateNameEvent"
	):registerEventHandler(
			WindowData.HealthBarColor.Event,
			"TargetWindow.HandleTintHealthBarEvent"
	)
	WindowUtils.RestoreWindowPosition(TargetWindow.id)
	if CurrentTarget.id() ~= 0 then
		EventApi.broadcast(CurrentTarget.event())
	end
end

function TargetWindow.Shutdown()
	TargetWindow.ClearPreviousTarget()
	WindowDataApi.unregisterData(CurrentTarget.dataType(), 0)
	WindowUtils.SaveWindowPosition(TargetWindow.id)
end

local function unregister()
	WindowDataApi.unregisterData(WindowData.MobileName.Type, CurrentTarget.id())
	WindowDataApi.unregisterData(WindowData.MobileStatus.Type, CurrentTarget.id())
	WindowDataApi.unregisterData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
end

function TargetWindow.ClearPreviousTarget()
	if( TargetWindow.HasTarget == true ) then
		WindowSetShowing("TargetWindow",false)
		if(TargetWindow.TargetType == TargetWindow.MobileType) then
			if WindowData.PlayerStatus.PlayerId ~= TargetWindow.TargetId and not MobileHealthBar.HasWindow(TargetWindow.TargetId) then
				UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
			end
			TargetWindow.RegisterTime[TargetWindow.TargetId] = nil
			local max = table.getn(TargetWindow.PreviousTargets)
			if (TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId) then
				table.insert(TargetWindow.PreviousTargets,TargetWindow.TargetId) 
			end
		end
		LabelSetText("TargetWindowName", L"")
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		TargetWindow.TargetType = 0
	end
end	

function TargetWindow.UnregisterPreviousTargetData()
	--If previous target was a mobile unregister data with the previous target
	if( TargetWindow.HasTarget == true) then
		if(TargetWindow.TargetType == TargetWindow.MobileType) then
			if WindowData.PlayerStatus.PlayerId ~= TargetWindow.TargetId and not MobileHealthBar.HasWindow(TargetWindow.TargetId) then
--				Debug.Print("TargetWindow.UnregisterPreviousTargetData")
				UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)	
				UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
			end
			TargetWindow.RegisterTime[TargetWindow.TargetId] = nil
		end
	end
end

function TargetWindow.UpdateMobile()
	if( TargetWindow.HasTarget == false or
	(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
				
		--Update the local targetType as a mobile type
		TargetWindow.TargetType = TargetWindow.MobileType
		WindowSetShowing("TargetWindow",true)

--		Debug.Print("TargetWindow.UpdateMobile")
		RegisterWindowData(WindowData.MobileName.Type, WindowData.CurrentTarget.TargetId)
		RegisterWindowData(WindowData.MobileStatus.Type,WindowData.CurrentTarget.TargetId)
		RegisterWindowData(WindowData.HealthBarColor.Type,WindowData.CurrentTarget.TargetId)
		TargetWindow.UpdateStatus(WindowData.CurrentTarget.TargetId)	
		TargetWindow.UpdateName(WindowData.CurrentTarget.TargetId)	
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
		TargetWindow.TintHealthBar(WindowData.CurrentTarget.TargetId)
		TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] = Interface.TimeSinceLogin
		
		local name = CreaturesDB.GetName(WindowData.CurrentTarget.TargetId)
		TargetWindow.CurrentCreature = CreaturesDB[name]
	end
	local max = table.getn(TargetWindow.PreviousTargets)
	if (TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId) then
		table.insert(TargetWindow.PreviousTargets,TargetWindow.TargetId) 
	end
end

function TargetWindow.UpdateTarget()
	if CurrentTarget.isMobile() then
		TargetWindow.UpdateMobile()
	else
		TargetWindow.ClearPreviousTarget()
	end
	TargetWindow.HasTarget = CurrentTarget.hasTarget() and not CurrentTarget.isCorpse() and not CurrentTarget.isObject()
end

function TargetWindow.MobileStatusUpdate()
    TargetWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateStatus(targetId)	
	if( targetId == WindowData.CurrentTarget.TargetId ) then
		local mobileData = Interface.GetMobileData(targetId, true)
		if not mobileData then
			return
		end
		StatusBarSetCurrentValue( "TargetWindowHealthBar", mobileData.CurrentHealth )	
		StatusBarSetMaximumValue( "TargetWindowHealthBar", mobileData.MaxHealth )			
		if( mobileData.IsDead ) then
		    LabelSetText("TargetWindowHits", StringToWString("Health: 0%"))
		else
			HotbarSystem.CurrentTargLife = 100
			if(TargetWindow.TargetType == TargetWindow.MobileType and IsHealthBarEnabled(targetId) and IsMobile(targetId)) then
				
				local data = WindowData.MobileName[targetId]
				if not data then
					UnregisterWindowData(WindowData.MobileName.Type, targetId)
					RegisterWindowData(WindowData.MobileName.Type, targetId)
				end
				if ( data ~= nil ) then
					if (data.Notoriety+1 < 8) then
						local curr = mobileData.CurrentHealth 
						local max = mobileData.MaxHealth 
						local perc = (curr/max)*100
						if (tostring(perc) == "-1.#IND") then
							perc = 0
							if Interface.TimeSinceLogin >= TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] + 0.2 then								
								UnregisterWindowData(WindowData.MobileStatus.Type, WindowData.CurrentTarget.TargetId)
								TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] = Interface.TimeSinceLogin
								return
							end
						end
						HotbarSystem.CurrentTargLife = perc
						perc = math.floor(perc)
						local gb = math.floor(2.55 * perc)
						LabelSetTextColor("TargetWindowHits", 255, gb, gb)
						LabelSetText("TargetWindowHits", StringToWString("Health: " .. tostring(perc) .. "%"))
					else
						LabelSetText("TargetWindowHits", L">>" .. wstring.upper(GetStringFromTid(3000509)) .. L"<<")
						
						LabelSetTextColor("TargetWindowHits", 255, 255, 0)
					end	
				end
			end
		end
	end
end

function TargetWindow.HandleUpdateNameEvent()
    TargetWindow.UpdateName(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateName(targetId)	
	if(targetId ~= nil and targetId == WindowData.CurrentTarget.TargetId ) then
		LabelSetText("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].MobName)
		
		local noto = WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1
		if (targetId == Interface.CurrentHonor) then
			noto = {r=163, g=73, b=164}
			LabelSetTextColor("TargetWindowName", noto.r, noto.g, noto.b)
		else
			NameColor.UpdateLabelNameColor("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1)
		end
	end
end

function TargetWindow.HandleTintHealthBarEvent()
    TargetWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function TargetWindow.TintHealthBar(mobileId)
	if( mobileId == WindowData.CurrentTarget.TargetId ) then
		local windowTintName = "TargetWindowHealthBar"
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

--When players double clice on the target window, send a request object use packet
function TargetWindow.OnItemDblClicked()
	if IsMobile(TargetWindow.TargetId) then
		local mobileId = TargetWindow.TargetId
		if  IsBanker( mobileId ) then
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenBankbox)
		elseif IsVendor( mobileId ) then
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.VendorBuy)
		elseif IsOldQuestGiver( mobileId ) then
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.NPCTalk)
		else
			UserActionUseItem(mobileId,false)
		end
	else
		UserActionUseItem(TargetWindow.TargetId,false)
	end
end

function TargetWindow.OnRClick()
	RequestContextMenu(TargetWindow.TargetId)
end

function TargetWindow.OnLClick()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.CurrentTarget.TargetId)
	else
		--Let the targeting manager handle single left click on the target
		HandleSingleLeftClkTarget(WindowData.CurrentTarget.TargetId)
	end
end

function TargetWindow.OnMoveStart()
	WindowSetMoving("TargetWindow", true)
	SnapUtils.StartWindowSnap("TargetWindow")
end
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

StatusWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

StatusWindow.CurPlayerId = 0


StatusWindow.Skills={
[1] = { sop=false, TCName =L"alchemy" },
[2] = { sop=true, TCName =L"anatomy" },
[3] = { sop=true, TCName =L"animallore" },
[4] = { sop=true, TCName =L"animaltaming" },
[5] = { sop=true, TCName =L"archery" },
[6] = { sop=false, TCName =L"armslore" },
[7] = { sop=false, TCName =L"begging" },
[8] = { sop=true, TCName =L"blacksmith" },
[9] = { sop=true, TCName =L"bushido" },
[10] = { sop=false, TCName =L"camping" },
[11] = { sop=false, TCName =L"carpentry" },
[12] = { sop=false, TCName =L"cartography" },
[13] = { sop=true, TCName =L"chivalry" },
[14] = { sop=false, TCName =L"cooking" },
[15] = { sop=false, TCName =L"detecthidden" },
[16] = { sop=true, TCName =L"discordance" },
[17] = { sop=true, TCName =L"evalint" },
[18] = { sop=true, TCName =L"fencing" },
[19] = { sop=true, TCName =L"fishing" },
[20] = { sop=false, TCName =L"fletching" },
[21] = { sop=true, TCName =L"focus" },
[22] = { sop=false, TCName =L"forensics" },
[23] = { sop=true, TCName =L"healing" },
[24] = { sop=false, TCName =L"herding" },
[25] = { sop=false, TCName =L"hiding" },
[26] = { sop=true, TCName =L"imbuing" },
[27] = { sop=false, TCName =L"inscribe" },
[28] = { sop=false, TCName =L"itemid" },
[29] = { sop=false, TCName =L"lockpicking" },
[30] = { sop=false, TCName =L"lumberjacking" },
[31] = { sop=true, TCName =L"macing" },
[32] = { sop=true, TCName =L"magery" },
[33] = { sop=true, TCName =L"magicresist" },
[34] = { sop=true, TCName =L"meditation" },
[35] = { sop=false, TCName =L"mining" },
[36] = { sop=true, TCName =L"musicianship" },
[37] = { sop=true, TCName =L"mysticism" },
[38] = { sop=true, TCName =L"necromancy" },
[39] = { sop=true, TCName =L"ninjitsu" },
[40] = { sop=true, TCName =L"parry" },
[41] = { sop=true, TCName =L"peacemaking" },
[42] = { sop=false, TCName =L"poisoning" },
[43] = { sop=true, TCName =L"provocation" },
[44] = { sop=false, TCName =L"removetrap" },
[45] = { sop=false, TCName =L"snooping" },
[46] = { sop=true, TCName =L"spellweaving" },
[47] = { sop=true, TCName =L"spiritspeak" },
[48] = { sop=true, TCName =L"stealing" },
[49] = { sop=true, TCName =L"stealth" },
[50] = { sop=true, TCName =L"swords" },
[51] = { sop=true, TCName =L"tactics" },
[52] = { sop=true, TCName =L"tailoring" },
[53] = { sop=false, TCName =L"tasteid" },
[54] = { sop=true, TCName =L"throwing" },
[55] = { sop=false, TCName =L"tinkering" },
[56] = { sop=false, TCName =L"tracking" },
[57] = { sop=true, TCName =L"veterinary" },
[58] = { sop=true, TCName =L"wrestling" },
}

StatusWindow.Notoriety = { NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK =4, CRIMINAL=5, ENEMY=6, MURDERER=7, INVULNERABLE=8 }

StatusWindow.TextColors = {}
StatusWindow.TextColors[StatusWindow.Notoriety.NONE]         = { r=225, g=225, b=225 } --- GREY/SYS
StatusWindow.TextColors[StatusWindow.Notoriety.INNOCENT]     = { r=0, g=130, b=255 } --- BLUE
StatusWindow.TextColors[StatusWindow.Notoriety.FRIEND]       = { r=0 ,  g=255, b=0   } --- GREEN 
StatusWindow.TextColors[StatusWindow.Notoriety.CANATTACK]    = { r=70, g=70, b=70 } --- GREY/SYS
StatusWindow.TextColors[StatusWindow.Notoriety.CRIMINAL]     = { r=70, g=70, b=70 } --- GREY/SYS
StatusWindow.TextColors[StatusWindow.Notoriety.ENEMY]        = { r=242, g=159, b=77  } --- ORANGE
StatusWindow.TextColors[StatusWindow.Notoriety.MURDERER]     = { r=255, g=0,  b=0  } --- RED  
StatusWindow.TextColors[StatusWindow.Notoriety.INVULNERABLE] = { r=255, g=255, b=0   } --- YELLOW 


StatusWindow.Locked = false
StatusWindow.HPLocked = false
StatusWindow.MANALocked = false
StatusWindow.STAMLocked = false

StatusWindow.DisableDelta = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function StatusWindow.Initialize(reinit)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)
	RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
	RegisterWindowData(WindowData.Paperdoll.Type, WindowData.PlayerStatus.PlayerId)
	
	if not reinit then
		WindowRegisterEventHandler( "StatusWindow", WindowData.PlayerStatus.Event, "StatusWindow.UpdateStatus")
	end
	
	StatusWindow.UpdateStatus()
	StatusWindow.ToggleStrLabel()
	-- TODO: Once someone fixes the baseline alignment of the various fonts (so that English isn't 3 pixels above every other language), remove this hack.
	-- START HACK
	if GetStringFromTid( 1011036 ) ~= L"OKAY" then -- assume not English
		local healthLabelName = "StatusWindowHealthTooltip"
		local manaLabelName = "StatusWindowManaTooltip"
		local staminaLabelName = "StatusWindowStaminaTooltip"
		local healthBarName = "StatusWindowHealthBar"
		local manaBarName = "StatusWindowManaBar"
		local staminaBarName = "StatusWindowStaminaBar"
		WindowClearAnchors( healthLabelName )
		WindowClearAnchors( manaLabelName )
		WindowClearAnchors( staminaLabelName )
		WindowAddAnchor( healthLabelName, "top", healthBarName, "top", 0, -6 )
		WindowAddAnchor( manaLabelName, "top", manaBarName, "top", 0, -6 )
		WindowAddAnchor( staminaLabelName, "top", staminaBarName, "top", 0, -6 )
	end	
	-- END HACK
	WindowUtils.RestoreWindowPosition("StatusWindow")
	WindowUtils.LoadScale("StatusWindow")
	
	WindowSetShowing("StatusWindowGuardsButton", true)
	
	Interface.StatusWindowStyle = Interface.LoadNumber( "StatusWindowStyle", Interface.StatusWindowStyle )
	StatusWindow.Locked = Interface.LoadBoolean( "StatusWindowLocked", StatusWindow.Locked )
	local this = "StatusWindow"
	local texture = "UO_Core"
	if ( StatusWindow.Locked  ) then		
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end
	
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_NORMAL, "arrowdown", 0, 0)
	ButtonSetTexture("StatusWindowMenu",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowdown", 22, 0)
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED, "arrowdown", 22, 0) 
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowdown", 22, 0)
	
	local w, h = WindowGetDimensions("StatusWindowLagBar")
	WindowSetDimensions("StatusWindowLagBar", w+1, h)
	WindowSetDimensions("StatusWindowLagBar", w, h)
	
	WindowSetTintColor("StatusWindowLagBar", 0, 255, 0)

	if DoesWindowNameExist("GlowingEffectHealth") then
		DestroyWindow("GlowingEffectHealth")
	end
	local noto =  1
	if (not DoesWindowNameExist("GlowingEffectHealth") and Interface.StatusWindowStyle == 0) then		
		if WindowData.MobileName[WindowData.PlayerStatus.PlayerId] then
			noto = tonumber(WindowData.MobileName[WindowData.PlayerStatus.PlayerId].Notoriety+1)
		end		
		CreateWindowFromTemplate("GlowingEffectHealth", "StatusTEXTs", "StatusWindow")
		CreateWindowFromTemplate("GlowingEffectAnimHealth", "StatusGlowingEffect", "GlowingEffectHealth")
		WindowClearAnchors("GlowingEffectHealth")
		WindowAddAnchor("GlowingEffectHealth", "center", "StatusWindowPortraitBg", "center", 14, 12)
		WindowSetScale("GlowingEffectHealth", WindowGetScale("StatusWindow"))		
		AnimatedImageStartAnimation( "GlowingEffectAnimHealth", 1, true, false, 0.0 )		
		AnimatedImageSetPlaySpeed( "GlowingEffectAnimHealth", 10)
		WindowSetTintColor("GlowingEffectAnimHealth",StatusWindow.TextColors[noto].r,StatusWindow.TextColors[noto].g,StatusWindow.TextColors[noto].b)
	end

	StatusWindow.HPLocked = Interface.LoadBoolean( "StatusWindowHPLocked", StatusWindow.HPLocked )
	StatusWindow.MANALocked = Interface.LoadBoolean( "StatusWindowMANALocked", StatusWindow.MANALocked )
	StatusWindow.STAMLocked = Interface.LoadBoolean( "StatusWindowSTAMLocked", StatusWindow.STAMLocked )
	StatusWindow.ToggleStrLabel()
	StatusWindow.ToggleButtons()
end

function StatusWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowUtils.SaveWindowPosition("StatusWindow")
	if (DoesWindowNameExist("TCTOOLSWindow")) then
		SnapUtils.SnappableWindows["TCTOOLSWindow"] = false
		WindowUtils.SaveWindowPosition("TCTOOLSWindow")
	end
end

function StatusWindow.Latency_OnMouseOver()
	if Interface.Latency then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, ReplaceTokens(GetStringFromTid(1155254), {towstring(Interface.Latency.lag).. L"ms", towstring(Interface.Latency.ploss) } ))
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end
end

function StatusWindow.LockTooltip()
	if ( StatusWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155250))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155251))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.Lock()
	StatusWindow.Locked = not StatusWindow.Locked 
	Interface.SaveBoolean( "StatusWindowLocked", StatusWindow.Locked  )
	
	local this = "StatusWindow"	
	local texture = "UO_Core"
	if ( StatusWindow.Locked  ) then		
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end
end

function StatusWindow.LockTooltipHP()
	if ( StatusWindow.HPLocked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155255))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155256))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.LockHP()
	StatusWindow.HPLocked = not StatusWindow.HPLocked 
	Interface.SaveBoolean( "StatusWindowHPLocked", StatusWindow.HPLocked  )
end

function StatusWindow.LockTooltipMANA()
	if ( StatusWindow.MANALocked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155257))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155258))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.LockMANA()
	StatusWindow.MANALocked = not StatusWindow.MANALocked 
	Interface.SaveBoolean( "StatusWindowMANALocked", StatusWindow.MANALocked  )
end

function StatusWindow.LockTooltipSTAM()
	if ( StatusWindow.STAMLocked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155259))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155260))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.LockSTAM()
	StatusWindow.STAMLocked = not StatusWindow.STAMLocked 
	Interface.SaveBoolean( "StatusWindowSTAMLocked", StatusWindow.STAMLocked  )
end

function StatusWindow.MenuTooltip()
	
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155252))
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.Menu()
	RequestContextMenu(WindowData.PlayerStatus.PlayerId, true)
end

function StatusWindow.UpdateLatency()
	local w, h = WindowGetDimensions("StatusWindowLagBar")

	StatusWindow.alternate = not StatusWindow.alternate
	local hue = {r=0,g=255,b=0}
	if Interface.Latency.lag < 250 then
		h = 52
	elseif Interface.Latency.lag < 650 then
		hue = {r=255,g=255,b=0}
		h = 28
	else
		hue = {r=255,g=0,b=0}
		h = 14
	end

	WindowSetTintColor("StatusWindowLagBar", hue.r, hue.g, hue.b)
	WindowSetDimensions("StatusWindowLagBar", w+1, h)
	WindowSetDimensions("StatusWindowLagBar", w, h)
end

StatusWindow.TempDisabled = false

function StatusWindow.ClickOutside()
	StatusWindow.TempDisabled = true
end

function StatusWindow.EnableInput(timePassed)
	if StatusWindow.TempDisabled then
		StatusWindow.DisableDelta = StatusWindow.DisableDelta + timePassed
		if StatusWindow.DisableDelta > 1 then
			StatusWindow.TempDisabled = false
			StatusWindow.DisableDelta = 0
		end
	end
end

function StatusWindow.UpdateStatus()
	--Debug.PrintToDebugConsole(L"UPDATING STATUS")
	if WindowData.PlayerStatus.PlayerId == 0 then
		return
	end
	StatusBarSetMaximumValue( "StatusWindowHealthBar", WindowData.PlayerStatus.MaxHealth )
	StatusBarSetMaximumValue( "StatusWindowManaBar", WindowData.PlayerStatus.MaxMana )
	StatusBarSetMaximumValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.MaxStamina )
	StatusBarSetCurrentValue( "StatusWindowHealthBar", WindowData.PlayerStatus.CurrentHealth )
	StatusBarSetCurrentValue( "StatusWindowManaBar", WindowData.PlayerStatus.CurrentMana )
	StatusBarSetCurrentValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.CurrentStamina )

	if (not Interface.AuraEnabled and DoesWindowNameExist("GlowingEffectAnimHealth")) then
		DestroyWindow("GlowingEffectAnimHealth")
	end
	--Colors the health bar to the correct color
	HealthBarColor.UpdateHealthBarColor("StatusWindowHealthBar", WindowData.PlayerStatus.VisualStateId)
	--Update label tooltip health, mana, and stamina
	StatusWindow.UpdateLabelContent()
	
	UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
	RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
	
	
	if WindowData.MobileName[WindowData.PlayerStatus.PlayerId] and DoesWindowNameExist("GlowingEffectAnimHealth") then
		local noto = tonumber(WindowData.MobileName[WindowData.PlayerStatus.PlayerId].Notoriety+1)
		WindowSetTintColor("GlowingEffectAnimHealth",StatusWindow.TextColors[noto].r,StatusWindow.TextColors[noto].g,StatusWindow.TextColors[noto].b)
	end

	if( SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId] ~= nil) then
	
		local textureData = SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId]	
		
		local x, y, scale
		if textureData.IsLegacy == 1 then
			x, y = -88, 10
			scale = 1.75
		else
			x, y = -11, -191
			scale = 0.75
		end
		
		local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, true)

		if IsPlayerDead() then
			WindowSetShowing("StatusWindowPortrait", false)
			WindowSetShowing("StatusWindowDead", true)
			CircleImageSetTexture("StatusWindowDead","dead",-32,-30)
		elseif mobileData then
			WindowSetShowing("StatusWindowPortrait", true)
			WindowSetShowing("StatusWindowDead", false)
			if mobileData.Gender == 1 then
				if mobileData.Race == PaperdollWindow.GARGOYLE then
					CircleImageSetTexture("StatusWindowPortrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset + 8, y - textureData.yOffset - 22 )
					CircleImageSetTextureScale("StatusWindowPortrait", InterfaceCore.scale * scale - 0.2)
				else
					CircleImageSetTexture("StatusWindowPortrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset + 8, y - textureData.yOffset - 18 )
					CircleImageSetTextureScale("StatusWindowPortrait", InterfaceCore.scale * scale)
				end
			else
				if mobileData.Race == PaperdollWindow.ELF then
					CircleImageSetTexture("StatusWindowPortrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset - 3, y - textureData.yOffset - 5 )
					CircleImageSetTextureScale("StatusWindowPortrait", InterfaceCore.scale * scale - 0.1)
				else
					CircleImageSetTexture("StatusWindowPortrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset - 3, y - textureData.yOffset - 5 )
					CircleImageSetTextureScale("StatusWindowPortrait", InterfaceCore.scale * scale)
				end
			end
		end
		StatusWindow.CurPlayerId = WindowData.PlayerStatus.PlayerId
	end
end

function StatusWindow.OnLButtonUp()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(StatusWindow.CurPlayerId)
	else
		WindowSetMoving("StatusWindow",false)
		HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
	end
end

function StatusWindow.OnLButtonDown()

	if (not StatusWindow.Locked ) then
		SnapUtils.StartWindowSnap("StatusWindow")
		WindowSetMoving("StatusWindow",true)
	else
		WindowSetMoving("StatusWindow",false)
	end

end

function StatusWindow.OnHPLButtonUp()
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnHPLButtonDown()

end

function StatusWindow.OnMLANAButtonUp()
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnMANALButtonDown()

end

function StatusWindow.OnSTAMLButtonUp()
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnSTAMLButtonDown()

end


function StatusWindow.GuardsButton_OnLButtonUp()
	SendChat( _channel, L"/say Guards ! Help Me !!!" )
end

function StatusWindow.GuardsButton_OnMouseOver()

	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = 1234,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	GetStringFromTid(1155253),
						body = L""}
						
	ItemProperties.SetActiveItem(itemData)
	PartyHealthBar.mouseOverId = StatusWindow.CurPlayerId
end

function StatusWindow.OnRButtonUp()
	RequestContextMenu(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.UpdateLabelContent()
	local healthLabelName = "StatusWindowHealthTooltip"
	local manaLabelName = "StatusWindowManaTooltip"
	local staminaLabelName = "StatusWindowStaminaTooltip"
	local healthStr = L""..WindowData.PlayerStatus.CurrentHealth..L"/"..WindowData.PlayerStatus.MaxHealth
	local manaStr = WindowData.PlayerStatus.CurrentMana..L"/"..WindowData.PlayerStatus.MaxMana
	local staminaStr = WindowData.PlayerStatus.CurrentStamina..L"/"..WindowData.PlayerStatus.MaxStamina
	--local statStr = healthStr..L"<BR>"..manaStr..L"<BR>"..staminaStr
	LabelSetText(healthLabelName, WindowUtils.translateMarkup(healthStr))
	LabelSetText(manaLabelName, WindowUtils.translateMarkup(manaStr))
	LabelSetText(staminaLabelName, WindowUtils.translateMarkup(staminaStr))
end

function StatusWindow.OnMouseOver()
	local itemData =
	{
		windowName = "ActionsWindow",
		itemId = StatusWindow.CurPlayerId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)	

	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing("StatusWindowHealthTooltip", true)
		WindowSetShowing("StatusWindowManaTooltip", true)
		WindowSetShowing("StatusWindowStaminaTooltip", true)
	end
end

function StatusWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()

	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing("StatusWindowHealthTooltip", false)
		WindowSetShowing("StatusWindowManaTooltip", false)
		WindowSetShowing("StatusWindowStaminaTooltip", false)
	end
end

function StatusWindow.ToggleStrLabel()
	WindowSetShowing("StatusWindowHealthTooltip", SystemData.Settings.GameOptions.showStrLabel)
	WindowSetShowing("StatusWindowManaTooltip", SystemData.Settings.GameOptions.showStrLabel)
	WindowSetShowing("StatusWindowStaminaTooltip", SystemData.Settings.GameOptions.showStrLabel)
end

function StatusWindow.OnMouseDlbClk()
    UserActionUseItem(StatusWindow.CurPlayerId,false)
end

function StatusWindow.TCTools()
	subMenu = {
			{ str = GetStringFromTid(1154884),flags=0,returnCode="str",pressed=false },
			{ str = GetStringFromTid(1154885),flags=0,returnCode="dex",pressed=false},
			{ str = GetStringFromTid(1154886),flags=0,returnCode="int",pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154883),0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[7].NameTid),flags=0,returnCode=7,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[22].NameTid),flags=0,returnCode=22,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[28].NameTid),flags=0,returnCode=28,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[53].NameTid),flags=0,returnCode=53,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154889),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[2].NameTid),flags=0,returnCode=2,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[5].NameTid),flags=0,returnCode=5,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[18].NameTid),flags=0,returnCode=18,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[21].NameTid),flags=0,returnCode=21,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[23].NameTid),flags=0,returnCode=23,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[31].NameTid),flags=0,returnCode=31,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[40].NameTid),flags=0,returnCode=40,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[50].NameTid),flags=0,returnCode=50,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[51].NameTid),flags=0,returnCode=51,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[58].NameTid),flags=0,returnCode=58,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[54].NameTid),flags=0,returnCode=54,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154890),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[1].NameTid),flags=0,returnCode=1,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[6].NameTid),flags=0,returnCode=6,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[8].NameTid),flags=0,returnCode=8,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[11].NameTid),flags=0,returnCode=11,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[12].NameTid),flags=0,returnCode=12,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[14].NameTid),flags=0,returnCode=14,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[20].NameTid),flags=0,returnCode=20,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[27].NameTid),flags=0,returnCode=27,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[30].NameTid),flags=0,returnCode=30,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[35].NameTid),flags=0,returnCode=35,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[52].NameTid),flags=0,returnCode=52,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[55].NameTid),flags=0,returnCode=55,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154891),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[9].NameTid),flags=0,returnCode=9,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[13].NameTid),flags=0,returnCode=13,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[17].NameTid),flags=0,returnCode=17,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[32].NameTid),flags=0,returnCode=32,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[33].NameTid),flags=0,returnCode=33,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[34].NameTid),flags=0,returnCode=34,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[38].NameTid),flags=0,returnCode=38,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[39].NameTid),flags=0,returnCode=39,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[46].NameTid),flags=0,returnCode=46,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[47].NameTid),flags=0,returnCode=47,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[37].NameTid),flags=0,returnCode=37,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[26].NameTid),flags=0,returnCode=26,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154892),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[3].NameTid),flags=0,returnCode=3,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[4].NameTid),flags=0,returnCode=4,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[10].NameTid),flags=0,returnCode=10,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[19].NameTid),flags=0,returnCode=19,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[24].NameTid),flags=0,returnCode=24,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[56].NameTid),flags=0,returnCode=56,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[57].NameTid),flags=0,returnCode=57,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154893),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[15].NameTid),flags=0,returnCode=15,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[25].NameTid),flags=0,returnCode=25,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[29].NameTid),flags=0,returnCode=29,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[42].NameTid),flags=0,returnCode=42,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[44].NameTid),flags=0,returnCode=44,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[45].NameTid),flags=0,returnCode=45,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[48].NameTid),flags=0,returnCode=48,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[49].NameTid),flags=0,returnCode=49,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155469),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[16].NameTid),flags=0,returnCode=16,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[36].NameTid),flags=0,returnCode=36,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[41].NameTid),flags=0,returnCode=41,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[43].NameTid),flags=0,returnCode=43,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154894),0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = GetStringFromTid(1154896),flags=Interface.ArteReceived,returnCode="arte",pressed=false },
			{ str = GetStringFromTid(1154897),flags=Interface.ResReceived,returnCode="res",pressed=false},
			{ str = GetStringFromTid(1154898),flags=Interface.AirReceived,returnCode="air",pressed=false},
			{ str = GetStringFromTid(1154899),flags=Interface.SeedsReceived,returnCode="seeds",pressed=false},
			}
	if (Interface.ArteReceived + Interface.ResReceived + Interface.AirReceived + Interface.SeedsReceived) >=4 then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154895),1,0,"null",false,nil)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154895),0,0,"null",false,subMenu)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154900),Interface.TokensReceived,"tokens",false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155470),0,"grow",false)

	
	
	ContextMenu.ActivateLuaContextMenu(StatusWindow.TCContextMenuCallback)
end

function StatusWindow.TCContextMenuCallback(returnCode, param)
	if ( returnCode=="arte" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give arties")
		Interface.ArteReceived = 1
		Interface.SaveNumber( "ArteReceived" , Interface.ArteReceived )
	elseif ( returnCode=="grow" ) then

		local okayButton = { textTid=UO_StandardDialog.TID_OKAY , callback=function()SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], L"/say Grow_Plant");end }
		local cancelButton = { text=GetStringFromTid(1154902)}
		local DestroyConfirmWindow = 
				{
				    windowName = "GrowPlant",
					title = GetStringFromTid(1155470),
					body = GetStringFromTid(1154901) ,
					buttons = { okayButton, cancelButton }
				}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

		

	elseif ( returnCode=="res" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give resources")
		Interface.ResReceived = 1
		Interface.SaveNumber( "ResReceived" , Interface.ResReceived )
	elseif ( returnCode=="air" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give air")
		Interface.AirReceived = 1
		Interface.SaveNumber( "AirReceived" , Interface.AirReceived )
	elseif ( returnCode=="seeds" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give seeds")
		Interface.SeedsReceived = 1
		Interface.SaveNumber( "SeedsReceived" , Interface.SeedsReceived )
	elseif ( returnCode=="tokens" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give tokens")
		Interface.TokensReceived = 1
		Interface.SaveNumber( "TokensReceived" , Interface.TokensReceived )
	elseif ( returnCode=="str" ) then
		local currStr  = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseStr" ),3,-2))
		local currDex = tonumber(WindowData.PlayerStatus["Dexterity"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseDex" ),3,-2))
		local currInt = tonumber(WindowData.PlayerStatus["Intelligence"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseInt" ),3,-2))
			local max = 255 - (currStr + currDex + currInt)
			local tmp = currStr
			max = max + tmp
			if max >= 125 then
				max = 125
			end
			local rdata = {title=GetStringFromTid(1077833), subtitle=ReplaceTokens(GetStringFromTid(1154798), {towstring(10),  towstring(max)}), callfunction=StatusWindow.EditStr, min = 10, max = max, id=L"str"}
			RenameWindow.Create(rdata)

	elseif ( returnCode=="dex" ) then
		local currStr  = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseStr" ),3,-2))
		local currDex = tonumber(WindowData.PlayerStatus["Dexterity"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseDex" ),3,-2))
		local currInt = tonumber(WindowData.PlayerStatus["Intelligence"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseInt" ),3,-2))

			local max = 255 - (currStr + currDex + currInt)
			local tmp = currDex
			max = max + tmp
			if max >= 125 then
				max = 125
			end
			local rdata = {title=GetStringFromTid(1077834), subtitle=ReplaceTokens(GetStringFromTid(1154798), {towstring(10),  towstring(max)}), callfunction=StatusWindow.EditStr, min = 10, max = max, id=L"dex"}
			RenameWindow.Create(rdata)
	elseif ( returnCode=="int" ) then
		local currStr  = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseStr" ),3,-2))
		local currDex = tonumber(WindowData.PlayerStatus["Dexterity"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseDex" ),3,-2))
		local currInt = tonumber(WindowData.PlayerStatus["Intelligence"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseInt" ),3,-2))

			local max = 255 - (currStr + currDex + currInt)
			local tmp = currInt
			max = max + tmp
			if max >= 125 then
				max = 125
			end
			local rdata = {title=GetStringFromTid(1077834), subtitle=ReplaceTokens(GetStringFromTid(1154798), {towstring(10),  towstring(max)}), callfunction=StatusWindow.EditStr, min = 10, max = max, id=L"int"}
			RenameWindow.Create(rdata)
	elseif (tonumber(returnCode) ~= nil and tonumber(returnCode) > 0) then
		local max = 100
		if (StatusWindow.Skills[returnCode] and StatusWindow.Skills[returnCode].sop == true) then
			max = 120
		end
		local rdata = {title=GetStringFromTid(WindowData.SkillsCSV[returnCode].NameTid), subtitle=ReplaceTokens(GetStringFromTid(1154798), {towstring(0), towstring(max)}), callfunction=StatusWindow.EditSkill, min = 0, max = max, id=returnCode}
		RenameWindow.Create(rdata)
	end
end
function StatusWindow.EditSkill(id, value, max, min)
	if ( tonumber(value)  ~= nil) then
		
		if tonumber(value) < min then
			value = min
		end
		if tonumber(value) > max then
			value = max
		end
		value = wstring.format(L"%.01f", value)
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say set " .. StatusWindow.Skills[id].TCName .. L" " .. value)
	end
end 

function StatusWindow.EditStr(id, value, max, min)
	
	if ( tonumber(value)  ~= nil) then
		if tonumber(value) < min then
			value = min
		end
		if tonumber(value) > max then
			value = max
		end
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say set " .. id .. L" " .. value)
	end
end

function StatusWindow.TCToolsTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154887))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

StatusWindow.TCToolsHandle = false
function StatusWindow.TCToolsOver()
	
	if not StatusWindow.TCToolsHandle then
		WindowSetShowing("TCTOOLSWindowIMG", true)
		StatusWindow.TCToolsHandle = true
	end
end

function StatusWindow.TCToolsOnLButtonDown()
	SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function StatusWindow.TCToolsOverend()
	WindowSetShowing("TCTOOLSWindowIMG", false)
	StatusWindow.TCToolsHandle = false
end

StatusWindow.MPHeight = 193
StatusWindow.MPWidth = 200
StatusWindow.LastMPHeight = -2
function StatusWindow.SetMana( current, maximum )
    local height = math.ceil( ( StatusWindow.MPHeight * current ) / maximum )
    if height ~= StatusWindow.LastMPHeight then
        StatusWindow.LastMPHeight = height
    end
end

StatusWindow.HPHeight = 193
StatusWindow.HPWidth = 200
StatusWindow.LastHPHeight = -2
function StatusWindow.SetHealth( current, maximum )
	if maximum == 0 then
		return
	end
    local height = math.ceil( ( StatusWindow.HPHeight * current ) / maximum )
    if height ~= StatusWindow.LastHPHeight then
        StatusWindow.LastHPHeight = height
    end
end

function StatusWindow.ChangeStyle( style )
	WindowSetShowing( "StatusWindow",  true)
	StatusWindow.Initialize(true)
end

function StatusWindow.ToggleButtons()
	WindowSetShowing("StatusWindowGuardsButton", Interface.StatusButtons)
	WindowSetShowing("StatusWindowMenu", Interface.StatusButtons)
	WindowSetShowing("StatusWindowRedButton", Interface.StatusButtons)
	WindowSetShowing("StatusWindowGreenButton", Interface.StatusButtons)
	WindowSetShowing("StatusWindowBlueButton", Interface.StatusButtons)
end
SettingsWindow = {}

local function overrideLegacySettings()
	--We are disabling all Legacy options and removing them.
	SystemData.Settings.Interface.LegacyChat = false
	SystemData.Settings.Interface.LegacyContainers = false
	SystemData.Settings.Interface.LegacyPaperdolls = false
	SystemData.Settings.GameOptions.legacyTargeting = false
	SystemData.Settings.GameOptions.myLegacyBackpackType = SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_DEFAULT
end

-- OnInitialize Handler()
function SettingsWindow.Initialize()
	Interface.OnCloseCallBack["SettingsWindow"] = SettingsWindow.OnCancelButton
	WindowUtils.SetWindowTitle( "SettingsWindow", GetStringFromTid( 1077814 ) )

	-- Tab Buttons
	ButtonSetText( "SettingsWindowGraphicsTabButton", GetStringFromTid( 1077815 ) )
	ButtonSetText( "SettingsWindowKeyBindingsTabButton", GetStringFromTid( 1094693 ) )
	ButtonSetText( "SettingsWindowOptionsTabButton", GetStringFromTid( 1015326 ) )
	ButtonSetText( "SettingsWindowSoundTabButton", GetStringFromTid( 3000390 ) )
	ButtonSetText( "SettingsWindowProfanityTabButton", GetStringFromTid( 3000173 ) )
	ButtonSetText( "SettingsWindowMobilesOnScreenTabButton", GetStringFromTid(1154852) )	
	ButtonSetText( "SettingsWindowHealthbarsTabButton", GetStringFromTid(1155276) )
	ButtonSetText( "SettingsWindowContainersTabButton", GetStringFromTid(1155277) )
	ButtonSetText( "SettingsWindowOverheadTextTabButton", GetStringFromTid(1155278) )

	-- Buttons
	ButtonSetText( "SettingsWindowOkayButton", GetStringFromTid( 3000093 ) )
	ButtonSetText( "SettingsWindowApplyButton", GetStringFromTid( 3000090 ) )
	ButtonSetText( "SettingsWindowResetButton", GetStringFromTid( 1077825 ) )
	ButtonSetText( "SettingsWindowCancelButton", GetStringFromTid( 1006045 ) )
	
	-- Start with graphics window open
	SettingsWindow.OpenGraphicsTab()
	overrideLegacySettings()
	SettingsGraphicsWindow.Initialize()
	SettingsKeyBindingsWindow.Initialize()
	SettingsSoundWindow.Initialize()
	SettingsOptionsWindow.Initialize()
	SettingsWindow.UpdateSettings()
	
	-- Call backs
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.USER_SETTINGS_UPDATED, "SettingsWindow.UpdateSettings" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.TOGGLE_USER_PREFERENCE, "SettingsWindow.ToggleSettingsWindow" )

	SettingsProfanityWindow.Initialize()
	SettingsContainersWindow.Initialize()
	SettingsHealthBarsWindow.Initialize()
	SettingsOverheadTextWindow.Initialize()
end

function SettingsWindow.ToggleSettingsWindow()	
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )	
end

function SettingsWindow.UpdateSettings()
	SettingsGraphicsWindow.UpdateSettings()
	SettingsOptionsWindow.UpdateSettings()
	SettingsContainersWindow.UpdateSettings()
	SettingsProfanityWindow.UpdateSettings()
	SettingsSoundWindow.UpdateSettings()
	SettingsKeyBindingsWindow.UpdateSettings()
	SettingsKeyBindingsWindow.UpdateKeyBindings()
	SettingsHealthBarsWindow.UpdateSettings()
	SettingsOverheadTextWindow.UpdateSettings()
end

function SettingsWindow.OnOkayButton()
	SettingsWindow.OnApplyButton()
	-- Close the window		
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function SettingsWindow.OnApplyButton()
	-- Set the Options
	SettingsGraphicsWindow.OnApplyButton()
	SettingsOptionsWindow.OnApplyButton()
	SettingsContainersWindow.OnApplyButton()
	SettingsSoundWindow.OnApplyButton()
	SettingsProfanityWindow.OnApplyButton()
	SettingsKeyBindingsWindow.OnApplyButton()
	SettingsHealthBarsWindow.OnApplyButton()
	SettingsOverheadTextWindow.OnApplyButton()
	MobilesOnScreen.SaveFilterSettings()	
	StatusWindow.ToggleStrLabel()
	-- push the new values to c++
	needsReload = UserSettingsChanged()
	if ( needsReload == true ) then
		InterfaceCore.ReloadUI()
	end
end

function SettingsWindow.OnResetButton()
	local okayButton = {
		textTid = UO_StandardDialog.TID_OKAY,
		callback = function()
			SettingsKeyBindingsWindow.ClearTempKeybindings();
			BroadcastEvent( SystemData.Events.RESET_SETTINGS_TO_DEFAULT );
		end
	}
	local cancelButton = {
		textTid = UO_StandardDialog.TID_CANCEL
	}
	local ResetConfirmWindow = {
		windowName = "SettingsWindow", 
		titleTid = 1078994, 
		bodyTid = 1078995, 
		buttons = { okayButton, cancelButton }
	}
			
	UO_StandardDialog.CreateDialog( ResetConfirmWindow )
end

function SettingsWindow.OnCancelButton()
	-- Reload the current settings
	SettingsKeyBindingsWindow.ClearTempKeybindings()
	SettingsWindow.UpdateSettings()
	-- Close the window		
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function SettingsWindow.ClearTabStates()
	-- The pressed flag isn't being used for these tabs to decide color anymore
	ButtonSetPressedFlag( "SettingsWindowGraphicsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowKeyBindingsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowSoundTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowOptionsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowProfanityTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowMobilesOnScreenTabButton", false )	
	ButtonSetPressedFlag( "SettingsWindowHealthbarsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowContainersTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowOverheadTextTabButton", false )
	
	ButtonSetDisabledFlag( "SettingsWindowGraphicsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowKeyBindingsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowSoundTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowOptionsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowProfanityTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowMobilesOnScreenTabButton", false )	
	ButtonSetDisabledFlag( "SettingsWindowHealthbarsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowContainersTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowOverheadTextTabButton", false )
	
	WindowSetShowing( "SettingsWindowGraphicsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowKeyBindingsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowSoundTabButtonTab", true )
	WindowSetShowing( "SettingsWindowOptionsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowProfanityTabButtonTab", true )
	WindowSetShowing( "SettingsWindowMobilesOnScreenTabButtonTab", true )	
	WindowSetShowing( "SettingsWindowHealthbarsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowContainersTabButtonTab", true )
	WindowSetShowing( "SettingsWindowOverheadTextTabButtonTab", true )

	local windows = {
		"SettingsGraphicsWindow",
		"SettingsKeyBindingsWindow",
		"SettingsSoundWindow",
		"SettingsOptionsWindow",
		"SettingsProfanityWindow",
		"SettingsKeyDefaultWindow",
		"OverheadTextSettingsWindow",
		"ContainersSettingsWindow",
		"HealthbarsSettingsWindow",
		"SettingsMobilesOnScreen",
	}

	for index = 1, #windows do
		WindowSetShowing( windows[index], false )
	end	
end

function SettingsWindow.OpenGraphicsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowGraphicsTabButton", true )
	WindowSetShowing( "SettingsWindowGraphicsTabButtonTab", false )
	WindowSetShowing( "SettingsGraphicsWindow", true )
end

function SettingsWindow.OpenKeyBindingsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowKeyBindingsTabButton", true )
	WindowSetShowing( "SettingsWindowKeyBindingsTabButtonTab", false )
	WindowSetShowing( "SettingsKeyBindingsWindow", true )
	WindowSetShowing( "SettingsKeyDefaultWindow", true )
end

function SettingsWindow.OpenSoundTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowSoundTabButton", true )
	WindowSetShowing( "SettingsWindowSoundTabButtonTab", false )
	WindowSetShowing( "SettingsSoundWindow", true )
end

function SettingsWindow.OpenOptionsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowOptionsTabButton", true )
	WindowSetShowing( "SettingsWindowOptionsTabButtonTab", false )
	WindowSetShowing( "SettingsOptionsWindow", true )
end

function SettingsWindow.OpenProfanityTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowProfanityTabButton", true )
	WindowSetShowing( "SettingsWindowProfanityTabButtonTab", false )
	WindowSetShowing( "SettingsProfanityWindow", true )
end

function SettingsWindow.OpenMobilesTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowMobilesOnScreenTabButton", true )
	WindowSetShowing( "SettingsWindowMobilesOnScreenTabButtonTab", false )
	WindowSetShowing( "SettingsMobilesOnScreen", true )
end

function SettingsWindow.OpenHealthbarsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowHealthbarsTabButton", true )
	WindowSetShowing( "SettingsWindowHealthbarsTabButtonTab", false )
	WindowSetShowing( "HealthbarsSettingsWindow", true )
end

function SettingsWindow.OpenContainersTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowContainersTabButton", true )
	WindowSetShowing( "SettingsWindowContainersTabButtonTab", false )
	WindowSetShowing( "ContainersSettingsWindow", true )
end

function SettingsWindow.OpenOverheadTextTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowOverheadTextTabButton", true )
	WindowSetShowing( "SettingsWindowOverheadTextTabButtonTab", false )
	WindowSetShowing( "OverheadTextSettingsWindow", true )
end

function SettingsWindow.LabelOnMouseOver()
	local windowName = SystemData.ActiveWindow.name
	local detailTID = WindowGetId(windowName)
	
	if ( (detailTID ~= nil) and (detailTID ~= 0) ) then
		local text = GetStringFromTid(detailTID)
		Tooltips.CreateTextOnlyTooltip(windowName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end 
end

function SettingsWindow.Check()
	local win = string.gsub(SystemData.ActiveWindow.name, "Label", "Button")
	ButtonSetPressedFlag( win, not ButtonGetPressedFlag( win ))
end
SettingsWindow = ListWindow:new("SettingsWindow")

local TAB_BUTTONS = {
	Graphics = "SettingsWindowGraphicsTabButton",
	KeyBindings = "SettingsWindowKeyBindingsTabButton",
	Options = "SettingsWindowOptionsTabButton",
	Sound = "SettingsWindowSoundTabButton",
	Filters = "SettingsWindowProfanityTabButton",
	Mobiles = "SettingsWindowMobilesOnScreenTabButton",
	HealthBars = "SettingsWindowHealthbarsTabButton",
	Containers = "SettingsWindowContainersTabButton",
	OverheadText = "SettingsWindowOverheadTextTabButton"
}

local BUTTONS = {
	Okay = "SettingsWindowOkayButton",
	Apply = "SettingsWindowApplyButton",
	Reset = "SettingsWindowResetButton",
	Cancel = "SettingsWindowCancelButton"
}

SettingsWindow.WINDOWS = {
	Graphics = "SettingsGraphicsWindow",
	KeyBindings = "SettingsKeyBindingsWindow",
	Sound = "SettingsSoundWindow",
	Options = "SettingsOptionsWindow",
	Filters = "SettingsProfanityWindow",
	KeyDefault = "SettingsKeyDefaultWindow",
	OverheadText = "OverheadTextSettingsWindow",
	Containers = "ContainersSettingsWindow",
	HealthBars = "HealthbarsSettingsWindow",
	Mobiles = "SettingsMobilesOnScreen"
}

local function overrideLegacySettings()
	--We are disabling most Legacy options and removing them.
	SystemData.Settings.Interface.LegacyChat = false
	SystemData.Settings.Interface.LegacyPaperdolls = false
	SystemData.Settings.GameOptions.legacyTargeting = false
end

function SettingsWindow.Initialize()
	Interface.OnCloseCallBack[SettingsWindow.id] = SettingsWindow.OnCancelButton
	WindowUtils.SetWindowTitle(SettingsWindow.id, StringFormatter.fromTid(1077814))
	SettingsWindow.adapter:addButton(
			TAB_BUTTONS.Graphics,
			1077815
	):addButton(
			TAB_BUTTONS.KeyBindings,
			1094693
	):addButton(
			TAB_BUTTONS.Options,
			1015326
	):addButton(
			TAB_BUTTONS.Sound,
			3000390
	):addButton(
			TAB_BUTTONS.Filters,
			3000173
	):addButton(
			TAB_BUTTONS.Mobiles,
			1154852
	):addButton(
			TAB_BUTTONS.HealthBars,
			1155276
	):addButton(
			TAB_BUTTONS.Containers,
			1155277
	):addButton(
			TAB_BUTTONS.OverheadText,
			1155278
	):addButton(
			BUTTONS.Okay,
			3000093
	):addButton(
			BUTTONS.Apply,
			3000090
	):addButton(
			BUTTONS.Reset,
			1077825
	):addButton(
			BUTTONS.Cancel,
			1006045
	)

	for _, value in pairs(TAB_BUTTONS) do
		SettingsWindow.adapter:addWindow(
				value.."Tab"
		)
	end

	overrideLegacySettings()
	SettingsWindow.OpenGraphicsTab()
	SettingsGraphicsWindow.Initialize()
	SettingsKeyBindingsWindow.Initialize()
	SettingsSoundWindow.Initialize()
	SettingsOptionsWindow.Initialize()
	SettingsProfanityWindow.Initialize()
	SettingsContainersWindow.Initialize()
	SettingsHealthBarsWindow.Initialize()
	SettingsOverheadTextWindow.Initialize()
	SettingsWindow.UpdateSettings()
	
	-- Call backs
	WindowRegisterEventHandler(SettingsWindow.id, SystemData.Events.USER_SETTINGS_UPDATED, "SettingsWindow.UpdateSettings" )
	WindowRegisterEventHandler(SettingsWindow.id, SystemData.Events.TOGGLE_USER_PREFERENCE, "SettingsWindow.ToggleSettingsWindow" )
end

function SettingsWindow.ToggleSettingsWindow()	
	ToggleWindowByName(SettingsWindow.id, "", nil)
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
	ToggleWindowByName(SettingsWindow.id, "", nil )
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
			EventApi.broadcast(SystemData.Events.RESET_SETTINGS_TO_DEFAULT)
		end
	}
	local cancelButton = {
		textTid = UO_StandardDialog.TID_CANCEL
	}
	local ResetConfirmWindow = {
		windowName = SettingsWindow.id,
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
	ToggleWindowByName(SettingsWindow.id, "", nil)
end

function SettingsWindow.ClearTabStates()
	for _, value in pairs(TAB_BUTTONS) do
		SettingsWindow.adapter.views[value]:setDisabledFlag(false)
		SettingsWindow.adapter.views[value.."Tab"]:setShowing(true)
	end

	SettingsSoundWindow:setShowing(false)
	SettingsProfanityWindow:setShowing(false)
	SettingsOverheadTextWindow:setShowing(false)
	SettingsOptionsWindow:setShowing(false)
	SettingsKeyBindingsWindow:setShowing(false)
	SettingsHealthBarsWindow:setShowing(false)
	SettingsGraphicsWindow:setShowing(false)
	SettingsContainersWindow:setShowing(false)
	WindowSetShowing("SettingsMobilesOnScreen", false)
end

function SettingsWindow.OpenGraphicsTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.Graphics]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.Graphics.."Tab"]:setShowing(false)
	SettingsGraphicsWindow:setShowing(true)
end

function SettingsWindow.OpenKeyBindingsTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.KeyBindings]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.KeyBindings.."Tab"]:setShowing(false)
	SettingsKeyBindingsWindow:setShowing(true)
end

function SettingsWindow.OpenSoundTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.Sound]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.Sound.."Tab"]:setShowing(false)
	SettingsSoundWindow:setShowing(true)
end

function SettingsWindow.OpenOptionsTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.Options]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.Options.."Tab"]:setShowing(false)
	SettingsOptionsWindow:setShowing(true)
end

function SettingsWindow.OpenProfanityTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.Filters]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.Filters.."Tab"]:setShowing(false)
	SettingsProfanityWindow:setShowing(true)
end

function SettingsWindow.OpenMobilesTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.Mobiles]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.Mobiles.."Tab"]:setShowing(false)
	WindowSetShowing("SettingsMobilesOnScreen", true)
end

function SettingsWindow.OpenHealthbarsTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.HealthBars]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.HealthBars.."Tab"]:setShowing(false)
	SettingsHealthBarsWindow:setShowing(true)
end

function SettingsWindow.OpenContainersTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.Containers]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.Containers.."Tab"]:setShowing(false)
	SettingsContainersWindow:setShowing(true)
end

function SettingsWindow.OpenOverheadTextTab()
	SettingsWindow.ClearTabStates()
	SettingsWindow.adapter.views[TAB_BUTTONS.OverheadText]:setDisabledFlag(true)
	SettingsWindow.adapter.views[TAB_BUTTONS.OverheadText.."Tab"]:setShowing(false)
	SettingsOverheadTextWindow:setShowing(true)
end

function SettingsWindow.Check()
	local win = string.gsub(SystemData.ActiveWindow.name, "Label", "Button")
	ButtonSetPressedFlag( win, not ButtonGetPressedFlag( win ))
end
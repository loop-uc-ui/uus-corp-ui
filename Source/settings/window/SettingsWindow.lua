SettingsWindow = {}

local adapter = ViewAdapter:new("SettingsWindow", "SettingsWindow")

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
	Mobiles = "SettingsMobilesOnScreen",
}

local function overrideLegacySettings()
	--We are disabling most Legacy options and removing them.
	SystemData.Settings.Interface.LegacyChat = false
	SystemData.Settings.Interface.LegacyPaperdolls = false
	SystemData.Settings.GameOptions.legacyTargeting = false
end

function SettingsWindow.Initialize()
	Interface.OnCloseCallBack[adapter.name] = SettingsWindow.OnCancelButton
	WindowUtils.SetWindowTitle(adapter.name, StringFormatter.fromTid(1077814))
	adapter:addButton(
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
	WindowRegisterEventHandler(adapter.name, Broadcast.Events.USER_SETTINGS_UPDATED, "SettingsWindow.UpdateSettings" )
	WindowRegisterEventHandler(adapter.name, Broadcast.Events.TOGGLE_USER_PREFERENCE, "SettingsWindow.ToggleSettingsWindow" )
end

function SettingsWindow.ToggleSettingsWindow()	
	ToggleWindowByName(adapter.name, "", nil)
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
	ToggleWindowByName(adapter.name, "", nil )
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
			Broadcast.Event(Broadcast.Events.RESET_SETTINGS_TO_DEFAULT)
		end
	}
	local cancelButton = {
		textTid = UO_StandardDialog.TID_CANCEL
	}
	local ResetConfirmWindow = {
		windowName = adapter.name,
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
	ToggleWindowByName(adapter.name, "", nil)
end

function SettingsWindow.ClearTabStates()
	for _, value in pairs(TAB_BUTTONS) do
		adapter.views[value]:setDisabledFlag(false)
		adapter:setShowing(true, value.."Tab")
	end

	for _, value in pairs(SettingsWindow.WINDOWS) do
		adapter:setShowing(false, value)
	end
end

function SettingsWindow.openTab(view)
	if view == nil then
		view = adapter.views[TAB_BUTTONS.Graphics]
	end
	SettingsWindow.ClearTabStates()
end

function SettingsWindow.OpenGraphicsTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.Graphics]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.Graphics.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.Graphics)
end

function SettingsWindow.OpenKeyBindingsTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.KeyBindings]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.KeyBindings.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.KeyBindings)
	adapter:setShowing(true, SettingsWindow.WINDOWS.KeyDefault)
end

function SettingsWindow.OpenSoundTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.Sound]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.Sound.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.Sound)
end

function SettingsWindow.OpenOptionsTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.Options]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.Options.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.Options)
end

function SettingsWindow.OpenProfanityTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.Filters]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.Filters.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.Filters)
end

function SettingsWindow.OpenMobilesTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.Mobiles]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.Mobiles.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.Mobiles)
end

function SettingsWindow.OpenHealthbarsTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.HealthBars]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.HealthBars.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.HealthBars)
end

function SettingsWindow.OpenContainersTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.Containers]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.Containers.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.Containers)
end

function SettingsWindow.OpenOverheadTextTab()
	SettingsWindow.ClearTabStates()
	adapter.views[TAB_BUTTONS.OverheadText]:setDisabledFlag(true)
	adapter:setShowing(false, TAB_BUTTONS.OverheadText.."Tab")
	adapter:setShowing(true, SettingsWindow.WINDOWS.OverheadText)
end

function SettingsWindow.Check()
	local win = string.gsub(SystemData.ActiveWindow.name, "Label", "Button")
	ButtonSetPressedFlag( win, not ButtonGetPressedFlag( win ))
end
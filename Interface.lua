----------------------------------------------------------------
-- Global functions
----------------------------------------------------------------

function ToggleWindowByName( wndName, btnName, toggleFunction, onOpenFunction, onCloseFunction )
	local showing = WindowGetShowing( wndName )
	showing = not showing	
	WindowSetShowing( wndName, showing )
	
	if (btnName ~= "") then
		ButtonSetPressedFlag( btnName, showing )
	end
	
	if( onOpenFunction ~= nil and showing == true ) then
	    onOpenFunction()
	elseif( onCloseFunction ~= nil and showing == false ) then
	    onCloseFunction()
	end
end

----------------------------------------------------------------
-- In-Game Interface Initialization Variables
----------------------------------------------------------------

Interface.DebugMode = false

Interface.TID = { accept=1013076, cancel=1011012 }

Interface.LoadedSettings = false
Interface.SpellweavingID = 46
Interface.ArcaneFocusLevel = 0

-- In the future, this could be exposed by c++:
Interface.PLAYWINDOWSET = 2

Interface.TimeSinceLogin = 0
Interface.OpeningBpk = 0
Interface.DeltaTime = 0

Interface.CurrentHonor = 0
Interface.LastItem = 0


Interface.MenuId = -1

Interface.AlacrityStart = 0

Interface.CurrentSpell = {}

Interface.BlockThisPaperdoll = {}

Interface.Clock = {}
Interface.Clock.DD = 0
Interface.Clock.MM = 0
Interface.Clock.YYYY = 0
Interface.Clock.Timestamp = 0
Interface.Clock.h = 0
Interface.Clock.m = 0
Interface.Clock.s = 0

Interface.LastTarget = 0
Interface.LastSpell = 0
Interface.LastSpecialMove = 0

Interface.IsFighting = false
Interface.IsFightingLastTime = 0
Interface.CanLogout = 0

Interface.MenuBar = nil
Interface.FirstImprovement = nil
Interface.InitialPositions = nil

Interface.NewPlayerInventoryToggled = false
Interface.NewPlayerPaperdollToggled = false
Interface.NewPlayerMapToggled = false
Interface.NewPlayerWarToggled = false

Interface.LastSpecialMoveTime = 0

Interface.ItemsCooldown = {}
Interface.SkillsCooldown = {}
Interface.SpellsCooldown = {}
Interface.SpecialsCooldown = {}
Interface.VirtuesCooldown = {}

Interface.ArteReceived = 0
Interface.ResReceived = 0
Interface.AirReceived = 0
Interface.SeedsReceived = 0
Interface.TokensReceived = 0

Interface.PaperdollOpen = true
Interface.BackpackOpen = true

Interface.TrapBoxID = 0
Interface.LootBoxID = 0

Interface.MobileArrowOver = 0

WindowUtils.ToggleAlpha = false
WindowUtils.ToggleScale = false

Interface.UnpackTransferCrate = false

Interface.ForceEnchant = 0
Interface.ForceAnimal = 0
Interface.ForceSpellTrigger = 0
Interface.ForcePolymorph = 0
Interface.ForceFamiliar = 0

Interface.RedButtonSpells = { 
	[1] = { SpellId = 0; AltText = GetStringFromTid(1011051)};
	[2] = { SpellId = 1; AltText = GetStringFromTid(1015164)};
	[3] = { SpellId = 3; AltText = GetStringFromTid(1015166)};
	[4] = { SpellId = 8; AltText = GetStringFromTid(1015170)};
	[5] = { SpellId = 27; AltText = GetStringFromTid(1015188)};

	[6] = { SpellId = 9; AltText = GetStringFromTid(1027989)};
	[7] = { SpellId = 10; AltText = GetStringFromTid(1027990)};
	[8] = { SpellId = 16; AltText = GetStringFromTid(1027996)};
	[9] = { SpellId = 17; AltText = GetStringFromTid(1027997)};

	[10] = { SpellId = 11; AltText = GetStringFromTid(1027991)};
	[11] = { SpellId = 25; AltText = GetStringFromTid(1028005)};
	
	[12] = { SpellId = 4; AltText = GetStringFromTid(1027985)};
	[13] = { SpellId = 29; AltText = GetStringFromTid(1028009)};
	[14] = { SpellId = 59; AltText = GetStringFromTid(1028039)};

	[15] = { SpellId = 201; AltText = GetStringFromTid(1028828)};
	[16] = { SpellId = 202; AltText = GetStringFromTid(1028829)};
	[17] = { SpellId = 209; AltText = GetStringFromTid(1060501)};

	[18] = { SpellId = 102; AltText = GetStringFromTid(1060510)};
	[19] = { SpellId = 103; AltText = GetStringFromTid(1060511)};
	[20] = { SpellId = 105; AltText = GetStringFromTid(1060513)};
	[21] = { SpellId = 108; AltText = GetStringFromTid(1060516)};

	[22] = { SpellId = 602; AltText = GetStringFromTid(1071027)};
	[23] = { SpellId = 615; AltText = GetStringFromTid(1071040)};

	[24] = { SpellId = 680; AltText = GetStringFromTid(1031680)};
	[25] = { SpellId = 682; AltText = GetStringFromTid(1031682)};
	[26] = { SpellId = 687; AltText = GetStringFromTid(1031687)};
	[27] = { SpellId = 688; AltText = GetStringFromTid(1031688)};
	
	[28] = { SpellId = 0; AltText = GetStringFromTid(1011051)};
	[29] = { SpellId = 6; AltText = GetStringFromTid(1044387)};
	[30] = { SpellId = 44; AltText = GetStringFromTid(1044424)};

	[31] = { SpellId = 5; AltText = GetStringFromTid(1044386)};
	[32] = { SpellId = 12; AltText = GetStringFromTid(1044392)};
	[33] = { SpellId = 18; AltText = GetStringFromTid(1044398)};
	[34] = { SpellId = 30; AltText = GetStringFromTid(1044410)};
	[35] = { SpellId = 37; AltText = GetStringFromTid(1044417)};
	[36] = { SpellId = 38; AltText = GetStringFromTid(1044418)};
	[37] = { SpellId = 41; AltText = GetStringFromTid(1044421)};
	[38] = { SpellId = 42; AltText = GetStringFromTid(1044422)};
	[39] = { SpellId = 43; AltText = GetStringFromTid(1044423)};
	[40] = { SpellId = 49; AltText = GetStringFromTid(1044429)};
	[41] = { SpellId = 51; AltText = GetStringFromTid(1044431)};
	[42] = { SpellId = 55; AltText = GetStringFromTid(1044435)};

	[43] = { SpellId = 109; AltText = GetStringFromTid(1060517)};
	[44] = { SpellId = 110; AltText = GetStringFromTid(1060518)};
	[45] = { SpellId = 111; AltText = GetStringFromTid(1060519)};

	[46] = { SpellId = 614; AltText = GetStringFromTid(1071039)};

	[47] = { SpellId = 678; AltText = GetStringFromTid(1031678)};
	[48] = { SpellId = 683; AltText = GetStringFromTid(1031683)};
	[49] = { SpellId = 689; AltText = GetStringFromTid(1031689)};
	[50] = { SpellId = 690; AltText = GetStringFromTid(1031690)};
	[51] = { SpellId = 691; AltText = GetStringFromTid(1031691)};
	[52] = { SpellId = 692; AltText = GetStringFromTid(1031692)};
	[53] = { SpellId = 209; AltText = GetStringFromTid(1060501)};
 }
 
Interface.GreenButtonSpells = { 
	[1] = { SpellId = 0; AltText = GetStringFromTid(1011051)};
	[2] = { SpellId = 1; AltText = GetStringFromTid(1015164)};
	[3] = { SpellId = 3; AltText = GetStringFromTid(1015166)};
	[4] = { SpellId = 8; AltText = GetStringFromTid(1015170)};
	[5] = { SpellId = 27; AltText = GetStringFromTid(1015188)};

	[6] = { SpellId = 9; AltText = GetStringFromTid(1027989)};
	[7] = { SpellId = 10; AltText = GetStringFromTid(1027990)};
	[8] = { SpellId = 16; AltText = GetStringFromTid(1027996)};
	[9] = { SpellId = 17; AltText = GetStringFromTid(1027997)};

	[10] = { SpellId = 11; AltText = GetStringFromTid(1027991)};
	[11] = { SpellId = 25; AltText = GetStringFromTid(1028005)};
	
	[12] = { SpellId = 4; AltText = GetStringFromTid(1027985)};
	[13] = { SpellId = 29; AltText = GetStringFromTid(1028009)};
	[14] = { SpellId = 59; AltText = GetStringFromTid(1028039)};

	[15] = { SpellId = 201; AltText = GetStringFromTid(1028828)};
	[16] = { SpellId = 202; AltText = GetStringFromTid(1028829)};
	[17] = { SpellId = 209; AltText = GetStringFromTid(1060501)};

	[18] = { SpellId = 102; AltText = GetStringFromTid(1060510)};
	[19] = { SpellId = 103; AltText = GetStringFromTid(1060511)};
	[20] = { SpellId = 105; AltText = GetStringFromTid(1060513)};
	[21] = { SpellId = 108; AltText = GetStringFromTid(1060516)};

	[22] = { SpellId = 602; AltText = GetStringFromTid(1071027)};
	[23] = { SpellId = 615; AltText = GetStringFromTid(1071040)};

	[24] = { SpellId = 680; AltText = GetStringFromTid(1031680)};
	[25] = { SpellId = 682; AltText = GetStringFromTid(1031682)};
	[26] = { SpellId = 687; AltText = GetStringFromTid(1031687)};
	[27] = { SpellId = 688; AltText = GetStringFromTid(1031688)};
	
	[28] = { SpellId = 0; AltText = GetStringFromTid(1011051)};
	[29] = { SpellId = 6; AltText = GetStringFromTid(1044387)};
	[30] = { SpellId = 44; AltText = GetStringFromTid(1044424)};

	[31] = { SpellId = 5; AltText = GetStringFromTid(1044386)};
	[32] = { SpellId = 12; AltText = GetStringFromTid(1044392)};
	[33] = { SpellId = 18; AltText = GetStringFromTid(1044398)};
	[34] = { SpellId = 30; AltText = GetStringFromTid(1044410)};
	[35] = { SpellId = 37; AltText = GetStringFromTid(1044417)};
	[36] = { SpellId = 38; AltText = GetStringFromTid(1044418)};
	[37] = { SpellId = 41; AltText = GetStringFromTid(1044421)};
	[38] = { SpellId = 42; AltText = GetStringFromTid(1044422)};
	[39] = { SpellId = 43; AltText = GetStringFromTid(1044423)};
	[40] = { SpellId = 49; AltText = GetStringFromTid(1044429)};
	[41] = { SpellId = 51; AltText = GetStringFromTid(1044431)};
	[42] = { SpellId = 55; AltText = GetStringFromTid(1044435)};

	[43] = { SpellId = 109; AltText = GetStringFromTid(1060517)};
	[44] = { SpellId = 110; AltText = GetStringFromTid(1060518)};
	[45] = { SpellId = 111; AltText = GetStringFromTid(1060519)};

	[46] = { SpellId = 614; AltText = GetStringFromTid(1071039)};

	[47] = { SpellId = 678; AltText = GetStringFromTid(1031678)};
	[48] = { SpellId = 683; AltText = GetStringFromTid(1031683)};
	[49] = { SpellId = 689; AltText = GetStringFromTid(1031689)};
	[50] = { SpellId = 690; AltText = GetStringFromTid(1031690)};
	[51] = { SpellId = 691; AltText = GetStringFromTid(1031691)};
	[52] = { SpellId = 692; AltText = GetStringFromTid(1031692)};
	[53] = { SpellId = 209; AltText = GetStringFromTid(1060501)};
}

Interface.BlueButtonSpells = { 
	[1] = { SpellId = 0; AltText = GetStringFromTid(1011051)};
	[2] = { SpellId = 1; AltText = GetStringFromTid(1015164)};
	[3] = { SpellId = 3; AltText = GetStringFromTid(1015166)};
	[4] = { SpellId = 8; AltText = GetStringFromTid(1015170)};
	[5] = { SpellId = 27; AltText = GetStringFromTid(1015188)};

	[6] = { SpellId = 9; AltText = GetStringFromTid(1027989)};
	[7] = { SpellId = 10; AltText = GetStringFromTid(1027990)};
	[8] = { SpellId = 16; AltText = GetStringFromTid(1027996)};
	[9] = { SpellId = 17; AltText = GetStringFromTid(1027997)};

	[10] = { SpellId = 11; AltText = GetStringFromTid(1027991)};
	[11] = { SpellId = 25; AltText = GetStringFromTid(1028005)};
	
	[12] = { SpellId = 4; AltText = GetStringFromTid(1027985)};
	[13] = { SpellId = 29; AltText = GetStringFromTid(1028009)};
	[14] = { SpellId = 59; AltText = GetStringFromTid(1028039)};

	[15] = { SpellId = 201; AltText = GetStringFromTid(1028828)};
	[16] = { SpellId = 202; AltText = GetStringFromTid(1028829)};
	[17] = { SpellId = 209; AltText = GetStringFromTid(1060501)};

	[18] = { SpellId = 102; AltText = GetStringFromTid(1060510)};
	[19] = { SpellId = 103; AltText = GetStringFromTid(1060511)};
	[20] = { SpellId = 105; AltText = GetStringFromTid(1060513)};
	[21] = { SpellId = 108; AltText = GetStringFromTid(1060516)};

	[22] = { SpellId = 602; AltText = GetStringFromTid(1071027)};
	[23] = { SpellId = 615; AltText = GetStringFromTid(1071040)};

	[24] = { SpellId = 680; AltText = GetStringFromTid(1031680)};
	[25] = { SpellId = 682; AltText = GetStringFromTid(1031682)};
	[26] = { SpellId = 687; AltText = GetStringFromTid(1031687)};
	[27] = { SpellId = 688; AltText = GetStringFromTid(1031688)};
	
	[28] = { SpellId = 0; AltText = GetStringFromTid(1011051)};
	[29] = { SpellId = 6; AltText = GetStringFromTid(1044387)};
	[30] = { SpellId = 44; AltText = GetStringFromTid(1044424)};

	[31] = { SpellId = 5; AltText = GetStringFromTid(1044386)};
	[32] = { SpellId = 12; AltText = GetStringFromTid(1044392)};
	[33] = { SpellId = 18; AltText = GetStringFromTid(1044398)};
	[34] = { SpellId = 30; AltText = GetStringFromTid(1044410)};
	[35] = { SpellId = 37; AltText = GetStringFromTid(1044417)};
	[36] = { SpellId = 38; AltText = GetStringFromTid(1044418)};
	[37] = { SpellId = 41; AltText = GetStringFromTid(1044421)};
	[38] = { SpellId = 42; AltText = GetStringFromTid(1044422)};
	[39] = { SpellId = 43; AltText = GetStringFromTid(1044423)};
	[40] = { SpellId = 49; AltText = GetStringFromTid(1044429)};
	[41] = { SpellId = 51; AltText = GetStringFromTid(1044431)};
	[42] = { SpellId = 55; AltText = GetStringFromTid(1044435)};

	[43] = { SpellId = 109; AltText = GetStringFromTid(1060517)};
	[44] = { SpellId = 110; AltText = GetStringFromTid(1060518)};
	[45] = { SpellId = 111; AltText = GetStringFromTid(1060519)};

	[46] = { SpellId = 614; AltText = GetStringFromTid(1071039)};

	[47] = { SpellId = 678; AltText = GetStringFromTid(1031678)};
	[48] = { SpellId = 683; AltText = GetStringFromTid(1031683)};
	[49] = { SpellId = 689; AltText = GetStringFromTid(1031689)};
	[50] = { SpellId = 690; AltText = GetStringFromTid(1031690)};
	[51] = { SpellId = 691; AltText = GetStringFromTid(1031691)};
	[52] = { SpellId = 692; AltText = GetStringFromTid(1031692)};
	[53] = { SpellId = 209; AltText = GetStringFromTid(1060501)};
}

Interface.BackPackItems = {}

Interface.SOSWaypoints = {}

Interface.AllowTrades = true

Interface.BardMastery = false
-------------------------------------------------------------------------------
--
-- SETTINGS DEFAULT VALUES
--
-------------------------------------------------------------------------------

----------------------------------------------------------------
-- CONTAINERS: (containers tab)
----------------------------------------------------------------
-- default container view
-- default corpse view
Interface.GridLegacy = true
Interface.EnableContainerGrid = true
Interface.AlternateGrid = false
Interface.ExtraBrightContainers = false
--ContainerWindow.BaseGridColor 
--ContainerWindow.AlternateBackpack

----------------------------------------------------------------
-- MAP: (options tab)
----------------------------------------------------------------

Interface.ShowMapCombos = false

----------------------------------------------------------------
-- HEALTHBARS/STATUS: (healthbars tab)

-- STATUS WINDOW STYLES:
-- 0: classic
-- 1: advanced
----------------------------------------------------------------

Interface.StatusWindowStyle = 0
-- always show health, stamina, mana
Interface.StatusButtons = true
Interface.AuraEnabled = true
Interface.EnableMobileArrow = true
Interface.HeartBeat = true -- Not available on the settings window at the moment.

-- MobileHealthBar.LegacyCloseStyle
-- MobileHealthBar.PetLegacyCloseStyle
Interface.ShowCloseExtract = true
Interface.HealthBarWod = true

Interface.RedDef = 1
Interface.RedButton = 29
Interface.RedButton2 = 59
Interface.RedButton3 = 0

Interface.GreenDef = 1
Interface.GreenButton = 25
Interface.GreenButton2 = 17
Interface.GreenButton3 = 0

Interface.BlueDef = 1
Interface.BlueButton = 44
Interface.BlueButton2 = 6
Interface.BlueButton3 = 0


----------------------------------------------------------------
-- NEW CHAT: (new chat tab)
----------------------------------------------------------------

Interface.UseNewChat = false -- Internal, no toggle for now.
Interface.LockChatLine = false

----------------------------------------------------------------
-- OVERHEAD TEXT: (overhead text tab)
----------------------------------------------------------------

-- show names:
-- show corpse names
-- OverheadText.clickableNames
-- overhead chat
-- overhead chat fade
Interface.DisableSpells = false
Interface.ShowSpellName = false
Interface.noPoisonOthers = true
Interface.OverhedTextSize = InterfaceCore.scale
-- chat font
-- name font
-- spell font
-- damage font
-- spells colors
-- damage colors
-- positive/negative messages colors

----------------------------------------------------------------
-- MISC: (options tab)
----------------------------------------------------------------

Interface.BlockOthersPaperdoll = false
Interface.EnableSnapping = true
-- block war on pets
-- block war on party
-- block war on guild
Interface.WarShield = true
-- -- CENTER SCREEN TEXT --
--CenterScreenText.EnableIgnoreSummons
--CenterScreenText.LowHPPercDisabled
--CenterScreenText.LowHPPETPercDisabled
-- CenterScreenText.LowHPPerc
-- CenterScreenText.LowPETHPPerc

----------------------------------------------------------------
--
-- INTERFACE STARTUP
--
----------------------------------------------------------------
function Interface.CreatePlayWindowSet()

	if Interface.DebugMode then
		WindowSetShowing("DebugWindow", true)
		if not DebugWindow.logging then
			DebugWindow.ToggleLogging()
		end
	end
		
	ok, err = pcall(Interface.LoadVariables)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.CreateWindows)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.RegisterEvents)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.InitializeWindows)	
	Interface.ErrorTracker(ok, err)	
	
	ok, err = pcall(Interface.CreateOverrides)	
	Interface.ErrorTracker(ok, err)	
		
	--ok, err = pcall(Interface.InitializeMap)	
	--Interface.ErrorTracker(ok, err)	
	
	ok, err = pcall(Interface.InterfaceInitialize)	
	Interface.ErrorTracker(ok, err)	
end

function Interface.RegisterEvents()
	WindowRegisterEventHandler( "Root", SystemData.Events.CHARACTER_SETTINGS_UPDATED, "Interface.RetrieveCharacterSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.WINDOWS_SETTINGS_UPDATED, "Interface.UpdateWindowsSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.OPEN_CRIMINAL_NOTIFICATION_GUMP, "Interface.ShowCriminalNotificationGump")
	WindowRegisterEventHandler( "Root", SystemData.Events.SHOW_PARTY_INVITE, "Interface.ShowPartyInvite")
	
	WindowRegisterEventHandler("Root", SystemData.Events.ITEM_USE_REQUEST, "Interface.ItemUseRequest")	
	WindowRegisterEventHandler("Root", SystemData.Events.SPELL_USE_REQUEST, "Interface.SpellUseRequest")
	WindowRegisterEventHandler("Root", SystemData.Events.SKILL_USE_REQUEST, "Interface.SkillUseRequest")
	WindowRegisterEventHandler("Root", SystemData.Events.VIRTUE_USE_REQUEST, "Interface.VirtueUseRequest")
	
	WindowRegisterEventHandler( "Root", SystemData.Events.TEXT_ARRIVED,      "Interface.NewChatText") 
	
	WindowRegisterEventHandler("Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "Interface.OnDebugPrint")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_BACKPACK_WINDOW, "Actions.ToggleInventoryWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_PAPERDOLL_CHARACTER_WINDOW, "Actions.TogglePaperdollWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_GUILD_WINDOW, "Actions.ToggleGuildWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_SKILLS_WINDOW, "Actions.ToggleSkillsWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_VIRTUES_WINDOW, "Actions.ToggleVirtuesWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_QUEST_LOG_WINDOW, "Actions.ToggleQuestWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_HELP_WINDOW, "Actions.ToggleHelpWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_WORLD_MAP_WINDOW, "Actions.ToggleMapWindow")
end

function Interface.LoadVariables()

	--Builds the data for player
	UOBuildTableFromCSV("Data/GameData/itemprop.csv", "PlayerItemPropCSV")	
	UOBuildTableFromCSV("Data/GameData/playerstats.csv", "PlayerStatsDataCSV")	
	WindowData.PlayerStatsDataCSV[Spellbook.tithId].iconId = 85800

	Interface.GridLegacy =								Interface.LoadBoolean( "GridLegacy" , Interface.GridLegacy )
	Interface.BackpackOpen =							Interface.LoadBoolean( "BackpackOpen" , Interface.BackpackOpen )
	ContainerWindow.Locked =							Interface.LoadBoolean( "LockedBackpack" , false )
	Interface.EnableContainerGrid =						Interface.LoadBoolean( "EnableContainerGrid" , Interface.EnableContainerGrid )
	Interface.AlternateGrid =							Interface.LoadBoolean( "AlternateGrid" , Interface.AlternateGrid )
	Interface.ExtraBrightContainers =					Interface.LoadBoolean( "ExtraBrightContainers" , Interface.ExtraBrightContainers )

	PetWindow.CloseLeft =								Interface.LoadBoolean( "PetWindowCloseLeft", true )
	PetWindow.PetWindowHidden =							Interface.LoadBoolean( "PetWindowHidden", Interface.PetWindowHidden )
	
	Interface.ShowMapCombos =							Interface.LoadBoolean( "ShowMapCombos", Interface.ShowMapCombos )
	
	Interface.AuraEnabled =								Interface.LoadBoolean( "AuraEnabled", Interface.AuraEnabled )
	
	Interface.RedButton =								Interface.LoadNumber( "RedButton", Interface.RedButton )
	Interface.GreenButton =								Interface.LoadNumber( "GreenButton", Interface.GreenButton )
	Interface.BlueButton =								Interface.LoadNumber( "BlueButton", Interface.BlueButton )
	
	Interface.RedButton2 =								Interface.LoadNumber( "RedButton2", Interface.RedButton2 )
	Interface.GreenButton2 =							Interface.LoadNumber( "GreenButton2", Interface.GreenButton2 )
	Interface.BlueButton2 =								Interface.LoadNumber( "BlueButton2", Interface.BlueButton2 )

	Interface.RedButton3 =								Interface.LoadNumber( "RedButton3", Interface.RedButton3 )
	Interface.GreenButton3 =							Interface.LoadNumber( "GreenButton3", Interface.GreenButton3 )
	Interface.BlueButton3 =								Interface.LoadNumber( "BlueButton3", Interface.BlueButton3 )
	
	Interface.RedDef =									Interface.LoadNumber( "RedDef", Interface.RedDef )
	Interface.GreenDef =								Interface.LoadNumber( "GreenDef", Interface.GreenDef )
	Interface.BlueDef =									Interface.LoadNumber( "BlueDef", Interface.BlueDef )
	
	Interface.ArteReceived =							Interface.LoadNumber( "ArteReceived", Interface.ArteReceived )
	Interface.ResReceived =								Interface.LoadNumber( "ResReceived", Interface.ResReceived )
	Interface.AirReceived =								Interface.LoadNumber( "AirReceived", Interface.AirReceived )
	Interface.TokensReceived =							Interface.LoadNumber( "AirReceived", Interface.TokensReceived )
	Interface.SeedsReceived =							Interface.LoadNumber( "SeedsReceived", Interface.SeedsReceived )
	
	Interface.PaperdollOpen =							Interface.LoadBoolean( "PaperdollOpen", Interface.PaperdollOpen )
	
	Interface.DefaultPet1 = 							Interface.LoadNumber( "DefaultPet1" , 0 )
	Interface.DefaultPet2 = 							Interface.LoadNumber( "DefaultPet2" , 0 )
	Interface.DefaultPet3 = 							Interface.LoadNumber( "DefaultPet3" , 0 )
	Interface.DefaultPet4 = 							Interface.LoadNumber( "DefaultPet4" , 0 )
	Interface.DefaultPet5 = 							Interface.LoadNumber( "DefaultPet5" , 0 )
	
	Interface.DefaultObject1 = 							Interface.LoadNumber( "DefaultObject1" , 0 )
	Interface.DefaultObject2 = 							Interface.LoadNumber( "DefaultObject2" , 0 )
	Interface.DefaultObject3 = 							Interface.LoadNumber( "DefaultObject3" , 0 )
	Interface.DefaultObject4 = 							Interface.LoadNumber( "DefaultObject4" , 0 )
	Interface.DefaultObject5 = 							Interface.LoadNumber( "DefaultObject5" , 0 )
	
	Interface.AlacrityStart =							Interface.LoadNumber( "AlacrityStart" , 0 )
	
	Interface.ArteReceived =							Interface.LoadNumber( "ArteReceived" , Interface.ArteReceived )
	Interface.ResReceived =								Interface.LoadNumber( "ResReceived" , Interface.ResReceived )
	Interface.AirReceived =								Interface.LoadNumber( "AirReceived" , Interface.AirReceived )
	Interface.SeedsReceived =							Interface.LoadNumber( "SeedsReceived" , Interface.SeedsReceived )
	Interface.TokensReceived =							Interface.LoadNumber( "TokensReceived" , Interface.TokensReceived )
	
	ActionsWindow.CurrentGroup =						Interface.LoadNumber( "ActionsWindowCurrentGroup", ActionsWindow.CurrentGroup )
		
	Interface.BlockOthersPaperdoll =					Interface.LoadBoolean( "BlockOthersPaperdoll", Interface.BlockOthersPaperdoll ) 
	
	Interface.TrapBoxID = 								Interface.LoadNumber( "TrapBoxID" , Interface.TrapBoxID )
	Interface.LootBoxID = 								Interface.LoadNumber( "LootBoxID" , Interface.LootBoxID )
	
	Interface.CurrentHonor =							Interface.LoadNumber( "CurrentHonor", Interface.CurrentHonor )
	
	Interface.OverhedTextSize =							Interface.LoadNumber( "OverhedTextSize" , Interface.OverhedTextSize )
	
	Interface.MenuBar =									Interface.LoadNumber( "MenuBar" , Interface.MenuBar )
	Interface.FirstImprovement =						Interface.LoadBoolean( "FirstImprovement", Interface.FirstImprovement ) 
	Interface.InitialPositions =						Interface.LoadBoolean( "InitialPositions", Interface.InitialPositions ) 
	
	Interface.NewPlayerInventoryToggled =				Interface.LoadBoolean( "NewPlayerInventoryToggled", Interface.NewPlayerInventoryToggled ) 
	Interface.NewPlayerPaperdollToggled =				Interface.LoadBoolean( "NewPlayerPaperdollToggled", Interface.NewPlayerPaperdollToggled ) 
	Interface.NewPlayerMapToggled =						Interface.LoadBoolean( "NewPlayerMapToggled", Interface.NewPlayerMapToggled ) 
	Interface.NewPlayerWarToggled =						Interface.LoadBoolean( "NewPlayerWarToggled", Interface.NewPlayerWarToggled ) 
		
	Interface.LockChatLine = 							Interface.LoadBoolean( "LockChatLine" , Interface.LockChatLine )
	
	Interface.EnableSnapping = 							Interface.LoadBoolean( "EnableSnapping" , Interface.EnableSnapping )
	
	SystemData.Settings.GameOptions.noWarOnPets =		Interface.LoadBoolean( "noWarOnPets" , true )
	SystemData.Settings.GameOptions.noWarOnParty =		Interface.LoadBoolean( "noWarOnParty" , true )
	SystemData.Settings.GameOptions.noWarOnFriendly =	Interface.LoadBoolean( "noWarOnFriendly" , true )
	
	CenterScreenText.EnableIgnoreSummons =				Interface.LoadBoolean( "EnableIgnoreSummons" , CenterScreenText.EnableIgnoreSummons )
	CenterScreenText.LowHPPercDisabled =				Interface.LoadBoolean( "LowHPPercDisabled" , CenterScreenText.LowHPPercDisabled )
	CenterScreenText.LowHPPETPercDisabled =				Interface.LoadBoolean( "LowHPPETPercDisabled" , CenterScreenText.LowHPPETPercDisabled )
	CenterScreenText.LowHPPerc =						Interface.LoadNumber( "LowHPPerc" , CenterScreenText.LowHPPerc )
	CenterScreenText.LowPETHPPerc =						Interface.LoadNumber( "LowPETHPPerc" , CenterScreenText.LowPETHPPerc )
	
	Interface.StatusButtons =							Interface.LoadBoolean( "StatusButtons" , Interface.StatusButtons )
	Interface.AuraEnabled =								Interface.LoadBoolean( "AuraEnabled" , Interface.AuraEnabled )
	SystemData.Settings.GameOptions.showStrLabel =		Interface.LoadBoolean( "StatusLabels", true ) 
	Interface.EnableMobileArrow =						Interface.LoadBoolean( "EnableMobileArrow", Interface.EnableMobileArrow ) 
	
	MobileHealthBar.LegacyCloseStyle =					Interface.LoadBoolean( "LegacyCloseStyle", MobileHealthBar.LegacyCloseStyle ) 
	MobileHealthBar.PetLegacyCloseStyle =				Interface.LoadBoolean( "PetLegacyCloseStyle", MobileHealthBar.PetLegacyCloseStyle ) 
	Interface.ShowCloseExtract =						Interface.LoadBoolean( "ShowCloseExtract", Interface.ShowCloseExtract ) 
	Interface.HealthBarWod =							Interface.LoadBoolean( "HealthBarWod", Interface.HealthBarWod ) 
	
	Interface.RedButton =								Interface.LoadNumber( "RedButton", Interface.RedButton )
	Interface.GreenButton = 							Interface.LoadNumber( "GreenButton", Interface.GreenButton )
	Interface.BlueButton =								Interface.LoadNumber( "BlueButton", Interface.BlueButton )
	
	Interface.RedButton2 =								Interface.LoadNumber( "RedButton2", Interface.RedButton2 )
	Interface.GreenButton2 =							Interface.LoadNumber( "GreenButton2", Interface.GreenButton2 )
	Interface.BlueButton2 =								Interface.LoadNumber( "BlueButton2", Interface.BlueButton2 )

	Interface.RedButton3 =								Interface.LoadNumber( "RedButton3", Interface.RedButton3 )
	Interface.GreenButton3 =							Interface.LoadNumber( "GreenButton3", Interface.GreenButton3 )
	Interface.BlueButton3 =								Interface.LoadNumber( "BlueButton3", Interface.BlueButton3 )
	
	Interface.RedDef =									Interface.LoadNumber( "RedDef", Interface.RedDef )
	Interface.GreenDef =								Interface.LoadNumber( "GreenDef", Interface.GreenDef )
	Interface.BlueDef =									Interface.LoadNumber( "BlueDef", Interface.BlueDef )
	
	Interface.ShowSpellName =							Interface.LoadBoolean( "ShowSpellName", Interface.ShowSpellName )
	Interface.DisableSpells =							Interface.LoadBoolean( "DisableSpells", Interface.DisableSpells )
	Interface.noPoisonOthers =							Interface.LoadBoolean( "noPoisonOthers", Interface.noPoisonOthers )

	OverheadText.clickableNames =						Interface.LoadBoolean( "clickableNames", OverheadText.clickableNames )
	OverheadText.OverhedTextSize =						Interface.LoadNumber( "OverhedTextSize", OverheadText.OverhedTextSize )
	OverheadText.FontIndex =							Interface.LoadNumber("OverheadTextFontIndex", OverheadText.FontIndex)
	OverheadText.NameFontIndex =						Interface.LoadNumber("OverheadTextNameFontIndex", OverheadText.NameFontIndex)
	OverheadText.SpellsFontIndex =						Interface.LoadNumber("OverheadTextSpellsFontIndex", OverheadText.SpellsFontIndex)
	OverheadText.DamageFontIndex =						Interface.LoadNumber("OverheadTextDamageFontIndex", OverheadText.DamageFontIndex)
	
	TextParsing.Heal  =									Interface.LoadColor("TextParsingHeal", TextParsing.Heal)
	TextParsing.Curse  =								Interface.LoadColor("TextParsingCurse", TextParsing.Curse)
	TextParsing.Paralyze = 								Interface.LoadColor("TextParsingParalyze", TextParsing.Paralyze)
	TextParsing.Neutral =								Interface.LoadColor("TextParsingNeutral", TextParsing.Neutral)
	
	TextParsing.OverHeadError = 						Interface.LoadColor("TextParsingOverHeadError", TextParsing.OverHeadError)
	TextParsing.SpecialColor =  						Interface.LoadColor("TextParsingSpecialColor", TextParsing.SpecialColor)
	
	DamageWindow.OTHERGETDAMAGE_COLOR = 				Interface.LoadColor("DamageWindowOTHERGETDAMAGE_COLOR", DamageWindow.OTHERGETDAMAGE_COLOR)
	DamageWindow.YOUGETAMAGE_COLOR =					Interface.LoadColor("DamageWindowYOUGETAMAGE_COLOR", DamageWindow.YOUGETAMAGE_COLOR)
	DamageWindow.PETGETDAMAGE_COLOR =					Interface.LoadColor("DamageWindowPETGETDAMAGE_COLOR", DamageWindow.PETGETDAMAGE_COLOR)
	
	SpellsInfo.PHYSICAL =								Interface.LoadColor("SpellsInfoPHYSICAL",SpellsInfo.PHYSICAL)
	SpellsInfo.FIRE =									Interface.LoadColor("SpellsInfoFIRE",SpellsInfo.FIRE)
	SpellsInfo.COLD  =									Interface.LoadColor("SpellsInfoCOLD",SpellsInfo.COLD)
	SpellsInfo.POISON  =								Interface.LoadColor("SpellsInfoPOISON",SpellsInfo.POISON)
	SpellsInfo.ENERGY  =								Interface.LoadColor("SpellsInfoENERGY",SpellsInfo.ENERGY)
	SpellsInfo.Chaos  =									Interface.LoadColor("SpellsInfoChaos",SpellsInfo.Chaos)
	
	Interface.WarShield =								Interface.LoadBoolean( "WarShield", Interface.WarShield )
	ContainerWindow.EnableAutoIgnoreCorpses =			Interface.LoadBoolean( "AutoIgnoreCorpses", ContainerWindow.EnableAutoIgnoreCorpses)
	
	Interface.ForceEnchant =							Interface.LoadNumber("ForceEnchant", Interface.ForceEnchant)
	Interface.ForceAnimal =								Interface.LoadNumber("ForceAnimal", Interface.ForceAnimal)
	Interface.ForceSpellTrigger =						Interface.LoadNumber("ForceSpellTrigger", Interface.ForceSpellTrigger)
	Interface.ForcePolymorph =							Interface.LoadNumber("ForcePolymorph", Interface.ForcePolymorph)
	Interface.ForceFamiliar =							Interface.LoadNumber("ForceFamiliar", Interface.ForceFamiliar)
	
	Interface.AllowTrades =								Interface.LoadBoolean( "AllowTrades", Interface.AllowTrades )
	
	
end

function Interface.CreateWindows()
	CreateWindow( "ResizeWindow", true )
	CreateWindow( "MainMenuWindow", false )
	CreateWindow( "SettingsWindow", false )
	CreateWindow( "CharacterSheet", false )
	CreateWindow( "CharacterAbilities", false )
	CreateWindow( "ItemProperties", false )
	CreateWindow( "SkillsWindow", false )
	CreateWindow( "MacroWindow", false )
	CreateWindow( "StatusWindow", true)
	Organizer.Initialize()
	CreateWindow( "TargetWindow", false )
	CreateWindow( "ContextMenu", false )
	CreateWindow( "ActionsWindow", false )
	CreateWindow( "ActionEditText", false )
	CreateWindow( "ActionEditSlider", false )
	CreateWindow( "ActionEditMacro", false )
	CreateWindow( "ActionEditEquip", false )
	CreateWindow( "ActionEditUnEquip", false )
	CreateWindow( "ActionEditArmDisarm", false )
	CreateWindow( "ActionEditTargetByResource", false )
	CreateWindow( "ActionEditTargetByObjectId", false )
	CreateWindow( "MapWindow", false )
	CreateWindow( "UserWaypointWindow", false)
	CreateWindow( "OrganizerWindow", true)
	CreateWindow( "ContainerSearchWindow", false)
	CreateWindow( "RenameWindow", false)
	CreateWindow( "PetWindow", true )
	CreateWindow( "MobilesOnScreenWindow", true)
	CreateWindow( "Compass", false)
	CreateWindow( "MapFindWindow", false)
	CreateWindow( "CenterScreenText", true)
	CreateWindow( "WarShield", Interface.WarShield)
	CreateWindow( "CrystalPortal", false)
	Interface.CreateTCTools()
end

function Interface.CreateTCTools()
	if (UserData.Settings.Login.lastShardSelected == 54 and not DoesWindowNameExist("TCTOOLSWindow")) then
		CreateWindowFromTemplate("TCTOOLSWindow", "TCTOOLS", "Root")
		WindowClearAnchors("TCTOOLSWindow")
		WindowAddAnchor("TCTOOLSWindow", "bottomright", "ResizeWindow", "bottomright", -10, -20)
		WindowSetShowing("TCTOOLSWindowIMG", false)
		SnapUtils.SnappableWindows["TCTOOLSWindow"] = true
		WindowUtils.RestoreWindowPosition("TCTOOLSWindow", false)
	end
end

function Interface.InitializeWindows()
	SpellsInfo.Initialize()
	HotbarSystem.Initialize()
	GGManager.Initialize()	
	DamageWindow.Initialize()
	EquipmentData.Initialize()
	HealthBarManager.Initialize()
	ObjectHandleWindow.Initialize()
	OverheadText.InitializeEvents()
    StaticTextWindow.Initialize()
    MapCommon.Initialize()
    QueryWindow.Initialize()
    AdvancedBuff.Initialize()
    StatusWindow.Initialize()
    BuffDebuff.Initialize()
	LegacyRunebookLoader.Initialize()
	PetWindow.UpdatePet()
end

function Interface.InitializeSOSWaypoints()
	if Interface.SOSWaypointsAll == nil then
		Interface.SOSWaypointsAll = {}
	end

	local shard = UserData.Settings.Login.lastShardSelected
	if Interface.SOSWaypointsAll[shard] == nil then
		Interface.SOSWaypointsAll[shard] = {}
	end
	
	local user = UserData.Settings.Login.lastUserName

	if Interface.SOSWaypointsAll[shard][user] == nil then
		Interface.SOSWaypointsAll[shard][user] = {}
	end
	
	Interface.SOSWaypoints = Interface.SOSWaypointsAll[shard][user]
	Interface.SOSWaypointsInitialized = true
end

function Interface.CreateOverrides()
	Interface.org_RegisterWindowData = RegisterWindowData
    RegisterWindowData = Interface.RegisterWindowData
    
	Interface.org_RequestContextMenu = RequestContextMenu
    RequestContextMenu = Interface.RequestContextMenu
    
    Interface.org_DragSlotQuantityRequestResult = DragSlotQuantityRequestResult
    DragSlotQuantityRequestResult = Interface.DragSlotQuantityRequestResult
    
    Interface.org_HandleSingleLeftClkTarget = HandleSingleLeftClkTarget
    HandleSingleLeftClkTarget = Interface.HandleSingleLeftClkTarget
    
    Interface.org_WindowRegisterEventHandler = WindowRegisterEventHandler
    WindowRegisterEventHandler = Interface.WindowRegisterEventHandler
end

function Interface.InterfaceInitialize() 
	if( not Interface.FirstImprovement) then
		Interface.FirstImprovement = true
		Interface.SaveBoolean( "FirstImprovement", Interface.FirstImprovement )
		
		SystemData.Settings.GameOptions.enableAutorun = true		
		SystemData.Settings.GameOptions.holdShiftToUnstack = true 
		SystemData.Settings.Interface.defaultCorpseMode = "List"
		SystemData.Settings.GameOptions.showStrLabel = true
		
		Interface.SaveBoolean( "StatusLabels", SystemData.Settings.GameOptions.showStrLabel )
		
		SystemData.Settings.GameOptions.mouseScrollUpAction = SystemData.Settings.GameOptions.MOUSESCROLL_NONE
		SystemData.Settings.GameOptions.mouseScrollDownAction = SystemData.Settings.GameOptions.MOUSESCROLL_NONE
		
		SystemData.Settings.Interface.customUiScale = 1
		
		if ( UserSettingsChanged() ) then
			InterfaceCore.ReloadUI()
			return
		end
	end	
	local hb = -1
	if( not Interface.MenuBar or not DoesWindowNameExist("Hotbar" .. Interface.MenuBar)) then	
		Interface.MenuBar = HotbarSystem.SpawnNewHotbar()
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5006, 860006, Interface.MenuBar,  1)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5007, 860007, Interface.MenuBar,  2)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5003, 860003, Interface.MenuBar,  3)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5004, 860004, Interface.MenuBar,  4)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5005, 860005, Interface.MenuBar,  5)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5008, 860008, Interface.MenuBar,  6)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5001, 860001, Interface.MenuBar,  7)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5002, 860002, Interface.MenuBar,  8)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5014, 860014, Interface.MenuBar,  9)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5015, 860015, Interface.MenuBar, 10)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5017, 860017, Interface.MenuBar, 11)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5011, 860011, Interface.MenuBar, 12)
		
		Interface.SaveNumber( "MenuBar", Interface.MenuBar )
		
		hb = HotbarSystem.SpawnNewHotbar()
	end	
	if( not Interface.InitialPositions) then
		
		local x,y = WindowGetDimensions("Root")
		WindowSetDimensions("ResizeWindow", x - 550, y - 300)
		
		--Hotbar.SetLocked(Interface.MenuBar, true)
		WindowClearAnchors("Hotbar" .. Interface.MenuBar)
		WindowAddAnchor("Hotbar" .. Interface.MenuBar, "bottom", "Root", "bottom", 0,0)
		
		WindowClearAnchors("WarShield")
		local x, y= WindowGetOffsetFromParent("WarShield")
		WindowClearAnchors("WarShield")
		WindowSetOffsetFromParent("WarShield", x,y)
		
		WindowClearAnchors("AdvancedBuffEvil")
		local x, y= WindowGetOffsetFromParent("AdvancedBuffEvil")
		WindowClearAnchors("AdvancedBuffEvil")
		WindowSetOffsetFromParent("AdvancedBuffEvil", x,y)
		
		WindowClearAnchors("StatusWindow")
		WindowAddAnchor("StatusWindow", "topleft", "ResizeWindow", "topleft", 30,30)
		local x, y= WindowGetOffsetFromParent("StatusWindow")
		WindowClearAnchors("StatusWindow")
		WindowSetOffsetFromParent("StatusWindow", x,y)
		
		WindowClearAnchors("AdvancedBuffGood")
		local x, y= WindowGetOffsetFromParent("AdvancedBuffGood")
		WindowClearAnchors("AdvancedBuffGood")
		WindowSetOffsetFromParent("AdvancedBuffGood", x,y)
		
		WindowClearAnchors("ResizeWindow")
		WindowAddAnchor("ResizeWindow", "topright", "PetWindow", "topleft", 5, 0)
		local x, y= WindowGetOffsetFromParent("ResizeWindow")
		WindowClearAnchors("ResizeWindow")
		WindowSetOffsetFromParent("ResizeWindow", x,y)
		ResizeWindow.UpdateViewport()
		
		--Hotbar.SetLocked(1, true)
		WindowClearAnchors("Hotbar1")
		WindowAddAnchor("Hotbar1", "bottomleft", "ResizeWindow", "topleft", 40, 0)
		local x, y= WindowGetOffsetFromParent("Hotbar1")
		WindowClearAnchors("Hotbar1")
		WindowSetOffsetFromParent("Hotbar1", x,y)
		
		--Hotbar.SetLocked(hb, true)
		WindowClearAnchors("Hotbar" .. hb)
		WindowAddAnchor("Hotbar" .. hb, "topright", "Hotbar1", "topleft", 0, 0)
		local x, y= WindowGetOffsetFromParent("Hotbar" .. hb)
		WindowClearAnchors("Hotbar" .. hb)
		WindowSetOffsetFromParent("Hotbar" .. hb, x,y)
		
		WindowClearAnchors("MapWindow")
		WindowAddAnchor("MapWindow", "topright", "ResizeWindow", "topleft", 0, 0)
		local x, y= WindowGetOffsetFromParent("MapWindow")
		WindowClearAnchors("MapWindow")
		WindowSetOffsetFromParent("MapWindow", x,y)
		
		WindowClearAnchors("TCTOOLSWindow")
		WindowAddAnchor("TCTOOLSWindow", "bottomright", "ResizeWindow", "bottomright", 0, -20)
		local x, y= WindowGetOffsetFromParent("TCTOOLSWindow")
		WindowClearAnchors("TCTOOLSWindow")
		WindowSetOffsetFromParent("TCTOOLSWindow", x,y)
		
		WindowClearAnchors("TargetWindow")
		WindowAddAnchor("TargetWindow", "top", "ResizeWindow", "top", 0, 20)
		local x, y= WindowGetOffsetFromParent("TargetWindow")
		WindowClearAnchors("TargetWindow")
		WindowSetOffsetFromParent("TargetWindow", x,y)
				
		Interface.BackpackFirstPositioning = true
		Interface.NewChatFirstPositioning = true
		Interface.PaperdollFirstPositioning = true
		Interface.GChatFirstPositioning = true
		
		local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, true)
		if mobileData and mobileData.Race == PaperdollWindow.GARGOYLE then
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_RACIAL_ABILITY, 1, 3021, 1,  1)
		end
		
		Interface.InitialPositions = true
		Interface.SaveBoolean("InitialPositions", Interface.InitialPositions )
		
	end
end

-------------------------------------------------------------------------------
--
-- TIMERS
--
-------------------------------------------------------------------------------

function Interface.Update( timePassed )
	ok, err = pcall(StatusWindow.EnableInput, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.ChatFixer, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	if ObjectHandleWindow.Active then
		ObjectHandleWindow.RefreshTimer = ObjectHandleWindow.RefreshTimer + timePassed
	end
	
	ok, err = pcall(BuffDebuff.Update, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(DamageWindow.UpdateTime, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(ResizeWindow.Update, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(OverheadText.Update, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(ContainerWindow.UpdatePickupTimer, timePassed)	
	Interface.ErrorTracker(ok, err)	

	ok, err = pcall(ContextMenu.Update, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(StaticTextWindow.Update, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(HotbarSystem.Update, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(MapCommon.Update, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.MapRefresh, timePassed)	
	Interface.ErrorTracker(ok, err)
		
	
	
	ok, err = pcall(QuickStats.OnUpdate, timePassed)
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.SummonsManager, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	Interface.DeltaTime = Interface.DeltaTime + timePassed	
	
	ok, err = pcall(Interface.SkillLocker, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.CheckLastTargetChanged, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	
	ok, err = pcall(Actions.MassOrganizer, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Actions.UndressAgent, timePassed)	
	Interface.ErrorTracker(ok, err)
		
	ok, err = pcall(Actions.Shuriken, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.SpellsTimer, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.Cooldowns, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.LoginTimeoutCheck, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(MapCommon.UpdateAreaInfo, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(PaperdollWindow.BlockPaperdolls, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.SpecialMovesManaCooldown, timePassed)	
	Interface.ErrorTracker(ok, err)
		
	ok, err = pcall(Interface.MobileArrowManager, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(Interface.UpdateWarButton, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(PaperdollWindow.OnUpdate, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.ClearWindowData, timePassed)	
	Interface.ErrorTracker(ok, err)
		
	ok, err = pcall(CenterScreenText.OnUpdate, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.SOSWaypointsCleaner, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(Interface.PropsCacheClear, timePassed)	
	Interface.ErrorTracker(ok, err)

	ok, err = pcall(Interface.BackpackCheck, timePassed)	
	Interface.ErrorTracker(ok, err)


	if (Interface.DeltaTime >= 1) then
		StatusWindow.UpdateStatus()
				
		if DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
			ok, err = pcall(PaperdollWindow.UpdateDurabilities, timePassed)	
			Interface.ErrorTracker(ok, err)
		end

		ok, err = pcall(Interface.PaperdollCheck, timePassed)	
		Interface.ErrorTracker(ok, err)
				
		ok, err = pcall(Interface.UpdateHealthbarStatus, timePassed)	
		Interface.ErrorTracker(ok, err)
		
		ok, err = pcall(Interface.ClockUpdater, timePassed)	
		Interface.ErrorTracker(ok, err)

		ok, err = pcall(TrackingPointer.UpdateAll, timePassed)	
		Interface.ErrorTracker(ok, err)

		if WindowData.PlayerStatus.PlayerId ~= 0 then
			ok, err = pcall(Interface.LowHPManager, timePassed)	
			Interface.ErrorTracker(ok, err)
		end
	
		Interface.DeltaTime = 0
	end	
	
	if WindowData.PlayerStatus.PlayerId ~= 0 then	
	
		if not Interface.SOSWaypointsInitialized then
			ok, err = pcall(Interface.InitializeSOSWaypoints)
			Interface.ErrorTracker(ok, err)
		end
		
		if not QuickStats.Initialized then
			ok, err = pcall(QuickStats.Initialize)
			Interface.ErrorTracker(ok, err)
		end
		
		ok, err = pcall(Interface.SkillsTrackerUpdate, timePassed)	
		Interface.ErrorTracker(ok, err)
	end
end

Interface.SOSWaypointsCleanerDelta = 0

function Interface.SOSWaypointsCleaner(timePassed)
	if not Interface.SOSWaypointsInitialized then
		return
	end
	if Interface.SOSWaypointsCleanerDelta < 5 then
		Interface.SOSWaypointsCleanerDelta = Interface.SOSWaypointsCleanerDelta + timePassed
		return
	else
		Interface.SOSWaypointsCleanerDelta = 0
	end
	for sosId, waypointID in pairs(Interface.SOSWaypoints) do
		if not DoesPlayerHaveItem(sosId) then
			UODeleteUserWaypoint(waypointID)
			Interface.SOSWaypoints[sosId] = nil
			MapCommon.UpdateWaypoints(MapCommon.ActiveView)
		end
	end

end

function Interface.PropsCacheClear(timePassed)
	--Debug.Print("PropsCacheClear")	
	if (not WindowGetShowing("ItemProperties")) then
		WindowData.ItemProperties[0] = {}
		if (WindowData.ItemProperties.CustomColorTitle) then
			WindowData.ItemProperties.CustomColorTitle.NotorietyEnable = false
			WindowData.ItemProperties.CustomColorTitle.NotorietyIndex = 0
			WindowData.ItemProperties.CustomColorBody.LabelIndex = 0
			WindowData.ItemProperties.CustomColorBody.Color = {r=0, g=0, b=0}
		end
	end
end

function Interface.UpdateWarButton(timePassed)
	if( WindowData.PlayerStatus.InWarMode ) then
        Actions.WarMode = 1       
        ButtonSetPressedFlag( "WarButton", true )
    else
        Actions.WarMode = 0
        ButtonSetPressedFlag( "WarButton", false )
    end
end

function Interface.MobileArrowManager(timePassed)
	--Debug.Print("MobileArrowManager")
	if	Interface.MobileArrowOver == 0 and
		MobileHealthBar.mouseOverId == 0 and
		PartyHealthBar.mouseOverId == 0 and
		not DoesWindowNameExist("MobileArrow") then
		
		return
	end
	if (Interface.EnableMobileArrow) then
		if (Interface.MobileArrowOver  == WindowData.PlayerStatus.PlayerId) then
			if (DoesWindowNameExist("MobileArrow")) then
				DetachWindowFromWorldObject( Interface.MobileArrowOver, "MobileArrow" )
				DestroyWindow("MobileArrow")
			end
			MobileHealthBar.mouseOverId = 0
			PartyHealthBar.mouseOverId = 0
			Interface.MobileArrowOver = 0
		end
		if (not DoesWindowNameExist("MobileArrow")) then
			CreateWindow( "MobileArrow", false )						
			WindowSetScale("MobileArrow", 0.4)
			AnimatedImageStartAnimation( "MobileArrowAnim", 1, true, false, 0.0 )
		end
		DetachWindowFromWorldObject( Interface.MobileArrowOver, "MobileArrow" )
		
		Interface.MobileArrowOver = WindowGetId("MobileArrow")
		local data = WindowData.MobileName[Interface.MobileArrowOver]
		if data then
			local textColor = NameColor.TextColors[data.Notoriety+1]
			WindowSetTintColor("MobileArrow", textColor.r, textColor.g, textColor.b)		
		end
		AttachWindowToWorldObject( Interface.MobileArrowOver, "MobileArrow" )
		if (MobileHealthBar.mouseOverId ~= Interface.MobileArrowOver and MobileHealthBar.mouseOverId ~= 0 and MobileHealthBar.mouseOverId ~= WindowData.PlayerStatus.PlayerId and not MobileHealthBar.windowDisabled[MobileHealthBar.mouseOverId]) then
			
			if (Interface.MobileArrowOver ~= MobileHealthBar.mouseOverId) then
				Interface.MobileArrowOver = MobileHealthBar.mouseOverId
				WindowSetId("MobileArrow", Interface.MobileArrowOver)
				WindowSetShowing("MobileArrow", true)
			end

			AttachWindowToWorldObject( Interface.MobileArrowOver, "MobileArrow" )
		elseif ((MobileHealthBar.mouseOverId == 0 or MobileHealthBar.mouseOverId ~= Interface.MobileArrowOver) and PartyHealthBar.mouseOverId ~= 0 and PartyHealthBar.mouseOverId ~= WindowData.PlayerStatus.PlayerId and not PartyHealthBar.windowDisabled[MobileHealthBar.mouseOverId]) then
			
			if (Interface.MobileArrowOver ~= PartyHealthBar.mouseOverId) then
				Interface.MobileArrowOver = PartyHealthBar.mouseOverId
				WindowSetId("MobileArrow", Interface.MobileArrowOver)
				WindowSetShowing("MobileArrow", true)
				
			end

			AttachWindowToWorldObject( Interface.MobileArrowOver, "MobileArrow" )
		elseif(Interface.MobileArrowOver == 0) then
			if (DoesWindowNameExist("MobileArrow")) then
				DetachWindowFromWorldObject( Interface.MobileArrowOver, "MobileArrow" )
				DestroyWindow("MobileArrow")
			end
		else
			if (DoesWindowNameExist("MobileArrow")) then
				DetachWindowFromWorldObject( Interface.MobileArrowOver, "MobileArrow" )
			end
		end
	else
		if (DoesWindowNameExist("MobileArrow")) then
			DestroyWindow("MobileArrow")
		end
	end
end


function Interface.SpecialMovesManaCooldown(timePassed)
	if Interface.LastSpecialMoveTime > 0 then
		Interface.LastSpecialMoveTime = Interface.LastSpecialMoveTime - timePassed
	end
end

function Interface.LoginTimeoutCheck(timePassed)
	if (DoesWindowNameExist("LogOutWarningDialog")) then
		local time = Interface.CanLogout - Interface.TimeSinceLogin
		if (time > 0) then
			local min = math.floor(time/60)
			if min > 0 then

				timer = StringToWString(tostring(min)	.. " minute")
				local sec = time - (min * 60)
				timer = timer .. L" and " .. StringToWString(tostring(sec)	.. " seconds")
			else
				timer = StringToWString(tostring(time)	.. " seconds")
			end
			LabelSetText("LogOutWarningDialogNormalText",ReplaceTokens(GetStringFromTid(1155273), {timer}))
		else
			BroadcastEvent( SystemData.Events.LOG_OUT )
		end
	end
end

function Interface.Cooldowns(timePassed)
	if HotbarSystem.GrapeDelayTime > 0 then
		HotbarSystem.GrapeDelayTime = HotbarSystem.GrapeDelayTime - timePassed
	end
	if HotbarSystem.AppleDelayTime > 0 then
		HotbarSystem.AppleDelayTime = HotbarSystem.AppleDelayTime - timePassed
	end
	if HotbarSystem.HealPotDelayTime > 0 then
		HotbarSystem.HealPotDelayTime = HotbarSystem.HealPotDelayTime - timePassed
	end
	if HotbarSystem.BandageDelayTime > 0 then
		HotbarSystem.BandageDelayTime = HotbarSystem.BandageDelayTime - timePassed
	end
	if HotbarSystem.StunTime > 0 then
		HotbarSystem.StunTime = HotbarSystem.StunTime - timePassed
	end
	if HotbarSystem.EvasionCooldown > 0 then
		HotbarSystem.EvasionCooldown = HotbarSystem.EvasionCooldown - timePassed
	end
	if HotbarSystem.AttunementCooldown > 0 then
		HotbarSystem.AttunementCooldown = HotbarSystem.AttunementCooldown - timePassed
	end
	if HotbarSystem.EtherealVoyageCooldown > 0 then
		HotbarSystem.EtherealVoyageCooldown = HotbarSystem.EtherealVoyageCooldown - timePassed
	end
	if HotbarSystem.ReflectionCooldown > 0 then
		HotbarSystem.ReflectionCooldown = HotbarSystem.ReflectionCooldown - timePassed
	end
	if HotbarSystem.SkillDelayTime > 0 then
		HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime - timePassed
	end
end
	
Interface.SpellRecovery = 0
function Interface.SpellsTimer(timePassed)
	local SpellSpeed = Interface.CurrentSpell
	if SpellSpeed.casting then
		SpellSpeed.ActualSpeed = SpellSpeed.ActualSpeed + timePassed
		if (SpellSpeed.casting and SpellSpeed.ActualSpeed > SpellSpeed.UnlaggedSpeed * 5 ) then
			SpellSpeed.casting = false
			SpellSpeed.ready =true
			Interface.SpellRecovery = SpellsInfo.GetRecoverySpeed()
			Interface.OnSpellCastedSuccessfully(Interface.CurrentSpell.SpellId)
		end
		if (SpellSpeed.ActualSpeed > SpellSpeed.UnlaggedSpeed) then
			Interface.OnSpellCastedSuccessfully(Interface.CurrentSpell.SpellId)
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			Interface.SpellRecovery = SpellsInfo.GetRecoverySpeed()
			return
		end
		if (SpellSpeed.CheckFizzle) then
			Interface.OnSpellCastFailed(SpellSpeed.SpellId )
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			Interface.SpellRecovery = SpellsInfo.GetRecoverySpeed()
			return
		end
		if( (WindowData.Cursor ~= nil and WindowData.Cursor.target == true)) then
			Interface.OnSpellCastedSuccessfully(Interface.CurrentSpell.SpellId)
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
		end
	elseif  Interface.SpellRecovery > 0 then
		Interface.SpellRecovery = Interface.SpellRecovery - timePassed
	end
	
end


Interface.chatFixed = false
function Interface.ChatFixer(timePassed)
	if not NewChatWindow and not Interface.chatFixed then
		return
	end
	
	if WindowData.PlayerStatus.PlayerId ~= 0 then
		if not NewChatWindow.Initialized then
			local ok, err = pcall(NewChatWindow.Initialize)
			Interface.ErrorTracker(ok, err)
		end
	end
	--Debug.Print("CHAT FIXER")
	ChatWindow.OnKeyEnter = Interface.ChatWindowOnKeyEnter
	ChatWindow.OnKeyTab = NewChatWindow.OnKeyTab
	ChatWindow.DoChatTextReplacement = NewChatWindow.DoChatTextReplacement
	ChatWindow.ResetTextBox = Interface.ChatWindowResetTextBox
	ChatWindow.SwitchChannelWithExistingText = Interface.ChatWindowSwitchChannelWithExistingText
	if (WindowGetShowing("NewChatWindow")) then
		WindowSetShowing("ChatWindowInputTextButton", false)
		if (DoesWindowNameExist("NewChatWindowInputTextButton")) then
			WindowSetShowing("NewChatWindowInputTextButton", true)
		else
			CreateWindow("NewChatWindowInputTextButton", true)
			WindowClearAnchors("NewChatWindowInputTextButton")
			WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "ResizeWindow", "bottomleft", 0, -6)
		end
		for key, wnd in pairs(ChatWindow.Windows) do
			WindowSetShowing(wnd.wndName, not WindowGetShowing("NewChatWindow"))
		end
		
		if (ChatWindowContainerTextInput.TextUpdated == true) then
			NewChatWindow.DoChatTextReplacement ()
			-- Make sure to reset the var because we handled this update
			ChatWindowContainerTextInput.TextUpdated = false
		end
	else
		WindowSetShowing("ChatWindowInputTextButton", true)
	end
	
	if (DoesWindowNameExist("ChatWindow") and not ChatWindow.Settings.autohide ) then
		for idxW, wnd in pairs(ChatWindow.Windows) do
			ChatWindow.PerformFadeIn(idxW)
		end
	end
	
    
	if (Interface.LockChatLine) then
		if (DoesWindowNameExist("ChatWindowInputTextButton")) then
			WindowClearAnchors("ChatWindowInputTextButton")
			WindowAddAnchor("ChatWindowInputTextButton", "bottomleft", "ResizeWindow", "bottomleft", 0, -6)
			if (DoesWindowNameExist("NewChatWindowInputTextButton")) then
				WindowClearAnchors("NewChatWindowInputTextButton")
				WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "ResizeWindow", "bottomleft", 0, -6)
			end
		end
		if (DoesWindowNameExist("ChatWindowContainer")) then
			WindowClearAnchors("ChatWindowContainer")
			if ( WindowGetShowing("NewChatWindow") ) then
				WindowAddAnchor("ChatWindowContainer", "bottomleft", "NewChatWindowInputTextButton", "bottomleft", 32, 5)
			else
				WindowAddAnchor("ChatWindowContainer", "bottomleft", "ChatWindowInputTextButton", "bottomleft", 25, 5)
			end
			WindowAddAnchor("ChatWindowContainer", "bottomright", "ResizeWindow", "bottomright", -50, 0)
		end
		if (DoesWindowNameExist("ChatWindowContainerTextInput")) then
			WindowClearAnchors("ChatWindowContainerTextInput")
			local x, y = WindowGetDimensions( "ChatWindowContainerChannelLabel" )
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomleft", "ChatWindowContainerChannelLabel", "bottomleft", x + 5, -4)
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 0)
			WindowSetLayer("ChatWindowContainerTextInput", Window.Layers.BACKGROUND	)
		end
	elseif (WindowGetShowing("NewChatWindow")) then
		WindowClearAnchors("NewChatWindowInputTextButton")
		WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "NewChatWindow", "bottomleft", 0, 38)
		if (DoesWindowNameExist("ChatWindowContainer")) then
			WindowClearAnchors("ChatWindowContainer")
			WindowAddAnchor("ChatWindowContainer", "bottomleft", "NewChatWindow", "bottomleft", 32, 38)
			WindowAddAnchor("ChatWindowContainer", "bottomright", "NewChatWindow", "bottomright", 0, 38)
		end
		if (DoesWindowNameExist("ChatWindowContainerTextInput")) then
			WindowClearAnchors("ChatWindowContainerTextInput")
			local x, y = WindowGetDimensions( "ChatWindowContainerChannelLabel" )
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomleft", "ChatWindowContainerChannelLabel", "bottomleft", x + 5, -4)
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 0)
			WindowSetLayer("ChatWindowContainerTextInput", Window.Layers.BACKGROUND	)
		end
	end
	Interface.chatFixed = true
end

function Interface.ClockUpdater(timePassed)
	Interface.Clock.Timestamp, Interface.Clock.YYYY, Interface.Clock.MM, Interface.Clock.DD, Interface.Clock.h, Interface.Clock.m, Interface.Clock.s  = GetCurrentDateTime()
	Interface.Clock.MM = Interface.Clock.MM + 1
	Interface.Clock.YYYY = 1900 + Interface.Clock.YYYY

	Interface.TimeSinceLogin = Interface.TimeSinceLogin + 1
end

function Interface.CheckLastTargetChanged(timePassed)
	if not WindowData.Cursor then
		WindowData.Cursor = {}
	end
	local newTarg = WindowData.Cursor.lastTarget
	if newTarg == nil then
		newTarg = 0
	end
	local oldTarg = Interface.LastTarget
	if oldTarg == nil then
		oldTarg = 0
	end
	
	if WindowData.Cursor.lastTarget ~= Interface.LastTarget then
		Interface.OnTarget(newTarg, oldTarg)
		Interface.LastTarget = WindowData.Cursor.lastTarget
	end
end

function Interface.PaperdollCheck(timePassed)

	if not Interface.NewPlayerPaperdollToggled and (not MapCommon.AreaDescription or MapCommon.AreaDescription == "") and Interface.TimeSinceLogin < 2 then
		return
	end
	
	if MapCommon.AreaDescription ~= "New Player Quest Area" then
		if (Interface.PaperdollOpen and not DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId)) then
			Interface.TogglePaperdollWindow()
		elseif DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
			if not WindowGetShowing("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
				Interface.TogglePaperdollWindow()
			end
		end
	elseif Interface.NewPlayerPaperdollToggled then
		if (Interface.PaperdollOpen and not DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId)) then
			Interface.TogglePaperdollWindow()
		elseif DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
			if not WindowGetShowing("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
				Interface.TogglePaperdollWindow()
			end
		end
	end

	if not DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
		if Interface.PaperdollOpen and (MapCommon.AreaDescription ~= "New Player Quest Area" or Interface.NewPlayerPaperdollToggled) then
			Interface.TogglePaperdollWindow()
		end
	end
end

function Interface.BackpackCheck(timePassed)
	if not Interface.NewPlayerInventoryToggled and (not MapCommon.AreaDescription or MapCommon.AreaDescription == "") and Interface.TimeSinceLogin < 2 then
		return
	end
	
	Interface.OpeningBpk = Interface.OpeningBpk + timePassed
	
	if ContainerWindow.PlayerBank == 0 then
		RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BANK)
		if WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] then
			ContainerWindow.PlayerBank = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId
		end
	end
	if MapCommon.AreaDescription ~= "New Player Quest Area" then
		if ContainerWindow.PlayerBackpack == 0 then
			RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
			if WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK] then
				ContainerWindow.PlayerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
			end
		elseif not IsPlayerDead() and Interface.BackpackOpen and not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.PlayerBackpack) and Interface.OpeningBpk > 2 then
			Actions.ToggleInventoryWindow()
			Interface.OpeningBpk = 0
		end
	elseif Interface.NewPlayerInventoryToggled then
		if ContainerWindow.PlayerBackpack == 0 then
			RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
			if WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK] then
				ContainerWindow.PlayerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
			end
		elseif not IsPlayerDead() and Interface.BackpackOpen and not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.PlayerBackpack) and Interface.OpeningBpk > 2 then
			Actions.ToggleInventoryWindow()
			Interface.OpeningBpk = 0
		end
	end
end

function Interface.MapRefresh(timePassed)
	if not Interface.NewPlayerMapToggled and (not MapCommon.AreaDescription or MapCommon.AreaDescription == "") and Interface.TimeSinceLogin < 2 then
		return
	end

	if(SystemData.Settings.Interface.mapMode == MapCommon.MAP_HIDDEN)then		
		return
	end

	if((MapCommon.AreaDescription ~= "New Player Quest Area") and (SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_HIDDEN) and not WindowGetShowing( "MapWindow") )then		
		MapWindow.ActivateMap()
		return
	end

	if (MapCommon.AreaDescription ~= "New Player Quest Area") or Interface.NewPlayerMapToggle then		
		if MapCommon.ActiveView ~= nil then
			MapCommon.RefreshDelta = MapCommon.RefreshDelta + timePassed
			
			if (MapCommon.ActiveView and MapCommon.RefreshDelta >= MapCommon.RefreshDelay and MapCommon.WaypointUpdateRequest) then
				MapCommon.UpdateWaypoints(MapCommon.ActiveView)
				MapCommon.RefreshDelta = 0
			end
		end	
	end	
end

function Interface.SkillsTrackerUpdate(timePassed)
	if (SkillsWindow.SkillsTrackerMode  == 1 or Interface.LoadBoolean( "ShowTracker" , false )) then
		SkillsWindow.SkillsTrackerMode = 1
		if (not DoesWindowNameExist("SkillsTrackerWindow")) then
			CreateWindow("SkillsTrackerWindow", true)
			WindowUtils.RestoreWindowPosition("SkillsTrackerWindow")
			SkillsTracker.Update()
		end
	else
		SkillsWindow.SkillsTrackerMode = 0
		if DoesWindowNameExist("SkillsTrackerWindow") then
			DestroyWindow("SkillsTrackerWindow")
		end
	end
end




function Interface.SummonsManager(timePassed)
	for mobileId, value in pairs(MobileHealthBar.CheckStatus) do
		if (MobileHealthBar.CreateTime[mobileId] and Interface.TimeSinceLogin > MobileHealthBar.CreateTime[mobileId] ) then
			MobilesOnScreen.RemoveHealthBar(mobileId)	
		end
	end
    
	for key, value in pairs (MobileHealthBar.SummonTimer) do
		local windowName = "MobileHealthBar_"..key
		if MobileHealthBar.SummonTimer[key] - Interface.TimeSinceLogin <= 0 then
			MobileHealthBar.SummonTimer[key] = nil
			MobilesOnScreen.ReversePet[key] = nil
			MobileHealthBar.CloseWindowByMobileId(key)
		else
			local timer = MobileHealthBar.SummonTimer[key] - Interface.TimeSinceLogin
			if (MobileHealthBar.hasWindow[key] and DoesWindowNameExist(windowName)) then
				WindowSetShowing(windowName.."SummonDuration", true)
				StatusBarSetCurrentValue( windowName.."SummonDuration", timer )	
				if (StatusBarGetMaximumValue(windowName.."SummonDuration") == 0) then
					StatusBarSetMaximumValue( windowName.."SummonDuration", timer )
				end
			end
			
			
			
			if timer >= 60 then
				local min = math.floor(timer/60)
				local prefix = ""
				if (timer - (min * 60) > 0) then
					prefix = ">"
				end
				timer = StringToWString(prefix .. string.format("%.0f", min)	.. " min")
			else
				timer = StringToWString(string.format("%.0f", timer)	.. " sec")
			end
			
			if (MobileHealthBar.hasWindow[key] and DoesWindowNameExist(windowName) ) then
				LabelSetText(windowName.."HealthBarTimeSpan", timer )
				--WindowSetFontAlpha(windowName .. "HealthBarTimeSpan", 0.5)
			end
			
		end
	end
end

function Interface.UpdateHealthbarStatus(timePassed)
	for mobileId, value in pairs (MobileHealthBar.hasWindow) do
		MobileHealthBar.UpdateStatus(mobileId)
	end
end

function Interface.SkillLocker(timePassed)
	if (Interface.DeltaTime >= 0.1) then
		SkillsWindow.LockSkills()
		SkillsWindow.DownSkills()
	end
end

Interface.BeatSlow = false
Interface.BeatMed = false
Interface.BeatFast = false
Interface.Beat = false

Interface.BeatSoundStartDelta = 0 
Interface.BeatSoundLength = 0

function Interface.LowHPManager(timePassed)
	local curr = WindowData.PlayerStatus.CurrentHealth
	local max = WindowData.PlayerStatus.MaxHealth
	local perc = (curr/max)*100
	if (max == 0) then
		perc = 100
	end
	perc = math.floor(perc)	
	if (perc <= CenterScreenText.LowHPPerc and not IsPlayerDead()) and not CenterScreenText.LOWHPMEStarted then
		CenterScreenText.SendCenterScreenTexture("lowhp")
		CenterScreenText.LOWHPMEStarted = true
		CenterScreenText.LOWHPPetStarted = false
	elseif(perc > CenterScreenText.LowHPPerc or IsPlayerDead()) and CenterScreenText.LOWHPMEStarted then
		CenterScreenText.LOWHPMEStarted = false
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)

	end

	if (Interface.HeartBeat) then
		
		if (perc <= 50 and not IsPlayerDead()) then
			Interface.BeatSoundStartDelta = Interface.BeatSoundStartDelta + timePassed
			local changeBeat = false

			if (perc >35 and perc <= 50 and not Interface.BeatSlow) then
				Interface.BeatSlow = true
				Interface.BeatMed = false
				Interface.BeatFast = false
				changeBeat = true
			end
			if (perc >20 and perc <= 35 and not Interface.BeatMed) then
				Interface.BeatSlow = false
				Interface.BeatMed = true
				Interface.BeatFast = false
				changeBeat = true
			end
			if (perc >0 and perc <= 20 and not Interface.BeatFast) then
				Interface.BeatSlow = false
				Interface.BeatMed = false
				Interface.BeatFast = true
				changeBeat = true
			end
			if Interface.BeatSoundStartDelta >= Interface.BeatSoundLength then
				changeBeat = true
			end
			if (changeBeat) then
				--PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
				if (Interface.BeatSlow ) then
					--PlaySound(1, 1657 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
					--Debug.Print("BEATSLOW")
					Interface.BeatSoundLength = 48
				elseif (Interface.BeatMed) then
					--PlaySound(1, 1656 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
					--Debug.Print("BEATMED")
					Interface.BeatSoundLength = 58
				elseif (Interface.BeatFast) then
					--PlaySound(1, 1655 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
					--Debug.Print("BEATFAST")
					Interface.BeatSoundLength = 120
				end
				Interface.BeatSoundStartDelta = 0
			end
			Interface.Beat = true
		else
			if (Interface.Beat) then
				--PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
				Interface.Beat = false
				Interface.BeatSlow = false
				Interface.BeatMed = false
				Interface.BeatFast = false
			end
			Interface.BeatSoundStartDelta = 0
			Interface.BeatSoundLength = 0
		end
		
		
	elseif( IsPlayerDead() ) then
		if (Interface.Beat) then
		--	PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
			Interface.Beat = false
			Interface.BeatSlow = false
			Interface.BeatMed = false
			Interface.BeatFast = false
		end
		Interface.BeatSoundStartDelta = 0
		Interface.BeatSoundLength = 0
	end
end

function Interface.ClearWindowData(timePassed)
	for mobileId, value in pairs(WindowData.MobileName) do
		if tonumber(mobileId) and mobileId ~= WindowData.PlayerStatus.PlayerId and mobileId ~= WindowData.CurrentTarget.TargetId then
			if not (DoesWindowNameExist("OverheadTextWindow_"..mobileId) or DoesWindowNameExist("PaperdollWindow"..mobileId) or DoesWindowNameExist("MobileHealthBar_"..mobileId) or PartyHealthBar.hasWindow[mobileId]) then
				UnregisterWindowData(WindowData.MobileName.Type,mobileId)				
				return			
			elseif not IsMobileVisible(mobileId) then				
				UnregisterWindowData(WindowData.MobileName.Type,mobileId)
				return
			end
		end
	end
	

end


-------------------------------------------------------------------------------
--
-- NEW CHAT OVERRIDES
--
-------------------------------------------------------------------------------
function Interface.NewChatText()
	
	local ign = false
	local share, ignore

	ok, ignore = pcall(TextParsing.IgnoreTextManager)
	Interface.ErrorTracker(ok, ignore)
	
	ok, err = pcall(TextParsing.ForceOverhead)
	Interface.ErrorTracker(ok, err)
	
	local color, channel
	ok, color, channel = pcall(TextParsing.ColorizeText)
	Interface.ErrorTracker(ok, color)
	
	ok, err = pcall(TextParsing.SpecialTexts)
	Interface.ErrorTracker(ok, err)
		
	ok, err = pcall(TextParsing.SpellCasting)
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(TextParsing.TimersNbuff)
	Interface.ErrorTracker(ok, err)
	
	ok, err = pcall(TextParsing.Taunts)
	Interface.ErrorTracker(ok, err)
	
		
	ok, err = pcall(TextParsing.CenterScreenText, timePassed)	
	Interface.ErrorTracker(ok, err)
	
	if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		local spellinf = SpellsInfo.SpellsData[WStringToString(SystemData.Text)]
		if (spellinf and Interface.LastSpell ~= 0) then
			 local speed = SpellsInfo.GetSpellSpeed(Interface.LastSpell)
			 if (speed) then
				Interface.CurrentSpell.UnlaggedSpeed = speed
				Interface.CurrentSpell.Recovery = 1.5
				Interface.CurrentSpell.ActualSpeed = 0
				Interface.CurrentSpell.IsSpell = true
				Interface.CurrentSpell.SpellId = spellinf.id
				Interface.CurrentSpell.ready =false
				Interface.CurrentSpell.casting = true
				Interface.CurrentSpell.CheckFizzle = false
			end
			if (NewChatWindow and not NewChatWindow.ShowSpells) then
				ign = true
			end
		end
		
	end

	SystemData.TextColor = color
	if NewChatWindow and not ign then
		
		local logVal = {text = SystemData.Text, ORGchannel = SystemData.TextChannelID , channel = channel, color = color, sourceId = SystemData.TextSourceID, sourceName = SystemData.SourceName, ignore = ign, category = 0, timeStamp = StringToWString(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
		table.insert(NewChatWindow.Messages, logVal)
		if (NewChatWindow.Setting and NewChatWindow.Setting.Messages) then
			table.insert(NewChatWindow.Setting.Messages, logVal)
		end
		if (NewChatWindow.Setting and table.getn(NewChatWindow.Setting.Messages) > 200) then
			table.remove(NewChatWindow.Setting.Messages, 1)
		end
		NewChatWindow.UpdateLog()
	end
end

function Interface.ChatWindowSwitchChannelWithExistingText (existingText)
    
    -- Set the Focus to the text input
    WindowSetShowing( "ChatWindowContainer", true )
    WindowSetShowing( "ChatWindowContainerTextInput", true )
    WindowAssignFocus( "ChatWindowContainerTextInput", true )
    
   
    
    if (existingText == nil) then
        existingText = L"";
    end
    
    -- Set the default channel to Say or the previous channel
    if (NewChatWindow.curChannel == nil and NewChatWindow.prevChannel == nil) then
        NewChatWindow.SwitchToChatChannel (SystemData.ChatLogFilters.SAY, ChatSettings.Channels[SystemData.ChatLogFilters.SAY].labelText, existingText)
    elseif (NewChatWindow.prevChannel ~= nil) then
        if (NewChatWindow.prevChannel == SystemData.ChatLogFilters.TELL_SEND and whisperTarget ~= nil) then
            NewChatWindow.SwitchToChatChannel (NewChatWindow.prevChannel, ChatWindow.FormatWhisperPrompt (whisperTarget), existingText)
        else
			if (NewChatWindow.prevChannel == 16) then  
				NewChatWindow.SwitchToChatChannel (NewChatWindow.prevChannel, L"[Self]:", existingText)
			else
				NewChatWindow.SwitchToChatChannel (NewChatWindow.prevChannel, ChatSettings.Channels[NewChatWindow.prevChannel].labelText, existingText)
			end
        end
    end
end

function Interface.ChatWindowResetTextBox ()

    -- Reanchor the Text Box
    WindowClearAnchors("ChatWindowContainerTextInput")
    WindowAddAnchor("ChatWindowContainerTextInput", "topright", "ChatWindowContainerChannelLabel", "topleft", 2, -6)
    WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 2)
    
    -- Clear the Text
    TextEditBoxSetText("ChatWindowContainerTextInput", L"")  

    -- Reset the color to white
    TextEditBoxSetTextColor ("ChatWindowContainerTextInput", 255, 255, 255)
    
    -- Reset all the label stuff
    LabelSetTextColor ("ChatWindowContainerChannelLabel", 255, 255, 255)
                                                 
    LabelSetText ("ChatWindowContainerChannelLabel", L"")
    
    NewChatWindow.UpdateCurrentChannel (nil)

end

function Interface.ChatWindowOnKeyEnter()
    local chatChannel = L""
    local chatText = ChatWindowContainerTextInput.Text
    if (NewChatWindow.curChannel == 16) then
		WindowUtils.ChatPrint( chatText, NewChatWindow.curChannel)
		WindowAssignFocus( "ChatWindowContainerTextInput", false )
		ChatWindow.ResetTextBox ()
		WindowSetShowing( "ChatWindowContainer", false )
		return
    end
    if (NewChatWindow.curChannel ~= nil) then
        -- This is the channel that the text will go to...
        chatChannel = ChatSettings.Channels[NewChatWindow.curChannel].serverCmd
    end

    --Debug.Print(L"ChatWindow.OnKeyEnter: text="..chatChannel..L" "..chatText)
   
    if (chatChannel == L"/tell") then
		chatChannel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		chatText = L"; " .. chatText
    end
    SendChat(chatChannel,chatText)
    
    ChatWindow.ResetTextBox ()
    
    -- Hide the Text Input Window
    WindowAssignFocus( "ChatWindowContainerTextInput", false )
    WindowSetShowing( "ChatWindowContainer", false )

end

function Interface.ChatWindowPerformFadeOut( rootWindowIndex )
	return
end

-------------------------------------------------------------------------------
--
-- OVERRIDES
--
-------------------------------------------------------------------------------
Interface.org_RegisterWindowData = nil
function Interface.RegisterWindowData(type, id, unregisterFirst)
	if unregisterFirst then
		UnregisterWindowData(type, id)
	end
	Interface.org_RegisterWindowData(type, id)
end

Interface.org_WindowRegisterEventHandler = nil
function Interface.WindowRegisterEventHandler(window, id, callback)
	if id == 0 then
		return
	end
	Interface.org_WindowRegisterEventHandler(window, id, callback)
end

Interface.org_RequestContextMenu = nil
function Interface.RequestContextMenu(id, visible)
	if not WindowData.ContextMenu then
		return
	end
	if visible == nil or visible == true then
		WindowData.ContextMenu.hideMenu = 0
	else
		WindowData.ContextMenu.hideMenu = 1
	end
	ContextMenu.SenderWindow = WindowUtils.GetActiveDialog()
	Interface.org_RequestContextMenu(id)
end

Interface.org_DragSlotQuantityRequestResult = nil
function Interface.DragSlotQuantityRequestResult(amount)
	SystemData.DragItem.DragAmount = amount 
	Interface.org_DragSlotQuantityRequestResult(amount)
end

Interface.org_HandleSingleLeftClkTarget = nil
function Interface.HandleSingleLeftClkTarget(id)
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
		Interface.OnTarget(0, id)
	end
	Interface.org_HandleSingleLeftClkTarget(id)
end

function Interface.RenamePet(mobileId)	
	if not IsMobile(mobileId) then
		return
	end	
	if not WindowData.MobileName[mobileId] then
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
	end	
	local rdata = {}
	local mobname = tostring(WindowData.MobileName[mobileId].MobName)
	rdata.text = wstring.trim(StringToWString(mobname))
	rdata.subtitle = GetStringFromTid(1115558)
	rdata.title = GetStringFromTid(1155270)
	rdata.callfunction =  Interface.RenameComplete
	rdata.id = mobileId
	rdata.maxChars = 16	
	RenameWindow.Create(rdata)
end

function Interface.RenameComplete()
	local mobileId = RenameWindow.id	
	WindowData.Pets.RenameId = mobileId
	WindowData.Pets.Name = WStringToString(RenameWindow.TextEntered)
	BroadcastEvent(SystemData.Events.RENAME_MOBILE)	
end

-------------------------------------------------------------------------------
--
-- OTHER
--
-------------------------------------------------------------------------------

function Interface.GetMobileData(mobileId, forceRegister)
	if not mobileId then
		return
	end
	local mobileData = WindowData.MobileStatus[mobileId]
	if not mobileData and WindowData.MobileStatus[0] then
		mobileData = WindowData.MobileStatus[0][mobileId]
	end
	
	if not mobileData and forceRegister then
		--Debug.Print("MobileData not found: "..mobileId)
		RegisterWindowData(WindowData.MobileStatus.Type, mobileId)
		mobileData = WindowData.MobileStatus[mobileId]
		if not mobileData and WindowData.MobileStatus[0] then
			mobileData = WindowData.MobileStatus[0][mobileId]
		end
		local noto = nil
		if(mobileData)then
			local noto = mobileData.Notoriety+1
		end

		if WindowData.PlayerStatus.PlayerId ~= mobileId and ((not MobileHealthBar.HasWindow(mobileId) and TargetWindow.TargetId ~= mobileId) or (noto == NameColor.Notoriety.INVULNERABLE)) then			
			--Debug.Print("Unregister MobileData: "..mobileId)
			UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		end
	end
	return mobileData
end

function Interface.Shutdown()
	QuickStats.Shutdown()
	EquipmentData.Shutdown()
	HotbarSystem.Shutdown()
	BuffDebuff.Shutdown()
	MapCommon.Shutdown()
	TradeWindow.OnCloseDialog()
	
	--Unload playerstatsData used for character sheet and the hotbar system
	UOUnloadCSVTable("PlayerStatsDataCSV")
	UOUnloadCSVTable("PlayerItemPropCSV")
	Interface.TotalUnregister()
end

function Interface.ErrorTracker(success, error)
	if (not success and error ~= nil and (type(error) == "string" or type(error) == "wstring")) then
		Debug.Print(error)
	end
end

function Interface.TotalUnregister()
	for key, value in pairs(WindowData) do
		if type(value) == "table" then
			local typ = -1
			for id, value2 in pairs(value) do
				if id == "Type" then
					typ = value2
					break
				end
			end
			if typ ~= -1 then
				--Debug.Print("WindowData." .. key .. ".Type = " .. typ)
				for id, value2 in pairs(value) do
					if tonumber(id) then
						--Debug.Print("Unregistering ID: " .. id)
						UnregisterWindowData(typ, id)
					end
				end
			end
		end
	end
	PaperdollWindow.Properties = {}
	PaperdollWindow.WearedItems = {}
end

-------------------------------------------------------------------------------
--
-- WindowData Counting
--
-------------------------------------------------------------------------------
function Interface.CountWinData()
	Debug.Print("Registerd Names: " .. Interface.CountNamesData())
	Debug.Print("Registerd Items: " .. Interface.CountObjectData())
	Debug.Print("Registerd Properties: " .. Interface.CountPropsData())
	Debug.Print("Registerd Containers: " .. Interface.CountContainersData())
	Debug.Print("Registerd Paperdolls: " .. Interface.CountPaperdollData())
	Debug.Print("Registerd Status: " .. Interface.CountMobileStatusData())
end


function Interface.CountNamesData()
	local a = 0
	for key, value in pairs(WindowData.MobileName) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountObjectData()
	local a = 0
	for key, value in pairs(WindowData.ObjectInfo) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountContainersData()
	local a = 0
	for key, value in pairs(WindowData.ContainerWindow) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountPropsData()
	local a = 0
	for key, value in pairs(WindowData.ItemProperties) do
		if tonumber(key) and key ~= 0 then
			a = a + 1
		end
	end
	return a
end


function Interface.CountMobileStatusData()
	local a = 0
	for key, value in pairs(WindowData.MobileStatus) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountPaperdollData()
	local a = 0
	for key, value in pairs(WindowData.Paperdoll) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end
-------------------------------------------------------------------------------
--
-- EVENTS
--
-------------------------------------------------------------------------------

function Interface.ReloadSettings() 
end

function Interface.TogglePaperdollWindow()
	playerId = WindowData.PlayerStatus.PlayerId
	local windowName = "PaperdollWindow"..playerId

	if(DoesWindowNameExist(windowName)) then
		DestroyWindow(windowName)
	else
	    UserActionUseItem(playerId,true)
	end
end

function Interface.OnDebugPrint()
	Debug.PrintToDebugConsole(DebugData.DebugString)
end

function Interface.RetrieveCharacterSettings()
	--WindowUtils.RetrieveWindowSettings()
end

function Interface.UpdateWindowsSettings()
	WindowUtils.SendWindowSettings()
end

function Interface.ShowCriminalNotificationGump()
	local okButton = { textTid = Interface.TID.accept, callback = Interface.AcceptCriminalNotification }
	local cancelButton = { textTid = Interface.TID.cancel, callback = nil }
	local windowData = 
	{
		windowName = "ShowCriminalNotification", 
		titleTid = 1111873, -- "Warning"
		bodyTid = 3000032, -- This may flag you criminal!
		buttons = { okButton, cancelButton }
	}
	UO_StandardDialog.CreateDialog( windowData )	
end

function Interface.ShowPartyInvite()
	CreateWindow( "PartyInviteWindow", true )
end

function Interface.AcceptCriminalNotification()
	AcceptCriminalNotification()		
end

function Interface.HonorMobileConfirm(mobileId)	
	Interface.CurrentHonor = mobileId
	Interface.SaveNumber( "CurrentHonor", Interface.CurrentHonor )
	Interface.WaitHonor = false
	MobileHealthBar.UpdateName(mobileId)
	TargetWindow.UpdateName(mobileId)	
	OverheadText.UpdateName(mobileId)
	MobilesOnScreen.isDirty = true
end

function Interface.ItemUseRequest()
	--Debug.Print("Used Item " .. GameData.UseRequests.UseItem .. " with target: " .. GameData.UseRequests.UseTarget)
	if GameData.UseRequests.UseTarget ~= 0 then
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end
		
	RegisterWindowData(WindowData.ObjectInfo.Type, GameData.UseRequests.UseItem)		
	local itemData = WindowData.ObjectInfo[GameData.UseRequests.UseItem]
	if not itemData then
		return
	end	
	if not Interface.ItemsCooldown[itemData.objectType] then
		Interface.ItemsCooldown[itemData.objectType] = {}
	end
	UnregisterWindowData(WindowData.ObjectInfo.Type, GameData.UseRequests.UseItem)

	local td = {func = function() ContainerWindow.UpdateUsesByID(GameData.UseRequests.UseItem) end, time = Interface.TimeSinceLogin + 2}
	table.insert(ContainerWindow.TODO, td)
	
	Interface.LastItem = GameData.UseRequests.UseItem	
end

Interface.LastSpell = 0
function Interface.SpellUseRequest()
	--Debug.Print("Used Spell " .. GameData.UseRequests.UseSpellcast .. " with target: " .. GameData.UseRequests.UseTarget)
	if GameData.UseRequests.UseTarget ~= 0 then
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end
	Interface.LastSpell = GameData.UseRequests.UseSpellcast
	if Interface.LastSpell == 503 or Interface.LastSpell == 507 or Interface.LastSpell == 508 then
		local speed = SpellsInfo.GetSpellSpeed(Interface.LastSpell)
		 if (speed) then
			Interface.CurrentSpell.UnlaggedSpeed = speed
			Interface.CurrentSpell.Recovery = 1.75
			Interface.CurrentSpell.ActualSpeed = 0
			Interface.CurrentSpell.IsSpell = true
			Interface.CurrentSpell.SpellId = Interface.LastSpell
			Interface.CurrentSpell.ready =false
			Interface.CurrentSpell.casting = true
			Interface.CurrentSpell.CheckFizzle = false
		end
	end
end

function Interface.SkillUseRequest()
	--Debug.Print("Used Skill " .. GameData.UseRequests.UseSkill .. " with target: " .. GameData.UseRequests.UseTarget)
	if GameData.UseRequests.UseTarget ~= 0 then
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end
end

function Interface.VirtueUseRequest()		
	if(GameData.UseRequests.UseVirtue ~= 0)then
		--Debug.Print("Used Virtue " .. GameData.UseRequests.UseVirtue .. " with target: " .. GameData.UseRequests.UseTarget)	
		local lastHonorTarget = Interface.CurrentHonor
		Interface.CurrentHonor = WindowData.Cursor.lastTarget
		if(lastHonorTarget ~= nil and lastHonorTarget ~= 0)then			
			MobileHealthBar.UpdateName(lastHonorTarget)
			OverheadText.UpdateName(lastHonorTarget)
			TargetWindow.UpdateName(lastHonorTarget)
			MobilesOnScreen.isDirty = true
		end						
	end	
end

function Interface.SpecialMoveUseRequest()
	--Debug.Print(GameData.UseRequests.UseSpecialMove)
	Interface.LastSpecialMove = GameData.UseRequests.UseSpecialMove
end


function Interface.OnTarget(lastTarget, newTarget)
	--Debug.Print("Target Triggered - PREVIOUS LAST: " .. lastTarget .. " NEW TARGET: " .. newTarget)
end

function Interface.OnSpellCastedSuccessfully(id)
end

function Interface.OnSpellCastFailed(id)
end

function Interface.OnSpecialMoveUsedSuccessfully(id, targetId)
end

function Interface.OnSpecialMoveDamageReceived(id)
end

function Interface.OnMouseOverItemChanged(id)
	if WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ITEM then
		if IsMobile(id) then
			Interface.OnMobileMouseOver(id)
		else
			Interface.OnObjectMouseOver(id)
		end
	elseif WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ACTION then
		Interface.OnActionMouseOver(id)
	elseif WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_WSTRINGDATA then
	end
end

function Interface.OnMobileMouseOver(id)
	-- Debug.Print("Over Mobile " .. id)
end

function Interface.OnObjectMouseOver(id)
	-- Debug.Print("Over Object " .. id)
end

function Interface.OnActionMouseOver(id)
	-- Debug.Print("Over Action " .. id)
end

-------------------------------------------------------------------------------

-- LOAD/SAVE

-------------------------------------------------------------------------------
--TODO Remove once all references have been moved to UserInterfaceVariables
-- Interface.SaveBoolean
-- Description:
--     Saves a boolean value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function Interface.SaveBoolean( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveBoolean: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( true ) then
		Debug.Print( "Interface.SaveBoolean: settingValue must be a boolean" )
		return false
	end

	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	if nBools <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
	else
		local found = false
		for i = 1, nBools do
			if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.BoolValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
		end
	end
	BroadcastEvent( SystemData.Events.USER_SETTINGS_UPDATED )
end

-------------------------------------------------------------------------------
-- Interface.SaveNumber
-- Description:
--     Saves a numeric value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveNumber( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveNumber: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( 0 ) then
		Debug.Print( "Interface.SaveNumber: \"" .. settingName .. "\" settingValue must be a number" )
		return false
	end
	
	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	if nNumbers <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
	else
		local found = false
		for i = 1, nNumbers do
			if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.NumberValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
		end
	end
	
end

-------------------------------------------------------------------------------
-- Interface.SaveColor
-- Description:
--     Saves a color value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved 
--                    (table {r=(0-255),g=(0-255),b=(0-255)[,a=(0-255)]})
-------------------------------------------------------------------------------
function Interface.SaveColor( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveColor: settingName must be a string" )
		return false
	end
	--Debug.Print("Checking Color: " .. settingName)
	if not Interface.CheckColor( settingValue, "Interface.SaveColor" ) then
		-- Debug printing in CheckColor function
		return false
	end
	--Debug.Print("Saving Color: " .. settingName)
	
	local r = settingValue.r
	local g = settingValue.g
	local b = settingValue.b
	local a = settingValue.a

	local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
	if nColors <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)		
	else
		local found = false
		for i = 1, nColors do
			if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.ColorRedValues[i] = r
				SystemData.Settings.Interface.UIVariables.ColorGreenValues[i] = g
				SystemData.Settings.Interface.UIVariables.ColorBlueValues[i] = b
				SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i] = a
				found = true				
				break
			end
		end
		if not found then			
			table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
		end
	end
end


-------------------------------------------------------------------------------
-- Interface.SaveString
-- Description:
--     Saves a string value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveString: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( "" ) then
		Debug.Print( "Interface.SaveString: settingValue must be a string" )
		return false
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	if nStrings <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.StringNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.StringValues, settingValue)
	else
		local found = false
		for i = 1, nStrings do
			if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.StringValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.StringNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.StringValues, settingValue)
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.SaveWString
-- Description:
--     Saves a wstring value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveWString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveString: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( L"" ) then
		Debug.Print( "Interface.SaveString: settingValue must be a wstring" )
		return false
	end
	
	local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	if nWStrings <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.WStringNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.WStringValues, settingValue)
	else
		local found = false
		for i = 1, nWStrings do
			if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.WStringValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.WStringNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.WStringValues, settingValue)
		end
	end
end


-------------------------------------------------------------------------------
-- Interface.DeleteSetting
-- Description:
--     Delete an existing setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-------------------------------------------------------------------------------

function Interface.DeleteSetting( settingName )
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do
		if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.BoolNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.BoolValues, i)
			return
		end
	end
	
	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	for i = 1, nNumbers do
		if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.NumberNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.NumberValues, i)
			return
		end
	end
	
	local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
	for i = 1, nColors do
		if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.ColorNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorRedValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorGreenValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorBlueValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorAlphaValues, i)
			return
		end
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.StringNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.StringValues, i)
			return
		end
	end
	
	local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	for i = 1, nWStrings do
		if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.WStringNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.WStringValues, i)
			return
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.CheckColor
-- Description:
--     Checks to see if an argument is a valid color table
-- Parameters:
--     color - the argument to check
--     rootFunction - the name of the function to use in the debug messages
--                    no logging is done if this is nil
-- Returns:
--     True if it is a valid color, false otherwise
-------------------------------------------------------------------------------
function Interface.CheckColor( color, rootFunction )
	local good = true
	if type( color ) ~= type( {} ) then
		good = false
	elseif type( color.r ) ~= type( 0 ) or color.r < 0 or color.r > 255 then
		good = false
	elseif type( color.g ) ~= type( 0 ) or color.g < 0 or color.g > 255 then
		good = false
	elseif type( color.b ) ~= type( 0 ) or color.b < 0 or color.b > 255 then
		good = false
	elseif color.a ~= nil and type( color.a ) ~= type( 0 ) then
		if (color.a < 0 or color.a > 255 ) then
			good = false
		end
	end
	if not good and rootFunction ~= nil then
		Debug.Print( rootFunction .. ": color must be a table with r, g, and b values between 0 and 255 (with an option a value between 0 and 255)" )
	end
	return good
end

-------------------------------------------------------------------------------
-- Interface.LoadBoolean
-- Description:
--     Gets the boolean value of a setting
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
--TODO Remove once all references have been moved to UserInterfaceVariables
-------------------------------------------------------------------------------
function Interface.LoadBoolean( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end

	if not SystemData.Settings.Interface.UIVariables.BoolNames then
		return defaultValue
	end

	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do

		if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
		--[[
			Debug.Print(settingName)
			Debug.Print(SystemData.Settings.Interface.UIVariables.BoolValues[i])
			Debug.Print("-------")
		--]]
			return SystemData.Settings.Interface.UIVariables.BoolValues[i]
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadNumber
-- Description:
--     Gets the numeric value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadNumber( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.NumberNames then
		return defaultValue
	end

	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	for i = 1, nNumbers do
		if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.NumberValues[i]
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadColor
-- Description:
--     Gets the color value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadColor( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadColor: settingName must be a string" )
		return false
	end
	
	if not SystemData.Settings.Interface.UIVariables.ColorNames then
		return defaultValue
	end

	local nStrings = #SystemData.Settings.Interface.UIVariables.ColorNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then	
			local color = {
						r=SystemData.Settings.Interface.UIVariables.ColorRedValues[i],
						g=SystemData.Settings.Interface.UIVariables.ColorGreenValues[i],
						b=SystemData.Settings.Interface.UIVariables.ColorBlueValues[i],
						a=SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i]
					   } 
			return color
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------
function Interface.LoadString( settingName, defaultValue )
    -- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.StringNames then
		return defaultValue
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.StringValues[i]
		end
	end
	return defaultValue
end


-------------------------------------------------------------------------------
-- Interface.LoadWStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------

function Interface.LoadWString( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.WStringNames then
		return defaultValue
	end

    local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	for i = 1, nWStrings do
		if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.WStringValues[i]
		end
	end

	return defaultValue
end


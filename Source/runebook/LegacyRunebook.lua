
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
LegacyRunebook = ListWindow:new("LEGACY_Runebook_GUMP")
LegacyRunebook.knownWindows = {}
LegacyRunebook.selectRuneType = {}
LegacyRunebook.NumActiveRunes = {}

LegacyRunebook.NUM_DEFAULT_LABELS = 7
LegacyRunebook.CHARGE_LABEL = 8
LegacyRunebook.KeymapTID = { 1011299, 1011298, 1077594, 1077595, 1062723, 1062724, 1011300, 1011296, }
LegacyRunebook.TID_LegacyRunebook = 1028901
LegacyRunebook.KeymapLabel = { "RenameBook", "DropRune", "Recall", "RecallSpell", "GateTravel", "Sacred", "SetDefault", "Charges",}

LegacyRunebook.ButtonIdLoc = {9, 199, 9, 49, 99, 74, 299}
LegacyRunebook.Hues = { malas = 1102, trammel = 10, tokuno = 1154, felucca = 81, termer=1645 }
LegacyRunebook.RuneColor = {purple = "LegacyPurpleRuneTemplate", torquoise = "LegacyTorquoiseRuneTemplate", gray = "LegacyGrayRuneTemplate", green = "LegacyGreenRuneTemplate", brown = "LegacyBrownRuneTemplate"}
LegacyRunebook.LegacyLabelColors= { malas={ r=146, g=73, b=0 }, trammel={ r=73, g=0, b=146 }, tokuno={ r=0, g=50, b=0 }, felucca={ r=10, g=90, b=90 }, termer={ r=0, g=109, b=219 } }

LegacyRunebook.DefaultNum = {}
LegacyRunebook.DefaultNum.RENAME_BOOK		= 1
LegacyRunebook.DefaultNum.DROP_RUNE		= 2
LegacyRunebook.DefaultNum.RECALL			= 3
LegacyRunebook.DefaultNum.GATE_TRAVEL		= 4
LegacyRunebook.DefaultNum.SACRED			= 5
LegacyRunebook.DefaultNum.SET_DEFAULT		= 6

-- Local Defaults for button matching to data from server
local NUM_LegacyRunebook_PAGE_END = 18
local selectedRune

LegacyRunebook.CHARGES_STRING = 19
LegacyRunebook.MAXCHARGES_STRING = 20

LegacyRunebook.SelectItemLabel = { r=200, g=0, b=0, a=255} -- Orange (Selected rune)
LegacyRunebook.DefaultItemLabel = { r=50, g=50, b=0, a=255} -- bottom label color
LegacyRunebook.BlackItemLabel = { r=25, g=25, b=0, a=255} --Black (rune coords color)
LegacyRunebook.DefaultRuneLabel = { r=250, g=50, b=0, a=255} -- bottom label color
LegacyRunebook.DisabledAlpha = 0.5
LegacyRunebook.EnableAlpha = 1


local function toggleHardCodedButtons(isDisabled)
	for key, value in pairs(LegacyRunebook.adapter.views) do
		if string.find(key, "Icon") and not string.find(key, "Button") then
			value:setDisabledFlag(isDisabled)
		end
	end
end

local function castSpell(spellId, index)
	GameData.UseRequests.UseSpellcast = spellId
	Interface.SpellUseRequest()
	UO_GenericGump.broadcastButtonPress(
			index,
			GenericGumpCore.data()
	)
	LegacyRunebook:destroy()
end

function LegacyRunebook.Initialize()
	local windowName = LegacyRunebook.id
	LegacyRunebook.knownWindows[windowName] = GenericGumpCore.stringDataCount()
	LegacyRunebook.NumActiveRunes[windowName] = NUM_LegacyRunebook_PAGE_END

	for i = 3, NUM_LegacyRunebook_PAGE_END do
		local button = RunebookButtonWindow:new(
				i - 2,
				GenericGumpCore.textHueData()[i - 2],
				GenericGumpCore.stringData()[i]
		)
		button:initialize()
		button:anchor()
		LegacyRunebook.adapter.views[button.id] = button

		if i == 3 then
			selectedRune = button
		end
	end

	LegacyRunebook.adapter:addLabel(
			LegacyRunebook.id.."RenameBookName",
			1011299
	):addLabel(
			LegacyRunebook.id.."DropRuneName",
			1011298
	):addLabel(
			LegacyRunebook.id.."SetDefaultName",
			1011300
	):addLabel(
			LegacyRunebook.id.."RecallName",
			1077594
	):addLabel(
			LegacyRunebook.id.."RecallSpellName",
			1077595
	):addLabel(
			LegacyRunebook.id.."GateTravelName",
			1062723
	):addLabel(
			LegacyRunebook.id.."SacredName",
			1062724
	):addLabel(
			LegacyRunebook.id.."CoordsName"
	):addLabel(
			LegacyRunebook.id.."LocationName"
	):addButton(
			LegacyRunebook.id.."RecallIcon"
	):addButton(
			LegacyRunebook.id.."RecallSpellIcon"
	):addButton(
			LegacyRunebook.id.."GateTravelIcon"
	):addButton(
			LegacyRunebook.id.."SacredIcon"
	):addButton(
			LegacyRunebook.id.."DropRuneIcon"
	):addLabel(
			LegacyRunebook.id.."Charges",
			StringFormatter.fromTid(1011296)..GenericGumpCore.stringData()[19]..L"/"..GenericGumpCore.stringData()[20]
	)

	if not selectedRune:icon():isDisabled() then
		selectedRune:onClick(true)
		toggleHardCodedButtons(false)
		LegacyRunebook:UpdateCoordTextandLoc(selectedRune)
	end
end

function LegacyRunebook.OnRecallSpellClicked()
	if selectedRune ~= nil then
		castSpell(32, selectedRune:recallSpellIndex())
	end
end

function LegacyRunebook.OnRecallChargeClicked()
	if selectedRune ~= nil then
		castSpell(32, selectedRune:recallChargeIndex())
	end
end

function LegacyRunebook.OnGateTravelClicked()
	if selectedRune ~= nil then
		castSpell(52, selectedRune:gateTravelIndex())
	end
end

function LegacyRunebook.OnSacredClicked()
	if selectedRune ~= nil then
		castSpell(210, selectedRune:sacredJourneyIndex())
	end
end

function LegacyRunebook.DestroyWindow(myWindowName)
	LegacyRunebook.ResetData(myWindowName)
	GGManager.destroyWindow( myWindowName, GGManager.DONT_DELETE_DATA_YET )
end
	
function LegacyRunebook.Shutdown()
	local windowName = SystemData.ActiveWindow.name
	local self = LegacyRunebook.knownWindows[windowName]
	
	if self ~= nil and self.broadcastHasBeenSent == false then
		--Returns 0 to close the window and do nothing
		UO_GenericGump.broadcastButtonPress( 0, self )
		self.broadcastHasBeenSent = true
	end
	
	LegacyRunebook.ResetData(windowName)
	--Save actual Position GG Manger has a bug and is not saving it
	WindowUtils.SaveWindowPosition(windowName, false, "LEGACY_Runebook_GUMP")
	GGManager.unregisterActiveWindow()
end

function LegacyRunebook:UpdateCoordTextandLoc(rune)
	if rune == nil then
		return
	end

	local label = self.adapter.views[self.id.."CoordsName"]
	label:setText(
			rune:coords()
	)

	label = self.adapter.views[self.id.."LocationName"]
	label:setText(
			rune:label():getText()
	)
end

function LegacyRunebook.OnRuneClicked()
	if selectedRune ~= nil then
		selectedRune:onClick(false)
	end

	local button = LegacyRunebook.adapter.views[ActiveWindow.name()]
	selectedRune = button
	selectedRune:onClick(true)
	toggleHardCodedButtons(false)
	LegacyRunebook:UpdateCoordTextandLoc(selectedRune)
end

function LegacyRunebook.SendServerButtonInfo(buttonNumber, runeData)
	--set default buttonId to zero
	local LegacyRunebookButtonId = 0
	
	if( buttonNumber == LegacyRunebook.DefaultNum.RENAME_BOOK ) then
		if (LegacyRunebook.ButtonIdLoc[buttonNumber] < runeData.buttonCount ) then
			LegacyRunebookButtonId =runeData.buttonIDs[LegacyRunebook.ButtonIdLoc[buttonNumber]]
		end  
	else
		LegacyRunebookButtonId = LegacyRunebook.ButtonIdLoc[buttonNumber] + LegacyRunebook.selectRuneType[runeData.windowName]
	end
	
	if buttonNumber == 3 then -- recall (charge)
		GameData.UseRequests.UseSpellcast = 32
	elseif buttonNumber == 4 then -- recall
		GameData.UseRequests.UseSpellcast = 32
	elseif buttonNumber == 5 then -- gate travel
		GameData.UseRequests.UseSpellcast = 52
	elseif buttonNumber == 6 then -- sacred journey
		GameData.UseRequests.UseSpellcast = 210
	end
	Interface.SpellUseRequest()
	
	local windowName = runeData.windowName
	UO_GenericGump.broadcastButtonPress( LegacyRunebookButtonId, runeData )
	self.broadcastHasBeenSent = true
	
	LegacyRunebook.DestroyWindow(windowName)
end

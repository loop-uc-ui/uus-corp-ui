
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
LegacyRunebook ={}
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
local NUM_LegacyRunebook_PAGE_END = 16
local NUM_ADD_STRING = 2
local COORDS_START_STRING = 24

LegacyRunebook.CHARGES_STRING = 19
LegacyRunebook.MAXCHARGES_STRING = 20

LegacyRunebook.SelectItemLabel = { r=200, g=0, b=0, a=255} -- Orange (Selected rune)
LegacyRunebook.DefaultItemLabel = { r=50, g=50, b=0, a=255} -- bottom label color
LegacyRunebook.BlackItemLabel = { r=25, g=25, b=0, a=255} --Black (rune coords color)
LegacyRunebook.DefaultRuneLabel = { r=250, g=50, b=0, a=255} -- bottom label color
LegacyRunebook.DisabledAlpha = 0.5
LegacyRunebook.EnableAlpha = 1

----------------------------------------------------------------
-- LegacyRunebook Functions
----------------------------------------------------------------
function LegacyRunebook.CreateRuneButton(parent, number, color)
	local index = number
	local runeButtonName = parent.."RuneButton"..tostring(index)
	local buttonName = parent.."RuneButton"..tostring(index).."Icon"
	local colorTemplate
	
	if( color == LegacyRunebook.Hues.trammel) then
		colorTemplate = LegacyRunebook.RuneColor.purple
	elseif( color == LegacyRunebook.Hues.felucca) then
		colorTemplate = LegacyRunebook.RuneColor.torquoise
	elseif( color == LegacyRunebook.Hues.malas) then
		colorTemplate = LegacyRunebook.RuneColor.gray
	elseif (color == LegacyRunebook.Hues.tokuno) then
		colorTemplate = LegacyRunebook.RuneColor.green
	else
		colorTemplate = LegacyRunebook.RuneColor.brown
	end

	CreateWindowFromTemplate(runeButtonName, colorTemplate, parent)
	ButtonSetStayDownFlag(buttonName,true)
	WindowSetId(buttonName, index)
	WindowSetId(runeButtonName, index)
	
	if ( index == 1 ) then
		WindowAddAnchor(runeButtonName, "topleft", parent.."First", "topleft", 15, 20)
	elseif ( index == 9 )then
		WindowAddAnchor(runeButtonName, "topleft", parent.."Second", "topleft", 15, 20)
	else
		WindowAddAnchor(runeButtonName, "bottomleft", parent.."RuneButton"..index-1, "topleft", 0, 0)
	end
end

function LegacyRunebook.CreateRuneWindows(data)
	self = {}
	self = data
	local color
	local windowName = self.windowName
	local flagEmptyStart = false

	for index = 1, LegacyRunebook.NumActiveRunes[windowName] do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
		local labelName = windowName.."RuneButton"..tostring(index).."Name"
		local textString = self.stringData[NUM_ADD_STRING+index]
		color = self.textHueData[index]
		LegacyRunebook.CreateRuneButton(windowName, index, color)

		local labelColor = LegacyRunebook.DefaultItemLabel
		if (color == LegacyRunebook.Hues.trammel) then
			labelColor = LegacyRunebook.LegacyLabelColors.trammel
		elseif (color == LegacyRunebook.Hues.felucca) then
			labelColor = LegacyRunebook.LegacyLabelColors.felucca
		elseif (color == LegacyRunebook.Hues.malas) then
			labelColor = LegacyRunebook.LegacyLabelColors.malas
		elseif (color == LegacyRunebook.Hues.tokuno) then
			labelColor = LegacyRunebook.LegacyLabelColors.tokuno
		elseif (color == LegacyRunebook.Hues.termer) then
			labelColor = LegacyRunebook.LegacyLabelColors.termer
		end
		
		
		LabelSetText( labelName, L""..textString)
		LabelSetTextColor( labelName, labelColor.r, labelColor.g, labelColor.b )

		
		local text = WStringToString(textString)
		if(text == "Empty") then
			ButtonSetDisabledFlag( buttonName, true )
			if(flagEmptyStart == false) then

				LegacyRunebook.NumActiveRunes[windowName] = index - 1
			end
			flagEmptyStart = true
		end
	end	
	WindowAssignFocus(windowName, true)	
end

function LegacyRunebook.ResetRuneDefaultIconText(data)
	self = {}
	self = data
	
	local windowName = self.windowName
	for index = 1, LegacyRunebook.NumActiveRunes[windowName] do
		local labelName = windowName.."RuneButton"..tostring(index).."Name"

        color = self.textHueData[index]
		local labelColor = LegacyRunebook.DefaultItemLabel
        if( color == LegacyRunebook.Hues.trammel) then
            labelColor = LegacyRunebook.LegacyLabelColors.trammel
        elseif( color == LegacyRunebook.Hues.felucca) then
            labelColor = LegacyRunebook.LegacyLabelColors.felucca
        elseif( color == LegacyRunebook.Hues.malas) then
            labelColor = LegacyRunebook.LegacyLabelColors.malas
        elseif (color == LegacyRunebook.Hues.tokuno) then
            labelColor = LegacyRunebook.LegacyLabelColors.tokuno
        end
		LabelSetTextColor( labelName, labelColor.r, labelColor.g, labelColor.b )
	end
end

function LegacyRunebook.EnableDefaultButtons(windowName)
	buttonName = windowName.."CoordsIcon"
	ButtonSetDisabledFlag( buttonName, false )
	
	for i = 2, LegacyRunebook.NUM_DEFAULT_LABELS do
		buttonName = windowName..LegacyRunebook.KeymapLabel[i].."Icon"
		labelName = windowName..LegacyRunebook.KeymapLabel[i]		
		ButtonSetDisabledFlag( buttonName, false )
		WindowSetFontAlpha( labelName, LegacyRunebook.EnableAlpha )
	end
end

function LegacyRunebook.DisableDefaultButtons(windowName)
	buttonName = windowName..LegacyRunebook.KeymapLabel[LegacyRunebook.DefaultNum.RENAME_BOOK].."Icon"
	ButtonSetPressedFlag( buttonName, false )
	
	--Set the Coords Texture to the disabled texture
	buttonName = windowName.."CoordsIcon"
	ButtonSetDisabledFlag( buttonName, true )
	
	for i = 2, LegacyRunebook.NUM_DEFAULT_LABELS do
		buttonName = windowName..LegacyRunebook.KeymapLabel[i].."Icon"
		labelName = windowName..LegacyRunebook.KeymapLabel[i]
		ButtonSetDisabledFlag( buttonName, true )
		ButtonSetPressedFlag( buttonName, false )
		WindowSetFontAlpha( labelName, LegacyRunebook.DisabledAlpha )
	end
end

function LegacyRunebook.SelectedRuneLocation(windowData, runeNum)
	self = {}
	self = windowData
	local windowName = self.windowName
	
	LegacyRunebook.selectRuneType[windowName] = runeNum
			
    for index = 1, NUM_LegacyRunebook_PAGE_END do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
        ButtonSetPressedFlag( buttonName, LegacyRunebook.selectRuneType[windowName] == index )
    end
end

-- labels for bottom menu and rename LegacyRunebook
function LegacyRunebook.ResetDefaultIconText(data)
	--Debug.Print("In LegacyRunebook Reset Default Icon")
	
	self = {}
	self = data
	local windowName = self.windowName

	--Name is called differently for charges
	local labelName = windowName..LegacyRunebook.KeymapLabel[LegacyRunebook.CHARGE_LABEL]
	local numCharges = self.stringData[LegacyRunebook.CHARGES_STRING]
	local maxCharges = self.stringData[LegacyRunebook.MAXCHARGES_STRING]
	LabelSetText( labelName, L""..GetStringFromTid(LegacyRunebook.KeymapTID[LegacyRunebook.CHARGE_LABEL])..numCharges..L"/"..maxCharges)
	LabelSetTextColor( labelName, LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b )

	for i = 1, LegacyRunebook.NUM_DEFAULT_LABELS do
		local currButtonName = windowName..LegacyRunebook.KeymapLabel[i]
		buttonName = windowName..LegacyRunebook.KeymapLabel[i].."Icon"
		labelName = windowName..LegacyRunebook.KeymapLabel[i].."Name"
		WindowSetId(currButtonName, i)
		WindowSetId(buttonName, i)
		LabelSetText( labelName, L""..GetStringFromTid(LegacyRunebook.KeymapTID[i]))
		LabelSetTextColor( labelName, LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b )
		LegacyRunebook.DisableDefaultButtons(windowName)
		--if ((WindowData.SkillDynamicData[HealthBarManager.SpellSchools.MAGERY].TempSkillValue >= 230 or BuffDebuff.ActiveBuffs[1124]) and LegacyRunebook.KeymapLabel[i] == "RecallSpell" ) then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], true)
		--elseif ((WindowData.SkillDynamicData[HealthBarManager.SpellSchools.MAGERY].TempSkillValue < 230 or BuffDebuff.ActiveBuffs[1124]) and LegacyRunebook.KeymapLabel[i] == "RecallSpell" ) then
		--	WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], false)
		--end
		
		if(tonumber(numCharges) > 0 and LegacyRunebook.KeymapLabel[i] == "Recall" ) then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], true)
		elseif(tonumber(numCharges) <= 0 and LegacyRunebook.KeymapLabel[i] == "Recall" ) then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], false)
		end
	end
end

-- OnInitialize Handler
function LegacyRunebook.Initialize()
	self = {}
	if(UO_GenericGump.retrieveWindowData( self )) then	
		--Set my LegacyRunebook data to use later
		LegacyRunebook.knownWindows[self.windowName] = self
		local windowName = self.windowName
		LegacyRunebook.NumActiveRunes[windowName] = NUM_LegacyRunebook_PAGE_END
		LegacyRunebook.ResetDefaultIconText(self)
		LegacyRunebook.CreateRuneWindows(self)
		
		local locWindowName = windowName.."Location"
		WindowSetShowing(locWindowName, false)
		
		WindowSetScale(WindowUtils.GetActiveDialog(), 0.88)
		Interface.OnCloseCallBack[self.windowName] = GGManager.destroyActiveWindow
		WindowSetShowing(windowName .. "Chrome", false)
		GGManager.registerWindow(self.windowName, self)
		self.broadcastHasBeenSent = false 
	end
end

function LegacyRunebook.ResetData(windowName)
	LegacyRunebook.knownWindows[windowName] = nil
	LegacyRunebook.selectRuneType[windowName] = nil
	LegacyRunebook.NumActiveRunes[windowName] = nil
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

function LegacyRunebook.UpdateCoordTextandLoc(runeData)
	local self = runeData

	local windowName = self.windowName
	local selectedRune = LegacyRunebook.selectRuneType[windowName]
	local coordName = windowName.."CoordsName"
	local coordsNum 
	-- If selected Rune is the first rune, do not add two to get the coord data
	if(selectedRune == 1) then
		coordsNum = COORDS_START_STRING 
	else
		coordsNum = selectedRune + COORDS_START_STRING - 1
	end
	--Debug.Print( tostring(coordsNum))
	local coordText = self.stringData[coordsNum] -- ..L"\n"..self.stringData[secondCoordNum]
	LabelSetText(coordName, coordText)
	LabelSetTextColor( coordName, LegacyRunebook.BlackItemLabel.r, LegacyRunebook.BlackItemLabel.g, LegacyRunebook.BlackItemLabel.b )
	
	--Show the text of the selected rune location
	local locWindowName = windowName.."Location"
	local locName = locWindowName.."Name"
	local labelName = windowName.."RuneButton"..tostring(selectedRune).."Name"
	local locText = LabelGetText(labelName)
	LabelSetText(locName, locText)
	LabelSetTextColor( locName, 10, 10, 0)  -- color for selected rune text
	WindowSetShowing(locWindowName, true)

end

function LegacyRunebook.OnRuneClicked()
	local windowName = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = LegacyRunebook.knownWindows[windowName]
	
	if(self) then
		if( buttonNum <= LegacyRunebook.NumActiveRunes[windowName] )then
			LegacyRunebook.ResetRuneDefaultIconText(self)
			LegacyRunebook.SelectedRuneLocation(self, buttonNum)
			LegacyRunebook.CurrentSelection = buttonNum
			LegacyRunebook.UpdateCoordTextandLoc(self)
			LegacyRunebook.EnableDefaultButtons(windowName)
			local labelName = windowName.."RuneButton"..tostring(buttonNum).."Name"
			LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
		end
	end
end

LegacyRunebook.CurrentSelection = 0

function LegacyRunebook.OnKeyTab()
	local windowName = WindowUtils.GetActiveDialog()
	local buttonNum = LegacyRunebook.CurrentSelection + 1
	 
	if LegacyRunebook.CurrentSelection < 0 then
		buttonNum = 1
	end

	if LegacyRunebook.CurrentSelection >= tonumber(LegacyRunebook.NumActiveRunes[windowName])  then
		buttonNum= 1
	end
	LegacyRunebook.CurrentSelection = buttonNum
	
	local self = LegacyRunebook.knownWindows[windowName]
	
	LegacyRunebook.ResetRuneDefaultIconText(self)
	LegacyRunebook.SelectedRuneLocation(self, buttonNum)
	LegacyRunebook.CurrentSelection = buttonNum
	LegacyRunebook.UpdateCoordTextandLoc(self)
	LegacyRunebook.EnableDefaultButtons(windowName)
	local labelName = windowName.."RuneButton"..tostring(buttonNum).."Name"
	LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
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

function LegacyRunebook.OnDefaultClicked()
	local currWindow = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = LegacyRunebook.knownWindows[currWindow]
	
	if(self) then
		local windowName = self.windowName
		if((LegacyRunebook.selectRuneType[windowName] ~= nil) or (buttonNum == LegacyRunebook.DefaultNum.RENAME_BOOK)) then
			LegacyRunebook.ResetDefaultIconText(self)
			
			local buttonName = windowName..LegacyRunebook.KeymapLabel[buttonNum].."Icon"
			local labelName = windowName..LegacyRunebook.KeymapLabel[buttonNum].."Name"
			ButtonSetPressedFlag( buttonName, true )
			LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
				--Drop Rune only when it is ok
				if (buttonNum == LegacyRunebook.DefaultNum.DROP_RUNE) then
			    local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() LegacyRunebook.SendServerButtonInfo(buttonNum, self) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL, callback=function() LegacyRunebook.ResetRuneDefaultIconText(self); LabelSetTextColor( labelName, LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b ) end }
				local DestroyConfirmWindow = 
				{
				    windowName = "DropRune"..currWindow,
					title = GetStringFromTid(1011298),
					body= GetStringFromTid(1155404),
					buttons = { okayButton, cancelButton }
				}
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
				
				ButtonSetPressedFlag( buttonName, false )
				--WindowSetShowing( currWindow, false )
				else
				LegacyRunebook.ResetDefaultIconText(self)
				LegacyRunebook.SendServerButtonInfo(buttonNum, self)
				end
		end
	end
	
end

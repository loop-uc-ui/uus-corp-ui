----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Spellbook = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Spellbook.uniqueOrdinals = { L"st", L"nd", L"rd" }
Spellbook.bardMasteries = { GetStringFromTid(1044082), GetStringFromTid(1044069), GetStringFromTid(1044075) }

Spellbook.TID = {Active=1156227, Index=1156226, Passive=1112232}


Spellbook.TID_MASTERY_DISCORD = 1151945
Spellbook.TID_MASTERY_PROVOCATION	= 1151946
Spellbook.TID_MASTERY_PEACEMAKING	= 1151947
Spellbook.TID_MASTERY_MAGERY = 1155771
Spellbook.TID_MASTERY_MYSTICISM	= 1155772
Spellbook.TID_MASTERY_NECRO	= 1155773
Spellbook.TID_MASTERY_SPELLWEAVING	= 1155774
Spellbook.TID_MASTERY_BUSHIDO	= 1155775
Spellbook.TID_MASTERY_CHIVALRY	= 1155776
Spellbook.TID_MASTERY_NINJITSU	= 1155777
Spellbook.TID_MASTERY_FENCING	= 1155778
Spellbook.TID_MASTERY_MACE	= 1155779
Spellbook.TID_MASTERY_SWORDS	= 1155780
Spellbook.TID_MASTERY_THROWING	= 1155781
Spellbook.TID_MASTERY_PARRY	= 1155782
Spellbook.TID_MASTERY_POISON	= 1155783
Spellbook.TID_MASTERY_WRESTILING	= 1155784
Spellbook.TID_MASTERY_ANIMAL_TAMING	= 1155785
Spellbook.TID_MASTERY_ARCHERY	= 1155786
Spellbook.MASTERY_COUNT = 45
Spellbook.ActiveMastery = 0
Spellbook.MasteryBookTIDs = { Spellbook.TID_MASTERY_PROVOCATION, Spellbook.TID_MASTERY_PEACEMAKING, Spellbook.TID_MASTERY_DISCORD, Spellbook.TID_MASTERY_MAGERY, Spellbook.TID_MASTERY_MYSTICISM, Spellbook.TID_MASTERY_NECRO, Spellbook.TID_MASTERY_SPELLWEAVING, Spellbook.TID_MASTERY_BUSHIDO, Spellbook.TID_MASTERY_CHIVALRY, Spellbook.TID_MASTERY_NINJITSU, Spellbook.TID_MASTERY_FENCING, Spellbook.TID_MASTERY_MACE, Spellbook.TID_MASTERY_SWORDS, Spellbook.TID_MASTERY_THROWING,  Spellbook.TID_MASTERY_PARRY, Spellbook.TID_MASTERY_POISON, Spellbook.TID_MASTERY_WRESTILING, Spellbook.TID_MASTERY_ANIMAL_TAMING,  Spellbook.TID_MASTERY_ARCHERY }
Spellbook.MAX_MASTERY_SPELL_COUNT = 3

-- Spell A, Spell B, Passive
Spellbook.ActiveMasteryIndex = {}
Spellbook.ActiveMasteryIndex[1151945] = {SpellA=705, SpellB=706,  Passive=0} 
Spellbook.ActiveMasteryIndex[1151946] = {SpellA=701, SpellB=702,  Passive=0}
Spellbook.ActiveMasteryIndex[1151947] = {SpellA=703, SpellB=704 ,  Passive=0 }
Spellbook.ActiveMasteryIndex[1155771] = {SpellA=707, SpellB=708 ,  Passive=715 }
Spellbook.ActiveMasteryIndex[1155772] = {SpellA=709, SpellB=710 ,  Passive=715 }
Spellbook.ActiveMasteryIndex[1155773] = {SpellA=711, SpellB=712 ,  Passive=715 }
Spellbook.ActiveMasteryIndex[1155774] = {SpellA=713, SpellB=714 ,  Passive=715}
Spellbook.ActiveMasteryIndex[1155775] = {SpellA=716, SpellB=717 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155776] = {SpellA=719, SpellB=720 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155777] = {SpellA=721, SpellB=722 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155778] = {SpellA=725, SpellB=726 ,  Passive=733 }
Spellbook.ActiveMasteryIndex[1155779] = {SpellA=727, SpellB=728 ,  Passive=733 }
Spellbook.ActiveMasteryIndex[1155780] = {SpellA=729, SpellB=730 ,  Passive=733}
Spellbook.ActiveMasteryIndex[1155781] = {SpellA=731, SpellB=732 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155782] = {SpellA=734, SpellB=735 ,  Passive=736 }
Spellbook.ActiveMasteryIndex[1155783] = {SpellA=737, SpellB=738 ,  Passive=739 }
Spellbook.ActiveMasteryIndex[1155784] = {SpellA=740, SpellB=741 ,  Passive=742 }
Spellbook.ActiveMasteryIndex[1155785] = {SpellA=743, SpellB=744 ,  Passive=745 }
Spellbook.ActiveMasteryIndex[1155786] = {SpellA=723, SpellB=724 ,  Passive=733 }

Spellbook.UpdateMasteryBook = 0

-- TODO: Obviously, TIDs should be in abilities.csv
Spellbook.baseTid = 1028319

-- Indexed by firstSpellNum, MAX per page is 8
Spellbook.numSpellsPerTab = {}
Spellbook.numSpellsPerTab[1] = 8 -- Magery
Spellbook.numSpellsPerTab[101] = 8 -- Necromancy
Spellbook.numSpellsPerTab[201] = 8 -- Chivalry
Spellbook.numSpellsPerTab[401] = 8 -- Bushido
Spellbook.numSpellsPerTab[501] = 8 -- Ninjitsu
Spellbook.numSpellsPerTab[601] = 8 -- Spellweaving
Spellbook.numSpellsPerTab[678] = 8 -- Mysticism
Spellbook.numSpellsPerTab[701] = 8 -- Bard

Spellbook.MAX_SPELLS_PER_TAB = 8

Spellbook.tithId = 44

Spellbook.OpenSpellbooks ={}



----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function Spellbook.Initialize()
	local this = SystemData.ActiveWindow.name
	if (Spellbook.OpenSpellbooks[this]) then
		WindowSetShowing(this, true)
		Spellbook.Init = true
	else
		Spellbook.Init = false
		local id = SystemData.DynamicWindowId
		WindowSetId(this, id)
		WindowUtils.RestoreWindowPosition(this, false)  
		
		Spellbook[id] = {}
		Spellbook[id].activeTab = 1
		Spellbook[id].tabsCreated = false
		Spellbook[id].numTabs = 0
		
		Spellbook.UpdateMasteryBook = 1	

		Interface.DestroyWindowOnClose[this] = true
		RegisterWindowData(WindowData.Spellbook.Type, id)
		RegisterWindowData(WindowData.PlayerStatus.Type, 0)
		WindowRegisterEventHandler(this, WindowData.Spellbook.Event, "Spellbook.UpdateSpells")
		WindowRegisterEventHandler(this, WindowData.PlayerStatus.Event, "Spellbook.UpdateTithing")
		Spellbook.OpenSpellbooks[this] = true
		WindowUtils.LoadScale( this )
	end
	
end

function Spellbook.OnShown()
	local this = SystemData.ActiveWindow.name
	WindowAssignFocus(this,true)
end

function Spellbook.SpellContext()
	local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local _, serverId = GetAbilityData(curSpell)
    
    if( serverId ~= nil ) then
		if serverId == 681 then
			local press = Interface.ForceEnchant
			local subMenu = {
				{ str = GetStringFromTid(1080133),flags=0,returnCode="enchant0",pressed=press==0,false }; -- Select Enchant
				{ str = GetStringFromTid(1079702),flags=0,returnCode="enchant1",pressed=press==1,false }; -- Hit Dispel
				{ str = GetStringFromTid(1079703),flags=0,returnCode="enchant2",pressed=press==2,false }; -- Hit Fireball
				{ str = GetStringFromTid(1079704),flags=0,returnCode="enchant3",pressed=press==3,false }; -- Hit Harm
				{ str = GetStringFromTid(1079705),flags=0,returnCode="enchant4",pressed=press==4,false }; -- Hit Lightning
				{ str = GetStringFromTid(1079706),flags=0,returnCode="enchant5",pressed=press==5,false }; -- Hit Magic Arrow
			}
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1080133),0,0,"null",false,subMenu)
		elseif serverId == 112 then -- summon familiar
			local press = Interface.ForceFamiliar
			if SpellsInfo.SumonFamiliarSkillRequirements(Interface.ForceFamiliar) == 1 then
				press = 0
			end
			
			local subMenu = {
			{ str = GetStringFromTid(1078861),flags=0,returnCode="familiar0",param=param,pressed=press==0,false }; -- Select
			{ str = GetStringFromTid(1060146),flags=SpellsInfo.SumonFamiliarSkillRequirements(1),returnCode="familiar1",pressed=press==1,false }; -- Horde Minion
			{ str = GetStringFromTid(1060142),flags=SpellsInfo.SumonFamiliarSkillRequirements(2),returnCode="familiar2",pressed=press==2,false }; -- Shadow Wisp
			{ str = GetStringFromTid(1060143),flags=SpellsInfo.SumonFamiliarSkillRequirements(3),returnCode="familiar3",pressed=press==3,false }; -- Dark Wolf
			{ str = GetStringFromTid(1060145),flags=SpellsInfo.SumonFamiliarSkillRequirements(4),returnCode="familiar4",pressed=press==4,false }; -- Death Adder
			{ str = GetStringFromTid(1060144),flags=SpellsInfo.SumonFamiliarSkillRequirements(5),returnCode="familiar5",pressed=press==5,false }; -- Vampire Bat
			}
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1060147),0,0,"null",false,subMenu)

		elseif serverId == 503 then -- animal form
			local press = Interface.ForceAnimal
			if SpellsInfo.AnimalFormSkillRequirements(Interface.ForceAnimal) == 1 then
				press = 0
			end

			local subMenu = {
				{ str = FormatProperly(GetStringFromTid(1078861)),flags=0,returnCode="animalForm0",param=param,pressed=press==0,false }; -- Select
				{ str = FormatProperly(GetStringFromTid(1028485)),flags=SpellsInfo.AnimalFormSkillRequirements(1028485),returnCode="animalForm1028485",pressed=press==1028485,false }; -- Rabbit
				{ str = FormatProperly(GetStringFromTid(1028483)),flags=SpellsInfo.AnimalFormSkillRequirements(1028483),returnCode="animalForm1028483",pressed=press==1028483,false }; -- Rat
				{ str = FormatProperly(GetStringFromTid(1075971)),flags=SpellsInfo.AnimalFormSkillRequirements(1075971),returnCode="animalForm1075971",pressed=press==1075971,false }; -- squirrel
				{ str = FormatProperly(GetStringFromTid(1018280)),flags=SpellsInfo.AnimalFormSkillRequirements(1018280),returnCode="animalForm1018280",pressed=press==1018280,false }; -- Dog
				{ str = FormatProperly(GetStringFromTid(1018264)),flags=SpellsInfo.AnimalFormSkillRequirements(1018264),returnCode="animalForm1018264",pressed=press==1018264,false }; -- Cat
				{ str = FormatProperly(GetStringFromTid(1075972)),flags=SpellsInfo.AnimalFormSkillRequirements(1075972),returnCode="animalForm1075972",pressed=press==1075972,false }; -- ferret
				{ str = FormatProperly(GetStringFromTid(1028496)),flags=SpellsInfo.AnimalFormSkillRequirements(1028496),returnCode="animalForm1028496",pressed=press==1028496,false }; -- Bullfrog
				{ str = FormatProperly(GetStringFromTid(1018114)),flags=SpellsInfo.AnimalFormSkillRequirements(1018114),returnCode="animalForm1018114",pressed=press==1018114,false }; -- Giant Serpent
				{ str = FormatProperly(GetStringFromTid(1031670)),flags=SpellsInfo.AnimalFormSkillRequirements(1031670),returnCode="animalForm1031670",pressed=press==1031670,false }; -- cu sidhe
				{ str = FormatProperly(GetStringFromTid(1028438)),flags=SpellsInfo.AnimalFormSkillRequirements(1028438),returnCode="animalForm1028438",pressed=press==1028438,false }; -- Llama
				{ str = FormatProperly(GetStringFromTid(1018273)),flags=SpellsInfo.AnimalFormSkillRequirements(1018273),returnCode="animalForm1018273",pressed=press==1018273,false }; -- Ostard
				{ str = FormatProperly(GetStringFromTid(1030083)),flags=SpellsInfo.AnimalFormSkillRequirements(1030083),returnCode="animalForm1030083",pressed=press==1030083,false }; -- Bake-Kitsune
				{ str = FormatProperly(GetStringFromTid(1028482)),flags=SpellsInfo.AnimalFormSkillRequirements(1028482),returnCode="animalForm1028482",pressed=press==1028482,false }; -- Wolf
				{ str = FormatProperly(GetStringFromTid(1075202)),flags=SpellsInfo.AnimalFormSkillRequirements(1075202),returnCode="animalForm1075202",pressed=press==1075202,false }; -- reptalon
				{ str = FormatProperly(GetStringFromTid(1029632)),flags=SpellsInfo.AnimalFormSkillRequirements(1029632),returnCode="animalForm1029632",pressed=press==1029632,false }; -- Kirin
				{ str = FormatProperly(GetStringFromTid(1018214)),flags=SpellsInfo.AnimalFormSkillRequirements(1018214),returnCode="animalForm1018214",pressed=press==1018214,false }; -- Unicorn 
			}
			ContextMenu.CreateLuaContextMenuItemWithString(WindowUtils.translateMarkup(GetStringFromTid(1063394)),0,0,"null",false,subMenu)	
		elseif serverId == 686 then -- spell trigger
			local press = Interface.ForceSpellTrigger

			local subMenu = {
				{ str = FormatProperly(GetStringFromTid(1078861)),flags=0,returnCode="spellTrigger0",param=param,pressed=press==0,false }; -- Select
			}
			local buttonId = 2
			local tempSubMenu = {}
			for _, tab in pairs(SpellsInfo.SpellsData) do
				if tab.id >= 678 and tab.id <= 700 and tab.spellTrigger then
					
					local _, abilityServerId, tid, _, _, _, _, minskill, _ = GetAbilityData(tab.id)
					skillId = 37
					skillIdsec = 26 -- imbuing
					skillIdthi= 21 -- focus
					
					abilityServerId = WindowData.SkillsCSV[skillId].ServerId
					local mainSkillLevel = WindowData.SkillDynamicData[abilityServerId].TempSkillValue / 10
					
					abilityServerId = WindowData.SkillsCSV[skillIdsec].ServerId
					local secondSkillLevel = WindowData.SkillDynamicData[abilityServerId].TempSkillValue / 10
					
					abilityServerId = WindowData.SkillsCSV[skillIdthi].ServerId
					local tempSkillLevel = WindowData.SkillDynamicData[abilityServerId].TempSkillValue / 10
					secondSkillLevel = math.max(tempSkillLevel,secondSkillLevel)
					local cando = 1
					if minskill <= 20 or (minskill <= mainSkillLevel and minskill <= secondSkillLevel) then
						cando = 0
					end
					local menu = { str = FormatProperly(GetStringFromTid(tid)),flags=cando,returnCode="spellTrigger".. buttonId,param=param,pressed=press==buttonId,false };
					tempSubMenu[tab.id] = menu
					buttonId = buttonId + 1
				end
			end
			for _, menu in pairsByKeys(tempSubMenu) do
				table.insert(subMenu, menu)
			end
			
			ContextMenu.CreateLuaContextMenuItemWithString(WindowUtils.translateMarkup(GetStringFromTid(1080151)),0,0,"null",false,subMenu)
		elseif type == SystemData.UserAction.TYPE_SPELL  and actionId == 56 then -- polymorph
			local press = Interface.ForcePolymorph

			local subMenu = {
				{ str = FormatProperly(GetStringFromTid(1078861)),flags=0,returnCode="polymorph0",	param=param,pressed=press==0,false }; -- Select
				{ str = FormatProperly(GetStringFromTid(1015236)),flags=0,returnCode="polymorph1",	param=param,pressed=press==1,false }; -- Chicken
				{ str = FormatProperly(GetStringFromTid(1015237)),flags=0,returnCode="polymorph2",	param=param,pressed=press==2,false }; -- Dog
				{ str = FormatProperly(GetStringFromTid(1015238)),flags=0,returnCode="polymorph3",	param=param,pressed=press==3,false }; -- Wolf
				{ str = FormatProperly(GetStringFromTid(1015239)),flags=0,returnCode="polymorph4",	param=param,pressed=press==4,false }; -- Panther
				{ str = FormatProperly(GetStringFromTid(1015240)),flags=0,returnCode="polymorph5",	param=param,pressed=press==5,false }; -- Gorilla
				{ str = FormatProperly(GetStringFromTid(1015241)),flags=0,returnCode="polymorph6",	param=param,pressed=press==6,false }; -- Black Bear
				{ str = FormatProperly(GetStringFromTid(1015242)),flags=0,returnCode="polymorph7",	param=param,pressed=press==7,false }; -- Grizzly Bear
				{ str = FormatProperly(GetStringFromTid(1015243)),flags=0,returnCode="polymorph8",	param=param,pressed=press==8,false }; -- Polar Bear
				{ str = FormatProperly(GetStringFromTid(1015244)),flags=0,returnCode="polymorph9",	param=param,pressed=press==9,false }; -- Human Male
				{ str = FormatProperly(GetStringFromTid(1015254)),flags=0,returnCode="polymorph10",	param=param,pressed=press==10,false }; -- Human Female
				{ str = FormatProperly(GetStringFromTid(1015246)),flags=0,returnCode="polymorph11",	param=param,pressed=press==11,false }; -- Slime
				{ str = FormatProperly(GetStringFromTid(1015247)),flags=0,returnCode="polymorph12",	param=param,pressed=press==12,false }; -- Orc
				{ str = FormatProperly(GetStringFromTid(1015248)),flags=0,returnCode="polymorph13",	param=param,pressed=press==13,false }; -- Lizard Man
				{ str = FormatProperly(GetStringFromTid(1015249)),flags=0,returnCode="polymorph14",	param=param,pressed=press==14,false }; -- Gargoyle
				{ str = FormatProperly(GetStringFromTid(1015250)),flags=0,returnCode="polymorph15",	param=param,pressed=press==15,false }; -- Ogre
				{ str = FormatProperly(GetStringFromTid(1015251)),flags=0,returnCode="polymorph16",	param=param,pressed=press==16,false }; -- Troll
				{ str = FormatProperly(GetStringFromTid(1015252)),flags=0,returnCode="polymorph17",	param=param,pressed=press==17,false }; -- Ettin
				{ str = FormatProperly(GetStringFromTid(1015253)),flags=0,returnCode="polymorph18",	param=param,pressed=press==18,false }; -- Daemon
			}
			ContextMenu.CreateLuaContextMenuItemWithString(WindowUtils.translateMarkup(GetStringFromTid(1015234)),0,0,"null",false,subMenu)

		else
			SystemData.ActiveWindow.name = this
			Spellbook.Hide()
		end
		ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)
	else
		SystemData.ActiveWindow.name = this
		Spellbook.Hide()
    end
end

function Spellbook.OnKeyHide()
	MainMenuWindow.notnow = true
	Spellbook.Hide()
end

function Spellbook.Hide()
	if string.find(SystemData.ActiveWindow.name, "Button") then
		Spellbook.SpellContext()
		return
	end	
	WindowSetShowing(WindowUtils.GetActiveDialog(), false)
end

Spellbook.Init = false
Spellbook.AnimWin = ""
Spellbook.startStart = false
Spellbook.endStart = false 
Spellbook.delta = 0

function Spellbook.OnUpdate(timePassed)
	local this = SystemData.ActiveWindow.name
	if (Spellbook.delta  > 0) then
		Spellbook.delta = Spellbook.delta  - timePassed
	end
	if (Spellbook.endStart and Spellbook.delta <= 0) then
		WindowStopScaleAnimation(Spellbook.AnimWin)
		Spellbook.endStart = false
		WindowSetShowing(Spellbook.AnimWin, false)		
	end

	--Spellbook.DeltaRefresh = Spellbook.DeltaRefresh + timePassed
	Spellbook.OnMasteryUpdate(this)	

end

function Spellbook.UpdateTithing()
	local this = WindowUtils.GetActiveDialog()
	local id = WindowGetId(this)
	--If it is a paladin/chivarlry spellbook show the updated tithing points
	if (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
		local tithingName = "Spellbook_"..id.."Tithing"
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(tithingName,  "UO_DefaultText_15pt", 12)
		else
			LabelSetFont(tithingName,  "UO_DefaultText", 12)
		end
		LabelSetText(tithingName, GetStringFromTid(1078097)..L" "..towstring(WindowUtils.AddCommasToNumber(tostring(WindowData.PlayerStatus.TithingPoints))))
	end
end

function Spellbook.CreateTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		CreateWindowFromTemplate(tabName, "SpellbookTabButton", parent)
		
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)
		else
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.CreateTabsLarge(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		CreateWindowFromTemplate(tabName, "SpellbookTabButtonLarge", parent)
		
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)
		else
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.UnselectAllTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		WindowSetShowing(tabName.."TabSelected", false)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function Spellbook.SelectTab(parent, tabNum)
	local tabName = parent.."TabButton"..tabNum
	WindowSetShowing(tabName.."TabSelected", true)
	ButtonSetDisabledFlag(tabName, true);
end
	
-- Called when a minimodel event causes a refresh
-- Update the spells on the current page & set the tab text
-- Doing this in Initialize was causing a bunch of "doesn't exist" error messages
function Spellbook.UpdateSpells()

    local this = SystemData.ActiveWindow.name
	local windowId = WindowGetId(this)
	local id = WindowData.UpdateInstanceId
	if (windowId ~= id) then
		Debug.Print("Window Id doesn't match InstanceId: windowId="..tostring(WindowId).."id="..tostring(id))
		return
	end	

	local data = WindowData.Spellbook[id]
	if Spellbook[id].activeTab then
		if not Spellbook[id].tabsCreated then
            local numTabs = 0
            for i = data.firstSpellNum, data.firstSpellNum + 100, Spellbook.numSpellsPerTab[data.firstSpellNum] do
				local _, _, tid = GetAbilityData(i)
				--Debug.Print("icon: "..tostring(icon).." serverId: "..tostring(serverId).." tid:"..tostring(tid).." i:"..tostring(i))
				if(tid ~= nil and tid > 0) then
					numTabs = numTabs + 1
				else
					break
				end        
            end
            
            Spellbook[id].numTabs = numTabs
            
            -- Displays Tabs on Top

            if not(Spellbook.IsMasteryBook(id)) then
            	Spellbook.CreateTabs(this, Spellbook[id].numTabs)
            end
			
			
			Spellbook[id].tabsCreated = true
			local buttonId = 1
			for i = data.firstSpellNum, data.firstSpellNum + Spellbook.numSpellsPerTab[data.firstSpellNum] do
				local _, serverId, tid = GetAbilityData(i)
				if(tid ~= nil and tid > 0) then
					Spellbook.RegisterSpellIcon(id, buttonId, serverId)
					buttonId = buttonId + 1    
				else
					break
				end        
			end 
		end
			
		local texture = 2200
		WindowSetShowing( this.."Chrome", false )
	
	
        if (data.firstSpellNum == 1) then -- MAGERY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1002106) )
            texture = 2219
        elseif (WindowData.Spellbook[id].firstSpellNum == 101) then -- NECROMANCY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1061677) )
            texture = 11008
        elseif (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1061666) )
            local tithingName = "Spellbook_"..id.."Tithing"
            LabelSetText(tithingName, GetStringFromTid(1078097)..L" "..towstring(WindowUtils.AddCommasToNumber(tostring(WindowData.PlayerStatus.TithingPoints))))
            texture = 11009
        elseif (WindowData.Spellbook[id].firstSpellNum == 401) then -- BUSHIDO
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1070814) )
            texture = 11015
        elseif (WindowData.Spellbook[id].firstSpellNum == 501) then -- NINJITSU
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1070815) )
            texture = 11014
        elseif (WindowData.Spellbook[id].firstSpellNum == 601) then -- SPELLWEAVING
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1031600) )
            texture = 11055
        elseif (WindowData.Spellbook[id].firstSpellNum == 1001) then -- WEAPONS ABILITIES
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1044566) )
            texture = 11010
        elseif (WindowData.Spellbook[id].firstSpellNum == 678) then -- MYSTICISM
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1031677) )
            texture = 11058
        elseif (WindowData.Spellbook[id].firstSpellNum == 701) then -- BARD
			WindowUtils.SetActiveDialogTitle( GetStringFromTid(1028794) )
			texture = 11049
        end
        
        local xSize, ySize
		local scale = 2.0
		texture, xSize, ySize = RequestGumpArt( texture )
		local textureSize = xSize
		
		if (textureSize < ySize) then
			textureSize = ySize
		end
		
		
		WindowSetDimensions(  this, (xSize * scale), (ySize * scale) + 20 )
		WindowSetDimensions(  this.."LegacyBook", xSize * scale, ySize * scale )
		DynamicImageSetTexture( this.."LegacyBook", texture, 0, 0 )
		DynamicImageSetTextureScale( this.."LegacyBook", scale )
		
		WindowClearAnchors(this.."LegacyBook")
		WindowAddAnchor( this.."LegacyBook", "topleft", this, "topleft", -60, 0)
		WindowSetShowing( this.."LegacyBook", true )
		
		WindowSetShowing( this.."LeftScrollWindow", false )
		WindowSetShowing( this.."RightScrollWindow", false )

		if not(Spellbook.IsMasteryBook(id)) then
			for i = 1, Spellbook[id].numTabs do
				local ordinal = Spellbook.uniqueOrdinals[i] or L"th"
				ButtonSetText( this.."TabButton"..i, L""..i..ordinal)
			end	
		
        	Spellbook.ShowTab(Spellbook[id].activeTab)
        else
        	Spellbook.InitMasteryIndexTab()
        	WindowSetShowing( this.."TabWindow", false)
        	WindowSetShowing( this.."LeftScrollWindow", true)
        	WindowSetShowing( this.."RightScrollWindow", true)
        end
	else
		return
	end
end

function Spellbook.ShowTab(tabnum)
        
    local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]    
	--Show Tithing Icon
	if (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
		local iconId = WindowData.PlayerStatsDataCSV[Spellbook.tithId].iconId
		Spellbook.SetMiniIconStats(this,iconId)
		WindowSetShowing(this.."SquareIcon",true)
	else
		WindowSetShowing(this.."SquareIcon",false)
	end
   
    -- Update tabs to highlight the correct one
    Spellbook.UnselectAllTabs(this, Spellbook[id].numTabs)
    Spellbook.SelectTab(this, tabnum)
    Spellbook[id].activeTab = tabnum
    	
	local pageOffset = (tabnum-1)*Spellbook.numSpellsPerTab[data.firstSpellNum]

	for i=1, Spellbook.MAX_SPELLS_PER_TAB do
		local buttonName = "Spellbook_"..id.."TabWindowButton"..i
		local iconName = buttonName.."SquareIcon"
		local labelName = buttonName.."Desc"
		local wordName = buttonName.."WordPower"
		local abilityId = data.firstSpellNum + pageOffset + i - 1
		
		--Debug.Print(L"abilityId: "..data.firstSpellNum..L"+"..pageOffset..L"+"..i..L"-1="..abilityId)
		--Debug.PrintToDebugConsole(L"Spellbook.ShowTab: i =  "..StringToWString(tostring(i))..L" abilityId = "..StringToWString(tostring(abilityId)))
	
		local icon, _, tid, _, _, powerword = GetAbilityData(abilityId)
		if(icon ~= nil and icon ~= 0 and i <= Spellbook.numSpellsPerTab[data.firstSpellNum]) then
			--Debug.PrintToDebugConsole(L"Spellbook.ShowTab: has ability data for icon  "..StringToWString(tostring(icon)))
			local texture, x, y = GetIconData( icon )
			DynamicImageSetTexture( iconName, texture, x, y )
		
			if data.spells[pageOffset+i] == 1 then
				WindowSetAlpha( iconName, 1.0 )
				LabelSetTextColor(labelName, 0, 0, 0)
				LabelSetTextColor(wordName,  0, 94, 0)
				ButtonSetDisabledFlag(buttonName, false)
			else
				WindowSetAlpha( iconName, 0.4 )
				LabelSetTextColor(labelName, 115, 115, 115)
				LabelSetTextColor(wordName, 115, 115, 115)
				ButtonSetDisabledFlag(buttonName, true)
			end
			        
			LabelSetText(labelName, GetStringFromTid(tid))			
			--Show the power words for the spell
			if(powerword ~= nil) then
				--Debug.Print("Words of Power = "..powerword)
				LabelSetText(wordName, StringToWString(powerword))
			end

			-- show the entry
			WindowSetShowing (buttonName, true)
			WindowSetShowing (labelName, true)
		else
			-- hide the entry
			WindowSetShowing (buttonName, false)
			WindowSetShowing (labelName, false)
		end
	end	
end

function Spellbook.InitMasteryIndexTab()
	local this = SystemData.ActiveWindow.name

	LabelSetText(this.."LeftScrollWindowScrollChildIndex", L" --- " .. GetStringFromTid(Spellbook.TID.Index) .. L" --- ")
	LabelSetText(this.."RightScrollWindowScrollChildActive", L" --- " .. GetStringFromTid(Spellbook.TID.Active) .. L" --- ")
		
	local baseItemName = this.."RightScrollWindowScrollChildItem"
	local parent = this.."RightScrollWindowScrollChild"
	local rightScrollWindow = this.."RightScrollWindow"

	WindowClearAnchors(parent)
	WindowAddAnchor( parent, "topleft", rightScrollWindow, "topleft", 0, 0)

	local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
	local lastShownIdx = 0
	
	local abilityId
	if (Spellbook.ActiveMastery)then
		for i=1, Spellbook.MAX_MASTERY_SPELL_COUNT do
			
			masteryData = Spellbook.ActiveMasteryIndex[Spellbook.ActiveMastery]
			if(masteryData == nil)then
				break				
			end
			if(i == 1)then
				abilityId = masteryData.SpellA
			elseif(i == 2)then
				abilityId = masteryData.SpellB
			else
				abilityId = masteryData.Passive				
			end			
			
			local currentWindowName = baseItemName.."Active"..i
			if (DoesWindowExist(currentWindowName)) then
				DestroyWindow(currentWindowName)
			end

			if(abilityId == 0)then
				break
			end

			local icon, _, tid, _, _, powerword = GetAbilityData(abilityId)
			if(icon ~= nil and icon ~= 0) then				
				--local buttonName = "Spellbook_"..id.."TabWindowButton"..i
				local iconName = currentWindowName.."SquareIcon"
				local labelName = currentWindowName.."Desc"
				local wordName = currentWindowName.."WordPower"			

				CreateWindowFromTemplate( currentWindowName, "SpellbookSpellDef",  parent)

				WindowClearAnchors(currentWindowName)
				
				if (i==1) then
					WindowAddAnchor( currentWindowName, "topleft", parent, "topleft", 0, 30)		 			
				else
					WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."Active"..(lastShownIdx), "topleft", 0, 0)
				end
				lastShownIdx = i

				local iconTexture, x, y = GetIconData(icon)

				DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
				
				WindowSetShowing(currentWindowName.."Disabled", false)
				WindowSetAlpha( iconName, 1.0 )
				LabelSetTextColor(labelName, 0, 0, 0)							
				LabelSetText(labelName, GetStringFromTid(tid))

				LabelSetTextColor(wordName,  0, 94, 0)
				if(powerword ~= nil) then
					--Debug.Print("Words of Power = "..powerword)
					LabelSetText(wordName, StringToWString(powerword))
				end
				
				WindowSetShowing(currentWindowName, true)			
				WindowSetId(currentWindowName, abilityId)
				WindowSetId(currentWindowName.."SquareIcon", abilityId)						
			end
		end
	end

	baseItemName = this.."LeftScrollWindowScrollChildItem"
	parent = this.."LeftScrollWindowScrollChild"
	local leftScrollWindow = this.."LeftScrollWindow"

	WindowClearAnchors(parent)
	WindowAddAnchor( parent, "topleft", leftScrollWindow, "topleft", 0, 0)
		
	lastShownIdx = 0
	for i=1, Spellbook.MASTERY_COUNT do
		
		abilityId = data.firstSpellNum + i - 1
		local currentWindowName = baseItemName.."All"..i
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end

		local icon, _, tid, _, _, powerword = GetAbilityData(abilityId)
		if(icon ~= nil and icon ~= 0) then
						
			local iconName = currentWindowName.."SquareIcon"
			local labelName = currentWindowName.."Desc"
			local wordName = currentWindowName.."WordPower"			

			CreateWindowFromTemplate( currentWindowName, "SpellbookSpellDef", parent)

			WindowClearAnchors(currentWindowName)			
			if (i==1) then
				WindowAddAnchor( currentWindowName, "topleft", parent, "topleft", 0, 30)	 			
			else
				WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."All"..(lastShownIdx), "topleft", 0, 0)
			end
			lastShownIdx = i

			local iconTexture, x, y = GetIconData(icon)

			DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
			
			WindowSetShowing(currentWindowName.."Disabled", false)
			WindowSetAlpha( iconName, 1.0 )
			LabelSetTextColor(labelName, 0, 0, 0)							
			LabelSetText(labelName, GetStringFromTid(tid))

			LabelSetTextColor(wordName,  0, 94, 0)
			if(powerword ~= nil) then
				--Debug.Print("Words of Power = "..powerword)
				LabelSetText(wordName, StringToWString(powerword))
			end

			--ButtonSetDisabledFlag(currentWindowName, true)			
			
			WindowSetShowing(currentWindowName, true)			
			WindowSetId(currentWindowName, abilityId)
			WindowSetId(currentWindowName.."SquareIcon", abilityId)						
		end
	end
	
	ScrollWindowUpdateScrollRect(rightScrollWindow)
	ScrollWindowUpdateScrollRect(leftScrollWindow)	
end

-- OnShutdown Handler
function Spellbook.Shutdown()
	ItemProperties.ClearMouseOverItem()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	UnregisterWindowData(WindowData.Spellbook.Type, id)
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowUtils.SaveWindowPosition(SystemData.ActiveWindow.name, false, "LEGACY_Spellbook_GUMP")	
end

-- OnLButtonDown Handler
function Spellbook.SpellLButtonDown(flags)
    local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]    
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = 0 	

    if not Spellbook.IsMasteryBook(id) then	
	    local page = Spellbook[id].activeTab	    
	    curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1
	else
		curSpell = index
	end    

    local icon, serverId = GetAbilityData(curSpell)
    if flags == SystemData.ButtonFlags.CONTROL then
		local blockBar = HotbarSystem.GetNextHotbarId()
		Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
		HotbarSystem.SpawnNewHotbar()
		
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPELL, curSpell, icon, blockBar,  1)
		
		local scaleFactor = 1/InterfaceCore.scale	
		
		local propWindowWidth = Hotbar.BUTTON_SIZE
		local propWindowHeight = Hotbar.BUTTON_SIZE
		
		-- Set the position
		local mouseX = SystemData.MousePosition.x - 30
		if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
			propWindowX = mouseX - (propWindowWidth / scaleFactor)
		else
			propWindowX = mouseX
		end
			
		local mouseY = SystemData.MousePosition.y - 15
		if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
			propWindowY = mouseY - (propWindowHeight / scaleFactor)
		else
			propWindowY = mouseY
		end
		
		WindowSetOffsetFromParent("Hotbar" .. blockBar, propWindowX * scaleFactor, propWindowY * scaleFactor)
		WindowSetMoving("Hotbar" .. blockBar, true)
    else
		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SPELL,serverId,icon)
	end
end

-- OnLButtonUP Handler
function Spellbook.SpellLButtonUp()
	local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]    
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = 0
 	
    if not Spellbook.IsMasteryBook(id) then	
	    local page = Spellbook[id].activeTab	    
	    curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1
	else
		curSpell = index
	end   

    local _, serverId = GetAbilityData(curSpell)

    if( serverId ~= nil ) then
		UserActionCastSpell(serverId)
		SystemData.ActiveWindow.name = this
    end
end

-- OnMouseOver Handler
function Spellbook.SpellMouseOver()
	CharacterSheet.UpdateStatus()

	local this = WindowUtils.GetActiveDialog()
	local id = WindowGetId(this)
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local curSpell = 0
 	local data = WindowData.Spellbook[id]

    if not Spellbook.IsMasteryBook(id) then	
    	
	    local page = Spellbook[id].activeTab	    
	    curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1	    
	else		
		curSpell = index		
	end

    local _, serverId, _, _, reagents, _, tithingcost, minskill, manacost  = GetAbilityData(curSpell)
    local reagentsStr = L""
    local tithingStr = L""
    local minskillStr = L"<BR>"
    local manacostStr = L""
    
   -- Debug.Print(curSpell)
  
    if(reagents ~= nil and reagents ~= "") then
		  --TID says "Reagents"
		reagentsStr = L"<BR>== "..GetStringFromTid(1002127)..L" ==<BR>"..StringToWString(reagents)
	--Debug.Print("reagents ="..reagents)
    end
    
    if(tithingcost ~= nil and tithingcost > 0) then
		-- Paladin
		if(serverId >= 201 and serverId <= 210) then
			-- TID says "Tithing Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1062099)..StringToWString(tostring(tithingcost))
		-- Bard
		elseif(serverId >= 701 and serverId <= 706) then
			-- TID says "Upkeep Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1115718)..StringToWString(tostring(tithingcost))
		elseif(serverId == 707 or serverId == 721 or serverId == 725 or serverId == 728 or serverId == 730 or serverId == 736) then
			-- TID says "Upkeep Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1115718)..StringToWString(tostring(tithingcost))
		elseif(serverId == 719 or serverId == 720 ) then
			-- TID says "Tithing Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1062099)..StringToWString(tostring(tithingcost))
		end

    end
    
    local skillId = 0 
	local skillLevel = 0
	-- 9 bushido
	-- 13 chivalry
	-- 32 magery
	-- 38 necromancy
	-- 39 ninjitsu
	-- 46 spellweaving
	-- 37 mysticism
	
    if (curSpell > 0 and curSpell < 65) then
		minskill = SpellsInfo.GetMinSkill(curSpell) 
		skillId = 32
	elseif (curSpell >= 101 and curSpell <= 200) then -- Necromancy
		minskill = SpellsInfo.GetMinSkill(curSpell) 
		skillId = 38
	elseif (curSpell >= 201 and curSpell <= 300) then -- Chivalry
		skillId = 13
	elseif (curSpell >= 401 and curSpell <= 500) then -- Bushido
		skillId = 9
	elseif (curSpell >= 501 and curSpell <= 600) then	-- Ninjitsu
		skillId = 39
	elseif (curSpell >= 601 and curSpell <= 677) then -- Spellweaving
		skillId = 46
	elseif (curSpell >= 678 and curSpell <= 700) then -- Mysticism
		skillId = 37
	end
	
	
	if (curSpell < 701) then
		serverId = WindowData.SkillsCSV[skillId].ServerId
		skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	end
	
    if(minskill ~= nil) then
		-- TID says "Min Skill:"
		minskillStr =  minskillStr..L"<BR>"..GetStringFromTid(1062101)..L" "..StringToWString(tostring(minskill))
    end
    
    if ( WindowData.PlayerStatus["Race"] == 1 and skillLevel < 20 ) then
		skillLevel = 20
	end
	local spelldamage = L""
	
	if (skillId > 0) then
		local maxskill = SpellsInfo.GetMaxSkill(minskill, curSpell) 
		if maxskill > minskill then
			minskillStr =  minskillStr..L"<BR>"..L"Max Skill: "..StringToWString(tostring(maxskill))
		end
	    

		local success  = ((skillLevel - minskill) * 100) / SpellsInfo.GetVariation(curSpell) 

        if skillLevel < minskill then
            success = 0
        end
        if skillLevel > minskill + SpellsInfo.GetVariation(curSpell)  then
            success = 100
        end
        
        success = string.format("%1.1f", success)
        
       minskillStr =  minskillStr..L"<BR><BR>"..L"Success Chance: "..StringToWString(tostring(success)) .. L"%<BR>"
       local spellspeed = SpellsInfo.GetSpellSpeed(curSpell)
       
		if (spellspeed) then
			minskillStr =  minskillStr .. L"<BR>Casting Speed: " .. spellspeed .. L"s<BR>"
		end
       spelldamage = SpellsInfo.GetSpellDamage(curSpell) 
    end
    
    if(manacost ~= nil) then
		-- TID says "Mana Cost:"
		local lmcMana = math.floor(manacost - (manacost * (tonumber(WindowData.PlayerStatus["LowerManaCost"]) / 100)))
		manacostStr =  L"<BR>"..GetStringFromTid(1062100)..L" " .. StringToWString(tostring(lmcMana)) .. L" (".. StringToWString(tostring(manacost)) .. L")"
    end
    

    
	local itemData = { windowName = this,
						itemId = curSpell,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_LONG,
						title = L"",	
						body = reagentsStr..tithingStr..minskillStr.. spelldamage .. manacostStr	}
	ItemProperties.SetActiveItem(itemData)	    
end

-- Tab Handler
function Spellbook.ToggleTab()
    -- Get the number of the tab clicked, which should be the last character of its name
    -- NOTE: Obviously, this won't work if you have more than ten tabs
    tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	Spellbook.ShowTab(tab_clicked)  
end


function Spellbook.RegisterSpellIcon(spellbookId, buttonId, serverId)
	local buttonName = "Spellbook_"..spellbookId.."TabWindowButton"..buttonId
	HotbarSystem.RegisterSpellIcon(buttonName, serverId)
end

-- OnShutdown Handler
function Spellbook.ShutdownSpellIcon()
	HotbarSystem.UnregisterSpellIcon(SystemData.ActiveWindow.name)
end

function Spellbook.TithLButtonDown(flags)
	local this = WindowUtils.GetActiveDialog()
	local windowId = WindowGetId(this)
	if (WindowData.Spellbook[windowId].firstSpellNum == 201) then
		local id = Spellbook.tithId
		local iconId = WindowData.PlayerStatsDataCSV[id].iconId	
		if flags == SystemData.ButtonFlags.CONTROL then
			local label = "QuickStat_" .. #QuickStats.Labels + 1
			local l = QuickStats.DoesLabelExist(id)
			if l > 0 and DoesWindowNameExist("QuickStat_" .. l) then
				label = "QuickStat_" .. l
			else
				local lab = {attribute=id, frame=true, icon=true, name=true, cap=true, locked=false, BGColor={r=0,g=0,b=0}, frameColor={r=255,g=255,b=255}, valueTextColor={r=255,g=255,b=255}, nameTextColor={r=243,g=227,b=49}}
				table.insert(QuickStats.Labels, lab)
				
				CreateWindowFromTemplate(label, "QuickStatTemplate", "Root")
				WindowSetId(label, #QuickStats.Labels)
				WindowUtils.openWindows[label] = true
				QuickStats.UpdateLabel(label)
				
				SnapUtils.SnappableWindows[label] = true
			end
			local scaleFactor = 1/InterfaceCore.scale	
			
			local propWindowWidth = 380
			local propWindowHeight = 30
			
			-- Set the position
			local mouseX = SystemData.MousePosition.x - 30
			if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
				propWindowX = mouseX - (propWindowWidth / scaleFactor)
			else
				propWindowX = mouseX
			end
				
			local mouseY = SystemData.MousePosition.y - 15
			if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
				propWindowY = mouseY - (propWindowHeight / scaleFactor)
			else
				propWindowY = mouseY
			end
			
			WindowSetOffsetFromParent(label, propWindowX * scaleFactor, propWindowY * scaleFactor)
			QuickStats.InMovement[label] = true
			WindowSetMoving(label, true)
			SnapUtils.StartWindowSnap(label)
		else
			DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_PLAYER_STATS,id,iconId)
		end
	end
end

function Spellbook.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( iconId )	
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 3
	WindowSetDimensions(iconWindow.."SquareIcon", 20, 20)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )			
end

function Spellbook.TithMouseOver()
	local this = WindowUtils.GetActiveDialog()
	local id = WindowGetId(this)
	if (WindowData.Spellbook[id].firstSpellNum == 201) then

		local buttonName = SystemData.ActiveWindow.name
		local text = GetStringFromTid(1112081)
		Tooltips.CreateTextOnlyTooltip(buttonName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end
end


function Spellbook.IsMasteryBook(id)
	return(WindowData.Spellbook[id] ~= nil and WindowData.Spellbook[id].firstSpellNum == 701)
end

function Spellbook.OnMasteryUpdate(windowName)
	local objectId = WindowGetId(windowName)    
    if Spellbook.IsMasteryBook(objectId) then	
    	if(Spellbook.UpdateMasteryBook == 0)then--if (Spellbook[objectId].lastUpdate < Spellbook.DeltaRefresh)then    		
    		return
    	end

    	local currentMastery = 0
    	local isDirty = 0
    	if(Spellbook.UpdateMasteryBook ~= 1)then
    		for i=1, #Spellbook.MasteryBookTIDs do				
				if Spellbook.MasteryBookTIDs[i] == Spellbook.UpdateMasteryBook then
					currentMastery = Spellbook.UpdateMasteryBook					
					break
				end
			end    		
    	end
    	Spellbook.UpdateMasteryBook = 0 
    	
    	if(currentMastery == 0)then
			local noObjectFound = 0
			if(not WindowData.ObjectInfo[objectId])then		
				RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
				noObjectFound = 1
			end

			local props = ItemProperties.GetObjectPropertiesArray( objectId, "Spellbook.OnMasteryUpdate" )
			if not props then
				return
			end			
			
			for j = 1, #props.PropertiesTids do
				local indexTID = props.PropertiesTids[j]
				for i=1, #Spellbook.MasteryBookTIDs do				
					if Spellbook.MasteryBookTIDs[i] == indexTID then
						currentMastery = indexTID					
						break
					end
				end

				if(currentMastery ~= 0)then
					break
				end
			end

			if noObjectFound == 1 then		
				UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
			end
		end

		if(currentMastery ~= Spellbook.ActiveMastery)then			
			isDirty =1
		end

		Spellbook.ActiveMastery = currentMastery
		if(isDirty== 1)then
			Spellbook.InitMasteryIndexTab()
		end	
    end

end


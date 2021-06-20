
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BuffDebuff = {}

BuffDebuff.BuffData = {}
BuffDebuff.Timers = {}
BuffDebuff.BuffWindowId = {}
BuffDebuff.TableOrder = {}
BuffDebuff.ReverseOrder = {}
BuffDebuff.MaxLength = 6
BuffDebuff.Gap = 2
BuffDebuff.DeltaTime = 0
BuffDebuff.Fade = {start = 30, endtime = 10, amount = 0.2 }
BuffDebuff.TID = {}
BuffDebuff.TID.timeleft = 1075611
BuffDebuff.IconSize = 38
BuffDebuff.ActiveBuffs = {}
BuffDebuff.Fade = {}
BuffDebuff.FadeRaising = {}

BuffDebuff.Good = {
[1005] = true; -- AB_NIGHT_SIGHT
[1010] = true; -- AB_DIVINE_FURY
[1011] = true; -- AB_ENEMY_OF_ONE
[1014] = true; -- AB_BLOOD_OATH_CASTER
[1020] = true; -- AB_RENEWAL
[1021] = true; -- AB_ATTUNE_WEAPON
[1024] = true; -- AB_ETHEREAL_VOYAGE
[1025] = true; -- AB_GIFT_OF_LIFE
[1026] = true; -- AB_ARCANE_EMPOWERMENT
[1028] = true; -- AB_REACTIVE_ARMOR
[1029] = true; -- AB_PROTECTION
[1030] = true; -- AB_ARCH_PROTECTION
[1031] = true; -- AB_MAGIC_REFLECTION
[1034] = true; -- AB_ANIMAL_FORM
[1035] = true; -- AB_POLYMORPH
[1036] = true; -- AB_INVISIBILITY
[1045] = true; -- AB_AGILITY
[1046] = true; -- AB_CUNNING
[1047] = true; -- AB_STRENGTH_SPELL
[1048] = true; -- AB_BLESS
[1050] = true; -- AB_STONE_FORM
[1052] = true; -- AB_GARGOYLE_BERSERK
[1055] = true; -- AB_BARD_INSPIRE
[1056] = true; -- AB_BARD_INVIGORATE
[1057] = true; -- AB_BARD_RESILIENCE
[1058] = true; -- AB_BARD_PERSEVERANCE
[1061] = true; -- AB_NEWBIE_TOKEN
[1062] = true; -- AB_FISH_BUFF
[1065] = true; -- AB_HIT_DUAL_WIELD
[1066] = true; -- AB_BLOCK
[1067] = true; -- AB_DEFENSE_MASTERY
[1069] = true; -- AB_HEALING_SKILL
[1070] = true; -- AB_SPELL_FOCUSING_BUFF
[1073] = true; -- AB_RAGE_FOCUSING_BUFF
[1074] = true; -- AB_WARDING
[1075] = true; -- AB_BARD_TRIBULATION_BUFF
[1078] = true; -- AB_SURGE
[1079] = true; -- AB_FEINT
[1082] = true; -- AB_CONSECRATE_BUFF
[1083] = true; -- AB_GRAPES_OF_WRATH
[1085] = true; -- AB_HORRIFIC_BEAST
[1086] = true; -- AB_LICH_FORM
[1087] = true; -- AB_VAMPRIC_FORM
[1088] = true; -- AB_CURSE_WEAPON
[1089] = true; -- AB_REAPER_FORM
[1124] = true; -- AB_WRAITH_FORM
[1090] = true; -- AB_IMMOLATING_WEAPON
[1091] = true; -- AB_ENCHANT
[1092] = true; -- AB_HONORABLE_EXEC
[1093] = true; -- AB_CONFIDENCE
[1094] = true; -- AB_EVASION
[1095] = true; -- AB_COUNTER_ATTACK
[1096] = true; -- AB_LIGHTNING_STRIKE
[1097] = true; -- AB_MOMENTUM_STRIKE
[1098] = true; -- AB_ORANGE_PETALS
[1099] = true; -- AB_ROSEOFTRINSIC_PETALS
[1100] = true; -- AB_POISON_IMMUNITY
[1101] = true; -- AB_VETERINARY
[1102] = true; -- AB_PERFECTION
[1103] = true; -- AB_HONORED_BUFF
[1104] = true; -- AB_MANA_PHASE
[1126] = true; -- AB_CITY_BUFF
[1128] = true; -- AB_VIRTUE_SPIRITUALITY_BUFF
[1129] = true; -- AB_HUMILITY_BUF
[1130] = true; -- AB_RAMPAGE
[1132] = true; -- AB_TOUGHNESS
[1133] = true; -- AB_THRUST
[1135] = true; -- AB_SCAVENG
[1136] = true; -- AB_FOCUSED_EYE
[1138] = true; -- AB_MAGNUS_EFFECT
[1140] = true; -- AB_CALLED_SHOT
[1141] = true; -- AB_WRESTLING_PASSIVE
[1142] = true; -- AB_SAVING_THROW
[1143] = true; -- AB_CONDUIT_BUFF
[1145] = true; -- AB_MYSTIC_WEAPON_BUFF
[1146] = true; -- AB_SW_MANA_SHIELD_BUFF
[1147] = true; -- AB_ANTICIPATE_HIT_BUFF
[1148] = true; -- AB_WAR_CRY_BUF
[1149] = true; -- AB_SHADOW_BUFF
[1150] = true; -- AB_WHITE_TIGER_BU
[1151] = true; -- AB_BODY_GUARD_BUFF
[1152] = true; -- AB_HEIGHTENSENSES_BUFF
[1153] = true; -- AB_TOLERANCE_BUFF
[1154] = true; -- AB_DEATH_RAY
[1156] = true; -- AB_MELEECAST_PASSIVE
[1157] = true; -- AB_SPELLCAST_PASSIVE
[1158] = true; -- AB_SHIELD_BASH
[1159] = true; -- AB_WHISPERING
[1160] = true; -- AB_COMBAT_TRAINING
[1162] = true; -- AB_INJECTING_BUFF
[1163] = true; -- AB_BUBBLE_IMMUNE_BUFF
[1166] = true; -- AB_BOARDING_BUFF
[1167] = true; -- AB_POTENCY_BUFF
[1169] = true; -- AB_FOF_BUFF
[1170] = true; -- AB_EODON_POTION_BARRAB_HEMOLYMPH
[1171] = true; -- AB_EODON_POTION_JUKARI_BURN
[1172] = true; -- AB_EODON_POTION_KURAK_AMBUSHER
[1173] = true; -- AB_EODON_POTION_BARAKO_DRAFT
[1174] = true; -- AB_EODON_POTION_URALI_TRANCE
[1175] = true; -- AB_EODON_POTION_SAKKHRA_PROPHYLAXIS
[1179] = true; -- AB_HIT_SPARKS_IMMUNE_BUFF
[1180] = true; -- AB_HIT_SWARM_IMMUNE_BUFF
[1181] = true; -- AB_HIT_BONECRUSHER_IMMUNE_BUFF
[1182] = true; -- AB_STATUE_TRANSFORM
[1183] = true; -- AB_CORA_IMMUNE
[1184] = true; -- AB_VIRTUE_SHIELD
[1186] = true; -- AB_TOK_METEOR_BUFF
[1187] = true; -- AB_POTION_GLORIOUS_FORTUNE_BUFF
[1188] = true; -- AB_TOTEM_TRANSFORM
}

BuffDebuff.Neutral = {
[1012] = true; -- AB_HIDDEN
[1013] = true; -- AB_MEDITATING
[1032] = true; -- AB_INCOGNITO
[1033] = true; -- AB_DISGUISED
[1054] = true; -- AB_GARGOYLE_FLY
[1068] = true; -- AB_BARD_DESPAIR_BUFF
[1008] = true; -- AB_HONORED
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function BuffDebuff.Update(timePassed)
	BuffDebuff.DeltaTime = BuffDebuff.DeltaTime + timePassed
	
	if (BuffDebuff.Timers ~= nil) then
		for key, value in pairs(BuffDebuff.Timers) do
			local buffId = key
			local parent = "BuffDebuff"
			local iconName = parent.."Icon"..buffId .. "TextureIcon"
			if ( type(BuffDebuff.Timers[buffId]) == "number") then
				local sec = tonumber(BuffDebuff.Timers[buffId])
				if ( sec < 10 and not BuffDebuff.Fade[buffId]) then
					
					BuffDebuff.Fade[buffId] = true
					WindowStartAlphaAnimation(iconName, Window.AnimationType.LOOP, 0.1, 0.8, 0.8, false, 0, 0)
				elseif (sec >= 10) then
					BuffDebuff.Fade[buffId] = false
					WindowStopAlphaAnimation(iconName)
				end
				
			end
		end
	end
	
	if( BuffDebuff.DeltaTime >= 1 ) then
		for key, value in pairs(BuffDebuff.Timers) do
			local time = value - BuffDebuff.DeltaTime
			--Debug.Print("Time passed for key ="..key.."time = "..math.ceil(time))
			if( time > 0 ) then
				BuffDebuff.Timers[key] = math.ceil(time)
			else
				BuffDebuff.Timers[key] = 0
				BuffDebuff.HandleBuffRemoved(key)
			end	
		end
		--Update Timer Label
		BuffDebuff.UpdateTimer(timePassed)
		--Reset delta time when it gets used to decrement the timers
		BuffDebuff.DeltaTime = 0
	end
end

function BuffDebuff.retrieveBuffData( buffData )
	if not buffData then
		return false
	end      

	if(WindowData.BuffDebuffSystem.CurrentBuffId == 0) then
		return false
	end
	
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	
	buffData.abilityId = WindowData.BuffDebuffSystem.CurrentBuffId
	buffData.TimerSeconds = WindowData.BuffDebuff.TimerSeconds
	buffData.HasTimer = WindowData.BuffDebuff.HasTimer
	buffData.NameVectorSize = WindowData.BuffDebuff.NameVectorSize
	buffData.ToolTipVectorSize = WindowData.BuffDebuff.ToolTipVectorSize
	buffData.IsBeingRemoved = WindowData.BuffDebuff.IsBeingRemoved
	buffData.NameWStringVector = WindowData.BuffDebuff.NameWStringVector
	buffData.ToolTipWStringVector =  WindowData.BuffDebuff.ToolTipWStringVector
	
	if (BuffDebuff.Good[buffId] or BuffDebuff.Neutral[buffId]) then
		buffData.good = true
	else
		buffData.good = false
	end
	
	return true
end

function BuffDebuff.Initialize()
	--Debug.Print("BuffDebuff.Initialize() ")
	UOBuildTableFromCSV("Data/GameData/buffdata.csv", "BuffDataCSV")
	RegisterWindowData(WindowData.BuffDebuff.Type, 0)
	WindowRegisterEventHandler( "BuffDebuff", WindowData.BuffDebuff.Event, "BuffDebuff.ShouldCreateNewBuff")
end

function BuffDebuff.ShouldCreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	
	--If we have a buff debuff icon up, check to see if that is being removed
	--Debug.Print("BuffDebuf event triggered")
	--Debug.Print(buffId)
	local buffData = {}
	if( BuffDebuff.retrieveBuffData( buffData ) ) then		
		BuffDebuff.BuffData[buffId] = buffData		
		if( WindowData.BuffDebuff.IsBeingRemoved == true ) then
			--Debug.Print("BuffDebuf getting destroyed"..buffId)
			if (BuffDebuff.BuffWindowId[buffId] == true) then
				if(buffId == 1043) then --1043 Curse
					if( BuffDebuff.ReverseOrder[1040] ~= nil) then --Clumsy
						BuffDebuff.HandleBuffRemoved(1040)
					end
					if( BuffDebuff.ReverseOrder[1041] ~= nil) then --Feeblemind
						BuffDebuff.HandleBuffRemoved(1041)
					end
					if( BuffDebuff.ReverseOrder[1042] ~= nil) then --Weaken
						BuffDebuff.HandleBuffRemoved(1042)
					end
				end
				BuffDebuff.HandleBuffRemoved(buffId)
			end
		else			
			local textureId = -1
			local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
			if(rowServerNum ~= nil and WindowData.BuffDataCSV ~= nil and WindowData.BuffDataCSV[rowServerNum] ~= nil and WindowData.BuffDataCSV[rowServerNum].IconId ~= nil) then
				textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
				--Debug.Print("Trying to get the icon "..WindowData.BuffDataCSV[rowServerNum].IconId)
			end
			if(textureId ~= nil and textureId ~= -1 )then
				--Debug.Print("BuffDebuff.CreateNewBuff()")					
				BuffDebuff.CreateNewBuff()
			else
				--Debug.Print("BuffDebuff.CreateNewBuff() failed: "..tostring(textureId))
				BuffDebuff.BuffData[buffId] = nil
			end
		end		
	else
		--Debug.Print("BuffDebuff.retrieveBuffData failed")
	end
end

function BuffDebuff.HandleBuffRemoved(buffId)
	local iconName = "BuffDebuffIcon"..buffId
	 
	 
	 if (BuffDebuff.BuffData[buffId].good) then
		local position = AdvancedBuff.ReverseOrderGood[buffId]

		table.remove(AdvancedBuff.TableOrderGood, position)

		AdvancedBuff.HandleReAnchorBuffGood(1)
	else
		local position = AdvancedBuff.ReverseOrderEvil[buffId]
		table.remove(AdvancedBuff.TableOrderEvil, position)
		AdvancedBuff.HandleReAnchorBuffEvil(1)
	end
	
	if (buffId == 1094) then
		HotbarSystem.EvasionCooldown = 20
	end
	if (buffId == 1021) then
		HotbarSystem.AttunementCooldown = 120
	end
	if (buffId == 1024) then
		HotbarSystem.EtherealVoyageCooldown = 300
	end
	
	-- Have to set this to nil since the buffId is removed from the table
	BuffDebuff.ReverseOrder[buffId] = nil
	BuffDebuff.BuffWindowId[buffId] = false
	BuffDebuff.BuffData[buffId] = nil
	BuffDebuff.Timers[buffId] = nil
	BuffDebuff.ActiveBuffs[buffId] = nil
	
	WindowUtils.SaveWindowPosition(iconName)
	DestroyWindow(iconName)
end

function BuffDebuff.UpdateTimer(timePassed)
	local endNumber = table.getn(AdvancedBuff.TableOrderGood)
	for i=1, endNumber do
		local buffId = AdvancedBuff.TableOrderGood[i]
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId
		local timer = L" "

		if ( BuffDebuff.Timers[buffId] ~= nil and BuffDebuff.Timers[buffId] > 0   ) then
			local min = math.floor(BuffDebuff.Timers[buffId]/60)
			if min > 60 then
				local prefix = ""
				if ((min / 60) - math.floor(min / 60) > 0) then
					prefix = ">"
				end
				local h = math.floor(min / 60)
				timer = StringToWString(prefix .. tostring(h) .. "h")
			elseif min > 0 then
				local prefix = ""
				if (BuffDebuff.Timers[buffId] - (min * 60) > 0) then
					prefix = ">"
				end
				timer = StringToWString(prefix .. tostring(min)	.. "m")
			else
				timer = StringToWString(tostring(BuffDebuff.Timers[buffId])	.. "s")
			end
		end
		LabelSetText(iconName.."TimerLabel",timer)
		local scale = 1
		scale = WindowGetScale( AdvancedBuff.WindowNameGood )
		WindowSetScale(iconName, scale)
	end
	endNumber = table.getn(AdvancedBuff.TableOrderEvil)
	for i=1, endNumber do
		local buffId = AdvancedBuff.TableOrderEvil[i]
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId
		local timer = L" "

		if ( BuffDebuff.Timers[buffId] ~= nil and BuffDebuff.Timers[buffId] > 0   ) then
			local min = math.floor(BuffDebuff.Timers[buffId]/60)
			if min > 0 then
				timer = StringToWString(tostring(min)	.. "m")
			else
				timer = StringToWString(tostring(BuffDebuff.Timers[buffId])	.. "s")
			end
		end
		if (buffId == 1070 or buffId == 1071 or buffId == 1072 or buffId == 1073) then

			timer = BuffDebuff.BuffData[buffId].ToolTipWStringVector[1]
			if (wstring.find(timer, L":", -7)) then
				timer = wstring.sub(timer, wstring.find(timer, L":", -7)+2)
			end

		end
		LabelSetText(iconName.."TimerLabel",timer)
		local scale = 1
		scale = WindowGetScale( AdvancedBuff.WindowNameEvil )
		WindowSetScale(iconName, scale)
	end
end

function BuffDebuff.CreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	local buffData = BuffDebuff.BuffData[buffId]
	
	if( BuffDebuff.BuffWindowId[buffId] ~= true)then
		-- Need to know the ordering so we can anchor the buffs correctly 
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId

		if (BuffDebuff.BuffData[buffId].good) then
			table.insert(AdvancedBuff.TableOrderGood, buffId)			
			CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", "Root")
		else
			table.insert(AdvancedBuff.TableOrderEvil, buffId)
			CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", "Root")
			
		end
		table.insert(BuffDebuff.TableOrder, buffId) 
	
		local scale = 1
		if (BuffDebuff.BuffData[buffId].good) then
			scale = WindowGetScale( AdvancedBuff.WindowNameGood )
		else
			scale = WindowGetScale( AdvancedBuff.WindowNameEvil )
		end
		WindowSetScale(iconName, scale)

		WindowSetId(iconName, buffId)


		if (BuffDebuff.BuffData[buffId].good) then
			numIcons = table.getn(AdvancedBuff.TableOrderGood)
			AdvancedBuff.ReverseOrderGood[buffId] = numIcons
			AdvancedBuff.HandleReAnchorBuffGood(numIcons)
		else
			numIcons = table.getn(AdvancedBuff.TableOrderEvil)
			AdvancedBuff.ReverseOrderEvil[buffId] = numIcons
			AdvancedBuff.HandleReAnchorBuffEvil(numIcons)
		end
		 
		BuffDebuff.BuffWindowId[buffId] = true
		BuffDebuff.UpdateStatus(buffId)
	else
		BuffDebuff.UpdateStatus(buffId)
	end
	
	if(buffData.HasTimer == true) then
		BuffDebuff.Timers[buffId] = buffData.TimerSeconds
		if buffId == 1069 or buffId == 1101 then
			HotbarSystem.BandageDelayTime = tonumber(BuffDebuff.Timers[buffId])
		end
	end
	BuffDebuff.UpdateTimer()
end

function BuffDebuff.ResizeOuterWindow(windowName, numIcons)
	local numRows = math.ceil(numIcons / (BuffDebuff.MaxLength))
	local width = BuffDebuff.IconSize * BuffDebuff.MaxLength
	if(numIcons < BuffDebuff.MaxLength ) then
		width = BuffDebuff.IconSize * numIcons
	end
	
	local height = BuffDebuff.IconSize * (numRows)
	
	if( numIcons > 0) then
		WindowSetDimensions(windowName, width, height)
	else
		WindowSetDimensions(windowName, 0 , 0)
	end
end

function BuffDebuff.MouseOver()
	local buffId = WindowGetId(SystemData.ActiveWindow.name)
	local data = BuffDebuff.BuffData[buffId]
	if( data ) then
		local nameString = L""
		for i = 1, data.NameVectorSize do
			nameString = nameString..data.NameWStringVector[i]
		end
		
		local tooltipString = L""
		for i = 1, data.ToolTipVectorSize do
			tooltipString = tooltipString..data.ToolTipWStringVector[i]
		end	

		
		local bodyText = WindowUtils.translateMarkup(tooltipString)
		
		if(data.HasTimer == true and BuffDebuff.Timers[buffId] > 0) then
			local timeText = ReplaceTokens(GetStringFromTid(BuffDebuff.TID.timeleft), { towstring(tostring(BuffDebuff.Timers[buffId])) }) 
			bodyText = bodyText..L"\n"..timeText
		end
		
		local itemData = { windowName = "BuffDebuffIcon"..buffId,
							itemId = buffId,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	WindowUtils.translateMarkup(nameString),
							body = bodyText	 }
							
		ItemProperties.SetActiveItem(itemData)	
			
		--Debug.Print("BuffDebuff UpdateStatus labelName = "..WStringToString( WindowUtils.translateMarkup(nameString)))
		--Debug.Print("BuffDebuff UpdateStatus tooltipName = "..WStringToString( WindowUtils.translateMarkup(tooltipString)) )
	end
end

function BuffDebuff.Shutdown()
	UnregisterWindowData(WindowData.BuffDebuff.Type, 0)
	
	UOUnloadCSVTable("BuffDataCSV")
end

function BuffDebuff.UpdateStatus(iconId)
	local buffId = iconId
	
	local parent = "BuffDebuffIcon"..buffId
	local iconTextureName = parent.."TextureIcon"
	
	--Debug.Print("BuffDebuff buffId = "..buffId)
	local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
	local textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
	if( textureId ~= nil or textureId ~= -1) then
		--Debug.Print("BuffDebuff UpdateStatus textureId = "..textureId)
		local texture, x, y = GetIconData( textureId )
		DynamicImageSetTexture( iconTextureName, texture, x, y )
	end	
end

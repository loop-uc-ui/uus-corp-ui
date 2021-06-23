
TextParsing = {}

TextParsing.OverHeadError = { r=255, g=0, b=0 }
TextParsing.SpecialColor = { r=64, g=164, b=254 }

TextParsing.PHYSICAL = { r=168, g=168, b=168 }
TextParsing.FIRE = { r=245, g=155, b=33 }
TextParsing.COLD = { r=28, g=111, b=234 }
TextParsing.POISON = { r=63, g=199, b=73 }
TextParsing.ENERGY = { r=192, g=69, b=192 }
TextParsing.Chaos = { r=251, g=30, b=251 }

TextParsing.Heal = { r=255, g=215, b=0 }
TextParsing.Curse = { r=162, g=153, b=185 }
TextParsing.Paralyze = { r=194, g=67, b=99 }
TextParsing.Neutral = { r=255, g=255, b=255 }

TextParsing.Green = { r=16, g=184, b=0 }

TextParsing.SpecialColorsString ={
[L"*evades*"] = true,
[L"You recover from the shock."] = true,
}

TextParsing.SpecialColors ={
[501770] = true, -- "You swallow the fish whole!"
[501891] = true, -- "You extract the message from the bottle."
[501240] = true, -- "You have hidden yourself well."
[1005534] = true, -- "* The poison seems to have no effect. *"
[1061914] = true, -- "* You push the strange green thorn into the ground *"
[1061905] = true, -- "* You eat the orange petal.  You feel more resilient! *"
[1061904] = true, -- "* You already feel resilient! You decide to save the petal for later *"
[1080057] = true, -- "* The creature has been beaten into subjugation! *"
[1114441] = true, -- "* You feel yourself resisting the effects of the poison *"
[1010597] = true, -- "*You start to tame the creature.*"
[1010598] = true, -- "*begins taming a creature.*"
[502060] = true, -- "Your pet looks happier."
[502799] = true, -- "It seems to accept you as master."
[1071958] = true, -- * ~1_VAL~ seems resistant to the poison *
[1061915] = true, -- * ~1_PLAYER_NAME~ pushes a strange green thorn into the ground. *
[1080021] = true, -- Bank container has ~1_VAL~ items, ~2_VAL~ stones
}

TextParsing.Specials ={
[501029] = TextParsing.Neutral, -- "Select Marked item."
[1113405] = TextParsing.Green, -- "Your gem is now active. You may enter the Experimental Room"
[1113402] = TextParsing.Green, -- "The next room has been unlocked! Hurry through the door before your gem's state changes again!"
[1113383] = TextParsing.Green, -- "You finish assembling your key and may now unlock the third puzzle."
[1113382] = TextParsing.Green, -- "You've solved the puzzle!! An item has been placed in your bag."
[1054054] = TextParsing.Green, -- You have completed your study of this Solen Egg Nest. You put your notes away.
[1054057] = TextParsing.Green, -- You complete your examination of this bizarre Egg Nest. The Naturalist will undoubtedly be quite interested in these notes!
[1113403] = TextParsing.Green, -- Congratulations!! The last room has been unlocked!! Hurry through to claim your reward! 
[1113579] = TextParsing.Green, -- Correct Code Entered. Crystal Lock Disengaged. 
}

TextParsing.OverHeadErrorsString ={
[L"* The sound of gas escaping is heard from the chest. *"] = true,
[L"An arrow imbeds itself in your flesh!"] = true,
}

TextParsing.OverHeadErrors ={
[502630] = "fizzle", -- "More reagents are needed for this spell."
[502632] = "fizzle", -- "The spell fizzles."
[500852] = true, -- "You stepped onto a spike trap!"
[500853] = true, -- "You stepped onto a blade trap!"
[500855] = true, -- "You are enveloped by a noxious gas cloud!"
[500854] = true, -- "You take damage from an exploding mushroom!"
[1010571] = true, -- "OUCH!"
[1008086] = true, -- "*rummages through a corpse and takes an item*"
[1010406] = true, -- "You cannot heal that target in their current state."
[1074165] = true, -- "You feel dizzy from a lack of clear air"
[1060757] = true, -- "You are bleeding profusely"
[1060758] = true, --  ~1_NAME~ is bleeding profusely
[1061121] = true, -- "Your equipment is severely damaged."
[500235] = true, -- "You must wait a few seconds before using another healing potion."
[1019048] = true, -- "I am dead and cannot do that."
[1076539] = true, -- "*looks confused*"
[502358] = true, -- "I cannot recall from that object."
[1078843] = true, -- "I cannot recall from that object right now."
[1019045] = true, -- "I can't reach that."
[501944] = true, -- "That location is blocked."
[1042873] = true, -- "You have been revealed!"
[501237] = true, -- "You can't seem to hide right now."
[502625] = true, -- "Insufficient mana for this spell."
[1112767] = true, -- "Medusa releases one of the petrified creatures!!"
[1010410] = true, -- "This is already locked down."
[503172] = true, -- "The fish don't seem to be biting here."
[503173] = true, -- "The fish don't seem to be biting here."
[500612] = true, -- "You play poorly, and there is no effect."
[1113587] = true, -- "* The creature goes into a frenzied rage! *"
[502998] = true, -- "A dart imbeds itself in your flesh!"
[500263] = true, -- "*Splashing acid blood scars your weapon!*"
[1114443] = true, -- "* Your body convulses from electric shock *"
[1010523] = true, -- "A toxic vapor envelops thee."
[1010525] = true, -- "Pain lances through thee from a sharp metal blade."
[1010526] = true, -- "Lightning arcs through thy body."
[1010524] = true, -- "Searing heat scorches thy skin."
[1040024] = true, -- "You are still too dazed from being knocked off your mount to ride."
[1112457] = true, -- "You are still too dazed to fly."
[1080060] = true, -- "* The solen's damaged acid sac squirts acid! *"
[1115755] = true, -- "The creature looks at you strangely and shakes its head no."
[502800] = true, -- "You can't see that."
[502801] = true, -- "You can't tame that!"
[1049655] = true, -- "That creature cannot be tamed."
[502803] = true, -- "It's too far away."
[502804] = true, -- "That animal looks tame already."
[1049650] = true, -- "Someone else is already taming that creature."
[502805] = true, -- "You seem to anger the beast!"
[502806] = true, -- "You have no chance of taming this creature."
[1053091] = true, -- "* You feel the effects of your poison resistance wearing off *"
[1053093] = true, -- "* The strength of the poison overcomes your resistance! *"
[500384] = true, --  "Ah, art thou trying to fool me? Thou hast not so much gold!"
[1054046] = true, -- You abandon your study of the Solen Egg Nest without gathering the needed information.
[1113400] = true, -- "You fail to neutralize the gem in time and are expelled from the room!!"
[1080038] = true, -- The solen's acid sac is burst open!
[1043255] = true, -- ~1_NAME~ appears to have decided that it is better off without a master!
[1042857] = true, -- "*You feel a bit nauseous*"
[1042859] = true, -- "* You feel disoriented and nauseous! *"
[1042861] = true, -- "* You begin to feel pain throughout your body! *"
[1042863] = true, -- "* You feel extremely weak and are in severe pain! *"
[1042865] = true, -- "* You are in extreme pain, and require immediate aid! *"
}

TextParsing.PoisonMessages ={
[1042858] = true, -- *~1_PLAYER_NAME~ looks ill.*
[1042860] = true, -- * ~1_PLAYER_NAME~ looks extremely ill. *
[1042867] = true, -- * ~1_PLAYER_NAME~ looks extremely ill. *
[1042862] = true, -- * ~1_PLAYER_NAME~ stumbles around in confusion and pain. *
[1042868] = true, -- * ~1_PLAYER_NAME~ stumbles around in confusion and pain. *
[1042864] = true, -- * ~1_PLAYER_NAME~ is wracked with extreme pain. *
[1042869] = true, -- * ~1_PLAYER_NAME~ is wracked with extreme pain. *
[1042866] = true, -- * ~1_PLAYER_NAME~ begins to spasm uncontrollably. *
[1042870] = true, -- * ~1_PLAYER_NAME~ begins to spasm uncontrollably. *
}

TextParsing.TauntsTable = {
[L"[*]ah[*]"] = 			{[0] =1049, [1] =778 };
[L"[*]ahha[*]"] = 			{[0] =1050, [1] =779 };
[L"[*]applaud[*]"] = 		{[0] =1051, [1] =780 };
[L"[*]blow nose[*]"] = 		{[0] =1052, [1] =781 };
[L"[*]burp[*]"] = 			{[0] =1053, [1] =782 };
[L"[*]cheer[*]"] = 			{[0] =1054, [1] =783 };
[L"[*]clear throat*"] = 	{[0] =1055, [1] =784 };
[L"[*]cough[*]"] = 			{[0] =1056, [1] =785 };
[L"[*]cough laugh*"] =		{[0] =1057, [1] =786 };
[L"[*]cry[*]"] = 			{[0] =1058, [1] =787 };
[L"[*]fart[*]"] = 			{[0] =1064, [1] =792 };
[L"[*]gasp[*]"] = 			{[0] =1065, [1] =793 };
[L"[*]giggle[*]"] = 		{[0] =1066, [1] =794 };
[L"[*]growl[*]"] = 			{[0] =1068, [1] =796 };
[L"[*]groan[*]"] = 			{[0] =1067, [1] =795 };
[L"[*]hey[*]"] = 			{[0] =1069, [1] =797 };
[L"[*]hic[*]"] = 			{[0] =1070, [1] =798 };
[L"[*]huh[*]"] = 			{[0] =1071, [1] =799 };
[L"[*]kiss[*]"] = 			{[0] =1072, [1] =800 };
[L"[*]laugh[*]"] = 			{[0] =1073, [1] =801 };
[L"[*]no[*]"] = 			{[0] =1074, [1] =802 };
[L"[*]oh[*]"] = 			{[0] =1075, [1] =803 };
[L"[*]oooh[*]"] = 			{[0] =1085, [1] =811 };
[L"[*]oops[*]"] = 			{[0] =1086, [1] =812 };
[L"[*]puke[*]"] = 			{[0] =1087, [1] =813 };
[L"[*]scream[*]"] = 		{[0] =1088, [1] =814 };
[L"[*]shh[*]"] = 			{[0] =1089, [1] =815 };
[L"[*]shush[*]"] = 			{[0] =1089, [1] =815 };
[L"[*]sigh[*]"] = 			{[0] =1090, [1] =816 };
[L"[*]sniff[*]"] = 			{[0] =1092, [1] =818 };
[L"[*]sneeze[*]"] = 		{[0] =1091, [1] =817 };
[L"[*]snore[*]"] = 			{[0] =1093, [1] =819 };
[L"[*]spit[*]"] = 			{[0] =1094, [1] =820 };
[L"[*]whistle[*]"] = 		{[0] =1095, [1] =821 };
[L"[*]yawn[*]"] = 			{[0] =1096, [1] =822 };
[L"[*]yeah[*]"] = 			{[0] =1097, [1] =823 };
[L"[*]yell[*]"] = 			{[0] =1098, [1] =824 };
} 

TextParsing.Fame = {
[1019051] = true;
[1019052] = true;
[1019053] = true;
[1019054] = true;
[1019055] = true;
[1019056] = true;
[1019057] = true;
[1019058] = true;
}

TextParsing.Karma = {
[1019059] = true;
[1019060] = true;
[1019061] = true;
[1019062] = true;
[1019063] = true;
[1019064] = true;
[1019065] = true;
[1019066] = true;
}

function TextParsing.Emotize(string)
	return L"* " .. string .. L" *"
end

function TextParsing.ColorizeText()
	local senderText = SystemData.Text
	local emotized = false
	local channel = SystemData.TextChannelID

	local default = ChatSettings.ChannelColors[SystemData.TextChannelID]
	local color = {r= default.r, g=default.g, b=default.b}
	
	local find = wstring.find
	
	if wstring.len(SystemData.Text) > 1 then
		if (find(wstring.sub(SystemData.Text, 1, 2), L'*') and find(wstring.sub(SystemData.Text, -1), L'*')) then
			channel = SystemData.ChatLogFilters.EMOTE
			emotized = true
			color = ChatSettings.ChannelColors[ SystemData.ChatLogFilters.EMOTE ]
		end
	end

	if not ChatSettings then
		return
	end
	
	if (SystemData.TextColor ~= 0 and not emotized) then
		color = SystemData.TextColor
	end

	if SpellsInfo.SpellsData[tostring(senderText)] then
		return SpellsInfo.SpellsData[tostring(senderText)].color, channel
	end
			 
	if (SystemData.TextChannelID == 16) then
		SystemData.SourceName = GetStringFromTid(3000610)
		color.r,color.g,color.b = HueRGBAValue(1195)
		return color, channel
	end
		
	if (SystemData.TextID == 1113587) then -- The creature goes into a frenzied rage!
		senderText = TextParsing.Emotize(senderText)
	end
		
	if TextParsing.OverHeadErrors[senderText] or TextParsing.OverHeadErrors[SystemData.TextID] or TextParsing.PoisonMessages[SystemData.TextID] then
		if (TextParsing.OverHeadErrors[SystemData.TextID] == "fizzle") then
			Interface.CurrentSpell.CheckFizzle = true
		end
		return TextParsing.OverHeadError, channel
	end
	
	if TextParsing.SpecialColorsString[senderText] or TextParsing.SpecialColors[SystemData.TextID] then
		return TextParsing.SpecialColor, channel
	end
	
	if TextParsing.Specials[SystemData.TextID] then
		return special, channel
	end
	
	if (find(senderText , L"You are attacking ") or find(senderText , L" is attacking you!") ) then
		return TextParsing.OverHeadError, channel
	end
	
	if ( find(senderText , L"Thy current bank balance is:") ) then
		return TextParsing.SpecialColor, channel
	end
	
	if ( find(senderText , L"Into your bank box I have placed a check in the amount of:")
		or SystemData.TextID == 1112821 -- I need to add some ~1_INGREDIENT~.
		) then
		
		return TextParsing.POISON, channel
	end
	
	return color, channel
end

function TextParsing.TimersNbuff()

	if(SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then		
		if ( SystemData.TextID == 1070839 ) then -- "The creature attacks with stunning force!"
			HotbarSystem.StunTime = 4
			return
		end	
	
		if ( SystemData.TextID == 1062074 ) then --"Anh Mi Sah Ko"
			HotbarSystem.SkillDelayTimeMax = 5
			HotbarSystem.SkillDelayTime = 5
			return
		end
		
		if ( SystemData.TextID == 500397 ) then --"To whom do you wish to grovel?"
			HotbarSystem.SkillDelayTimeMax = 11
			HotbarSystem.SkillDelayTime = 11
			return
		end
		
		if ( SystemData.TextID == 500612 ) then -- "You play poorly, and there is no effect."
			HotbarSystem.SkillDelayTimeMax = 6
			HotbarSystem.SkillDelayTime = 6
			return
		end
		
		if ( SystemData.TextID == 1010597 ) then --  "*You start to tame the creature.*" 
			HotbarSystem.SkillDelayTimeMax = 11
			HotbarSystem.SkillDelayTime = 11
			return
		end	
		
		
		if ( SystemData.TextID == 501240 ) then --  "You have hidden yourself well."
			HotbarSystem.SkillDelayTimeMax = 11
			HotbarSystem.SkillDelayTime = 11
			return
		end
		
		if ( SystemData.TextID == 501241 ) then -- "You fail to hide."
			HotbarSystem.SkillDelayRestarted = true
			HotbarSystem.SkillDelayTime = 11
			return
		end
		return
	end

	if(SystemData.TextID == 1151949)then --"You have changed to ~1_val~"
		local masteryToks = SystemData.TextIDToks
		local numMasteryToks = table.getn(masteryToks)
		
		for i=1,numMasteryToks do
			local tok = masteryToks[i]
			Spellbook.UpdateMasteryBook = tok			
		end		
		return
	end
	
	if(SystemData.TextID == 1074846) then -- "A tasty bite of the enchanted apple lifts all curses from your soul."
		HotbarSystem.AppleDelayTime = 30
	end	

	if ( (SystemData.TextID == 500618 or SystemData.TextID ==  500877)  and TextParsing.InstrumentCheck ) then -- "That is too far away!", "That is not a musical instrument."
		HotbarSystem.SkillDelayTime = 9
		TextParsing.InstrumentCheck = false
		HotbarSystem.SkillDelayTimeMax = 9		
	end	
	
	if (TextParsing.InstrumentCheck) then
		TextParsing.InstrumentCheck = false
	end
	
	if ( SystemData.TextID == 500617 ) then -- "What instrument shall you play?"
		TextParsing.InstrumentCheck = true
	end
	
	if ( SystemData.TextID ==  1115884 ) then -- "You started Honorable Combat!"
		local mobileId = Interface.CurrentHonor
		if mobileId == 0 then
			mobileId = WindowData.Cursor.lastTarget
		end
		Interface.HonorMobileConfirm(mobileId)
		return
	end

	if ( SystemData.TextID == 502730 ) then --  "You begin to move quietly."
		if (HotbarSystem.SkillDelayTime > 5) then
			HotbarSystem.SkillDelayTimeMax = 5
			HotbarSystem.SkillDelayTime = 5
		end
		return
	end

	if ( SystemData.TextID == 501596) then -- "You play rather poorly, and to no effect."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		return
	end

	if ( SystemData.TextID == 1011350 ) then -- "What do you wish to track?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end
	
	if ( SystemData.TextID == 502989  ) then -- "Tracking failed."
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end	
	
	
	if ( SystemData.TextID == 502368 ) then -- "Which trap will you attempt to disarm?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end
	
	if ( SystemData.TextID == 500819 ) then -- "Where will you search?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end
	
	if ( SystemData.TextID == 502698 ) then -- "Which item will you attempt to steal?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end
	
	if ( SystemData.TextID == 1005584 ) then -- "Both hands must be free to steal."
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end	
	
	if ( SystemData.TextID == 1049532 ) then -- "You play hypnotic music, calming your target."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
		return
	end
	
	if ( SystemData.TextID == 500615 ) then -- "You play your hypnotic music, stopping the battle."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
		return
	end
	
	if ( SystemData.TextID == 1049648 ) then -- "You play hypnotic music, but there is nothing in range for you to calm."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
		return
	end
	
	if ( SystemData.TextID == 1049531  ) then -- "You attempt to calm your target, but fail."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
		return
	end
	
	if ( SystemData.TextID == 501602 ) then -- "Your music succeeds, as you start a fight."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
		return
	end
	
	if ( SystemData.TextID == 501599 ) then -- "Your music fails to incite enough anger."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
		return
	end
	
	if ( SystemData.TextID == 1049539 ) then -- "You play jarring music, suppressing your target's strength."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
		return
	end
	
	-- "You are at peace." "You cannot focus your concentration." "You are busy doing something else and cannot focus." "You enter a meditative trance."
	if (SystemData.TextID == 501846  or SystemData.TextID == 501848 or SystemData.TextID == 501845 or SystemData.TextID == 501851) then
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end
	
	if ( SystemData.TextID == 502137 ) then -- "Select the poison you wish to use."
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
		return
	end
	
	if ( SystemData.TextID == 1049540 ) then -- "You attempt to disrupt your target, but fail."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
		return
	end
		
	if ( SystemData.TextID == 1063235 ) then -- "You embrace your honor"
		TextParsing.HonorActive = true
		return
	end
	
	if ( SystemData.TextID == 1063236 ) then -- "You no longer embrace your honor"
		TextParsing.HonorActive = false
		return
	end
	
	-- SPECIAL ATTACKS
	-- DEAL

	if  SystemData.SourceName == L"" and (
		SystemData.TextID == 1060076  or -- Your attack penetrates their armor!  
		SystemData.TextID == 1060078  or -- You strike and hide in the shadows!
		SystemData.TextID == 1060080  or -- Your precise strike has increased the level of the poison by 1
		SystemData.TextID == 1060082  or -- The force of your attack has dislodged them from their mount!
		SystemData.TextID == 1060086  or -- You deliver a mortal wound!
		SystemData.TextID == 1060090  or -- You have delivered a crushing blow!
		SystemData.TextID == 1060092  or -- You disarm their weapon!
		SystemData.TextID == 1060159  or -- Your target is bleeding!
		SystemData.TextID == 1060161  or -- The whirling attack strikes a target!
		SystemData.TextID == 1060163  or -- You deliver a paralyzing blow!
		SystemData.TextID == 1060165  or -- You have delivered a concussion!
		SystemData.TextID == 1060216  or -- Your shot was successful
		SystemData.TextID == 1063345  or -- You block an attack!
		SystemData.TextID == 1063356  or -- You cripple your target with a nerve strike!
		SystemData.TextID == 1063353  or -- You perform a masterful defense!
		SystemData.TextID == 1063360  or -- You baffle your target with a feint!
		SystemData.TextID == 1063362  or -- You dually wield for increased speed!
		SystemData.TextID == 1063358  or -- You deliver a talon strike!
		SystemData.TextID == 1063348  or -- You launch two shots at once!
		SystemData.TextID == 1063350  or -- You pierce your opponent's armor!
		SystemData.TextID == 1074381  or -- You fire an arrow of pure force.
		SystemData.TextID == 1074374  or -- You attack your enemy with the force of nature!
		SystemData.TextID == 1074383  or -- Your shot sends forth a wave of psychic energy.
		SystemData.TextID == 1149563  or -- The infused projectile strikes a target!
		SystemData.TextID == 1149565  or -- The mystic arc strikes the target!
	    SystemData.TextID == 1060084  -- You attack with lightning speed!
		
		) then 
	
		local _, _, tid, _ = GetAbilityData(Interface.LastSpecialMove + CharacterAbilities.WEAPONABILITY_OFFSET)

		if(tid ~= nil or tid ~= 0)then			
			DamageWindow.waitSpecialDamage = GetStringFromTid(tid).. L"!"
			DamageWindow.lastSpecialWaiting = Interface.LastSpecialMove
		end
	end
	
	-- RECEIVED
	if  (SystemData.SourceName == L"" and AbilitiesInfo.MessageToID[SystemData.TextID] ) then 
		
		local _, _, tid, _ = GetAbilityData(AbilitiesInfo.MessageToID[SystemData.TextID] + CharacterAbilities.WEAPONABILITY_OFFSET)
		DamageWindow.waitDamage =tid .. L"!"
		Interface.OnSpecialMoveDamageReceived(Interface.LastSpecialMove)
	end
	
end

function TextParsing.SpellCasting()
	if ( SystemData.TextID == 1063218 ) then -- "You cannot use that ability in this form."
		Interface.CurrentSpell.CheckFizzle = true
		return
	end
	
	if ( SystemData.TextID == 501078 ) then -- "You must be holding a weapon."
		Interface.CurrentSpell.CheckFizzle = true
		return
	end

	
	if ( SystemData.TextID ==  1150066 ) then -- "Your magic reflection pool has been depleted."
		HotbarSystem.ReflectionCooldown = 30
		return
	end

end



function TextParsing.SpecialTexts()
	local senderText = SystemData.Text
	local find = wstring.find
	
	if ( SystemData.TextID ==  1151281) then -- "Your Clean Up Britannia point total is now ~1_VALUE~!"
		local clean =  wstring.gsub(GetStringFromTid(1151281),L"~1_VALUE~!", L"")
		local num = wstring.gsub(senderText, clean, "")
		num = wstring.gsub(num, "!", "")
		num = WindowUtils.AddCommasToNumber(num)
		SystemData.Text = wstring.gsub(GetStringFromTid(1151281),L"~1_VALUE~", num)
		SystemData.TextColor = {r=16,g=184, b=0}
	end
	
	-- CHARYBDIS
	if ( SystemData.TextID ==  1150191) then -- "The location you seek is:"
		clean =  wstring.gsub(GetStringFromTid(1150191),L" ~1_val~", L"")  -- The location you seek is: ~1_val~
		local coord = wstring.gsub(senderText, clean, "")
		coord = StringToWString(coord)
		local text2 = wstring.find(coord, L"[,]")
		local first = wstring.sub(coord, 1, text2 - 1)
		first = wstring.gsub(first, L"o ", L".")
		first = wstring.gsub(first, L"'", L"")
						

		local latDir = wstring.sub(first, -1)
		local latVal = wstring.sub(first,1, -2)
			
		local second = wstring.sub(coord, text2 + 3)
		second = wstring.gsub(second, L"o ", L".")
		second = wstring.gsub(second, L"'", L"")
		local longDir = wstring.sub(second, -1)
		local longVal = wstring.sub(second,1, -2)
		local x,y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, 1, 1)
		UOCreateUserWaypoint( MapCommon.WaypointCustomType, x, y, WindowData.PlayerLocation.facet, L"Charybdis" .. L"_ICON_100010_SCALE_" .. 0.69 )
	end
	
	if ( SystemData.TextID == 1077957 ) then -- "The intense energy dissipates. You are no longer under the effects of an accelerated skillgain scroll."
		Interface.AlacrityStart = 0
		Interface.SaveNumber( "AlacrityStart", Interface.AlacrityStart )
	end
	if ( SystemData.TextID == 1077956 ) then -- "You are infused with intense energy. You are under the effects of an accelerated skillgain scroll."
		if (Interface.AlacrityStart <= 0) then
			Interface.AlacrityStart = 900
			Interface.SaveNumber( "AlacrityStart", Interface.AlacrityStart )
		end
	end
	
	
	if ( SystemData.TextID == 1073480 ) then -- "Your arcane focus disappears."
		Interface.ArcaneFocusLevel = 0
	end
		
	if ( SystemData.TextID == 501864 ) then -- "You can't dig while riding or flying."
		UserActionUseItem(WindowData.PlayerStatus.PlayerId ,false)
	end
	
	if ( SystemData.TextID ==  500971 ) then -- "You can't fish while riding or flying!"
		Interface.Dismount = true
	end

	if ( find(senderText, L"I was killed by") and SystemData.TextChannelID == 9 ) then
		if ( wstring.gsub(senderText, L"I was killed by  ", L"") == L"!!" ) then
			SystemData.Text = L"I killed myself !!"
		end
	end
	
	
	if ( SystemData.TextID == 1043255 ) then -- "is better off without a master"
		MobilesOnScreen.ReversePet[SystemData.TextSourceID] = nil
		MobileHealthBar.CloseWindowByMobileId(SystemData.TextSourceID)		
		MobilesOnScreen.isDirty = true
	end
	
	if (find(senderText , L"Thy current bank balance is:")) then
		local cut = WindowUtils.AddCommasToNumber(wstring.sub(SystemData.Text, 29))
		SystemData.Text = wstring.sub(SystemData.Text, 0,29) .. cut
	end
	

	if ( find(senderText , L"Into your bank box I have placed a check in the amount of:")) then
		local cut = WindowUtils.AddCommasToNumber(wstring.sub(SystemData.Text,59))
		SystemData.Text = wstring.sub(SystemData.Text, 0,59) .. cut
	end
	
	if (wstring.lower(senderText) == L"give arties" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		Interface.ArteReceived = 1
		Interface.SaveNumber( "ArteReceived" , Interface.ArteReceived )
	end
	
	if (wstring.lower(senderText) == L"give resources" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		Interface.ResReceived = 1
		Interface.SaveNumber( "ResReceived" , Interface.ResReceived )
	end
	
	if (wstring.lower(senderText) == L"give air" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		Interface.AirReceived = 1
		Interface.SaveNumber( "AirReceived" , Interface.AirReceived )
	end
	
	if (wstring.lower(senderText) == L"give seeds" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		Interface.SeedsReceived = 1
		Interface.SaveNumber( "SeedsReceived" , Interface.SeedsReceived )
	end
	
	if (wstring.lower(senderText) == L"give tokens" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		Interface.TokensReceived = 1
		Interface.SaveNumber( "TokensReceived" , Interface.TokensReceived )
	end

end
function TextParsing.IgnoreTextManager()

	local ign = false
	if (NewChatWindow and not NewChatWindow.ShowSpellsCasting) then
		if (SystemData.TextID == 502645) then -- You are already casting a spell.
			ign = true
		end 
		if (SystemData.TextID == 502644) then -- You have not yet recovered from casting a spell.
			ign = true
		end
	end
	if (NewChatWindow and not NewChatWindow.ShowPerfection) then
		if (SystemData.TextID == 1063255) then -- You gain in Perfection as you precisely strike your opponent.
			ign = true
		end 
		if (SystemData.TextID == 1063257) then -- You have lost some Perfection in fighting this opponent.
			ign = true
		end
	end
	if (NewChatWindow and not NewChatWindow.ShowMultiple and Interface.LastJournalMSG == SystemData.Text) then
		ign = true
	else
		Interface.LastJournalMSG = SystemData.Text
	end
	if (NewChatWindow and not NewChatWindow.ShowSpells and IsSpell) then
		ign = true
	end
	return ign
end

function TextParsing.ForceOverhead()

	if ( SystemData.TextID == 1062001 ) then -- "You can no longer wield your ~1_WEAPON~"
		WindowUtils.SendOverheadText(SystemData.Text, 33, false)
	end

	if ( SystemData.TextID == 1062002 ) then -- "You can no longer wear your ~1_ARMOR~"
		WindowUtils.SendOverheadText(SystemData.Text, 33, false)
	end

	if ( SystemData.TextID == 1062003 ) then -- "You can no longer equip your ~1_SHIELD~"
		WindowUtils.SendOverheadText(SystemData.Text, 33, false)
	end
	
	if ( SystemData.TextID == 1075051 ) then
		local num = tonumber(string.sub(senderText, 34, -11))
		WindowUtils.SendOverheadText(ReplaceTokens(GetStringFromTid(1155217), {towstring(num)}), 1270, true)
	end
	
	if ( SystemData.TextID ==  1151481 ) then -- "Channeling the corrupted mana has damaged you!"
		WindowUtils.SendOverheadText( GetStringFromTid(1151481), 33, true)
	end
	
	if ( SystemData.TextID ==  1116778 ) then -- "The tainted life force energy damages you as your body tries to absorb it."
		WindowUtils.SendOverheadText( GetStringFromTid(1116778), 33, true)
	end
	
	if ( SystemData.TextID ==  503170 ) then -- "Uh oh! That doesn't look like a fish!" 
		WindowUtils.SendOverheadText( GetStringFromTid(503170), 33, true)
		local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId)
		local sid = 1065
		if (mobileData.Gender == 1) then
			sid = 793
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
	end
	
	if ( SystemData.TextID ==  1153493 ) then -- "Your keen senses detect something hidden in the area..."
		local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId)
		local sid = 1071
		if (mobileData.Gender == 1) then
			sid = 799
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
	end
	
	if ( SystemData.TextID ==  1149918 ) then -- You have uncovered a ~1_SIZE~ deposit of niter! Mine it to obtain saltpeter.
		WindowUtils.SendOverheadText(SystemData.Text, 33, true)
	end
end

function TextParsing.Taunts()
	if ( SystemData.TextID == 1060093 ) then -- "Your weapon has been disarmed!"
		PlaySound(1, 323, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
	end
	
    -- EMOTES
	local wfind = wstring.find
	if ( SystemData.SourceName ~= L"" and SystemData.TextSourceID ~= 0 ) then
		local mobileData = Interface.GetMobileData(SystemData.TextSourceID)
		if not mobileData then
			return
		end
		local sid

		for taunt, tbl in pairs(TextParsing.TauntsTable) do
			local text = wfind(wstring.lower(SystemData.Text) , taunt) 
			if ( text ~= nil ) then
				
				sid = tbl[mobileData.Gender] 
			end
		end
		if sid then
			PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		end
	end
end
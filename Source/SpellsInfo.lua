
SpellsInfo = {}

SpellsInfo.PHYSICAL = { r=168, g=168, b=168 }
SpellsInfo.FIRE = { r=245, g=155, b=33 }
SpellsInfo.COLD = { r=28, g=111, b=234 }
SpellsInfo.POISON = { r=63, g=199, b=73 }
SpellsInfo.ENERGY = { r=192, g=69, b=192 }
SpellsInfo.Chaos = { r=251, g=30, b=251 }

function SpellsInfo.Initialize()
	SpellsInfo.SpellsData = {
	["Uus Jux"] = { id=1, name="Clumsy", color=TextParsing.Curse, distance=10 };
	["In Mani Ylem"] = { id=2, name="Create Food", color=TextParsing.Neutral, notarget=true };
	["Rel Wis"] = { id=3, name="Feeblemind", color=TextParsing.Curse, distance=10 };
	["In Mani"] = { id=4, name="Heal", color=TextParsing.Heal, distance=10 };
	["In Por Ylem"] = { id=5, name="Magic Arrow", color=SpellsInfo.FIRE, distance=10 };
	["In Lor"] = { id=6, name="Night Sight", color=TextParsing.Neutral, distance=10 };
	["Flam Sanct"] = { id=7, name="Reactive Armor", color=TextParsing.Neutral, notarget=true };
	["Des Mani"] = { id=8, name="Weaken", color=TextParsing.Curse, distance=10 };

	["Ex Uus"] = { id=9, name="Agility", color=TextParsing.Heal, distance=10 };
	["Uus Wis"] = { id=10, name="Cunning", color=TextParsing.Heal, distance=10 };
	["An Nox"] = { id=11, name="Cure", color=TextParsing.Heal, distance=10 };
	["An Mani"] = { id=12, name="Harm", color=SpellsInfo.COLD, distance=10 };
	["In Jux"] = { id=13, name="Magic Trap", color=TextParsing.Neutral, cursorOnly=true };
	["An Jux"] = { id=14, name="Magic Untrap", color=TextParsing.Neutral, distance=10, cursorOnly=true  };
	["Uus Sanct"] = { id=15, name="Protection", color=TextParsing.Neutral, notarget=true  };
	["Uus Mani"] = { id=16, name="Strength", color=TextParsing.Heal, distance=10 };

	["Rel Sanct"] = { id=17, name="Bless", color=TextParsing.Heal, distance=10 };
	["Vas Flam"] = { id=18, name="Fireball", color=SpellsInfo.FIRE, distance=10 };
	["An Por"] = { id=19, name="Magic Lock", color=TextParsing.Neutral, distance=15 };
	["In Nox"] = { id=20, name="Poison", color=SpellsInfo.POISON, distance=10 };
	["Ort Por Ylem"] = { id=21, name="Telekinesis", color=TextParsing.Neutral, distance=15 };
	["Rel Por"] = { id=22, name="Teleport", color=TextParsing.Neutral, cursorOnly=true };
	["Ex Por"] = { id=23, name="Unlock", color=TextParsing.Neutral, distance=15 };
	["In Sanct Ylem"] = { id=24, name="Wall of Stone", color=TextParsing.Neutral, distance=22 };

	["Vas An Nox"] = { id=25, name="Arch Cure", color=TextParsing.Heal };
	["Vas Uus Sanct"] = { id=26, name="Arch Protection", color=TextParsing.Neutral, distance=6 };
	["Des Sanct"] = { id=27, name="Curse", color=TextParsing.Curse, distance=12 };
	["In Flam Grav"] = { id=28, name="Fire Field", color=SpellsInfo.FIRE, distance=22 };
	["In Vas Mani"] = { id=29, name="Greater Heal", color=TextParsing.Heal, distance=12 };
	["Por Ort Grav"] = { id=30, name="Lightning", color=SpellsInfo.ENERGY, distance=12 };
	["Ort Rel"] = { id=31, name="Mana Drain", color=TextParsing.Curse, distance=12 };
	["Kal Ort Por"] = { id=32, name="Recall", color=TextParsing.Neutral, noSelf=true };

	["In Jux Hur Ylem"] = { id=33, name="Blade Spirits", color=TextParsing.Neutral, cursorOnly=true };
	["An Grav"] = { id=34, name="Dispel Field", color=TextParsing.Neutral, distance=13, noSelf=true };
	["Kal In Ex"] = { id=35, name="Incognito", color=TextParsing.Neutral, notarget=true };
	["In Jux Sanct"] = { id=36, name="Magic Reflection", color=TextParsing.Neutral, notarget=true };
	["Por Corp Wis"] = { id=37, name="Mind Blast", color=SpellsInfo.COLD, distance=12 };
	["An Ex Por"] = { id=38, name="Paralyze", color=TextParsing.Paralyze, distance=12 };
	["In Nox Grav"] = { id=39, name="Poison Field", color=SpellsInfo.POISON, distance=22 };
	["Kal Xen"] = { id=40, name="Summon Creature", color=TextParsing.Neutral, notarget=true };

	["An Ort"] = { id=41, name="Dispel", color=TextParsing.Neutral, distance=12, noSelf=true };
	["Corp Por"] = { id=42, name="Energy Bolt", color=SpellsInfo.ENERGY, distance=12 };
	["Vas Ort Flam"] = { id=43, name="Explosion", color=SpellsInfo.FIRE, distance=12 };
	["An Lor Xen"] = { id=44, name="Invisibility", color=TextParsing.Neutral, distance=12 };
	["Kal Por Ylem"] = { id=45, name="Mark", color=TextParsing.Neutral, noSelf=true };
	["Vas Des Sanct"] = { id=46, name="Mass Curse", color=TextParsing.Curse };
	["In Ex Grav"] = { id=47, name="Paralyze Field", color=TextParsing.Paralyze, distance=22 };
	["Wis Quas"] = { id=48, name="Reveal", color=TextParsing.Neutral, distance=22 };

	["Vas Ort Grav"] = { id=49, name="Chain Lightning", color=SpellsInfo.ENERGY, distance=10 };
	["In Sanct Grav"] = { id=50, name="Energy Field", color=SpellsInfo.ENERGY, distance=22 };
	["Kal Vas Flam"] = { id=51, name="Flamestrike", color=SpellsInfo.FIRE, distance=12 };
	["Vas Rel Por"] = { id=52, name="Gate Travel", color=TextParsing.Neutral, cursorOnly=true };
	["Ort Sanct"] = { id=53, name="Mana Vampire", color=TextParsing.Curse, distance=12 };
	["Vas An Ort"] = { id=54, name="Mass Dispel", color=TextParsing.Neutral, distance=22 };
	["Flam Kal Des Ylem"] = { id=55, name="Meteor Swarm", color=SpellsInfo.FIRE, distance=12 };
	["Vas Ylem Rel"] = { id=56, name="Polymorph", color=TextParsing.Neutral, notarget=true };

	["In Vas Por"] = { id=57, name="Earthquake", color=SpellsInfo.PHYSICAL, notarget=true };
	["Vas Corp Por"] = { id=58, name="Energy Vortex", color=TextParsing.Neutral, cursorOnly=true };
	["An Corp"] = { id=59, name="Resurrection", color=TextParsing.Heal, distance=1 };
	["Kal Vas Xen Hur"] = { id=60, name="Air Elemental", color=TextParsing.Neutral, notarget=true };
	["Kal Vas Xen Corp"] = { id=61, name="Summon Daemon", color=TextParsing.Neutral, notarget=true };
	["Kal Vas Xen Ylem"] = { id=62, name="Earth Elemental", color=TextParsing.Neutral, notarget=true };
	["Kal Vas Xen Flam"] = { id=63, name="Fire Elemental", color=TextParsing.Neutral, notarget=true };
	["Kal Vas Xen An Flam"] = { id=64, name="Water Elemental", color=TextParsing.Neutral, notarget=true  };

	["Uus Corp"] = { id=101, name="Animate Dead", color=TextParsing.Neutral , distance=11 };
	["In Jux Mani Xen"] = { id=102, name="Blood Oath", color=TextParsing.Curse, distance=12 };
	["In Aglo Corp Ylem"] = { id=103, name="Corpse Skin", color=TextParsing.Curse, distance=12 };
	["An Sanct Gra Char"] = { id=104, name="Curse Weapon", color=TextParsing.Neutral, notarget=true };
	["Pas Tym An Sanct"] = { id=105, name="Evil Omen", color=TextParsing.Curse, distance=12 };
	["Rel Xen Vas Bal"] = { id=106, name="Horrific Beast", color=TextParsing.Neutral, notarget=true };
	["Rel Xen Corp Ort"] = { id=107, name="Lich Form", color=TextParsing.Neutral, notarget=true };
	["Wis An Ben"] = { id=108, name="Mind Rot", color=TextParsing.Curse, distance=12 };
	["In Sar"] = { id=109, name="Pain Spike", color=SpellsInfo.ENERGY, distance=12 };
	["In Vas Nox"] = { id=110, name="Poison Strike", color=SpellsInfo.POISON, distance=12 };
	["In Bal Nox"] = { id=111, name="Strangle", color=SpellsInfo.POISON, distance=12 };
	["Kal Xen Bal"] = { id=112, name="Summon Familiar", color=TextParsing.Neutral, notarget=true };
	["Rel Xen An Sanct"] = { id=113, name="Vampiric Embrace", color=TextParsing.Neutral, notarget=true };
	["Kal Xen Bal Beh"] = { id=114, name="Vengeful Spirit", color=TextParsing.Neutral, distance=12, noSelf=true };
	["Kal Vas An Flam"] = { id=115, name="Wither", color=SpellsInfo.COLD, notarget=true };
	["Rel Xen Um"] = { id=116, name="Wraith Form", color=TextParsing.Neutral, notarget=true };
	["Ort Corp Grav"] = { id=117, name="Exorcism", color=TextParsing.Neutral, notarget=true };

	["Expor Flamus"] = { id=201, name="Cleanse by Fire", color=TextParsing.Heal, distance=18 };
	["Obsu Vulni"] = { id=202, name="Close Wounds", color=TextParsing.Heal, distance=2 };
	["Consecrus Arma"] = { id=203, name="Consecrate Weapon", color=TextParsing.Neutral, notarget=true };
	["Dispiro Malas"] = { id=204, name="Dispel Evil", color=TextParsing.Neutral, notarget=true };
	["Divinum Furis"] = { id=205, name="Divine Fury", color=TextParsing.Neutral, notarget=true };
	["Forul Solum"] = { id=206, name="Enemy of One", color=TextParsing.Neutral, notarget=true };
	["Augus Luminos"] = { id=207, name="Holy Light", color=TextParsing.Neutral, notarget=true };
	["Dium Prostra"] = { id=208, name="Noble Sacrifice", color=TextParsing.Heal, notarget=true };
	["Extermo Vomica"] = { id=209, name="Remove Curse", color=TextParsing.Heal, distance=18 };
	["Sanctum Viatas"] = { id=210, name="Sacred Journey", color=TextParsing.Neutral, distance=15 };

	["Myrshalee"] = { id=601, name="Arcane Circle", color=TextParsing.Neutral, notarget=true };
	["Olorisstra"] = { id=602, name="Gift of Renewal", color=TextParsing.Heal };
	["Thalshara"] = { id=603, name="Immolating Weapon", color=TextParsing.Neutral, notarget=true };
	["Haeldril"] = { id=604, name="Attune Weapon", color=TextParsing.Neutral, notarget=true };
	["Erelonia"] = { id=605, name="Thunderstorm", color=TextParsing.Curse, notarget=true };
	["Rauvvrae"] = { id=606, name="Nature's Fury", color=TextParsing.Neutral, cursorOnly=true };
	["Alalithra"] = { id=607, name="Summon Fey", color=TextParsing.Neutral, notarget=true };
	["Nylisstra"] = { id=608, name="Summon Fiend", color=TextParsing.Neutral, notarget=true };
	["Tarisstree"] = { id=609, name="Reaper Form", color=TextParsing.Neutral, notarget=true };
	["Haelyn"] = { id=610, name="Wildfire", color=SpellsInfo.FIRE, distance=12 };
	["Anathrae"] = { id=611, name="Essence of Wind", color=TextParsing.Curse, notarget=true };
	["Rathril"] = { id=612, name="Dryad Allure", color=TextParsing.Neutral, distance=12 };
	["Orlavdra"] = { id=613, name="Ethereal Voyage", color=TextParsing.Neutral, notarget=true };
	["Nyraxle"] = { id=614, name="Word of Death", color=SpellsInfo.Chaos, distance=11 };
	["Illorae"] = { id=615, name="Gift of Life", color=TextParsing.Neutral };
	["Aslavdra"] = { id=616, name="Arcane Empowerment", color=TextParsing.Neutral, notarget=true };

	["In Corp Ylem"] = { id=678, name="Nether Bolt", color=SpellsInfo.Chaos, distance=12, spellTrigger = true };
	["Kal In Mani"] = { id=679, name="Healing Stone", color=TextParsing.Neutral, notarget=true, spellTrigger = true };
	["An Ort Sanct"] = { id=680, name="Purge Magic", color=TextParsing.Neutral, distance=13, spellTrigger = true };
	["In Ort Ylem"] = { id=681, name="Enchant", color=TextParsing.Neutral, notarget=true, spellTrigger = true };
	["In Zu"] = { id=682, name="Sleep", color=TextParsing.Paralyze, distance=13, spellTrigger = true };
	["Kal Por Xen"] = { id=683, name="Eagle Strike", color=SpellsInfo.ENERGY, distance=13, spellTrigger = true };
	["In Jux Por Ylem"] = { id=684, name="Animated Weapon", color=TextParsing.Neutral, cursorOnly=true, spellTrigger = true };
	["In Rel Ylem"] = { id=685, name="Stone Form", color=TextParsing.Neutral, notarget=true, spellTrigger = true };
	["In Vas Ort Ex"] = { id=686, name="Spell Trigger", color=TextParsing.Neutral, notarget=true };
	["Vas Zu"] = { id=687, name="Mass Sleep", color=TextParsing.Paralyze, distance=13, spellTrigger = true };
	["In Vas Mani Hur"] = { id=688, name="Cleansing Winds", color=TextParsing.Heal, distance=13, spellTrigger = true };
	["Corp Por Ylem"] = { id=689, name="Bombard", color=SpellsInfo.PHYSICAL, distance=13, spellTrigger = true };
	["Vas Rel Jux Ort"] = { id=690, name="Spell Plague", color=TextParsing.Curse, distance=13 };
	["Kal Des Ylem"] = { id=691, name="Hail Storm", color=SpellsInfo.COLD, distance=13 };
	["Grav Hur"] = { id=692, name="Nether Cyclone", color=SpellsInfo.Chaos, distance=13 };
	["Kal Vas Xen Corp Ylem"] = { id=693, name="Rising Colossus", color=TextParsing.Neutral, cursorOnly=true };

	["Uus Por"] = { id=701, name="Inspire", color=TextParsing.Heal, notarget=true };
	["An Zu"] = { id=702, name="Invigorate", color=TextParsing.Heal, notarget=true };
	["Kal Mani Tym"] = { id=703, name="Resilience", color=TextParsing.Heal, notarget=true };
	["Uus Jux Sanct"] = { id=704, name="Preservance", color=TextParsing.Heal, notarget=true };
	["In Jux Hur Rel"] = { id=705, name="Tribulation", color=TextParsing.Curse };
	["Kal Des Mani Tym"] = { id=706, name="Despair", color=SpellsInfo.PHYSICAL };

	["Honorable Execution"] = { id=401, notarget=true};
	["Confidence"] = { id=402, notarget=true};
	["Evasion"] = { id=403, notarget=true};
	["Counter Attack"] = { id=404, notarget=true};
	["Lightning Strike"] = { id=405, notarget=true};
	["Momentum Strike"] = { id=406, notarget=true};

	["Focus Attack"] = { id=501, notarget=true};
	["Death Strike"] = { id=502, notarget=true};
	["Animal Form"] = { id=503, notarget=true};
	["Ki Attack"] = { id=504, notarget=true};
	["Surprise Attack"] = { id=505, notarget=true};
	["Backstab"] = { id=506, notarget=true};
	["Shadowjump"] = { id=507, cursorOnly=true};
	["Mirror Image"] = { id=508, notarget=true};

	["Tribulation"] = { id=705, distance=8};
	["Despair"] = { id=706, distance=8};

	["Anh Mi Sah Ko"] = { id=-1, name="Spirit Speak", color=TextParsing.Heal };
	}
end


function SpellsInfo.GetMinSkill(spellId) 
	if (spellId >= 1 and spellId <= 8) then -- Magery 1
		return -20
	elseif (spellId >= 9 and spellId <= 16) then-- Magery 2
		return -5
	elseif (spellId >= 17 and spellId <= 24) then-- Magery 3
		return 9
	elseif (spellId >= 25 and spellId <= 32) then-- Magery 4
		return 23
	elseif (spellId >= 33 and spellId <= 40) then-- Magery 5
		return 38
	elseif (spellId >= 41 and spellId <= 48) then-- Magery 6
		return 52
	elseif (spellId >= 49 and spellId <= 56) then-- Magery 7
		return 66
	elseif (spellId >= 57 and spellId <= 64) then-- Magery 8
		return 80
	elseif (spellId == 101) then -- Animate Dead
		return 40
	elseif (spellId == 102) then -- Blood Oath
		return 20
	elseif (spellId == 103) then -- Corpse Skin
		return 20
	elseif (spellId == 104) then -- Curse Weapon
		return 0
	elseif (spellId == 105) then -- Evil Omen
		return 20
	elseif (spellId == 106) then -- Horrific Beast
		return 40
	elseif (spellId == 107) then -- Lich Form
		return 70
	elseif (spellId == 108) then -- Mind Rot
		return 30
	elseif (spellId == 109) then -- Pain Spike
		return 20
	elseif (spellId == 110) then -- Poison Strike
		return 50
	elseif (spellId == 111) then -- Strangle
		return 65
	elseif (spellId == 112) then -- Summon Familiar
		return 30
	elseif (spellId == 113) then -- Vampiric Embrace
		return 99
	elseif (spellId == 114) then -- Vengeful Spirit
		return 80
	elseif (spellId == 115) then -- Wither
		return 60
	elseif (spellId == 116) then -- Wraith Form
		return 20
	elseif (spellId == 117) then -- Exorcism
		return 80
	end
end

function SpellsInfo.GetMaxSkill(minSkill, spellId) 
	if (spellId == 401 or spellId == 405 or spellId == 406) then
		return minSkill
	end
	if (spellId >= 1 and spellId <= 8) then -- Magery 1
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 9 and spellId <= 16) then-- Magery 2
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 17 and spellId <= 24) then-- Magery 3
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 25 and spellId <= 32) then-- Magery 4
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 33 and spellId <= 40) then-- Magery 5
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 41 and spellId <= 48) then-- Magery 6
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 49 and spellId <= 56) then-- Magery 7
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 57 and spellId <= 64) then-- Magery 8
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 101 and spellId <= 200) then -- Necromancy
		return minSkill + 40
	elseif (spellId >= 201 and spellId <= 300) then -- Chivalry
		return minSkill + 50
	elseif (spellId >= 401 and spellId <= 500) then -- Bushido
		return minSkill + 35
	elseif (spellId >= 501 and spellId <= 600) then	-- Ninjitsu
		return minSkill + 40
	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		return minSkill + 40
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		return minSkill + 37.5
	else
		return minSkill + 40
	end
end

function SpellsInfo.GetVariation(spellId) 
	if (spellId >= 1 and spellId <= 64) then-- Magery 
		return 40
	elseif (spellId >= 101 and spellId <= 200) then -- Necromancy
		return 40
	elseif (spellId >= 201 and spellId <= 300) then -- Chivalry
		return 50
	elseif (spellId >= 401 and spellId <= 500) then -- Bushido
		return 35
	elseif (spellId >= 501 and spellId <= 600) then	-- Ninjitsu
		return 40
	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		return 40
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		return  37.5
	else
		return  40
	end
end

function SpellsInfo.GetSkillID(spellId) 
	if (spellId >= 1 and spellId <= 64) then-- Magery 
		return 32
	elseif (spellId >= 101 and spellId <= 200) then -- Necromancy
		return 38
	elseif (spellId >= 201 and spellId <= 300) then -- Chivalry
		return 13
	elseif (spellId >= 401 and spellId <= 500) then -- Bushido
		return 9
	elseif (spellId >= 501 and spellId <= 600) then	-- Ninjitsu
		return 39
	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		return 46
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		return 37
	end
end

function SpellsInfo.GetSpellDamage(spellId) 
	local skillId
	local skillIdsec
	local skillIdthi
	local itemSDI = tonumber(WindowData.PlayerStatus["SpellDamageIncrease"])
	local int = tonumber(WindowData.PlayerStatus["Intelligence"]) 
	local intSDI = math.ceil(tonumber(WindowData.PlayerStatus["Intelligence"]) / 10)	
	local serverId = WindowData.SkillsCSV[27].ServerId
	local inscribeSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	local inscribeSDI = 0
	if (inscribeSkillLevel >= 100) then
		inscribeSDI = 10
	end
	
	local sdiit = ((intSDI + inscribeSDI + itemSDI) / 100) + 1
	
	local str = L""
	if (spellId >= 1 and spellId <= 64) then-- Magery 
		skillId = 32
		skillIdsec = 17 -- eval int
		
		serverId = WindowData.SkillsCSV[skillId].ServerId
		local mainSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		
		serverId = WindowData.SkillsCSV[skillIdsec].ServerId
		local secondSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10

		local evalSDI = ((secondSkillLevel * 3) / 100) + 1
		
		if (spellId == 5) then -- magic arrow
			
			local min = 3.1
			local max = 4.1
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 12) then -- harm
			
			local min = 5.2
			local max = 6.6
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154877), { min .. L" - " .. max .. GetStringFromTid(1154882)})
		elseif (spellId == 18) then -- fireball
			
			local min = 6
			local max = 7.2
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 30) then -- lightning
			
			local min = 6.9
			local max = 8
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154876), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 37) then -- mind blast
			
			local min = 6.9
			local max = 8
			min = math.floor(min + (mainSkillLevel + int) / 5)
			max = math.floor(max + (mainSkillLevel + int) / 5)
			str = ReplaceTokens(GetStringFromTid(1154877), { min .. L" - " .. max .. GetStringFromTid(1154882)})
		elseif (spellId == 42) then -- energy bolt
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154876), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 43) then -- explosion
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 49) then -- chain lightning
			
			local min = 15.5
			local max = 16.8
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. GetStringFromTid(1154881)})
		elseif (spellId == 51) then -- flamestrike
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 55) then -- Meteor swarm
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. GetStringFromTid(1154881)})
		elseif (spellId == 57) then -- hearthquake
			
			local min = 19
			local max = 21.2
			min = math.floor(min * evalSDI)
			max = math.floor(max * evalSDI)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. GetStringFromTid(1154880)})
		end
	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		skillId = 46
		serverId = WindowData.SkillsCSV[skillId].ServerId
		local sw = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		
		local circle = Interface.ArcaneFocusLevel
		if (spellId == 605) then -- thunderstorm
			local min = math.max(11, 10 + (sw / 24)) + circle
			min = math.floor(min * sdiit)
			str = L"<BR>Energy Damage: " .. min .. L"<BR>"
		elseif (spellId == 611) then -- essence of wind
			local min = 25 + circle
			min = math.floor(min * sdiit)
			str = L"<BR>Cold Damage: " .. min .. L"<BR>"
		elseif (spellId == 614) then -- Word of Death
			local min = math.max((sw / 24), 1) + 4
			min = math.floor(min * sdiit)
			
			str = L"<BR>Chaos Damage: " .. min .. L"<BR>"
			local amount = circle * 5
			if (amount <=0 ) then
				amount =5 
			end
			min = 300
			min = math.floor(min * sdiit)
			str = str .. ReplaceTokens(GetStringFromTid(1154874), {amount, min})
		end		
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		skillIdthi= 21 -- focus
		local secondSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		serverId = WindowData.SkillsCSV[skillIdthi].ServerId
		local tempSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		secondSkillLevel = math.max(tempSkillLevel,secondSkillLevel)
		
		local Perc = 412.5
        local focusSDI = (((Perc / 120) * secondSkillLevel) / 100) + 1
        if (spellId == 678) then -- nether bolt
			
			local min = 3.1
			local max = 4.1
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154875), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 683) then -- eagle strike
			
			local min = 5.0
			local max = 6.6
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154876), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 689) then -- bombard
			
			local min = 10
			local max = 12.2
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154878), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 691) then -- hail storm
			
			local min = 12
			local max = 14
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154877), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 692) then -- Nether cyclone
			
			local min = 12
			local max = 14
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154875), { min .. L" - " .. max .. L"<BR>"})
		end
	end
	return str
end

function SpellsInfo.GetRecoverySpeed()
	local fcr = 	tonumber(WindowData.PlayerStatus["FasterCastRecovery"])
	return 1.5 - (0.25 * fcr)
end

function SpellsInfo.GetSpellSpeed(spellId)
	local serverId = WindowData.SkillsCSV[32].ServerId
	local magery = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	
	serverId = WindowData.SkillsCSV[37].ServerId
	local mysticism = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	local forceCap = false
	if (magery >=70 or mysticism >=70) then
		forceCap = true
	end
	
	local fc = 	tonumber(WindowData.PlayerStatus["FasterCasting"])
	local speed
	if (spellId >= 1 and spellId <= 8) then-- Magery 
		speed = 0.5
		forceCap = true
	elseif (spellId >= 9 and spellId <= 16) then-- Magery 
		speed = 0.75
		forceCap = true
	elseif (spellId >= 17 and spellId <= 24) then-- Magery 
		speed = 1
		forceCap = true
	elseif (spellId >= 25 and spellId <= 32) then-- Magery 
		speed = 1.25
		forceCap = true
	elseif (spellId >= 33 and spellId <= 40) then-- Magery 
		if (spellId == 33) then
			speed = 5
			forceCap = false
		else
			speed = 1.5
			forceCap = true
		end
		
	elseif (spellId >= 41 and spellId <= 48) then-- Magery 
		speed = 1.75
		forceCap = true
	elseif (spellId >= 49 and spellId <= 56) then-- Magery 
		speed = 2
		forceCap = true
	elseif (spellId >= 57 and spellId <= 64) then-- Magery 
		speed = 2
		forceCap = true
		
	elseif (spellId == 104 or spellId == 109 or spellId == 105) then -- Necromancy
		speed = 1
		forceCap = true
	elseif (spellId == 102 or spellId == 108 or spellId == 101 or spellId == 115) then -- Necromancy
		speed = 1.5
		forceCap = true
	elseif (spellId == 103 or spellId == 110 or spellId == 117) then -- Necromancy
		speed = 2
		forceCap = true
	elseif (spellId == 111) then -- Necromancy
		speed =2.5
		forceCap = true
	elseif (spellId == 116 or spellId == 112 or spellId == 106 or spellId == 107 or spellId == 113 or spellId == 114) then -- Necromancy
		speed = 4
		forceCap = true
		
	elseif (spellId == 601) then -- Spellweaving
		speed = 0.5
	elseif (spellId == 602 or spellId == 611 or spellId == 612) then -- Spellweaving
		speed = 3
	elseif (spellId == 603 or spellId == 604) then -- Spellweaving
		speed = 1
	elseif (spellId == 605 or spellId == 606) then -- Spellweaving
		speed = 1.5
	elseif (spellId == 607 or spellId == 608) then -- Spellweaving
		speed = 2
	elseif (spellId == 609 or spellId == 610) then -- Spellweaving
		speed = 2.5
	elseif (spellId == 613 or spellId == 614) then -- Spellweaving
		speed = 3.5
	elseif (spellId == 615 or spellId == 616) then -- Spellweaving
		speed = 4
	elseif (spellId == 204) then -- Chivalry
		speed = 0.25
	elseif (spellId == 203 or spellId == 204 or spellId == 206) then -- Chivalry
		speed = 0.5
	elseif (spellId == 201 or spellId == 205) then -- Chivalry
		speed = 1.0
	elseif (spellId == 202 or spellId == 208 or spellId == 209 or spellId == 210 ) then -- Chivalry
		speed = 1.5
	elseif (spellId == 207) then -- Chivalry
		speed = 1.75
	elseif (spellId == 678) then -- Mysticism
		speed = 0.5
		forceCap = true
	elseif (spellId >= 680 and spellId <= 681) then -- Mysticism
		speed = 0.75
		forceCap = true
	elseif (spellId >= 682 and spellId <= 683) then -- Mysticism
		speed = 1
		forceCap = true
	elseif (spellId >= 684 and spellId <= 685) then -- Mysticism
		speed = 1.25
		forceCap = true
	elseif (spellId == 679 or spellId == 686 ) then
		speed = 5.5
		forceCap = true
	elseif (spellId == 687) then -- Mysticism
		speed = 1.5
		forceCap = true
	elseif (spellId >= 688 and spellId <= 689) then -- Mysticism
		speed = 1.75
		forceCap = true
	elseif (spellId >= 690 and spellId <= 691) then -- Mysticism
		speed = 2
		forceCap = true
	elseif (spellId >= 692 and spellId <= 693) then -- Mysticism
		speed = 2.25
		forceCap = true
		
	elseif (spellId == 402) then -- Bushido
		speed = 0.5
		forceCap = false
	elseif (spellId == 403) then -- Bushido
		speed = 0.25
		forceCap = false
	elseif (spellId == 404) then -- Bushido
		speed = 0.25
		forceCap = false
		
	elseif (spellId == 503) then -- Ninjitsu
		speed = 1.5
		forceCap = false
	elseif (spellId == 507) then -- Ninjitsu
		speed = 1.0
		forceCap = false
	elseif (spellId == 508) then -- Ninjitsu
		speed = 1.5
		forceCap = false
	end
	
	if (forceCap and fc >= 2) then
		fc = 2
	end
	local itemFC = fc * 0.25
	
	
	if (speed and itemFC > 0) then
		speed = speed - itemFC
		if (speed < 0.25) then
			speed = 0.25
		end
	end
	return speed 
end

function SpellsInfo.SumonFamiliarSkillRequirements(animalTid) -- 0 = DOABLE, 1 = CANT DO IT

	local serverId = WindowData.SkillsCSV[38].ServerId
	local SkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, true)
	if mobileData.Race == PaperdollWindow.HUMAN and SkillLevel < 20 then
		SkillLevel = 20
	end
	
	serverId = WindowData.SkillsCSV[47].ServerId
	local SkillSecondary = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	if mobileData.Race == PaperdollWindow.HUMAN and SkillSecondary < 20 then
		SkillSecondary = 20
	end
	
	if animalTid == 1 then
		if SkillLevel >= 30 and SkillSecondary >= 30 then
			return 0
		end
	elseif animalTid == 2 then
		if SkillLevel >= 50 and SkillSecondary >= 50 then
			return 0
		end
	elseif animalTid == 3 then
		if SkillLevel >= 60 and SkillSecondary >= 60 then
			return 0
		end
	elseif animalTid == 4 then
		if SkillLevel >= 80 and SkillSecondary >= 80 then
			return 0
		end
	elseif animalTid == 5 then
		if SkillLevel >= 100 and SkillSecondary >= 100 then
			return 0
		end
	end
	return 1
end

function SpellsInfo.AnimalFormSkillRequirements(animalTid) -- 0 = DOABLE, 1 = CANT DO IT
	local serverId = WindowData.SkillsCSV[SpellsInfo.GetSkillID(503)].ServerId
	local SkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, true)
	if mobileData.Race == PaperdollWindow.HUMAN and SkillLevel < 20 then
		SkillLevel = 20
	end
	local taliId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][12].slotId
	local taliName
	if taliId ~= 0 then
		if not WindowData.ObjectInfo[taliId] then
			RegisterWindowData(WindowData.ObjectInfo.Type, taliId, true)
		end
		if WindowData.ObjectInfo[taliId] then
			taliName = wstring.lower(WindowData.ObjectInfo[taliId].name)
		end
	end
	
	if animalTid == 1028485 then
		if SkillLevel >= 0 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028483 then
		if SkillLevel >= 20 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1075971 then

		if SkillLevel >= 20 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075971))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018280 then
		if SkillLevel >= 40 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018264 then
		if SkillLevel >= 40 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1075972 then
		if SkillLevel >= 40 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075972))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028496 then
		if SkillLevel >= 50 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018114 then
		if SkillLevel >= 50 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1031670 then
		if SkillLevel >= 60 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1031670))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028438 then
		if SkillLevel >= 70 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018273 then
		if SkillLevel >= 70 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1030083 then
		if SkillLevel >= 85 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028482 then
		if SkillLevel >= 85 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1075202 then
		if SkillLevel >= 90 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075202))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1029632 then
		if SkillLevel > 100 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018214 then
		if SkillLevel > 100 then
			return 0
		else
			return 1
		end
	end

end

-- Spell Trigger
function SpellsInfo.GetButtonIDST(buttonId) -- 0 = force manual selection
	local spellId = 676 + buttonId
	local _, _, _, _, _, _, _, minskill, _ = GetAbilityData(spellId)
	local skillId = 37
	local skillIdsec = 26 -- imbuing
	local skillIdthi= 21 -- focus
	
	local serverId = WindowData.SkillsCSV[skillId].ServerId
	local mainSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	
	serverId = WindowData.SkillsCSV[skillIdsec].ServerId
	local secondSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	
	serverId = WindowData.SkillsCSV[skillIdthi].ServerId
	local tempSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	secondSkillLevel = math.max(tempSkillLevel,secondSkillLevel)
	if minskill <= 20 or (minskill <= mainSkillLevel and minskill <= secondSkillLevel) then
		return buttonId
	else
		return 0
	end
end

-- ANimal Form
function SpellsInfo.GetButtonID(animalTid) -- 0 = force manual selection
	local serverId = WindowData.SkillsCSV[SpellsInfo.GetSkillID(503)].ServerId
	local SkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, true)
	if mobileData.Race == PaperdollWindow.HUMAN and SkillLevel < 20 then
		SkillLevel = 20
	end
	
	local taliId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][12].slotId
	local taliName
	if taliId ~= 0 then
		if not WindowData.ObjectInfo[taliId] then
			RegisterWindowData(WindowData.ObjectInfo.Type, taliId)
		end
		if WindowData.ObjectInfo[taliId] then
			taliName = wstring.lower(WindowData.ObjectInfo[taliId].name)
		end
	end
	
	-- 1 = cancel
	-- 2+ = trasformazioni
	-- 12 = next
	
	if animalTid == 1028485 then
		if SkillLevel < 20 then
			return 2
		elseif SkillLevel < 40 then
			return 3
		elseif SkillLevel < 50 then
			return 5
		elseif SkillLevel < 70 then
			return 7
		elseif SkillLevel < 85 then
			return 9
		elseif SkillLevel < 100 then
			return 11
		elseif SkillLevel >= 100 then
			return 15
		end
	elseif animalTid == 1028483 then
		if SkillLevel < 40 then
			return 2
		elseif SkillLevel < 50 then
			return 4
		elseif SkillLevel < 70 then
			return 6
		elseif SkillLevel < 85 then
			return 8
		elseif SkillLevel < 100 then
			return 10
		elseif SkillLevel >= 100 then
			return 14
		end
		
	elseif animalTid == 1075971 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075971))})) then
			return 0
		end
		if SkillLevel < 40  then
			return 4
		elseif SkillLevel < 50 then
			return 6
		elseif SkillLevel < 70 then
			return 8
		elseif SkillLevel < 85 then
			return 10
		elseif SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1018280 then
		if SkillLevel < 50 then
			return 2
		elseif SkillLevel < 70 then
			return 4
		elseif SkillLevel < 85 then
			return 6
		elseif SkillLevel < 100 then
			return 8
		elseif SkillLevel >= 100 then
			return 10
		end
	elseif animalTid == 1018264 then
		if SkillLevel < 50 then
			return 3
		elseif SkillLevel < 70 then
			return 5
		elseif SkillLevel < 85 then
			return 7
		elseif SkillLevel < 100 then
			return 9
		elseif SkillLevel >= 100 then
			return 11
		end
		
	elseif animalTid == 1075972 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075972))})) then
			return 0
		end
		if SkillLevel < 50 then
			return 6
		elseif SkillLevel < 70 then
			return 8
		elseif SkillLevel < 85 then
			return 10
		elseif SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1028496 then
		if SkillLevel < 70 then
			return 2
		elseif SkillLevel < 85 then
			return 4
		elseif SkillLevel < 100 then
			return 6
		elseif SkillLevel >= 100 then
			return 8
		end
	elseif animalTid == 1018114 then
		if SkillLevel < 70 then
			return 3
		elseif SkillLevel < 85 then
			return 5
		elseif SkillLevel < 100 then
			return 7
		elseif SkillLevel >= 100 then
			return 9
		end
		
	elseif animalTid == 1031670 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1031670))})) then
			return 0
		end
		if SkillLevel < 70  then
			return 8
		elseif SkillLevel < 85 then
			return 10
		elseif SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1028438 then
		if SkillLevel < 85 then
			return 2
		elseif SkillLevel < 100 then
			return 4
		elseif SkillLevel >= 100 then
			return 6
		end
	elseif animalTid == 1018273 then
		if SkillLevel < 85 then
			return 3
		elseif SkillLevel < 100 then
			return 5
		elseif SkillLevel >= 100 then
			return 7
		end
		
	elseif animalTid == 1030083 then
		if SkillLevel < 100 then
			return 2
		elseif SkillLevel >= 100 then
			return 4
		end
	elseif animalTid == 1028482 then
		if SkillLevel < 100 then
			return 3
		elseif SkillLevel >= 100 then
			return 5
		end
	
	elseif animalTid == 1075202 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075202))})) then
			return 0
		end
		if SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1029632 then
		if SkillLevel >= 100 then
			return 2
		end
	elseif animalTid == 1018214 then
		if SkillLevel >= 100 then
			return 3
		end
	end
	
end
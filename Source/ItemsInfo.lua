
ItemsInfo = {}

ItemsInfo.Data = {
[1] = {name="Bandage", types={3617,3817}, coolDown="bandages" };
[2] = {name="Healing Potion", types={3852}, hues={0}, coolDown=10 };
[3] = {name="Enchanted Apple", types={12248}, hues={1160}, coolDown=30 };
[4] = {name="Grapes of Wrath", types={12247}, hues={1154}, coolDown=120 };
}

ItemsInfo.Reagents = {
[3962] = 1023962, -- Black Pearl
[3963] = 1023963, -- Blood Moss
[3972] = 1023972, -- Garlic
[3973] = 1023973, -- Ginseng
[3974] = 1023974, -- Mandrake Root
[3976] = 1023976, -- Nightshade
[3980] = 1023980, -- Sulfurous Ash
[3981] = 1023981, -- Spiders' Silk
[3966] = 1023966, -- Bone
[16503]= 1023970, -- Dragon's Blood
[3969] = 1023969, -- Fertile Dirt
[3968] = 1023968, -- Daemon Bone
[3983] = 1023983, -- Grave Dust
[3960] = 1023960, -- Batwing
[3982] = 1023982, -- Nox Crystal
[3965] = 1023965, -- Daemon Blood
[3978] = 1023978, -- Pig Iron
}


function GetCooldown(type, _)
	for i = 1, #ItemsInfo.Data do
		for j=1, #ItemsInfo.Data[i].types do
			if ItemsInfo.Data[i].types[j] == type then
				for k=1, #ItemsInfo.Data[i].hues do
					if ItemsInfo.Data[i].hues[k] == id then
						return ItemsInfo.Data[i].coolDown
					end
				end
			end
		end
	end
	return -1
end
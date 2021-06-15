
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ActionsWindow = {}
ActionsWindow.DefaultTypes = 91

function ActionsWindow.InitActionData()

	ActionsWindow.ActionData = {}
	ActionsWindow.ActionData[1]  = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=625, nameTid=1078184, detailTid=1115131, editWindow="Equip", paramInfoTid=1078184}
	ActionsWindow.ActionData[2]  = { type=SystemData.UserAction.TYPE_UNEQUIP_ITEMS,					inActionWindow=true, iconId=637, nameTid=1078185, detailTid=1115132, editWindow="UnEquip", paramInfoTid=1078185}
	ActionsWindow.ActionData[3]  = { type=SystemData.UserAction.TYPE_TOGGLE_WAR_MODE,				inActionWindow=true, iconId=635, nameTid=3002081, detailTid=1115133 }
	ActionsWindow.ActionData[4]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=632, nameTid=3002076, detailTid=1115134, editWindow="Text", paramInfoTid=3002006 }
	ActionsWindow.ActionData[5]  = { type=SystemData.UserAction.TYPE_SPEECH_EMOTE,					inActionWindow=true, iconId=624, nameTid=3002077, detailTid=1115135, editWindow="Text", paramInfoTid=3002007 }
	ActionsWindow.ActionData[6]  = { type=SystemData.UserAction.TYPE_SPEECH_WHISPER,				inActionWindow=true, iconId=638, nameTid=3002078, detailTid=1115136, editWindow="Text", paramInfoTid=3002009 }
	ActionsWindow.ActionData[7]  = { type=SystemData.UserAction.TYPE_SPEECH_YELL,					inActionWindow=true, iconId=639, nameTid=3002079, detailTid=1115137, editWindow="Text", paramInfoTid=3002010 }
	ActionsWindow.ActionData[8]  = { type=SystemData.UserAction.TYPE_LAST_SKILL,					inActionWindow=true, iconId=617, nameTid=3002089, detailTid=1115138 }
	ActionsWindow.ActionData[9]  = { type=SystemData.UserAction.TYPE_LAST_SPELL,					inActionWindow=true, iconId=640, nameTid=3002091, detailTid=1115139 }
	ActionsWindow.ActionData[10] = { type=SystemData.UserAction.TYPE_LAST_OBJECT,					inActionWindow=true, iconId=629, nameTid=3002092, detailTid=1115140 }
	ActionsWindow.ActionData[11] = { type=SystemData.UserAction.TYPE_USE_TARGETED_OBJECT,			inActionWindow=true, iconId=646, nameTid=1079159, detailTid=1115141 }
	ActionsWindow.ActionData[12] = { type=SystemData.UserAction.TYPE_BOW,							inActionWindow=true, iconId=622, nameTid=3002093, detailTid=1115142 }
	ActionsWindow.ActionData[13] = { type=SystemData.UserAction.TYPE_SALUTE,						inActionWindow=true, iconId=631, nameTid=3002094, detailTid=1115143 }
	ActionsWindow.ActionData[14] = { type=SystemData.UserAction.TYPE_OPEN_DOOR,						inActionWindow=true, iconId=641, nameTid=3002087, detailTid=1115144 }
	ActionsWindow.ActionData[15] = { type=SystemData.UserAction.TYPE_ALL_NAMES,						inActionWindow=true, iconId=619, nameTid=3002096, detailTid=1115145 }
	ActionsWindow.ActionData[16] = { type=SystemData.UserAction.TYPE_DELAY,							inActionWindow=true, iconId=623, nameTid=3002103, detailTid=1115146, editWindow="Slider", paramInfoTid=3002103, sliderMin=0.0, sliderMax=10.0 }
	ActionsWindow.ActionData[17] = { type=SystemData.UserAction.TYPE_WAIT_FOR_TARGET,				inActionWindow=true, iconId=618, nameTid=3002100, detailTid=1115147 }
	ActionsWindow.ActionData[18] = { type=SystemData.UserAction.TYPE_MACRO,							inActionWindow=false,			 nameTid=3000394, editWindow="Macro" }
	ActionsWindow.ActionData[19] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_LAST,			inActionWindow=true, iconId=644, nameTid=1079156, detailTid=1115148 }
	ActionsWindow.ActionData[20] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_CURRENT,			inActionWindow=true, iconId=643, nameTid=1079157, detailTid=1115149 }
	ActionsWindow.ActionData[21] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_SELF,			inActionWindow=true, iconId=645, nameTid=1079158, detailTid=1115150 }
	ActionsWindow.ActionData[22] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_FRIENDLY,			inActionWindow=true, iconId=647, nameTid=1079177, detailTid=1115151 }
	ActionsWindow.ActionData[23] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_ENEMY,				inActionWindow=true, iconId=648, nameTid=1079178, detailTid=1115152 }
	ActionsWindow.ActionData[24] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_GROUPMEMBER,		inActionWindow=true, iconId=649, nameTid=1079179, detailTid=1115153 }
	ActionsWindow.ActionData[25] = { type=SystemData.UserAction.TYPE_TARGET_NEXT,					inActionWindow=true, iconId=708, nameTid=1094824, detailTid=1115154 }
	ActionsWindow.ActionData[26] = { type=SystemData.UserAction.TYPE_ARM_DISARM,					inActionWindow=true, iconId=677, nameTid=3002099, detailTid=1115155, editWindow="ArmDisarm", paramInfoTid=1079292 }
	ActionsWindow.ActionData[27] = { type=SystemData.UserAction.TYPE_WAR_MODE,						inActionWindow=true, iconId=675, nameTid=3000086, detailTid=1115156 }
	ActionsWindow.ActionData[28] = { type=SystemData.UserAction.TYPE_PEACE_MODE, 					inActionWindow=true, iconId=676, nameTid=3000085, detailTid=1115157 }
	ActionsWindow.ActionData[29] = { type=SystemData.UserAction.TYPE_PET_COMMAND_ALLKILL,			inActionWindow=true, iconId=650, nameTid=1079300, detailTid=1115158 }
	ActionsWindow.ActionData[30] = { type=SystemData.UserAction.TYPE_PET_COMMAND_COME,				inActionWindow=true, iconId=651, nameTid=1079301, detailTid=1115159 }
	ActionsWindow.ActionData[31] = { type=SystemData.UserAction.TYPE_PET_COMMAND_FOLLOW,			inActionWindow=true, iconId=655, nameTid=1079302, detailTid=1115160 }
	ActionsWindow.ActionData[32] = { type=SystemData.UserAction.TYPE_PET_COMMAND_FOLLOWME,			inActionWindow=true, iconId=656, nameTid=1079303, detailTid=1115161 }
	ActionsWindow.ActionData[33] = { type=SystemData.UserAction.TYPE_PET_COMMAND_GUARD,				inActionWindow=true, iconId=657, nameTid=1079304, detailTid=1115163 }
	ActionsWindow.ActionData[34] = { type=SystemData.UserAction.TYPE_PET_COMMAND_GUARDME,			inActionWindow=true, iconId=658, nameTid=1079305, detailTid=1115162 }
	ActionsWindow.ActionData[35] = { type=SystemData.UserAction.TYPE_PET_COMMAND_STAY,				inActionWindow=true, iconId=660, nameTid=1079306, detailTid=1115164 }
	ActionsWindow.ActionData[36] = { type=SystemData.UserAction.TYPE_PET_COMMAND_STOP,				inActionWindow=true, iconId=661, nameTid=1079307, detailTid=1115165 }
	ActionsWindow.ActionData[37] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_LEFT,		inActionWindow=true, iconId=668, nameTid=1079313, detailTid=1115166 }
	ActionsWindow.ActionData[38] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_RIGHT,	inActionWindow=true, iconId=669, nameTid=1079314, detailTid=1115167 }
	ActionsWindow.ActionData[39] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD,			inActionWindow=true, iconId=667, nameTid=1079325, detailTid=1115168 }
	ActionsWindow.ActionData[40] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_LEFT,	inActionWindow=true, iconId=653, nameTid=1079315, detailTid=1115169 }
	ActionsWindow.ActionData[41] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_RIGHT,	inActionWindow=true, iconId=654, nameTid=1079316, detailTid=1115170 }
	ActionsWindow.ActionData[42] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARDS,		inActionWindow=true, iconId=652, nameTid=1079317, detailTid=1115171 }
	ActionsWindow.ActionData[43] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_LEFT,				inActionWindow=true, iconId=664, nameTid=1079318, detailTid=1115172 }
	ActionsWindow.ActionData[44] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_RIGHT,			inActionWindow=true, iconId=665, nameTid=1079319, detailTid=1115173 }
	ActionsWindow.ActionData[45] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_LEFT,		inActionWindow=true, iconId=670, nameTid=1079320, detailTid=1115174 }
	ActionsWindow.ActionData[46] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_RIGHT,		inActionWindow=true, iconId=672, nameTid=1079321, detailTid=1115175 }
	ActionsWindow.ActionData[47] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_AROUND,		inActionWindow=true, iconId=662, nameTid=1079322, detailTid=1115176 }
	ActionsWindow.ActionData[48] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_DORACRON,			inActionWindow=true, iconId=663, nameTid=1079323, detailTid=1115177 }
	ActionsWindow.ActionData[49] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_SUEACRON,			inActionWindow=true, iconId=674, nameTid=1079324, detailTid=1115178 }
	ActionsWindow.ActionData[50] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_STOP,				inActionWindow=true, iconId=673, nameTid=1052073, detailTid=1115179, editWindow="Text", paramInfoTid=3002006, callback=L"Furl Sail"  }
	ActionsWindow.ActionData[51] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_DROP_ANCHOR,		inActionWindow=true, iconId=666, nameTid=1079333, detailTid=1115180 }
	ActionsWindow.ActionData[52] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_RAISE_ANCHOR,		inActionWindow=true, iconId=671, nameTid=1079334, detailTid=1115181 }
	ActionsWindow.ActionData[53] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=694, nameTid=3005113, detailTid=1115182, editWindow="Text", paramInfoTid=3002006, callback=L"Start" }
	ActionsWindow.ActionData[54] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=695, nameTid=1052072, detailTid=1115183, editWindow="Text", paramInfoTid=3002006, callback=L"Continue" }
	ActionsWindow.ActionData[55] = { type=SystemData.UserAction.TYPE_TARGET_BY_RESOURCE,			inActionWindow=true, iconId=770, nameTid=1079430, detailTid=1115184, editWindow="TargetByResource", paramInfoTid=1079430 }
	ActionsWindow.ActionData[56] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=771, nameTid=1094786, detailTid=1115185, editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[57] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=790, nameTid=3002105, detailTid=1115186, editWindow="Text", paramInfoTid=3002105 }
	ActionsWindow.ActionData[58] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=701, nameTid=1051005, detailTid=1052058, invokeId=1 } -- Honor
	ActionsWindow.ActionData[59] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=706, nameTid=1051001, detailTid=1052053, invokeId=2 } -- Sacrifice
	ActionsWindow.ActionData[60] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=700, nameTid=1051004, detailTid=1052057, invokeId=3 } -- Valor
	ActionsWindow.ActionData[61] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=702, nameTid=1051002, detailTid=1053000, invokeId=4 } -- Compassion
	ActionsWindow.ActionData[62] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=704, nameTid=1051007, detailTid=1052060, invokeId=5 } -- Honesty
	ActionsWindow.ActionData[63] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=707, nameTid=1051000, detailTid=1052051, invokeId=6 } -- Humility
	ActionsWindow.ActionData[64] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=703, nameTid=1051006, detailTid=1052059, invokeId=7 } -- Justice
	ActionsWindow.ActionData[65] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=705, nameTid=1051003, detailTid=1052056, invokeId=8 } -- Spirituality
	ActionsWindow.ActionData[66] = { type=SystemData.UserAction.TYPE_CYCLE_CURSOR_TARGET,			inActionWindow=true, iconId=772, nameTid=1112413, detailTid=1115187 }
	ActionsWindow.ActionData[67] = { type=SystemData.UserAction.TYPE_ATTACK_CURRENT_TARGET,			inActionWindow=true, iconId=773, nameTid=1112414, detailTid=1115188 }
	ActionsWindow.ActionData[68] = { type=SystemData.UserAction.TYPE_ATTACK_LAST_CURSOR_TARGET,		inActionWindow=true, iconId=774, nameTid=1112415, detailTid=1115190 }
	ActionsWindow.ActionData[69] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_FOLLOWER,			inActionWindow=true, iconId=775, nameTid=1112416, detailTid=1115191 }
	ActionsWindow.ActionData[70] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_OBJECT,			inActionWindow=true, iconId=776, nameTid=1112420, detailTid=1115192 }
	ActionsWindow.ActionData[71] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_FRIENDLY,		inActionWindow=true, iconId=777, nameTid=1112431, detailTid=1115193 }
	ActionsWindow.ActionData[72] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_ENEMY,			inActionWindow=true, iconId=778, nameTid=1112432, detailTid=1115194 }
	ActionsWindow.ActionData[73] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_GROUPMEMBER,	inActionWindow=true, iconId=779, nameTid=1112433, detailTid=1115195 }
	ActionsWindow.ActionData[74] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_FOLLOWER,		inActionWindow=true, iconId=780, nameTid=1112434, detailTid=1115196 }
	ActionsWindow.ActionData[75] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_OBJECT,		inActionWindow=true, iconId=781, nameTid=1112435, detailTid=1115197 }
	ActionsWindow.ActionData[76] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS,				inActionWindow=true, iconId=782, nameTid=1112436, detailTid=1115198 }
	ActionsWindow.ActionData[77] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_FRIENDLY,		inActionWindow=true, iconId=783, nameTid=1112437, detailTid=1115199 }
	ActionsWindow.ActionData[78] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_ENEMY,			inActionWindow=true, iconId=784, nameTid=1112438, detailTid=1115200 }
	ActionsWindow.ActionData[79] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_GROUPMEMBER,	inActionWindow=true, iconId=785, nameTid=1112439, detailTid=1115201 }
	ActionsWindow.ActionData[80] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_FOLLOWER,		inActionWindow=true, iconId=786, nameTid=1112440, detailTid=1115202 }
	ActionsWindow.ActionData[81] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_OBJECT,			inActionWindow=true, iconId=787, nameTid=1112441, detailTid=1115203 }
	ActionsWindow.ActionData[82] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST,				inActionWindow=true, iconId=788, nameTid=1112442, detailTid=1115204 }
	ActionsWindow.ActionData[83] = { type=SystemData.UserAction.TYPE_TOGGLE_ALWAYS_RUN,				inActionWindow=true, iconId=789, nameTid=1113150, detailTid=1115205 }
	ActionsWindow.ActionData[84] = { type=SystemData.UserAction.TYPE_TOGGLE_CIRCLE_OF_TRANSPARENCY,	inActionWindow=true, iconId=791, nameTid=1079818, detailTid=1115206 }
	ActionsWindow.ActionData[85] = { type=SystemData.UserAction.TYPE_EQUIP_LAST_WEAPON,				inActionWindow=true, iconId=792, nameTid=1114305, detailTid=1115207 }
	ActionsWindow.ActionData[86] = { type=SystemData.UserAction.TYPE_BANDAGE_SELF,					inActionWindow=true, iconId=793, nameTid=1114306, detailTid=1115208 }
	ActionsWindow.ActionData[87] = { type=SystemData.UserAction.TYPE_BANDAGE_SELECTED_TARGET,		inActionWindow=true, iconId=794, nameTid=1114307, detailTid=1115209 }
	ActionsWindow.ActionData[88] = { type=SystemData.UserAction.TYPE_QUIT_GAME,						inActionWindow=true, iconId=795, nameTid=1114308, detailTid=1115210 }
	ActionsWindow.ActionData[89] = { type=SystemData.UserAction.TYPE_LOG_OUT,						inActionWindow=true, iconId=796, nameTid=1115334, detailTid=1115335 }
	ActionsWindow.ActionData[90] = { type=SystemData.UserAction.TYPE_CLEAR_TARGET_QUEUE,			inActionWindow=true, iconId=797, nameTid=1115342, detailTid=1115344 }
	ActionsWindow.ActionData[91] = { type=SystemData.UserAction.TYPE_DISMOUNT,						inActionWindow=true, iconId=798, nameTid=1115935, detailTid=1115936 }

	-- 4001 -> 4020 :  CANNON ACTIONS
	ActionsWindow.ActionData[4000] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870400, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"1"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"1"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4001] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870401, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"2"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"2"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4002] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870402, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"3"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"3"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4003] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870403, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"4"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"4"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4004] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870404, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"5"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"5"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4005] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870405, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"6"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"6"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4006] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870406, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"7"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"7"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4007] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870407, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"8"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"8"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[4008] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=870408, nameString=ReplaceTokens(GetStringFromTid(1155059), {L"9"}), detailString=ReplaceTokens(GetStringFromTid(1155060), {L"9"}), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	
	-- 4100 -> 4299 :  EQUIPMENT
	ActionsWindow.ActionData[4100] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875000, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155063)}
	ActionsWindow.ActionData[4101] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875001, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155064)}
	ActionsWindow.ActionData[4102] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875002, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155065)}
	ActionsWindow.ActionData[4103] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875003, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155066)}
	ActionsWindow.ActionData[4104] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875004, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155067)}
	ActionsWindow.ActionData[4105] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875005, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155068)}
	ActionsWindow.ActionData[4106] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875006, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155069)}
	ActionsWindow.ActionData[4107] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875007, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155070)}
	ActionsWindow.ActionData[4108] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875008, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155071)}
	ActionsWindow.ActionData[4109] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875009, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155072)}
	ActionsWindow.ActionData[4110] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875010, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155073)}
	ActionsWindow.ActionData[4111] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875011, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155074)}
	ActionsWindow.ActionData[4112] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875012, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155075)}
	ActionsWindow.ActionData[4113] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875013, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155076)}
	ActionsWindow.ActionData[4114] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875014, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155077)}
	ActionsWindow.ActionData[4115] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875015, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155078)}
	ActionsWindow.ActionData[4116] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875016, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155079)}
	ActionsWindow.ActionData[4117] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875017, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155080)}
	ActionsWindow.ActionData[4118] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875018, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155081)}
	ActionsWindow.ActionData[4119] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875019, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155082)}
	ActionsWindow.ActionData[4120] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875020, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155083)}
	ActionsWindow.ActionData[4121] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875021, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155084)}
	ActionsWindow.ActionData[4122] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875022, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155085)}
	ActionsWindow.ActionData[4123] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875023, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155086)}
	ActionsWindow.ActionData[4124] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875024, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155087)}
	ActionsWindow.ActionData[4125] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875025, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155088)}
	ActionsWindow.ActionData[4126] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875026, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155089)}
	ActionsWindow.ActionData[4127] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875027, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155090)}
	ActionsWindow.ActionData[4128] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875028, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155091)}
	ActionsWindow.ActionData[4129] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875029, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155092)}
	ActionsWindow.ActionData[4130] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875030, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155093)}
	ActionsWindow.ActionData[4131] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875031, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155094)}
	ActionsWindow.ActionData[4132] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875032, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155095)}
	ActionsWindow.ActionData[4133] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875033, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1049028}
	ActionsWindow.ActionData[4134] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875034, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1049029}
	ActionsWindow.ActionData[4135] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875035, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1049030}
	ActionsWindow.ActionData[4136] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875036, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1049031}
	
	-- 4300 -> 4349 :  SUPER SLAYERS
	ActionsWindow.ActionData[4300] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875200, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079747}
	ActionsWindow.ActionData[4301] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875201, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079748}
	ActionsWindow.ActionData[4302] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875202, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079749}
	ActionsWindow.ActionData[4303] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875203, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1070855}
	ActionsWindow.ActionData[4304] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875204, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079750}
	ActionsWindow.ActionData[4305] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875205, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079751}
	ActionsWindow.ActionData[4306] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875206, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079752}
					
	-- 4350 -> 4399 :  SLAYERS		
	ActionsWindow.ActionData[4350] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875250, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079743}
	ActionsWindow.ActionData[4351] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875251, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079746}
	ActionsWindow.ActionData[4352] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875252, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079753}
	ActionsWindow.ActionData[4353] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875253, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079737}
	ActionsWindow.ActionData[4354] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875254, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079733}
	ActionsWindow.ActionData[4355] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875255, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079734}
	ActionsWindow.ActionData[4356] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875256, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079735}
	ActionsWindow.ActionData[4357] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875257, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079736}
	ActionsWindow.ActionData[4358] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875258, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079742}
	ActionsWindow.ActionData[4359] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875259, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079745}
	ActionsWindow.ActionData[4360] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875260, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079755}
	ActionsWindow.ActionData[4361] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875261, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079741}
	ActionsWindow.ActionData[4362] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875262, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079739}
	ActionsWindow.ActionData[4363] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875263, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079754}
	ActionsWindow.ActionData[4364] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875264, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1061284}
	ActionsWindow.ActionData[4365] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875265, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079738}
	ActionsWindow.ActionData[4366] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875266, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079740}
	ActionsWindow.ActionData[4367] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875267, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079744}
	ActionsWindow.ActionData[4368] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875269, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1075462}
	ActionsWindow.ActionData[4369] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875268, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072512}

	-- 4400 -> 4449 : TALISMAN SLAYERS																																					  
	ActionsWindow.ActionData[4400] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875300, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072506}
	ActionsWindow.ActionData[4401] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875301, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072504}
	ActionsWindow.ActionData[4402] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875302, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072508}
	ActionsWindow.ActionData[4403] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875303, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072509}
	ActionsWindow.ActionData[4404] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875304, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072512}
	ActionsWindow.ActionData[4405] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875305, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072511}
	ActionsWindow.ActionData[4406] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875306, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072510}
	ActionsWindow.ActionData[4407] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875307, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072507}
	ActionsWindow.ActionData[4408] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875308, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1079752}
	ActionsWindow.ActionData[4409] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875309, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1072505}
	ActionsWindow.ActionData[4410] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875310, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameTid=1095010}
																																						
	-- 4450 -> 4499 :  WORKER'S TALISMAN																												
	ActionsWindow.ActionData[4450] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875450, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155108)}
	ActionsWindow.ActionData[4451] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875451, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155109)}
	ActionsWindow.ActionData[4452] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875452, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155110)}
	ActionsWindow.ActionData[4453] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875453, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155111)}
	ActionsWindow.ActionData[4454] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875454, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155112)}
	ActionsWindow.ActionData[4455] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875455, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155113)}
	ActionsWindow.ActionData[4456] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875456, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155114)}
	ActionsWindow.ActionData[4457] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875457, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155115)}
	ActionsWindow.ActionData[4458] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875458, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155116)}
	ActionsWindow.ActionData[4459] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875459, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155117)}
	ActionsWindow.ActionData[4460] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=875460, detailString=L"", editWindow="Equip", paramInfoTid=1078184, nameString=GetStringFromTid(1155118)}


	-- 5001 -> 5099 :  MENU ACTIONS
	ActionsWindow.ActionData[5001] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860001, detailString=L"", nameTid=1077438, callback=L"script Actions.ToggleMapWindow()" }
	ActionsWindow.ActionData[5002] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860002, detailString=L"", nameTid=1049755, callback=L"script Actions.ToggleMainMenu()" }
	ActionsWindow.ActionData[5003] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860003, detailString=L"", nameTid=1077440, callback=L"script Actions.ToggleQuestWindow()"}
	ActionsWindow.ActionData[5004] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860004, detailString=L"", nameTid=1077439, callback=L"script Actions.ToggleVirtuesWindow()"}
	ActionsWindow.ActionData[5005] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860005, detailString=L"", nameTid=1063308, callback=L"script Actions.ToggleGuildWindow()" }
	ActionsWindow.ActionData[5006] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860006, detailString=L"", nameTid=3000133, callback=L"script Actions.TogglePaperdollWindow()" }
	ActionsWindow.ActionData[5007] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860007, detailString=L"", nameTid=3000084, callback=L"script Actions.ToggleSkillsWindow()" }
	ActionsWindow.ActionData[5008] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860008, detailString=L"", nameTid=1114078, callback=L"script Actions.ToggleChatWindow()" }
	ActionsWindow.ActionData[5009] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860009, detailString=L"", nameTid=1077437, callback=L"script Actions.ToggleCharacterSheet()" }
	ActionsWindow.ActionData[5010] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860010, detailString=L"", nameTid=1112228, callback=L"script Actions.ToggleCharacterAbilities()" }
	ActionsWindow.ActionData[5011] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860011, detailString=L"", nameTid=1022482, callback=L"script Actions.ToggleInventoryWindow()" }
	ActionsWindow.ActionData[5013] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860013, detailString=L"", nameTid=1077814, callback=L"script Actions.ToggleUserSettings()" }
	ActionsWindow.ActionData[5014] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860014, detailString=L"", nameTid=1079812, callback=L"script Actions.ToggleActions()"}
	ActionsWindow.ActionData[5015] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860015, detailString=L"", nameTid=3000172, callback=L"script Actions.ToggleMacros()" }
	ActionsWindow.ActionData[5016] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860016, detailString=L"", nameTid=1061037, callback=L"script Actions.ToggleHelpWindow()" }
	ActionsWindow.ActionData[5017] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860017, detailString=L"", nameTid=1157353, callback=L"script Actions.ToggleUOStoreWindow()" }

	-- 5100 -> 5119 :  COMMUNICATION ACTIONS
	ActionsWindow.ActionData[5100]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855002, nameTid=1023083, detailString=GetStringFromTid(1154984), editWindow="Text", paramInfoTid=3002006, callback=L"Bank"}
	ActionsWindow.ActionData[5101]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855005, nameTid=1076893, detailString=GetStringFromTid(1154985), editWindow="Text", paramInfoTid=3002006, callback=L"Guards ! Help Me !!!"}
	ActionsWindow.ActionData[5102]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855008, nameString=GetStringFromTid(1154983), detailString=GetStringFromTid(1154986), editWindow="Text", paramInfoTid=3002006, callback=L"Vendor Buy"}
	ActionsWindow.ActionData[5103]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855011, nameString=GetStringFromTid(1154987), detailString=GetStringFromTid(1154988), editWindow="Text", paramInfoTid=3002006, callback=L"Vendor Sell"}
	ActionsWindow.ActionData[5104]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855014, nameString=L"Recsu", detailString=GetStringFromTid(1154990), editWindow="Text", paramInfoTid=3002006, callback=L"Recsu"}
	ActionsWindow.ActionData[5105]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855015, nameString=L"Recdu", detailString=L"Use this when standing on the pentagram in the Papua mage shop to reach Moonglow.", editWindow="Text", paramInfoTid=3002006, callback=L"Recdu"}
	ActionsWindow.ActionData[5106]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855016, nameString=GetStringFromTid(1154989), detailString=GetStringFromTid(1154991), editWindow="Text", paramInfoTid=3002006, callback=L"I must consider my sins"}
	ActionsWindow.ActionData[5107]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855003, nameString=GetStringFromTid(1112634), detailString=GetStringFromTid(1154992), editWindow="Text", paramInfoTid=3002006, callback=L"Balance"}
	ActionsWindow.ActionData[5108]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855017, nameString=GetStringFromTid(1154993), detailString=GetStringFromTid(1154994), editWindow="Text", paramInfoTid=3002006, callback=L"Ord"}
	ActionsWindow.ActionData[5109]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855018, nameString=GetStringFromTid(1154995), detailString=GetStringFromTid(1154996), editWindow="Text", paramInfoTid=3002006, callback=L"An Ord"}
	--ActionsWindow.ActionData[5110]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855019, nameString=L"I Honor Your Leadership", detailString=L"Use this to transfer your faction kill points to another faction member.", editWindow="Text", paramInfoTid=3002006, callback=L"I Honor Your Leadership"}
	--ActionsWindow.ActionData[5111]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855023, nameString=L"Punkte", detailString=L"This command return the number of your faction points.", editWindow="Text", paramInfoTid=3002006, callback=L"Punkte"}
	ActionsWindow.ActionData[5112]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=713, 	nameString=GetStringFromTid(1154999), detailString=GetStringFromTid(1155000), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Secure This"}
	ActionsWindow.ActionData[5113]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=714, 	nameString=GetStringFromTid(1155001), detailString=GetStringFromTid(1155002), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Release This"}
	ActionsWindow.ActionData[5114]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=715, 	nameString=GetStringFromTid(1155003), detailString=GetStringFromTid(1155004), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Lock This Down"}
	ActionsWindow.ActionData[5115]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855020, nameString=GetStringFromTid(1155005), detailString=GetStringFromTid(1155006), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Place A Trash Barrel"}
	ActionsWindow.ActionData[5116]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855022, nameString=L"News", detailString=L"Used near a barkeep or a town crier, will give a scenario hint.", editWindow="Text", paramInfoTid=3002006, callback=L"News"}
	ActionsWindow.ActionData[5117]  = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=855028, nameString=GetStringFromTid(1155261), detailString=GetStringFromTid(1155262), callback=L"script ContextMenu.RequestContextAction(TargetWindow.TargetId, ContextMenu.DefaultValues.BodRequest)"}
	ActionsWindow.ActionData[5118]  = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=855030, nameString=GetStringFromTid(1155267), detailString=GetStringFromTid(1155268), callback=L"script ContextMenu.RequestContextAction(TargetWindow.TargetId, ContextMenu.DefaultValues.Bribe)"}
	
	-- 5120 -> 5149 : PET COMMANDS
	ActionsWindow.ActionData[5120]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855012, nameString=GetStringFromTid(1154997), detailString=GetStringFromTid(1154998), editWindow="Text", paramInfoTid=3002006, callback=L"Stable"}
	ActionsWindow.ActionData[5121]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855013, nameString=L"Claim Pet", detailString=GetStringFromTid(1155008), editWindow="Text", paramInfoTid=3002006, callback=L"Claim Pet"}
	ActionsWindow.ActionData[5122]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855021, nameString=GetStringFromTid(1155007), detailString=L"Used in a stable, will report how many stable slots are occupied.", editWindow="Text", paramInfoTid=3002006, callback=L"Stablecount"}
	--ActionsWindow.ActionData[5123]  = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=855029, detailString=GetStringFromTid(1155429), nameString=GetStringFromTid(1155424),  callback=L"script Actions.AllRelease()" }
	
	-- 5150 -> 5169 : BOAT COMMANDS
	ActionsWindow.ActionData[5150] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00709, 	nameString=GetStringFromTid(1155011), detailString=GetStringFromTid(1155012), editWindow="Text", paramInfoTid=3002006, callback=L"Slow Forward" }
	ActionsWindow.ActionData[5151] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00711, 	nameString=GetStringFromTid(1155013), detailString=GetStringFromTid(1155014), editWindow="Text", paramInfoTid=3002006, callback=L"Forward One" }
	ActionsWindow.ActionData[5152] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00710, 	nameString=GetStringFromTid(1155015), detailString=GetStringFromTid(1155016), editWindow="Text", paramInfoTid=3002006, callback=L"Slow Back" }
	ActionsWindow.ActionData[5153] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00712, 	nameString=GetStringFromTid(1155017), detailString=GetStringFromTid(1155018), editWindow="Text", paramInfoTid=3002006, callback=L"Back One" }
	ActionsWindow.ActionData[5154] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855025, nameString=GetStringFromTid(1155019), detailString=GetStringFromTid(1155020), editWindow="Text", paramInfoTid=3002006, callback=L"Start Tracking" }
	ActionsWindow.ActionData[5155] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855026, nameString=L"Stop Tracking", detailString=L"Interrupt the ship tracking and remove the map markers.", editWindow="Text", paramInfoTid=3002006, callback=L"Stop Tracking" }
	ActionsWindow.ActionData[5156] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855027, detailString=GetStringFromTid(1155097), nameString=GetStringFromTid(1155096) }
	
	-- 5200 -> 5299 :  TARGETING ACTIONS
	ActionsWindow.ActionData[5200] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865006, detailString=GetStringFromTid(1155022), nameString=GetStringFromTid(1155021), callback=L"script Actions.PrevTarget()" }
	ActionsWindow.ActionData[5201] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865007, 	detailString=GetStringFromTid(1155024), nameString=GetStringFromTid(1155023),  callback=L"script Actions.NextTarget()" }
	ActionsWindow.ActionData[5202] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865008, 	detailString=GetStringFromTid(1155026), nameString=GetStringFromTid(1155025),  callback=L"script Actions.NearTarget()" }
	ActionsWindow.ActionData[5203] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865001, detailString=GetStringFromTid(1155028), nameString=GetStringFromTid(1155027),  callback=L"script Actions.InjuredFollower()" }
	ActionsWindow.ActionData[5204] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865002, detailString=GetStringFromTid(1155030), nameString=GetStringFromTid(1155029),  callback=L"script Actions.InjuredMobile()" }
	ActionsWindow.ActionData[5205] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865003, detailString=GetStringFromTid(1155032), nameString=GetStringFromTid(1155031),  callback=L"script Actions.InjuredParty()" }
	ActionsWindow.ActionData[5206] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865004, detailString=GetStringFromTid(1155034), nameString=GetStringFromTid(1155033),  callback=L"script Actions.TargetFirstContainerObject()" }
	ActionsWindow.ActionData[5207] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=865005, detailString=GetStringFromTid(1155036), nameString=GetStringFromTid(1155035)}
	
	-- 5300 -> 5350 :  PET TARGETING ACTIONS (STORE)
	ActionsWindow.ActionData[5301] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870000, detailString=ReplaceTokens(GetStringFromTid(1155038), {L"1"}), nameString=ReplaceTokens(GetStringFromTid(1155037), {L"1"}), callback=L"script Actions.TargetDefaultPet(1)" }
	ActionsWindow.ActionData[5302] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870001, detailString=ReplaceTokens(GetStringFromTid(1155038), {L"2"}), nameString=ReplaceTokens(GetStringFromTid(1155037), {L"2"}), callback=L"script Actions.TargetDefaultPet(2)" }
	ActionsWindow.ActionData[5303] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870002, detailString=ReplaceTokens(GetStringFromTid(1155038), {L"3"}), nameString=ReplaceTokens(GetStringFromTid(1155037), {L"3"}), callback=L"script Actions.TargetDefaultPet(3)" }
	ActionsWindow.ActionData[5304] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870003, detailString=ReplaceTokens(GetStringFromTid(1155038), {L"4"}), nameString=ReplaceTokens(GetStringFromTid(1155037), {L"4"}), callback=L"script Actions.TargetDefaultPet(4)" }
	ActionsWindow.ActionData[5305] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870004, detailString=ReplaceTokens(GetStringFromTid(1155038), {L"5"}), nameString=ReplaceTokens(GetStringFromTid(1155037), {L"5"}), callback=L"script Actions.TargetDefaultPet(5)" }
	
	-- 5351 -> 5399 :  PET TARGETING ACTIONS (TARGETING)
	ActionsWindow.ActionData[5351] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870050, detailString=ReplaceTokens(GetStringFromTid(1155040), {L"1"}), nameString=ReplaceTokens(GetStringFromTid(1155039), {L"1"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultPet1 )" }
	ActionsWindow.ActionData[5352] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870051, detailString=ReplaceTokens(GetStringFromTid(1155040), {L"2"}), nameString=ReplaceTokens(GetStringFromTid(1155039), {L"2"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultPet2 )" }
	ActionsWindow.ActionData[5353] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870052, detailString=ReplaceTokens(GetStringFromTid(1155040), {L"3"}), nameString=ReplaceTokens(GetStringFromTid(1155039), {L"3"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultPet3 )" }
	ActionsWindow.ActionData[5354] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870053, detailString=ReplaceTokens(GetStringFromTid(1155040), {L"4"}), nameString=ReplaceTokens(GetStringFromTid(1155039), {L"4"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultPet4 )" }
	ActionsWindow.ActionData[5355] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870054, detailString=ReplaceTokens(GetStringFromTid(1155040), {L"5"}), nameString=ReplaceTokens(GetStringFromTid(1155039), {L"5"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultPet5 )" }
	
	-- 5400 -> 5450 :  OBJECT TARGETING ACTIONS (STORE)
	ActionsWindow.ActionData[5400] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870100, detailString=ReplaceTokens(GetStringFromTid(1155042), {L"1"}), nameString=ReplaceTokens(GetStringFromTid(1155041), {L"1"}), callback=L"script Actions.TargetDefaultItem(1)" }
	ActionsWindow.ActionData[5401] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870101, detailString=ReplaceTokens(GetStringFromTid(1155042), {L"2"}), nameString=ReplaceTokens(GetStringFromTid(1155041), {L"2"}), callback=L"script Actions.TargetDefaultItem(2)" }
	ActionsWindow.ActionData[5402] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870102, detailString=ReplaceTokens(GetStringFromTid(1155042), {L"3"}), nameString=ReplaceTokens(GetStringFromTid(1155041), {L"3"}), callback=L"script Actions.TargetDefaultItem(3)" }
	ActionsWindow.ActionData[5403] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870103, detailString=ReplaceTokens(GetStringFromTid(1155042), {L"4"}), nameString=ReplaceTokens(GetStringFromTid(1155041), {L"4"}), callback=L"script Actions.TargetDefaultItem(4)" }
	ActionsWindow.ActionData[5404] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870104, detailString=ReplaceTokens(GetStringFromTid(1155042), {L"5"}), nameString=ReplaceTokens(GetStringFromTid(1155041), {L"5"}), callback=L"script Actions.TargetDefaultItem(5)" }

	-- 5451 -> 5499 :  OBJECT TARGETING ACTIONS (TARGETING)
	ActionsWindow.ActionData[5450] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870150, detailString=ReplaceTokens(GetStringFromTid(1155044), {L"1"}), nameString=ReplaceTokens(GetStringFromTid(1155043), {L"1"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultObject1 )" }
	ActionsWindow.ActionData[5451] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870151, detailString=ReplaceTokens(GetStringFromTid(1155044), {L"2"}), nameString=ReplaceTokens(GetStringFromTid(1155043), {L"2"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultObject2 )" }
	ActionsWindow.ActionData[5452] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870152, detailString=ReplaceTokens(GetStringFromTid(1155044), {L"3"}), nameString=ReplaceTokens(GetStringFromTid(1155043), {L"3"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultObject3 )" }
	ActionsWindow.ActionData[5453] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870153, detailString=ReplaceTokens(GetStringFromTid(1155044), {L"4"}), nameString=ReplaceTokens(GetStringFromTid(1155043), {L"4"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultObject4 )" }
	ActionsWindow.ActionData[5454] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870154, detailString=ReplaceTokens(GetStringFromTid(1155044), {L"5"}), nameString=ReplaceTokens(GetStringFromTid(1155043), {L"5"}), callback=L"script HandleSingleLeftClkTarget( Interface.DefaultObject5 )" }

	-- 5500 -> 5599 :  PETBALLS
	ActionsWindow.ActionData[5500] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870200, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155446) }
	ActionsWindow.ActionData[5501] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870201, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155447) }
	ActionsWindow.ActionData[5502] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870202, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155448) }
	ActionsWindow.ActionData[5503] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870203, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155449) }
	ActionsWindow.ActionData[5504] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870204, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155450) }
	ActionsWindow.ActionData[5505] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870205, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155451) }
	ActionsWindow.ActionData[5506] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870206, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155453) }
	ActionsWindow.ActionData[5507] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870207, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155454) }
	ActionsWindow.ActionData[5508] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870208, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155455) }
	ActionsWindow.ActionData[5509] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870209, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155456) }
	ActionsWindow.ActionData[5510] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870210, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155457) }
	ActionsWindow.ActionData[5511] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870211, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155458) }
	ActionsWindow.ActionData[5512] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870212, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155459) }
	ActionsWindow.ActionData[5513] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870213, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155460) }
	ActionsWindow.ActionData[5514] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870214, detailString=GetStringFromTid(1155045), nameString=GetStringFromTid(1155452) }

	-- 5600 -> 5699 :  MOUNTS
	ActionsWindow.ActionData[5600] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870300, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155046)}
	ActionsWindow.ActionData[5601] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870301, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155047)}
	ActionsWindow.ActionData[5602] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870302, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155048)}
	ActionsWindow.ActionData[5603] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870303, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155049)}
	ActionsWindow.ActionData[5604] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870304, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155050)}
	ActionsWindow.ActionData[5605] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870305, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155051)}
	ActionsWindow.ActionData[5606] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870306, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155052)}
	ActionsWindow.ActionData[5607] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870307, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155053)}
	ActionsWindow.ActionData[5608] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870308, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155054)}
	ActionsWindow.ActionData[5609] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870309, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155055)}
	ActionsWindow.ActionData[5610] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870310, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155056) }
	ActionsWindow.ActionData[5611] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870311, detailString=GetStringFromTid(1155058), nameString=GetStringFromTid(1155057) }
	
	-- 5700 -> 5719 :  CURSOR TARGETING
	ActionsWindow.ActionData[5700] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=00799, detailString=GetStringFromTid(1155062), nameString=GetStringFromTid(1155061),  callback=L"script HandleSingleLeftClkTarget(0)" }
	
	-- 5720 -> 5799 : OTHER
	ActionsWindow.ActionData[5720] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=724,	detailString=GetStringFromTid(1154928), nameString=GetStringFromTid(1154929), callback=L"script Actions.ToggleFoliage()" }
	ActionsWindow.ActionData[5721] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875100, detailTid=1115316, nameTid=3000469, callback=L"script Actions.IgnorePlayer()" }
	ActionsWindow.ActionData[5722] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875101, detailString=L"", nameString=GetStringFromTid(1155103),  callback=L"script Actions.ToggleLegacyContainers()" }
	ActionsWindow.ActionData[5724] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=729, 	detailString=L"", nameString=GetStringFromTid(1154930), callback=L"script Actions.ToggleSound()"}
	ActionsWindow.ActionData[5725] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=731, 	detailString=L"", nameString=GetStringFromTid(1155105), callback=L"script Actions.ToggleSoundEffects()"}
	ActionsWindow.ActionData[5726] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=730, 	detailString=L"", nameString=GetStringFromTid(1155106), callback=L"script Actions.ToggleMusic()"}
	ActionsWindow.ActionData[5727] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=732, 	detailString=L"", nameString=GetStringFromTid(1155107), callback=L"script Actions.ToggleFootsteps()"}
	ActionsWindow.ActionData[5728] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875104, detailString=GetStringFromTid(1115914), nameString=GetStringFromTid(1115913),  callback=L"script Actions.ToggleEnglishNames()" }
	ActionsWindow.ActionData[5729] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875103, detailString=GetStringFromTid(1155124), nameString=GetStringFromTid(1155123), callback=L"script Actions.ExportContainerItems()" }
	ActionsWindow.ActionData[5730] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875105, detailString=GetStringFromTid(1155127), nameString=GetStringFromTid(1155126),  callback=L"script Actions.CloseAllContainers()" }
	ActionsWindow.ActionData[5731] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875106, detailString=GetStringFromTid(1155129), nameString=GetStringFromTid(1155128),  callback=L"script Actions.CloseAllCorpses()" }
	ActionsWindow.ActionData[5732] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875107, detailString=GetStringFromTid(1155132), nameString=GetStringFromTid(1155131),  callback=L"script Actions.MassOrganizerStart()" }
	ActionsWindow.ActionData[5733] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875124, detailString=GetStringFromTid(1155230), nameString=L"Undress Agent",  callback=L"script Actions.UndressMe()" }
	
	ActionsWindow.ActionData[5735] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875110, nameString=GetStringFromTid(1155137),  callback=L"script MobileHealthBar.CloseAllHealthbars()" }
	ActionsWindow.ActionData[5736] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875111, detailString=GetStringFromTid(1155139), nameString=GetStringFromTid(1155138) }
	ActionsWindow.ActionData[5737] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875112, detailString=GetStringFromTid(1155141), nameString=GetStringFromTid(1155140),  callback=L"script Actions.DressHolding()" }
	ActionsWindow.ActionData[5738] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875113, detailString=GetStringFromTid(1155143), nameString=GetStringFromTid(1155142),  callback=L"script Actions.DropHolding()" }
	ActionsWindow.ActionData[5739] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875114, detailString=GetStringFromTid(1155151), nameString=GetStringFromTid(1155150),  callback=L"script Actions.ToggleTrapBox()" }
	ActionsWindow.ActionData[5740] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875115, detailString=GetStringFromTid(1155158), nameString=GetStringFromTid(1155157),  callback=L"script Actions.ToggleLootbag()" } 
	ActionsWindow.ActionData[5741] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875116, detailString=GetStringFromTid(1155163), nameString=GetStringFromTid(1155162),  callback=L"script Actions.ToggleAlphaMode()" }
	ActionsWindow.ActionData[5742] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875117, detailString=GetStringFromTid(1155165), nameString=GetStringFromTid(1155164),  callback=L"script Actions.ToggleScaleMode()" }
	ActionsWindow.ActionData[5743] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=718,	detailString=GetStringFromTid(1155168), nameString=L"Switch Object Handle", callback=L"script Actions.ObjectHandleContextMenu()" }
	ActionsWindow.ActionData[5744] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875118, detailString=GetStringFromTid(1155174), nameString=GetStringFromTid(1155173),  callback=L"script Actions.GetHealthbar()" }
	ActionsWindow.ActionData[5745] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875119, detailString=GetStringFromTid(1155178), nameString=GetStringFromTid(1155177),  callback=L"script Actions.GetTypeID()" }
	ActionsWindow.ActionData[5746] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875120, detailString=GetStringFromTid(1155180), nameString=GetStringFromTid(1155179),  callback=L"script Actions.GetHueID()" }
	ActionsWindow.ActionData[5747] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875121, detailString=GetStringFromTid(1155218), nameString=GetStringFromTid(1155219),  callback=L"script Actions.IgnoreTargettedItem()" }
	ActionsWindow.ActionData[5748] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875122, detailString=GetStringFromTid(1155222), nameString=GetStringFromTid(1155223),  callback=L"script Actions.ClearIgnoreList()" }

	-- 5800 -> 5850 : BARD'S SUPER SLAYER
	ActionsWindow.ActionData[5800] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875350, detailString=GetStringFromTid(1155461), nameTid=1079747 }
	ActionsWindow.ActionData[5801] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875351, detailString=GetStringFromTid(1155461), nameTid=1079748 }
	ActionsWindow.ActionData[5802] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875352, detailString=GetStringFromTid(1155461), nameTid=1079749 }
	ActionsWindow.ActionData[5803] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875353, detailString=GetStringFromTid(1155461), nameTid=1070855 }
	ActionsWindow.ActionData[5804] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875354, detailString=GetStringFromTid(1155461), nameTid=1079750 }
	ActionsWindow.ActionData[5805] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875355, detailString=GetStringFromTid(1155461), nameTid=1079751 }
	ActionsWindow.ActionData[5806] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875356, detailString=GetStringFromTid(1155461), nameTid=1079752 }
	
	-- 5850 -> 5899 : BARD'S SLAYER
	ActionsWindow.ActionData[5850] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875400, detailString=GetStringFromTid(1155461), nameTid=1079743}
	ActionsWindow.ActionData[5851] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875401, detailString=GetStringFromTid(1155461), nameTid=1079746}
	ActionsWindow.ActionData[5852] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875402, detailString=GetStringFromTid(1155461), nameTid=1079753}
	ActionsWindow.ActionData[5853] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875403, detailString=GetStringFromTid(1155461), nameTid=1079737}
	ActionsWindow.ActionData[5854] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875404, detailString=GetStringFromTid(1155461), nameTid=1079733}
	ActionsWindow.ActionData[5855] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875405, detailString=GetStringFromTid(1155461), nameTid=1079734}
	ActionsWindow.ActionData[5856] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875406, detailString=GetStringFromTid(1155461), nameTid=1079735}
	ActionsWindow.ActionData[5857] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875407, detailString=GetStringFromTid(1155461), nameTid=1079736}
	ActionsWindow.ActionData[5858] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875408, detailString=GetStringFromTid(1155461), nameTid=1079742}
	ActionsWindow.ActionData[5859] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875409, detailString=GetStringFromTid(1155461), nameTid=1079745}
	ActionsWindow.ActionData[5860] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875410, detailString=GetStringFromTid(1155461), nameTid=1079755}
	ActionsWindow.ActionData[5861] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875411, detailString=GetStringFromTid(1155461), nameTid=1079741}
	ActionsWindow.ActionData[5862] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875412, detailString=GetStringFromTid(1155461), nameTid=1079739}
	ActionsWindow.ActionData[5863] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875413, detailString=GetStringFromTid(1155461), nameTid=1079754}
	ActionsWindow.ActionData[5864] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875414, detailString=GetStringFromTid(1155461), nameTid=1061284}
	ActionsWindow.ActionData[5865] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875415, detailString=GetStringFromTid(1155461), nameTid=1079738}
	ActionsWindow.ActionData[5866] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875416, detailString=GetStringFromTid(1155461), nameTid=1079740}
	ActionsWindow.ActionData[5867] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875417, detailString=GetStringFromTid(1155461), nameTid=1079744}
					
	-- 5900 -> 5949 :  PLAYER CONTEXT MENU
	ActionsWindow.ActionData[5900] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875500, detailString=L"", nameTid=1113797,  callback=L"script Actions.EnablePVPWarning()" }
	ActionsWindow.ActionData[5901] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875501, detailString=L"", nameTid=3006205,  callback=L"script Actions.ReleaseCoownership()" }
	ActionsWindow.ActionData[5902] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875502, detailString=L"", nameTid=3006207,  callback=L"script Actions.LeaveHouse()" }
	ActionsWindow.ActionData[5903] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875503, detailString=L"", nameTid=3006156,  callback=L"script Actions.QuestConversation()" }
	ActionsWindow.ActionData[5904] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875504, detailString=L"", nameTid=3006154,  callback=L"script Actions.ViewQuestLog()" }
	ActionsWindow.ActionData[5905] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875505, detailString=L"", nameTid=3006155,  callback=L"script Actions.CancelQuest()" }
	ActionsWindow.ActionData[5906] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875506, detailString=L"", nameTid=3006169,  callback=L"script Actions.QuestItem()" }
	ActionsWindow.ActionData[5907] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875507, detailString=L"", nameTid=1114299,  callback=L"script Actions.InsuranceMenu()" }
	ActionsWindow.ActionData[5908] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875508, detailString=L"", nameTid=3006201,  callback=L"script Actions.ToggleItemInsurance()" }
	ActionsWindow.ActionData[5909] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875509, detailString=L"", nameTid=1115022,  callback=L"script Actions.TitlesMenu()" }
	ActionsWindow.ActionData[5910] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875510, detailString=L"", nameTid=1049594,  callback=L"script Actions.LoyaltyRating()" }
	ActionsWindow.ActionData[5911] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875511, detailString=L"", nameTid=3006157,  callback=L"script Actions.CancelProtection()" }																													
	ActionsWindow.ActionData[5912] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875512, detailString=L"", nameTid=1152531,  callback=L"script Actions.VoidPool()" }
	ActionsWindow.ActionData[5913] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875513, detailString=GetStringFromTid(1155122), nameString=GetStringFromTid(1155121),  callback=L"script Actions.ToggleTrades()" }
	ActionsWindow.ActionData[5914] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow=true, iconId=875514, detailString=L"", nameTid=3006168,  callback=L"script Actions.SiegeBlessItem()" }
	
	-- 5950 -> 5999 :  ITEMS/ABILITIES
	ActionsWindow.ActionData[5950] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=875600, detailString=GetStringFromTid(1155134), nameString=GetStringFromTid(1155133),  callback=L"script Actions.LoadShuri()" }
	
	-- 6000 -> 6100 :  CRAFTING UTILITIES
	ActionsWindow.ActionData[6000] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876001, detailString=GetStringFromTid(1155374), nameString=GetStringFromTid(1155373),  callback=L"script Actions.UnravelItem()" }
	ActionsWindow.ActionData[6001] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876000, detailString=GetStringFromTid(1155376), nameString=GetStringFromTid(1155375),  callback=L"script Actions.ImbueLast()" }
	ActionsWindow.ActionData[6002] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876002, detailString=GetStringFromTid(1155377), nameString=FormatProperly(GetStringFromTid(1094726 )),  callback=L"script Actions.AlterItem()" }
	ActionsWindow.ActionData[6003] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876003, detailString=GetStringFromTid(1155378), nameString=FormatProperly(GetStringFromTid(1061001 )),  callback=L"script Actions.EnhanceItem()" }
	ActionsWindow.ActionData[6004] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876004, detailString=GetStringFromTid(1155379), nameString=FormatProperly(GetStringFromTid(1044015 )),  callback=L"script Actions.RepairItem()" }
	ActionsWindow.ActionData[6005] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876005, detailString=GetStringFromTid(1155380), nameString=FormatProperly(GetStringFromTid(1044016 )),  callback=L"script Actions.SmeltItem()" }
	ActionsWindow.ActionData[6006] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=876006, detailString=GetStringFromTid(1155381), nameString=FormatProperly(GetStringFromTid(1044013)),  callback=L"script Actions.MakeLast()" }
	
																																		
	-- This table is used to define the different catagories of actions, so they don't have to all show up in one list					
	-- nameString can be removed once you localize them all - it was just for testing that the strings will fit
	-- nameTid will overpower nameString
	-- I'm not going to bother to localize them until I get offical groups from design
	ActionsWindow.Groups = {}
	
	ActionsWindow.Groups[1]  = { nameString=L"Items/Abilities",			nameTid=1079384, index={ 8, 9, 10, 26, 86, 87, 5950 } }
	ActionsWindow.Groups[2]  = { nameString=L"Combat",					nameTid=1077417, index={ 27, 28, 67, 68 } }
	ActionsWindow.Groups[3]  = { nameString=L"Virtues",					nameTid=1077439, index={ 58, 59, 60, 61, 62, 63, 64, 65 } }
	ActionsWindow.Groups[4]  = { nameString=L"Equipment",				nameTid=1154982, index={ 1, 2, 85, 4100, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4120, 4121, 4122, 4123, 4124, 4125, 4126, 4127, 4128, 4129, 4130, 4131, 4132, 4133, 4134, 4135, 4136 } }
	ActionsWindow.Groups[5]  = { nameString=L"Cursor Targeting",		nameTid=1094876, index={ 17, 19, 20, 21, 56, 66, 90, 5700 } }
	ActionsWindow.Groups[6]  = { nameString=L"Targeting",				nameTid=1079383, index={ 55, 22, 71, 77, 23, 72, 78, 24, 73, 79, 69, 74, 80, 70, 75, 81, 25, 76, 82, 11, 5200, 5201, 5202, 5203, 5204, 5205, 5206, 5207 } }
	ActionsWindow.Groups[7]  = { nameString=L"Pet Targeting",			nameTid=1154968, index={ 5351, 5301, 5352, 5302, 5353, 5303, 5354, 5304, 5355, 5305 } }
	ActionsWindow.Groups[8]  = { nameString=GetStringFromTid(1155462),						 index={ 5400, 5450, 5401, 5451, 5402, 5452, 5403, 5453, 5404, 5454 } }
	ActionsWindow.Groups[9]  = { nameString=L"Petballs",				nameTid=1154980, index={ 5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, 5508, 5509, 5510, 5511, 5512, 5513, 5514 } }
	ActionsWindow.Groups[10] = { nameString=L"Mounts",					nameTid=1154981, index={ 91, 5600, 5601, 5602, 5603, 5604, 5605, 5606, 5607, 5608, 5609, 5610, 5611 } }
	ActionsWindow.Groups[11] = { nameString=L"Pet Commands",			nameTid=1079385, index={ 5120, 5121, 5122, 29, 30, 31, 32, 34, 35, 36, 5123  } }
	ActionsWindow.Groups[12] = { nameString=L"Boat Commands",			nameTid=1079386, index={ 5156, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 53, 54, 5150, 5151, 5152, 5153, 5154, 5155 } }
	ActionsWindow.Groups[13] = { nameString=L"Cannons",					nameTid=1116354, index={ 4000, 4001, 4002, 4003, 4004, 4005, 4006, 4007, 4008 } }
	ActionsWindow.Groups[14] = { nameString=L"Communication",			nameTid=1094744, index={ 5100, 5107, 5101, 5116, 5102, 5103, 5104, 5105, 5108, 5109, 5111, 5110, 5106, 5112, 5113, 5114, 5115, 4, 5, 6, 7, 12, 13, 5117, 5118 } }
	ActionsWindow.Groups[15] = { nameString=L"Other",					nameTid=1044294, index={ 15, 14, 16, 83, 84, 57, 5720, 5721, 5722, 5723, 5724, 5725, 5726, 5727, 5728, 5729, 5730, 5731, 5732, 5733, 5735, 5736, 5737, 5738, 5739, 5740, 5741, 5742, 5743, 5744, 5745, 5746, 5747, 5748, 5749 } }
	ActionsWindow.Groups[16] = { nameString=L"Menu Actions",			nameTid=1154979, index={ 5001, 5002, 5003, 5004, 5005, 5006, 89, 5007, 88, 5008, 5009, 5010, 5011, 5012, 5013, 3, 5014, 5015, 5016, 5017 } }
	ActionsWindow.Groups[17] = { nameString=GetStringFromTid(1155463),							 index={ 4300, 4301, 4302, 4303, 4304, 4305, 4306 } }
	ActionsWindow.Groups[18] = { nameString=GetStringFromTid(1155464),							 index={ 4350, 4351, 4352, 4353, 4354, 4355, 4356, 4357, 4358, 4359, 4360, 4361, 4362, 4363, 4364, 4365, 4366, 4367, 4368, 4369 } }
	ActionsWindow.Groups[19] = { nameString=GetStringFromTid(1155465),						 index={ 4400, 4401, 4402, 4403, 4404, 4405, 4406, 4407, 4408, 4409, 4410 } }
	ActionsWindow.Groups[20] = { nameString=GetStringFromTid(1155466),						 index={ 4450, 4451, 4452, 4453, 4454, 4455, 4456, 4457, 4458, 4459, 4460 } } 
	ActionsWindow.Groups[21] = { nameString=GetStringFromTid(1155467),					 index={ 5800, 5801, 5802, 5803, 5804, 5805, 5806 } } 
	ActionsWindow.Groups[22] = { nameString=GetStringFromTid(1155468),							 index={ 5850, 5851, 5852, 5853, 5854, 5855, 5856, 5857, 5858, 5859, 5860, 5861, 5862, 5863, 5864, 5865, 5866, 5867 } } 
	ActionsWindow.Groups[23] = { nameString=GetStringFromTid(1155372),						 index={ 6000, 6001, 6002, 6003, 6004, 6005, 6006 } } 
	ActionsWindow.Groups[24] = { nameString=GetStringFromTid(1155120),						 index={ 5900, 5901, 5902, 5903, 5904, 5905, 5906, 5907, 5908, 5909, 5910, 5911, 5912, 5913, 5914 } } 
end

ActionsWindow.OFFSET_FROM_TOP = 50
ActionsWindow.OFFSET_FROM_BOTTOM = 10
ActionsWindow.SIDE_OFFSET = 10
ActionsWindow.ITEM_WIDTH = 50
ActionsWindow.ITEM_HEIGHT = 50

ActionsWindow.CurrentGroup = 1

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ActionsWindow.Initialize()
    ActionsWindow.InitActionData()
    Interface.OnCloseCallBack["ActionsWindow"] = ActionsWindow.OnClose

	
	local groupItr
	local group
	local itemItr
	local actionIndex
	local actionData
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		

			if( actionData and actionData.inActionWindow == true ) then
				local scrollChild = "ActionsWindowListScrollChild"
				local windowName = scrollChild.."Group"..groupItr.."Row"..rowIndex			
				CreateWindowFromTemplate(windowName, "ActionItemDef", scrollChild)
				WindowSetId(windowName.."Button", actionIndex )
				local texture, x, y = GetIconData( actionData.iconId )
				DynamicImageSetTexture( windowName.."ButtonSquareIcon", texture, x, y )
				
				DynamicImageSetTexture( windowName.."ButtonSquareIconBG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
				if (actionData.type ~= 1000) then
					if( UserActionIsActionTypeTargetModeCompat(actionData.type) ) then
						WindowSetShowing(windowName.."ButtonDisabled", false)
						LabelSetTextColor( windowName.."Name", 255, 255, 255 )
					else
						WindowSetShowing(windowName.."ButtonDisabled", true)
						LabelSetTextColor( windowName.."Name", 128, 128, 128 )
					end
				else
					WindowSetShowing(windowName.."ButtonDisabled", false)
					LabelSetTextColor( windowName.."Name", 255, 255, 255 )
				end
				if (actionData.nameTid) then
					LabelSetText( windowName.."Name", FormatProperly(GetStringFromTid(actionData.nameTid)) )
				else
					LabelSetText( windowName.."Name", actionData.nameString )
				end
				if( rowIndex == 1 ) then
					WindowAddAnchor(windowName,"topleft",scrollChild,"topleft",0,0)
				else
					local relativeTo = scrollChild.."Group"..groupItr.."Row"..(rowIndex-1)
					WindowAddAnchor(windowName,"bottomleft",relativeTo,"topleft",0,0)
				end
				rowIndex = rowIndex + 1
			end
		end	
	end
	ActionsWindow.RefreshList(0)	
	WindowUtils.SetWindowTitle("ActionsWindow",GetStringFromTid(1079812))
	WindowUtils.RestoreWindowPosition("ActionsWindow")	
end

function ActionsWindow.Shutdown()
	WindowUtils.SaveWindowPosition("ActionsWindow")
end

function ActionsWindow.CustomEdit(actionId)
	local rtn = actionId >= 5000 -- custom action starting range
	rtn = rtn or (actionId == 50 or actionId == 53 or actionId == 54) -- stop, start, continue
	return rtn
end

function ActionsWindow.RefreshList(modifier)
	ActionsWindow.UpdateCurrentGroup(modifier)
	ActionsWindow.SetGroupLabel()
	ActionsWindow.HideAllGroups()
	ActionsWindow.ShowActiveGroup()
	ScrollWindowSetOffset( "ActionsWindowList", 0 )
	ScrollWindowUpdateScrollRect("ActionsWindowList")
end

function ActionsWindow.SetGroupLabel()
	if ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid
	and ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid ~= 0
	then
		LabelSetText( "ActionsWindowTopArrowsText", GetStringFromTid( ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid ) )
	else
		if ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameString
		then
			LabelSetText( "ActionsWindowTopArrowsText", ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameString )
		else
			LabelSetText( "ActionsWindowTopArrowsText", L""..ActionsWindow.CurrentGroup )
		end
	end
end

function ActionsWindow.ItemLButtonDown(flags)
	local index = WindowGetId(SystemData.ActiveWindow.name)	
	local actionData = ActionsWindow.ActionData[index]
	local actionId = 0
	
	if not (index < 4000 and index ~= 53 and index ~= 54 and index ~= 50) then
		actionId = index
	end
	if (actionData.type == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then
		actionId = actionData.invokeId
	end

	if flags == SystemData.ButtonFlags.CONTROL then
		local blockBar = HotbarSystem.GetNextHotbarId()
		Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
		HotbarSystem.SpawnNewHotbar()
		
		HotbarSystem.SetActionOnHotbar(actionData.type, actionId, actionData.iconId, blockBar,  1)
		
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
		DragSlotSetActionMouseClickData(actionData.type, actionId, actionData.iconId)
	end
end

function ActionsWindow.ItemMouseOver()
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local actionData = ActionsWindow.ActionData[index]
	
	if(actionData.type == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then
		index = actionData.invokeId
	end
	local name = L""
	if (actionData.nameTid) then
		name = FormatProperly(GetStringFromTid(actionData.nameTid))
	else
		name = actionData.nameString
	end

	local desc = L""
	if (actionData.detailTid) then
		desc = GetStringFromTid(actionData.detailTid)
	else
		desc = actionData.detailString
	end
	local itemData
	
	if (index < 4000 and index ~= 53 and index ~= 54 and index ~= 50) then
	
		itemData =
		{
			windowName = "ActionsWindow",
			itemId = index,
			actionType = actionData.type,
			detail = ItemProperties.DETAIL_LONG,
			itemType = WindowData.ItemProperties.TYPE_ACTION,
			title =	name,
			body = desc
		}	
	elseif (index==5011) then
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
		if backpackId ~= 0 then
			itemData = {
				windowName = dialog,
				itemId = backpackId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
			}
			ItemProperties.SetActiveItem(itemData)
		end
	else
		
			itemData =
		{
			windowName = "ActionsWindow",
			itemId = index,
			detail = ItemProperties.DETAIL_LONG,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			title =	name,
			body = desc
		}	
	end				
	ItemProperties.SetActiveItem(itemData)	
end

function ActionsWindow.GetActionDataForType(actionType)
	for index, actionData in pairs(ActionsWindow.ActionData) do
		if( actionData.type == actionType ) then
			return actionData
		end
	end
end
function ActionsWindow.GetActionDataForID( actionId)
	for index, actionData in pairs(ActionsWindow.ActionData) do
		if( index == actionId ) then
			return actionData
		end
	end
end

function ActionsWindow.LeftArrowPressed()
	ActionsWindow.RefreshList(-1)
end

function ActionsWindow.RightArrowPressed()
	ActionsWindow.RefreshList(1)
end

function ActionsWindow.UpdateCurrentGroup(modifier)
	ActionsWindow.CurrentGroup = ActionsWindow.CurrentGroup + modifier
	
	if ( not ActionsWindow.CurrentGroup ) or ( ActionsWindow.CurrentGroup > #ActionsWindow.Groups ) then
		ActionsWindow.CurrentGroup = 1
	end
	
	if ( ActionsWindow.CurrentGroup < 1 ) then
		ActionsWindow.CurrentGroup = #ActionsWindow.Groups
	end
	Interface.SaveNumber("ActionsWindowCurrentGroup", ActionsWindow.CurrentGroup)
end

function ActionsWindow.HideAllGroups()
	local groupItr
	local group
	local itemItr
	local actionIndex
	local actionData
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		
			if( actionData and actionData.inActionWindow == true ) then
				local windowName = "ActionsWindowListScrollChildGroup"..groupItr.."Row"..rowIndex			
				WindowSetShowing( windowName, false )
				WindowClearAnchors( windowName )
				rowIndex = rowIndex + 1
			end
		end	
	end
end

function ActionsWindow.ShowActiveGroup()
	local itemItr
	local actionIndex
	local actionData
	local rowIndex = 1
	for itemItr, actionIndex in pairs(ActionsWindow.Groups[ActionsWindow.CurrentGroup].index) do	
		actionData = ActionsWindow.ActionData[actionIndex]		
		if( actionData and actionData.inActionWindow == true ) then
			local windowName = "ActionsWindowListScrollChildGroup"..ActionsWindow.CurrentGroup.."Row"..rowIndex			
			WindowSetShowing( windowName, true )
			WindowClearAnchors( windowName )
			if itemItr == 1 then
				WindowAddAnchor( windowName, "topleft", "ActionsWindowListScrollChild", "topleft", 0, 0 ) 
			else
				WindowAddAnchor( windowName, "bottomleft", "ActionsWindowListScrollChildGroup"..ActionsWindow.CurrentGroup.."Row"..(rowIndex-1), "topleft", 0, 0 )
			end
			rowIndex = rowIndex + 1
		end
	end
end

function ActionsWindow.Context()
	for i=1, table.getn(ActionsWindow.Groups) do
		local name = ""
		if (ActionsWindow.Groups[i].nameTid) then
			name = GetStringFromTid(ActionsWindow.Groups[i].nameTid)
		else
			name = ActionsWindow.Groups[i].nameString
		end
		ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,ActionsWindow.CurrentGroup== i)
	end
	ContextMenu.ActivateLuaContextMenu(ActionsWindow.ContextMenuCallback)
end

function ActionsWindow.ContextMenuCallback( returnCode, param )
	ActionsWindow.CurrentGroup=returnCode
	ActionsWindow.RefreshList(0)
end


function ActionsWindow.ContextTooltip()

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154966))
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ActionsWindow.GetIdByType(type)
	if not ActionsWindow.isAction(type) then
		return
	end
	for i = 1, ActionsWindow.DefaultTypes do
		if ActionsWindow.ActionData[i].type == type then
			return i
		end
	end
end

function ActionsWindow.isAction(type)
	if type ~= SystemData.UserAction.TYPE_SKILL and type ~= SystemData.UserAction.TYPE_SPELL and type ~= SystemData.UserAction.TYPE_WEAPON_ABILITY and type ~= SystemData.UserAction.TYPE_USE_ITEM and type ~= SystemData.UserAction.TYPE_USE_OBJECTTYPE and type ~= SystemData.UserAction.TYPE_PLAYER_STATS then
		return true
	end
	return false
end
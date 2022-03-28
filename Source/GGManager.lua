
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


GGManager = 
{
	NumOfGumps = 0,
	
	-- map of windowNames to dynamic windowData
	knownWindows = { },
	
	-- functions to be called before creating the window
	-- templates can register a function by callig GGManager.registerOnCreateCallback() during static initialization 
	--
	-- if the callback returns TRUE then a new window will not be created
	-- this can be used to avoid opening a window if it's already open
	--
	onCreateCallback = {},
}



----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


GGManager.DISPLAY_GUMPNOTFOUND = false
--GGManager.DISPLAY_GUMPNOTFOUND = true

--GGManager.ASK_BETA_TESTERS_FOR_HELP = false
GGManager.ASK_BETA_TESTERS_FOR_HELP = true

--GGManager.TELL_BETA_TESTERS_WE_KNOW = false
GGManager.TELL_BETA_TESTERS_WE_KNOW = true


--constrants for Text IDs for localized strings
-- BE SURE TO CALL GGManager.translateTID() ON THESE WHEN YOU USE THEM
GGManager.OKAY_TID   = 1011036
GGManager.CANCEL_TID = 1011012
GGManager.ACCEPT_TID = 1013076
GGManager.REFUSE_TID = 1013077
GGManager.RESIGN_TID = 3006115
GGManager.QUIT_TID   = 3000100
GGManager.CLOSE_TID	 = 1060675
GGManager.BACK_TID	 = 1011447

-- constant to be returned from  back from a
--
GGManager.NEW_GUMP_HAS_BEEN_HANDLED = true

-- constants to be passed to GGManager.destroyWindow or GGManager.destroyActiveWindow
--
GGManager.DELETE_DATA = true
GGManager.DONT_DELETE_DATA_YET = false


----------------------------------------------------------------
-- Generic Gump Manager Functions
----------------------------------------------------------------

function GGManager.Initialize()
	WindowRegisterEventHandler( "Root", SystemData.Events.GG_ARRIVED, "GGManager.GGArrived")
	WindowRegisterEventHandler( "Root", SystemData.Events.GG_CLOSE, "GGManager.GGClose")
	WindowRegisterEventHandler( "Root", SystemData.Events.GG_DATA_READY, "GGManager.GGParseData")
	GGManager.WindowName = {}
	GGManager.GumpName = {}
	
	GGManager.WindowPositionGroup = {}
	
	----------------------------------------------------------------------------------------------------
	--      KNOWN BROKEN GUMPS - ONES THAT PLAYERS ARE BEING TOLD NOT TO REPORT! FIX THESE ASAP!      --
	-- ANY GUMP NOT LISTED HERE AS A KNOWN BROKEN ONE WILL GENERATE LOTS OF BUG REPORTS FROM PLAYERS! --
	----------------------------------------------------------------------------------------------------	
	-- Format: GGManager.WindowName[_NUMBER_] = "KnownBrokenGump" -- "_NAME_"

	-- END KNOWN BROKEN GUMPS --------------------------------------------------------------------------
	
	--------------------------------------------
	-- KNOWN FIXED - AWAITING A SERVER UPDATE --
	--------------------------------------------
	-- Turn these ones on once a server update has gone out.
	
	-- END KNOWN FIXED -------------------------
	
	---------------------------------------------------------------------
	-- NOT NEEDED GUMPS - BETA TESTERS ARE BEING TOLD TO REPORT THESE! --
	---------------------------------------------------------------------	
	-- These should all be commented out!
	-- If QA ever reports that "Gump #_ is broken.", where _ is a number in this list, then that one needs fixing for KR.
	-- If, after a suitable amount of time has passed, no one has reported these as missing, you may just want to switch them all over so they point at "DO_NOT_DISPLAY"
	--GGManager.WindowName[10000]	= "GUMP_GENERATOR_PUZZLE" -- No longer used, per Tim
	--GGManager.WindowName[10004]	= "GUMP_CONTROL_DEVICE" -- No longer used, per Tim
	--GGManager.WindowName[999048]	= "GUMP_INVOKE_GOOD" -- Testing for deprication, as nothing appears to link into this script.
	--GGManager.WindowName[999049]	= "GUMP_INVOKE_EVIL" -- Testing for deprication, as nothing appears to link into this script.
	--GGManager.WindowName[0]		= "DO_NOT_DISPLAY" -- Because GID 0 shouldn't really be used for ANYTHING. Shame it is being used below
	-- Jason claims the the 0 being used below is out of date!
	-- Ticket gumps aren't needed in KR, so says Tim
	--GGManager.WindowName[999029]	= "KnownBrokenGump" -- "GUMP_TICKET_GUMP_ZERO"
	--GGManager.WindowName[999030]	= "KnownBrokenGump" -- "GUMP_TICKET_GUMP_ONE"
	--GGManager.WindowName[999031]	= "KnownBrokenGump" -- "GUMP_TICKET_GUMP_TWO"
	--GGManager.WindowName[999032]	= "KnownBrokenGump" -- "GUMP_TICKET_GUMP_THREE"
	--GGManager.WindowName[999033]	= "KnownBrokenGump" -- "GUMP_TICKET_GUMP_FOUR"
	--GGManager.WindowName[24811]	= "KnownBrokenGump" -- "GUMP_PLANT_GM_MENU" -- Used by GMs only, it would seem. Might need implementing if GMs complain about/report it.
	-- I don't think the KR plant gump has the AGM button appearing on it even, so they may never report this. I'll have to check.
	-- END NOT NEEDED GUMPS ---------------------------------------------

	-- Welcome to the Corey Zone
	GGManager.WindowName[90009]			= "FACTION_HORSEVENDOR"
	GGManager.WindowName[4294967296]	= "FACTION_ITEM"
	GGManager.WindowName[400]			= "FACTION_MASTERSTONE"
	GGManager.WindowName[9000]			= "FACTION_FACTIONSTONE"
	GGManager.WindowName[305]			= "FACTION_SHERIFF"
	GGManager.WindowName[306]			= "FACTION_FINANCE"
	GGManager.WindowName[29842]			= "GUMP_PLANT"
	GGManager.WindowName[29582]			= "GUMP_EMPTYBOWL"
	GGManager.WindowName[22222]			= "GUMP_PLANTREPRODUCTION"
	GGManager.WindowName[42422]			= "masterTwoButton"
	GGManager.WindowName[650]			= "FACTION_VOTE"			-- GUMP_FACTION_VOTE
	GGManager.WindowName[651]			= "FACTION_ELECTION"		-- GUMP_FACTION_ELECTION	
	GGManager.WindowName[660]			= "GUMP_FORTUNE_OFFER"		-- GUMP_FORTUNE_TELLER_OFFER    (Sphinx)
	GGManager.WindowName[9045]			= "GUMP_FORTUNE_TELLER"		-- GUMP_FORTUNE_TELLER_QUESTION (Attendant Fortune Teller)
	GGManager.WindowName[9046]			= "GUMP_FORTUNE"			-- GUMP_FORTUNE_TELLER_FORTUNE  (Attendant Fortune Teller)
	GGManager.WindowName[17000]			= "GUMP_COMCOLLECTION"		-- GUMP_COMCOLLECTION_BASE
	GGManager.WindowName[17001]			= "GUMP_CONFIRMPIC"			-- GUMP_COMCOLLECTION_REWARD_CONFIRM
	-- Thank you for visiting the Corey Zone
	
	-- *** TODO: should find a better way to map Gump IDs to Window names that can stay in sync with the server
	GGManager.WindowName[0] = "GG_Test_Center_Info_0" --"TwoButtonDialog" Several gumpid = 0 can use twobuttonDialog in the future
	GGManager.WindowName[999002] = "GG_Test_Center_Info_0" -- "OneButtonDialog" (not generic - uses StringData)
	GGManager.WindowName[999005] = "OneButtonDialog" -- "GUMP_NOTICE_GUMP"

	GGManager.WindowName[9030] = "TwoButtonDialog_Short" -- Confirmation gump for promo tokens
	
	--GGManager.WindowName[9012] = "GUMP_ANIMAL_FORM" -- should be handled by GUMP_CHOOSE_FORM or GUMP_CHOICE_ICONS now

	GGManager.WindowName[999034] = "GUMP_HOLIDAY_TREE_PLACEMENT"
	GGManager.WindowName[999023] = "GUMP_HAIR_STYLE_COUPON"
	GGManager.WindowName[9051] = "GUMP_STATUE_MAKER"
	GGManager.WindowName[18001]	= "GUMP_AQUARIUM_CONTENTS"
	GGManager.WindowName[9052] = "GUMP_STATUE_PLINTH_PLAQUE"
	GGManager.WindowName[10017] = "GUMP_WARNING_SACRIFICE"
	GGManager.WindowName[9008] = "GUMP_HOUSE_BULLETINBOARD"
	GGManager.WindowName[999018] = "GUMP_THIEF_DISGUISE_KIT"
	GGManager.WindowName[999020] = "GUMP_TEST_GUMP"
	GGManager.WindowName[681] = "GUMP_RENTAL_CONTRACT"
	GGManager.WindowName[453] = "GUMP_VR_SELECT"
	GGManager.WindowName[683] = "GUMP_VENDORBARBIE_MAIN"
	GGManager.WindowName[200001] = "GUMP_TRANSFER_SHARD_LIST"
	GGManager.WindowName[999013] = "GUMP_TRANSFER_INFO"
	GGManager.WindowName[100001] = "GUMP_TRANSFER_WARNING"
	GGManager.WindowName[675] = "GUMP_PROMO_7TH_CONFIRM"
	GGManager.WindowName[452] = "TwoButtonDialog_Short" --"GUMP_VR_PROMPT"
	GGManager.WindowName[454] = "GUMP_VR_CONFIRM"
	GGManager.WindowName[9013] = "TwoButtonDialog_Short" --"GUMP_PROMO_TOKEN_CONFIRM"
	GGManager.WindowName[679] = "GUMP_PROMO_NAMECHANGE_CONFIRM"
	GGManager.WindowName[300001] = "GUMP_TRANSFER_DISPLAY_ITEMS"
	GGManager.WindowName[9016] = "OneButtonDialog_Short" --"GUMP_ADVANCEMENT_START"
	GGManager.WindowName[9018] = "GUMP_ADVANCED_CHAR_ERROR"
	GGManager.WindowName[9017] = "TwoButtonDialog_Short" --"GUMP_ADVANCED_CHAR_CONFIRM"
	GGManager.WindowName[653] = "GUMP_YOUNG_DEATH"
	GGManager.WindowName[474] = "GUMP_TCHEST_REMOVE_WARNING"
	GGManager.WindowName[682] = "GUMP_EXPIRED_VENDOR_RECLAIM"
	GGManager.WindowName[665] = "GUMP_VENDOR_RECLAIM"
	GGManager.WindowName[478] = "ChoiceButtonsStringData" --"GUMP_DOOM_CHARON_BOAT_TRIP"
	GGManager.WindowName[479] = "ChoiceButtonsStringData" --"GUMP_DOOM_GREEDY_HEALER"
	GGManager.WindowName[9999] = "ChoiceButtonsStringData" --"GUMP_PROTECTION_OFFER"
	GGManager.WindowName[10022] = "ChoiceButtonsStringData" --"GUMP_PROTECTION_OFFER"
	GGManager.WindowName[684] = "GUMP_CANCEL_VENDOR"
	GGManager.WindowName[2535] = "TwoButtonDialog_Short" --"GUMP_FRIEND_CLEAR_CONFIRM"
	GGManager.WindowName[9007] = "TwoButtonDialog_Short" --"GUMP_DOOM_EXIT"
	GGManager.WindowName[2536] = "TwoButtonDialog_Short" --"GUMP_COOWNER_CLEAR_CONFIRM"
	GGManager.WindowName[502] = "TwoButtonDialog" --"GUMP_ACCESSLIST_CLEAR_CONFIRM"
	
	-- Virtue Gumps
	GGManager.WindowName[10005] = "GUMP_VIRTUE_MENU" -- "GUMP_VIRTUE_MENU"
	GGManager.WindowName[10010] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_VALOR"
	GGManager.WindowName[10011] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_HONOR"
	GGManager.WindowName[10008] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_COMPASSION"
	GGManager.WindowName[10012] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_JUSTICE"
	GGManager.WindowName[10013] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_HONESTY"
	GGManager.WindowName[10009] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_SPIRITUALITY"
	GGManager.WindowName[10007] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_SACRIFICE"
	GGManager.WindowName[10006] = "GUMP_VIRTUE_INFO" -- "GUMP_VIRTUE_HUMILITY"
	
	-- Puzzle Box Gumps
	GGManager.WindowName[298] = "GUMP_PUZZLEBOX"
	GGManager.WindowName[300] = "GUMP_PUZZLEGUESS" 
	GGManager.WindowName[11026]	= "GUMP_LORE_CONVERSATION" -- Needed per DT 10309
	GGManager.WindowName[999003] = "GUMP_CHOOSE_HAIR" -- GUMP_HAIRTYPE
	GGManager.WindowName[999004] = "GUMP_CHOOSE_HAIR" -- GUMP_FACIALHAIRTYPE
	GGManager.WindowName[999037] = "GUMP_DYES" -- "GUMP_HAIRSTYLIST_TWO"
	GGManager.WindowName[999038] = "GUMP_DYES" -- "GUMP_HAIRSTYLIST_THREE"
	GGManager.WindowName[999039] = "GUMP_DYES" -- "GUMP_HAIRSTYLIST_FOUR"
	GGManager.WindowName[999040] = "GUMP_DYES" -- "GUMP_HAIRSTYLIST_FIVE"
	GGManager.WindowName[999041] = "GUMP_DYES" -- "GUMP_HAIRSTYLIST_SIX"
	GGManager.WindowName[999042] = "GUMP_DYES" -- "GUMP_HAIRSTYLIST_SEVEN"
	GGManager.WindowName[999043] = "GUMP_HAIRSTYLIST_EIGHT" 
	GGManager.WindowName[667] = "GUMP_GIFT_AOS_LAUNCH"
	GGManager.WindowName[309] = "GUMP_BANNER_DEED"
	GGManager.WindowName[310] = "GUMP_BANNERCHOICE"
	GGManager.WindowName[311] = "GUMP_BANNER_DEED_ADDON"
	
	GGManager.WindowName[9071] = "GUMP_BANNER_DEED"
	GGManager.WindowName[9072] = "GUMP_BANNER_DEED"
	
	GGManager.WindowName[999046] = "GUMP_EDIT_BALLOTBOX"
	GGManager.WindowName[9035] = "GUMP_VACLOAK_GAME1"

	GGManager.WindowName[999016] = "TwoButtonDialog_Short" --"GUMP_TELEPORT"
	GGManager.WindowName[2546] = "TwoButtonDialog_Short" --"GUMP_BANLIST_CLEAR_CONFIRM"
	GGManager.WindowName[670] =  "GUMP_BULK_ORDER_PURCHASE" --"GUMP_AGREED_TO_PURCHASE_CONFIRM" might also fit this one

	GGManager.WindowName[2222] = "TwoButtonDialog" --"GUMP_CAMPING"
	GGManager.WindowName[308] = "TwoButtonDialog_Short" --"GUMP_BANNER_REDEED"
		
	GGManager.WindowName[9024] = "ChoiceButtons" -- "TwoButtonDialog_Short" --"GUMP_ANIMALCONTAINER_CONFIRM" -- actually a ChoiceButtons with radios: 1,0 and 7 as button
	GGManager.WindowName[9015] = "TwoButtonDialog_Short" --"GUMP_CANCEL_INSURANCE_CONFIRM"
	GGManager.WindowName[9058] = "TwoButtonDialog_Short" --"GUMP_CONFIRM_TRASH"
	GGManager.WindowName[9005] = "TwoButtonDialog_Short" --"GUMP_GATE_CHECK"
	GGManager.WindowName[9069] = "TwoButtonDialog_Short" --"GUMP_REWARD_TITLER"
	GGManager.WindowName[9073] = "TwoButtonDialog_Short" --"GUMP_REWARD_TITLER"
	GGManager.WindowName[302] = "TwoButtonDialog_Short" --"GUMP_MARK_ME"
	
	-- FACTION GUMPS (Starting here)
	GGManager.WindowName[9001] = "TwoButtonDialog_Short" --"GUMP_LEAVEFACTION"
	GGManager.WindowName[9002] = "TwoButtonDialog_Short" --"GUMP_GUILD_LEAVEFACTION"
	GGManager.WindowName[15000]		= "GUMP_GOODEVIL" -- GUMP_PALADIN
	GGManager.WindowName[15001]		= "GUMP_GOODEVIL" -- GUMP_EVIL
	
	--*** WARNING: GUMP_MESSAGE_DETAILS may get renumbered
	-- it currently shares same GUMPID as GUMP_CHANGERACE_CONFIRM
	GGManager.WindowName[671] = "GUMP_MESSAGE_DETAILS"
	GGManager.WindowName[200] = "OneButtonDialog" -- "GUMP_TMAP_INSTRUCTIONS"
	GGManager.WindowName[601] = "TwoButtonDialog_Short" --"GUMP_PET_RELEASE"
	GGManager.WindowName[2223] = "TwoButtonDialog" --"GUMP_RESME"
	GGManager.WindowName[9022] = "GUMP_SELECT_TARGETING_MODE"
	GGManager.WindowName[659] = "GUMP_SHRINE_TITHE"
	GGManager.WindowName[462] = "GUMP_STABLED_PETS"
	GGManager.WindowName[500] = "GUMP_TITLE"
	GGManager.WindowName[9021] = "GUMP_SELECT_PETITION_TARGET"
	
	GGManager.WindowName[123456] = "TwoButtonDialog_Short" --"GUMP_TRANSPORT"
	GGManager.WindowName[123457] = "TwoButtonDialog_Short" --"GUMP_PARTY_TRANSPORT"
	GGManager.WindowName[123458] = "ChoiceButtons" -- looks like "TwoButtonDialog_Short" but is radio buttons --"GUMP_VALIDATE_TELEPORT"


	-- TODO GUMP_CHOOSE_FORM should be renamed to a more generic template name like ChoiceIcons
	-- since it currently handle many different kinds of gump
	GGManager.WindowName[9014] = "GUMP_CHOOSE_FORM" -- actually handles all "GUMP_CHOICE_ICONS"
													--   including: [5008] = "GUMP_POLYMORPH" and 
											--   [9287] = "GUMP_CHOOSE_FORM"

	GGManager.WindowName[678] = "TwoButtonDialog" -- Sex change gump
	GGManager.WindowName[680] = "TwoButtonDialog" -- Sex change gump confirmation
	
	GGManager.WindowName[999015] = "TwoButtonDialog_Short" -- "GUMP_STATUETTE"
	GGManager.WindowName[999050] = "TwoButtonDialog_Short" -- "GUMP_WINDCHIME_SWITCH"
	
	GGManager.WindowName[475] = "AnimalLore" -- inherits OneButtonDialog, used for GUMP_ANIMAL_LORE	
	GGManager.WindowName[661] = "HouseSecuritySetting" -- inherits ChoiceList, used for GUMP_HOUSE_SECURITY_SETTING
	GGManager.WindowName[15010] = "GUMP_SOULSTONE" -- inherits ChoiceList, used for GUMP_SOULSTONE
	
	GGManager.WindowName[600] = "GUMP_MOONGATE" -- (not generic)
	GGManager.WindowName[15002] = "GUMP_MURDER_REPORT" -- (not generic)
	GGManager.WindowName[658] = "GUMP_NE_FAMILIAR"
	GGManager.WindowName[477] = "GUMP_PET_RESURRECTION" -- (not generic)
	GGManager.WindowName[603] = "TwoButtonDialog_Short" --"GUMP_PET_TRANSFER"
	GGManager.WindowName[662] = "TwoButtonDialog_Short" --"GUMP_RELEASE_FAMILIAR"
	
	GGManager.WindowName[401] = "GUMP_SPECIAL_DYES" -- "GUMP_SPECIAL_DYES"
	GGManager.WindowName[402] = "GUMP_LEATHER_DYES" -- "GUMP_LEATHER_DYES"
	GGManager.WindowName[999022] = "GUMP_DYES" -- "GUMP_HAIR_COLOR_SELECTION_MENU"
	GGManager.WindowName[999024] = "GUMP_DYES" -- "GUMP_SPECIAL_BEARD_DYE"
	GGManager.WindowName[999025] = "GUMP_DYES" -- "GUMP_SPECIAL_HAIR_DYE"
	
	-- Not sure if GUMP_ACTION is used for anything except Monorail, but using that for now
	GGManager.WindowName[9026] = "Monorail" -- "GUMP_ACTION" 

	GGManager.WindowName[89] = "RUNEBOOK_GUMP"

	GGManager.WindowName[460] = "CraftingWindow"
	GGManager.WindowName[685] = "CraftingWindow"
	
	GGManager.WindowName[403] = "TwoButtonDialog" -- GUMP_SIX_MONTH_REWARD
	GGManager.WindowName[9047] = "TwoButtonDialog" -- GUMP_CONFIRM_ATTENDANT
	GGManager.WindowName[9064] = "TwoButtonDialog_Short" -- GUMP_SIEGE_TRADEIN_CONFIRM
	GGManager.WindowName[9025] = "GUMP_CHOICE_TEXT" -- Used to be a choice list, but really needs its own thing -- "ChoiceList"
	GGManager.WindowName[12350000] = "ChoiceList" -- GUMP_TRACKING_ONE
	GGManager.WindowName[9054] = "OneButtonDialog" -- "Your pet was unable to join you while you are a ghost"
	GGManager.WindowName[807] = "GUMP_QUEST_HISTORY"
	GGManager.WindowName[999028] = "GUMP_NEWBIE_TICKETS"
	GGManager.WindowName[999021] = "TwoButtonDialog_Short" -- GUMP_REMOVE_THE_DESTINATION_ARROW	

	GGManager.WindowName[42882] = "ChoiceList"  -- GUMP_BUILDING_SITE_EDITOR
	GGManager.WindowName[71] = "OneButtonDialog" -- "TEST_CENTER_WARNING"
	GGManager.WindowName[304] = "GUMP_SR_RATING" -- Allows rating of GMs, companions, etc... - Basic mG choicelist thing
	
	GGManager.WindowName[295] = "GUMP_NEWBIE_SCAM"
	GGManager.WindowName[9028] = "GUMP_SIEGE_BLESS"
	GGManager.WindowName[9027] = "GUMP_SIEGE_UNBLESS"
	GGManager.WindowName[23452] = "TwoButtonDialog_Wide" -- RENOUNCENEWBIE_WARNING
	
	-- HELP MENU Gumps
	GGManager.WindowName[666] = "GUMP_HELP_MENU" 
	GGManager.WindowName[672] = "TextEntry" -- GUMP_PAGE_TEXTENTRY
	GGManager.WindowName[296] = "ChoiceList" -- "GUMP_STUCK_PLAYER"
	GGManager.WindowName[9019] = "GUMP_TARGET_PETITION_TARGET"
	GGManager.WindowName[9020] = "GUMP_TYPE_PETITION_TARGET"
	GGManager.WindowName[9021] = "GUMP_SELECT_PETITION_TARGET"
	
	-- Quest Gumps
	--   [802] = GUMP_QUEST_STATUS and [804] = GUMP_QUEST_OBTAIN do not appear to be used.
	GGManager.WindowName[800] = "GUMP_QUEST_OFFER" 	-- GUMP_QUEST_OFFER
	GGManager.WindowName[801] = "ChoiceButtons" 	-- GUMP_QUEST_QUIT
	GGManager.WindowName[803] = "OneButtonDialog" 	-- GUMP_QUEST_REWARD
	GGManager.WindowName[805] = "GUMP_QUEST_JOURNAL" 
	GGManager.WindowName[806] = "OneButtonDialog" 	-- GUMP_QUEST_CONVERSATION
	--GGManager.WindowName[807] = "ChoiceList" 			-- GUMP_QUEST_HISTORY
	GGManager.WindowName[808] = "OneButtonDialog" 	-- GUMP_QUEST_CONVO
	GGManager.WindowName[809] = "GUMP_QUEST_JOURNAL_DETAILS" -- declared in QuestOffer.xml	
	GGManager.WindowName[810] = "TwoButtonDialog" 	-- GUMP_QUEST_CONVERSATION_2
	
	-- Lore Quest Gumps
	GGManager.WindowName[11022] =  "GUMP_LORE_QUEST_LOG"
	GGManager.WindowName[11023] =  "ChoiceButtons"  -- GUMP_LORE_QUEST_OFFER
	GGManager.WindowName[11024] = "OneButton" -- GUMP_LORE_QUEST_LOG_UPDATE,
	GGManager.WindowName[11025] = "OneButtonDialog" -- GUMP_LORE_CONVERSATION_ONE_TIME,
	GGManager.WindowName[11027] = "GUMP_LORE_QUIT_OFFER"  --,  Title tid 1078848 
	--GGManager.WindowName[11028] = "OneButtonDialog" -- GUMP_LORE_TRANSITION,
	GGManager.WindowName[11029] = "TwoButtonDialog" -- GUMP_LORE_ACCEPT_OR_DECLINE,

	-- Guild Gumps
	GGManager.WindowName[725] = "GUMP_GUILD_CREATE"  -- for creating a new guild
	GGManager.WindowName[726] = "TwoButtonDialog" -- "GUMP_GUILD_INVITE"	-- inherits "TwoButtonDialog"	// presented to player invited to a guild
	GGManager.WindowName[727] = "GUMP_GUILD_PLR_ROSTER" -- // shows all players in the guild
	GGManager.WindowName[728] = "GUMP_GUILD_PLR_DETAIL" -- // list/modifies details for a particular player in a guild

	-- Defined but never used: -- "GUMP_GUILD_ALLY_ROSTER" -- for showing all the guilds in an alliance (any alliance)
	-- It might have been that GUMP_GUILD_ALLY_ROSTER was never implemented properly.
	-- Code for it is in place, but it used to use the same GID as GUMP_GUILD_DIPLOMACY.
	-- I split it off from GUMP_GUILD_DIPLOMACY and called it GUMP_GUILD_DIPLOMACY_TWO.
	-- If a designer ever fixes it, then they may want to use GUMP_GUILD_DIPLOMACY's template for it in KR.
	GGManager.WindowName[729] = "GUMP_GUILD_DIPLOMACY"		-- // lists all other guilds and their basic relationship to you
	GGManager.WindowName[730] = "GUMP_GUILD_RELATIONSHIP"		-- // lists/modifies the details of any relationship with a particular guild
	GGManager.WindowName[731] = "GUMP_GUILD_WAR"				-- // for declaring war against another guild

	GGManager.WindowName[733] = "GUMP_GUILD_MY_INFO" -- showing/modifying misc. guild information
	GGManager.WindowName[734] = "GUMP_GUILD_ADVSEARCH"		-- // advanced search options for guild roster
	GGManager.WindowName[999036] = "GUMP_GUILD_DIPLOMACY" -- "GUMP_GUILD_DIPLOMACY_TWO" -- GUMP_GUILD_DIPLOMACY now handles both of these; this is when case = 8.

	GGManager.WindowPositionGroup[725] = "Guild"
	GGManager.WindowPositionGroup[726] = "Guild"
	GGManager.WindowPositionGroup[727] = "Guild"
	GGManager.WindowPositionGroup[728] = "Guild"
	GGManager.WindowPositionGroup[729] = "Guild"
	GGManager.WindowPositionGroup[730] = "Guild"
	GGManager.WindowPositionGroup[731] = "Guild"
	GGManager.WindowPositionGroup[733] = "Guild"
	GGManager.WindowPositionGroup[734] = "Guild"
	GGManager.WindowPositionGroup[999036] = "Guild"


	-- house placement gumps	
	GGManager.WindowName[492] = "TwoButtonDialog" -- GUMP_HOUSE_WARNING
	GGManager.WindowName[503] = "GUMP_HOUSE_COMMIT" -- inherits "TwoButtonDialog" with extra text

	GGManager.WindowName[507] = "HousePlacementWindow" -- GUMP_KR_HOUSE_PLACEMENT_TOOL
	--GGManager.WindowName[464] = "HousePlacementWindow" -- Legacy GUMP_HOUSE_PLACEMENT_TOOL this should never be sent to a KR client

	GGManager.WindowName[508] = "HousePlacementWarningWindow" 

	--VACLOAK Quest
	--GUMP_VACLOAK_QUEST_GENERIC,GUMP_VACLOAK_QUEST2_NPC,GUMP_VACLOAK_QUEST4_CHOICE,GUMP_VACLOAK_QUEST1_ACCEPT, GUMP_VACLOAK_QUEST1_DECLINE
	GGManager.WindowName[9031] = "GUMP_VACLOAK_QUEST"	
	GGManager.WindowName[9032] = "GUMP_VACLOAK_QUEST"	--GUMP_VACLOAK_QUEST1_OFFER
	GGManager.WindowName[9033] = "GUMP_VACLOAK_QUEST"	
	GGManager.WindowName[9034] = "GUMP_VACLOAK_QUEST"   
	GGManager.WindowName[9036] = "GUMP_VACLOAK_QUEST"	
	GGManager.WindowName[9037] = "GUMP_VACLOAK_QUEST"   		
	
	-- house sign gumps
	GGManager.WindowName[2533] = "HouseSignWindow" 
	GGManager.WindowName[687] = "GUMP_HOUSESIGN_VENDOR_LIST" -- Basically a choiceList that uses string data instead - Actually uses masterGUMP
	
	GGManager.WindowName[42882] = "ChoiceList"    -- GUMP_BUILDING_SITE_EDITOR
	GGManager.WindowName[652] = "GUMP_FLIPFLOP"    -- inherits ChoiceList
	GGManager.WindowName[2547] = "HouseSignPlaqueWindow"  -- the little house sign brass plaque window if you don't have privileges
	
	-- Two button warning dialogs 
	GGManager.WindowName[2538] = "TwoButtonDialog" -- GUMP_HOUSE_COOWNER_REMOVAL
	GGManager.WindowName[486] = "TwoButtonDialog" -- GUMP_HOUSE_CLAIM_CONFIRM
	GGManager.WindowName[9009] = "TwoButtonDialog" -- GUMP_HOUSE_CONTRACT_VENDOR_WARNING
	GGManager.WindowName[676] = "TwoButtonDialog" -- GUMP_HOUSE_OVERSECURE_WARNING
	GGManager.WindowName[495] = "TwoButtonDialog" -- GUMP_HOUSE_CONVERT
	GGManager.WindowName[496] = "TwoButtonDialog" -- GUMP_HOUSE_REPLACE
	GGManager.WindowName[2534] = "TwoButtonDialog" -- GUMP_DEMOLISH_HOUSE
	GGManager.WindowName[487] = "TwoButtonDialog" -- GUMP_HOUSE_MAKEPRIMARY_CONFIRM
	GGManager.WindowName[999006] = "TwoButtonDialog" -- GUMP_PERSONAL_BLESS

	GGManager.WindowName[999001] = "GUMP_RECRUIT"
	GGManager.WindowName[69] =  "SIEGE_WARNING"
	GGManager.WindowName[9055] = "TwoButtonDialog_Short" -- GUMP_CONFIRM_CRYSTAL
	GGManager.WindowName[9056] = "TwoButtonDialog_Short" -- GUMP_CONFIRM_SHADOW
	GGManager.WindowName[9053] = "GUMP_SELF_RECHARGE_CANNON"
	GGManager.WindowName[506] = "GUMP_UNIQUE_HAIR_DYE"
	GGManager.WindowName[307] = "GUMP_HEAD_REDEED"
	GGManager.WindowName[9049] = "TwoButtonDialog_Short" --GUMP_RECHARGE_WEAPON_ENGRAVER
	GGManager.WindowName[9050] = "TwoButtonDialog_Short" --GUMP_SELF_RECHARGE_WEAPON_ENGRAVER
	GGManager.WindowName[9023] = "TwoButtonDialog" --GUMP_XFER_EXCHANGE_7TH	
	GGManager.WindowName[9043] = "TwoButtonDialog_Short" --GUMP_ORACLE_CLEAR_CONFIRM
	GGManager.WindowName[999026] = "GUMP_REALLY_IMPRISON_TARGET"
	
	-- One button notice dialogs 
	GGManager.WindowName[501] = "OneButtonDialog" -- GUMP_HOUSE_CUSTOMIZATION_NOTICE
	GGManager.WindowName[504] = "OneButtonDialog" -- GUMP_HOUSE_STRUCTURE_NOTICE
	GGManager.WindowName[493] = "OneButtonDialog" -- GUMP_INSUFFICIENT_FUNDS
	GGManager.WindowName[244] = "OneButtonDialog" -- GUMP_HOUSESURVEY_TEST
	GGManager.WindowName[494] = "OneButtonDialog" -- GUMP_HOUSESIGN_NOTICE
	GGManager.WindowName[501] = "OneButtonDialog" -- GUMP_HOUSE_CUSTOMIZATION_NOTICE
	GGManager.WindowName[663] = "OneButtonDialog" -- GUMP_VENDOR_NOTICE
	GGManager.WindowName[130] = "OneButtonDialog" -- DUNG_GUMP (Short for "DUNGeon")
	GGManager.WindowName[99999] = "OneButtonDialog" -- GUMP_TRANSFER_START
	GGManager.WindowName[999027] = "OneButtonDialog" -- "GUMP_PURIFIER_BOOK"
	GGManager.WindowName[999035] = "GUMP_TROPHYCHOICE" -- For picking which way an animal trpohy head faces when placed in a corner


	GGManager.WindowName[999019] = "GUMP_NAVAL_TREASURE_MESSAGE"
	GGManager.WindowName[999017] = "GUMP_HOLIDAY_GUMP"
	
	
	GGManager.WindowName[999007] = "TwoButtonDialog_Short" -- "GUMP_DRY_DOCK_BOAT_CONFIRM" 
	GGManager.WindowName[999008] = "GUMP_AGREED_TO_PURCHASE_CONFIRM" -- inherits TwoButtonDialog
	GGManager.WindowName[999010] = "OneButtonDialog" -- "GUMP_SHOPKEEPINFO_FOR_NEW_PLAYERS"
	GGManager.WindowName[9048] = "GUMP_HERALD" -- choicelist one-off, has to be since not all buttons are selectable in all cases
	
	GGManager.WindowName[9006] = "GUMP_POWERSCROLL" -- inherits TwoButtonDialog
	GGManager.WindowName[673] = "GUMP_PROMO_7TH_TAPESTRY"
	GGManager.WindowName[9010] = "GUMP_PROMO_CODE" -- Has a text entry box, used for promo code entry
	GGManager.WindowName[12350001] = "GUMP_TRACKING_TWO"
	GGManager.WindowName[674] = "GUMP_PROMO_7TH_CHOICE" -- inherits ChoiceList, uses Button, Title, Subtitle, and Choices
	GGManager.WindowName[669] = "GUMP_BULK_ORDER_FILTER" -- Uses combo boxes	
	GGManager.WindowName[668] = "BULK_ORDER_BOOK"
	GGManager.WindowName[10002] = "GUMP_BARKEEP_TITLE"
	GGManager.WindowName[999012] = "GUMP_FLIPFLOP" -- "GUMP_TOWN_BARKEEP_MENU" is happily fitting into this one's one off :-)
	GGManager.WindowName[5009] = "GUMP_VENDORBARBIE"
	GGManager.WindowName[999014] = "GUMP_VENDORBARBIE_SILVER"
	GGManager.WindowName[16000] = "GUMP_ENGRAVING_TOOL_NAME_ENTRY"
	GGManager.WindowName[455] = "GUMP_DE_PLAYER_BULKOFFER"
	GGManager.WindowName[456] = "GUMP_DE_ITEM_BULKDEED"

	GGManager.WindowName[10001] = "GUMP_BARKEEP_MENU"
	GGManager.WindowName[9044] = "GUMP_LUCKY_DEALER"
	GGManager.WindowName[677] = "GUMP_PROMO_NAMECHANGE"
	GGManager.WindowName[201] =  "OneButton" -- a OneButtonDialog with no dialog :)
		
	GGManager.WindowName[999047] = "GUMP_VOLUNTEER_MEMORIAL" -- A memorial for volunteers
	
	GGManager.WindowName[999011] = "GUMP_NEW_PLAYER_INSTRUCTION" -- "New player expierence talking gump"	
	GGManager.WindowName[999044] = "TwoButtonDialog_Short"  --"GUMP_END_NPE_CONFIRM"
	GGManager.WindowName[999045] = "TwoButtonDialog_Short"  --"GUMP_CHANGERACE_CONFIRM" 
	
	GGManager.WindowName[9063] = "GUMP_MADMAGE_ANDREWS_CARD"
	
	-- 10th Anniversary Map
	GGManager.WindowName[999051] = "GUMP_PROMO_10TH_MAP"
	-- body sculptor npc
	GGManager.WindowName[688] = "FaceSelectionWindow" -- Body sculptor face selector
	GGManager.WindowName[689] = "GUMP_BODY_SCULPTOR_MAIN_SELECTION" -- Body sculptor main menu
	GGManager.WindowName[999043] = "GUMP_HAIRSTYLIST_EIGHT" -- menu of options one can do using the npc
	-- text entry
	GGManager.WindowName[686] = "SingleLineTextEntry" -- Generic single line text entry gump that returns a text entry packet
	
	GGManager.WindowName[9068] = "TwoButtonDialog" -- Replace active balm confirmation
	
	-- Cupid - Throbbing Heart menu
	GGManager.WindowName[999054] = "GUMP_CUPID_MENU"
	GGManager.WindowName[999055] = "TwoButtonDialog" -- Select your Valentine confirmation

	-- Gumps to not display in KR
	GGManager.WindowName[10014] = "DO_NOT_DISPLAY" -- The pretty gump for the virtue system, deprecated in KR! 
	GGManager.WindowName[464] = "DO_NOT_DISPLAY" -- "HousePlacementWindow" -- Legacy GUMP_HOUSE_PLACEMENT_TOOL: this should never be sent to a KR client
end


-- Function: GGManager.getAllKnownWindows
--
function GGManager.getAllKnownWindows()
	return GGManager.knownWindows
end


-- Function: GGManager.getAllWindowsForID
--
-- Inputs:
--	gumpID		- type number (required) 
--	objectID	 - type number (optional) - if missing it will match any window with the gumpID
--
-- Returns: an array (1-based) of tables containing all gumpData
--
function GGManager.getAllWindowsForID( gumpID, objectID )
	local filteredWindows = {}
	
	for _, gumpData in pairs(GGManager.knownWindows) do
		if gumpID == gumpData.gumpID then
			if objectID == nil or objectID == gumpData.objectID then
				table.insert( filteredWindows, gumpData )
			end
		end
	end
	
	return filteredWindows 
end


-- 
--
function GGManager.registerWindow( windowName, windowData )
	GGManager.knownWindows[windowName] = windowData
end


-- 
--
function GGManager.unregisterWindow( windowName )
	--Debug.Print("GGManager.unregisterWindow, windowName = "..windowName)
	GGManager.knownWindows[windowName] = nil
end

-- 
--
function GGManager.unregisterActiveWindow()
	local windowName = WindowUtils.GetActiveDialog()
	--Debug.Print("GGManager.unregisterActiveWindow, windowName = "..windowName)
	GGManager.knownWindows[windowName] = nil
end


--
-- if shouldUnregister is set to GGManager.DONT_DELETE_DATA_YET (false) then the window needs to make sure it calls 
--   unregisterWindow or unregisterActiveWindow later (probably in the OnShutdown handler)
--
--
--
function GGManager.destroyWindow( windowName, shouldUnregister )
	-- shouldUnregister defaults to GGManager.DELETE_DATA (true)
	if windowName ~= nil and (shouldUnregister == nil or shouldUnregister == GGManager.DELETE_DATA) then
		GGManager.unregisterWindow( windowName )
	end
	
	if windowName ~= nil and DoesWindowNameExist(windowName) == true then	
		local windowData = GGManager.knownWindows[windowName]
		if windowData ~= nil and windowData.gumpID ~= nil then
			local savePositionGroup = GGManager.WindowPositionGroup[windowData.gumpID] or GGManager.WindowName[windowData.gumpID]
			WindowUtils.SaveWindowPosition(windowName, false, savePositionGroup)
			--UO_GenericGump.debug( StringToWString("called SaveWindowPosition, PositionGroup = "..savePositionGroup) )
		end
		
		DestroyWindow( windowName )
		--UO_GenericGump.debug( StringToWString("called DestroyWindow on windowName = "..windowName) )
	end
end

function GGManager.destroyActiveWindow( shouldUnregister )
	local windowName = WindowUtils.GetActiveDialog()
	GGManager.destroyWindow( windowName, shouldUnregister )
end


-- Called from the server
--
function GGManager.GGClose()

	--UO_GenericGump.debug( L"GGManager.GGClose" )

	local gumpID = WindowData.CloseGG.RetId
	local foundWindows = GGManager.getAllWindowsForID( gumpID )
	for _, windowData in pairs(foundWindows) do
		GGManager.destroyWindow( windowData.windowName )
	end
end


----

-- Register a function to be called before the window is created
-- if it returns true then GGManager will ignore the incoming gump request
--
-- Note: windowName is the name for the XML template, not an individual instance of it
--
function GGManager.registerOnCreateCallback( windowName, fn )
	GGManager.onCreateCallback[windowName] = fn
end

function GGManager.unregisterOnCreateCallback( windowName )
	GGManager.onCreateCallback[windowName] = nil
end


function GGManager.GGArrived()

	local gumpId = WindowData.GG_Core.GumpId
	local windowName = GGManager.WindowName[gumpId]

	if windowName and GGManager.onCreateCallback[windowName] then
		UO_GenericGump.debug( StringToWString("calling "..windowName.."'s onCreateCallback function ") )
		if GGManager.onCreateCallback[windowName]() == GGManager.NEW_GUMP_HAS_BEEN_HANDLED then	
			UO_GenericGump.debug( StringToWString(windowName)..L" has been handled by the callback. Exiting GGManager.GGArrived") 
			return;
		end
	end
	

	-- Don't display anything for gumps that don't want to be displayed!
	if windowName and windowName == "DO_NOT_DISPLAY" then
		return false
	end

	if not windowName then
		if IsInternalBuild() then	
		Debug.PrintToDebugConsole( L"ERROR in GGManager.GGArrived: No generic gump window found for gumpId = "..gumpId )
			if GGManager.DISPLAY_GUMPNOTFOUND then
				windowName = "NoGumpFound"
			else			
				return false
			end
		else
			if GGManager.ASK_BETA_TESTERS_FOR_HELP then
				windowName = "NoGumpFound" -- As this now handles both the debug to us developers and the help us to beta testers
			else
				return false
			end
		end	 
	end
		
	-- The "Do not report this" message isn't very helpful for developers!
	if windowName == "KnownBrokenGump" and IsInternalBuild() then
		if GGManager.DISPLAY_GUMPNOTFOUND
		then
			windowName = "NoGumpFound"
		else
			return false
		end
	end
	
	-- Disable KnownBrokenGump if flag for it is disabled
	if windowName == "KnownBrokenGump" and not IsInternalBuild() and not GGManager.TELL_BETA_TESTERS_WE_KNOW then 
		return false
	end
	
	GGManager.NumOfGumps = GGManager.NumOfGumps + 1	
	local gumpName = GGManager.GumpName[gumpId] or  windowName.."-"..GGManager.NumOfGumps

	if string.match(string.lower(windowName), "runebook_gump") then
		LegacyRunebook.init().create()
		return
	else
		CreateWindowFromTemplate( gumpName, windowName, "Root" )
	end


	local savePositionGroup = GGManager.WindowPositionGroup[gumpId] or windowName
	WindowUtils.RestoreWindowPosition(gumpName, false, savePositionGroup)
	--UO_GenericGump.debug( StringToWString("calling RestoreWindowPosition, PositionGroup = "..savePositionGroup) )

	-- *** could use this to access windows by index
	--WindowSetId( gumpName, GGManager.NumOfGumps )
	

	UO_GenericGump.debug( StringToWString("Created new window "..gumpName.." using template "..windowName) )
	--UO_GenericGump.debug( GGManager.GumpToString() )
end

function GGManager.ConcatStringFromTID(TIDTable, spacer, beginIdx, endIdx)
	result = L""
	for i, tid in ipairs(TIDTable) do
		if i>endIdx then break end
		
		if i>=beginIdx then
			result = result..GetStringFromTid(tonumber(tid))..spacer
		end
	end
	return result
end


-- removes all markup tags
-- str is  of type wstring
--
function GGManager.stripMarkup(str, replaceEmptyString)
	if replaceEmptyString == true and (str == L"" or str == "") then
		str = L" "
	end
	str = WindowUtils.translateMarkup(str)
	if replaceEmptyString == true and (str == L"" or str == "") then
		str = L" "
	end
	return str
end


-- takes in a Text ID value as a string or number
-- looks up the CliLoc text string, replaces <br> with "\n" and then 
-- removes all markup tags
-- TODO: we may want to replace other markup than just <br> in the future, e.g. href
--
function GGManager.translateTID(tid)

	--if not tid or not type(tid) == "number" then
	if not tid or tonumber(tid) == nil then
		Debug.PrintToDebugConsole( L"ERROR in GGManager.translateTID: TID is nil" )
		return L""
	end
	result = GetStringFromTid( tonumber(tid) ) 
	if not result then
		Debug.PrintToDebugConsole( L"ERROR in GGManager.translateTID: No string found for TID = "..tid )
		return L""
	end
	
	return WindowUtils.translateMarkup(result)
end
-- THIS FUNCTION (and all calls to it (NoGumpFound.lua)) SHOULD BE REMOVED ONCE ALL THE GUMPS WORK
function GGManager.BetaTesterHelpMessage()
	--local bthm = GGManager.translateTID( ##?## )..WindowData.GG_Core.GumpId..GGManager.translateTID( ##?## )
	local bthm =	L"Since KR is a brand new client, there are some things that are bound to go wrong. You have found one of them.\n\n"..
					L"In order to help us fix this, we ask that you report this as a bug.\n\n"..
					L"Here's how:\n1) Click on the Main Menu button on the hotbar.\n2) Select the Bug Report choice.\n"..
					L"3) Check the UI box under Select Bug Type.\n"..
					L"4) Type ''Gump #"..WindowData.GG_Core.GumpId..L" is broken.'' and a description of what you were doing in the box below.\n\n"..
					L"Please only report this bug once. We will fix it ASAP.\n\nThank you."
	return bthm
end


--------------------------
-- DEBUGGING FUNCTIONS
--------------------------

-- function GGManager.tableToString - creates string for debugging 
--
-- Input: 
--		data (type table)
--		spacing (type wstring) - just an indentation used mainly during recursion, ignoring this parameter should be fine for most cases
--
-- Returns: wide string of fields inside table
-- Note: this only handles values of the following types: string, wstring, number, boolean, and table
--
function GGManager.tableToString( data, spacing )


	spacing = spacing or L"  "
	
	local str = L"table: "
	if data.name and type(data.name) == "wstring" then
		str = str..data.name
	end
	str = str..L"\n"

	for k, v in pairs( data ) do
	
		local keyName = GGManager.convertToWString( k ) or L"<"..StringToWString( type(k) )..L">"	
		local valueName
		
		if type( v ) == "table" then
			valueName = GGManager.tableToString( v, L"  "..spacing  )
		else
			valueName = GGManager.convertToWString( v ) or L"<"..StringToWString( type(v) )..L">"
		end
		
		str = str..spacing..keyName..L" = "..valueName..L"\n"

	end
	
	
	return str
end

-- doesn't handle tables
-- returns nil if it is unknown type
--
function GGManager.convertToWString( value )

	local valueName 
	
	if type( value ) == "wstring" then
		valueName = value
	elseif type( value ) == "string" then
		valueName = StringToWString( value )
	elseif type( value ) == "boolean" or type( value ) == "number" then
		valueName = StringToWString( tostring(value) )
	end
	
	return valueName
end

function GGManager.printTable( data, name )
	UO_GenericGump.debug( GGManager.tableToString( data, name ) )
end


function GGManager.GGParseData()
	GumpsParsing.CheckGumpType(0)
end

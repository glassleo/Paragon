local LL, _, T = {}, ...

-- Localization Data

-- Translate this (including the "Notes:" part in Paragon.toc) and submit using CurseForge:
-- https://wow.curseforge.com/projects/paragon

-- Don't worry about translating the faction names - that is easily done via Wowhead!



-- English
LL["enUS"] = {
	-- Faction standing labels
	["faction_standing_hated"] 				= FACTION_STANDING_LABEL1, -- Hated
	["faction_standing_hostile"] 			= FACTION_STANDING_LABEL2, -- Hostile
	["faction_standing_unfriendly"] 		= FACTION_STANDING_LABEL3, -- Unfriendly
	["faction_standing_neutral"] 			= FACTION_STANDING_LABEL4, -- Neutral
	["faction_standing_friendly"] 			= FACTION_STANDING_LABEL5, -- Friendly
	["faction_standing_honored"] 			= FACTION_STANDING_LABEL6, -- Honored
	["faction_standing_revered"] 			= FACTION_STANDING_LABEL7, -- Revered
	["faction_standing_exalted"] 			= FACTION_STANDING_LABEL8, -- Exalted
	["faction_standing_paragon"] 			= "Paragon",
	-- Defaults (also used by Halfhill factions, etc)
	["faction_standing_stranger"] 			= "Stranger",
	["faction_standing_acquaintance"] 		= "Acquaintance",
	["faction_standing_buddy"] 				= "Buddy",
	["faction_standing_friend"] 			= "Friend",
	["faction_standing_good_friend"]		= "Good Friend",
	["faction_standing_best_friend"] 		= "Best Friend",
	-- Nat Pagle/Conjurer Margoss/Fisherfriends
	["faction_standing_pal"] 				= "Pal",
	-- Corbyn
	["faction_standing_curiosity"] 			= "Curiosity",
	["faction_standing_non-threat"] 		= "Non-Threat",
	["faction_standing_helpful_friend"]		= "Helpful Friend",
	-- Chromie
	["faction_standing_whelpling"] 			= "Whelpling",
	["faction_standing_temporal_trainee"] 	= "Temporal Trainee",
	["faction_standing_timehopper"] 		= "Timehopper",
	["faction_standing_chrono-friend"] 		= "Chrono-Friend",
	["faction_standing_bronze_ally"] 		= "Bronze Ally",
	["faction_standing_epoch-mender"] 		= "Epoch-Mender",
	["faction_standing_timelord"] 			= "Timelord",
	-- Ve'nari
	["faction_standing_dubious"] 			= "Dubious",
	["faction_standing_apprehensive"] 		= "Apprehensive",
	["faction_standing_tentative"] 			= "Tentative",
	["faction_standing_ambivalent"] 		= "Ambivalent",
	["faction_standing_cordial"] 			= "Cordial",
	["faction_standing_appreciative"] 		= "Appreciative",
	-- Barracks Bodyguards
	["faction_standing_bodyguard"] 			= "Bodyguard",
	["faction_standing_trusted_bodyguard"]	= "Trusted Bodyguard",
	["faction_standing_personal_wingman"]	= "Personal Wingman",
	-- Nomi
	["faction_standing_apprentice"] 		= "Apprentice",
	["faction_standing_journeyman"] 		= "Journeyman",
	["faction_standing_expert"] 			= "Expert",
	-- The Archivist's Codex
	["faction_standing_tier_1"] 			= "Tier 1",
	["faction_standing_tier_2"] 			= "Tier 2",
	["faction_standing_tier_3"] 			= "Tier 3",
	["faction_standing_tier_4"] 			= "Tier 4",
	["faction_standing_tier_5"] 			= "Tier 5",
	["faction_standing_tier_6"] 			= "Tier 6",


	-- Global
	["highest reputation"] 					= "Highest Reputation",
	["lowest reputation"] 					= "Lowest Reputation",

	-- Tooltips
	["hold shift for more"] 				= "<Hold Shift for More>",
	["hold shift for highest reputation"] 	= "<Hold Shift for Highest Reputation>",

	-- Slash Commands
	["/paragon help"] = "|cFF00FFFFParagon|r Usage:\n|cff00ffff/paragon <faction>|r  List Highest Reputation for the specified faction in chat\n|cff00ffff/paragon delete <name or name-realm>|r  Delete a character's data\n|cff00ffff/paragon config|r  Open the Options Panel",

	["/paragon delete no argument"] 		= "|cFF00FFFFParagon|r: No character name specified.",
	["delete character not found"]			= "|cFF00FFFFParagon|r: There is nothing to remove for \"%s\". Make sure you include the character's realm if it's not on %s.",
	["delete character successful"] 		= "|cFF00FFFFParagon|r: Removed all data for \"%s\".",

	-- Results Window
	["reputation not discovered"]			= "None of your characters have discovered\n%s yet.",
	["no results"]							= "Nothing to display for %s.",

	-- Settings Panel
	["cfgFrameSubtext"] 					= "Paragon keeps track of reputation for all your characters.\n\nType |cff00ffff/par <faction>|r in chat to bring up an overview window for a specific reputation faction.\n\n\nTo delete stored data for a character, type |cff00ffff/par delete <name>|r in chat.",
	["cfgChatOutputLimitLabel"] 			= "Maximum Chat Lines",
	["cfgTooltipHeader"] 					= "Item Tooltips",
	["cfgTooltipSubtext"] 					= "Paragon can add additional information to tooltips for reputation related items.",
	["cfgTooltipPersonalEnabled"] 			= "Show Your Current Reputation",
	["cfgHighestReputationLabel"] 			= "Character List",
	["cfgTooltipAltsEnabled"] 				= "Show Highest Reputation",
	["cfgTooltipAltsEnabledShift"] 			= "Show Extended Highest Reputation When Holding |cff00ff00<Shift>|r",
	["cfgTooltipAltsEnabledAlt"] 			= "Switch to Lowest Reputation When Holding |cff00ff00<Alt>|r",
	["cfgTooltipAltsLimitLabel"] 			= "Characters Listed",
	["cfgTooltipAltsLimitShiftLabel"] 		= "When Holding |cff00ff00<Shift>|r",
	["cfgTooltipFiltersLabel"] 				= "Filters",
	["cfgTooltipHideExalted"] 				= "Exclude "..T.standingColor[8].."Exalted|r Characters from Character List (Non-Paragon Reputations)",
	["cfgTooltipHideNeutral"] 				= "Exclude "..T.standingColor[4].."Neutral|r Characters from Character List",
	["cfgTooltipHideUnfriendly"] 			= "Exclude "..T.standingColor[3].."Unfriendly|r, "..T.standingColor[2].."Hostile|r and "..T.standingColor[1].."Hated|r Characters from Character List",
	["cfgShortRealmNames"] 					= "Shorten Realm Names to Acronyms",


	-- Faction Names
	-- These should match the name displayed in game in the Reputation UI Panel

	-- Guild
	["f guild"] 							= "Guild",

	-- Shadowlands
	["f court of harvesters"]				= "Court of Harvesters",
	["f court of night"]					= "Court of Night",
	["f death's advance"]					= "Death's Advance",
	["f marasmius"]							= "Marasmius",
	["f stitchmasters"]						= "Stitchmasters",
	["f the archivist's codex"]				= "The Archivist's Codex",
	["f the ascended"]						= "The Ascended",
	["f the avowed"]						= "The Avowed",
	["f the ember court"]					= "The Ember Court",
	["f the undying army"]					= "The Undying Army",
	["f the wild hunt"]						= "The Wild Hunt",
	["f ve'nari"]							= "Ve'nari",

	-- Battle for Azeroth
	["f 7th legion"]						= "7th Legion",
	["f champions of azeroth"]				= "Champions of Azeroth",
	["f honeyback hive"] 					= "Honeyback Hive",
	["f order of embers"]					= "Order of Embers",
	["f proudmoore admiralty"]				= "Proudmoore Admiralty",
	["f rajani"]							= "Rajani",
	["f rustbolt resistance"] 				= "Rustbolt Resistance",
	["f storm's wake"]						= "Storm's Wake",
	["f talanji's expedition"]				= "Talanji's Expedition",
	["f the honorbound"]					= "The Honorbound",
	["f the unshackled"] 					= "The Unshackled",
	["f tortollan seekers"]					= "Tortollan Seekers",
	["f uldum accord"] 						= "Uldum Accord",
	["f voldunai"]							= "Voldunai",
	["f waveblade ankoan"] 					= "Waveblade Ankoan",
	["f zandalari empire"]					= "Zandalari Empire",

	-- Legion
	["f argussian reach"] 					= "Argussian Reach",
	["f armies of legionfall"] 				= "Armies of Legionfall",
	["f army of the light"] 				= "Army of the Light",
	["f chromie"] 							= "Chromie",
	["f conjurer margoss"] 					= "Conjurer Margoss",
	["f court of farondis"] 				= "Court of Farondis",
	["f dreamweavers"] 						= "Dreamweavers",
	["f highmountain tribe"] 				= "Highmountain Tribe",
	["f the nightfallen"] 					= "The Nightfallen",
	["f the wardens"] 						= "The Wardens",
	["f valarjar"] 							= "Valarjar",
	["f talon's vengeance"] 				= "Talon's Vengeance",
	-- Fisherfriends
	["f akule riverhorn"] 					= "Akule Riverhorn",
	["f corbyn"] 							= "Corbyn",
	["f ilyssia of the waters"] 			= "Ilyssia of the Waters",
	["f impus"] 							= "Impus",
	["f keeper raynae"] 					= "Keeper Raynae",
	["f sha'leth"] 							= "Sha'leth",

	-- Warlords of Draenor
	["f arakkoa outcasts"] 					= "Arakkoa Outcasts",
	["f council of exarchs"]				= "Council of Exarchs",
	["f frostwolf orcs"]					= "Frostwolf Orcs",
	["f hand of the prophet"]				= "Hand of the Prophet",
	["f laughing skull orcs"]				= "Laughing Skull Orcs",
	["f order of the awakened"]				= "Order of the Awakened",
	["f sha'tari defense"]					= "Sha'tari Defense",
	["f steamwheedle preservation society"]	= "Steamwheedle Preservation Society",
	["f the saberstalkers"]					= "The Saberstalkers",
	["f vol'jin's headhunters"]				= "Vol'jin's Headhunters",
	["f vol'jin's spear"]					= "Vol'jin's Spear",
	["f wrynn's vanguard"]					= "Wrynn's Vanguard",
	-- Barracks Bodyguards
	["f aeda brightdawn"]					= "Aeda Brightdawn",
	["f defender illona"]					= "Defender Illona",
	["f delvar ironfist"]					= "Delvar Ironfist",
	["f leorajh"]							= "Leorajh",
	["f talonpriest ishaal"]				= "Talonpriest Ishaal",
	["f tormmok"]							= "Tormmok",
	["f vivianne"]							= "Vivianne",

	-- Mists of Pandaria
	["f dominance offensive"]				= "Dominance Offensive",
	["f emperor shaohao"]					= "Emperor Shaohao",
	["f forest hozen"]						= "Forest Hozen",
	["f golden lotus"]						= "Golden Lotus",
	["f kirin tor offensive"]				= "Kirin Tor Offensive",
	["f operation: shieldwall"]				= "Operation: Shieldwall",
	["f order of the cloud serpent"]		= "Order of the Cloud Serpent",
	["f pearlfin jinyu"]					= "Pearlfin Jinyu",
	["f shado-pan"]							= "Shado-Pan",
	["f shado-pan assault"]					= "Shado-Pan Assault",
	["f sunreaver onslaught"]				= "Sunreaver Onslaught",
	["f the august celestials"]				= "The August Celestials",
	["f the black prince"]					= "The Black Prince",
	["f the klaxxi"]						= "The Klaxxi",
	["f the lorewalkers"]					= "The Lorewalkers",
	["f the anglers"]						= "The Anglers",
	["f nat pagle"]							= "Nat Pagle",
	["f the tillers"]						= "The Tillers",
	["f chee chee"]							= "Chee Chee",
	["f ella"]								= "Ella",
	["f farmer fung"]						= "Farmer Fung",
	["f fish fellreed"]						= "Fish Fellreed",
	["f gina mudclaw"]						= "Gina Mudclaw",
	["f haohan mudclaw"]					= "Haohan Mudclaw",
	["f jogu the drunk"]					= "Jogu the Drunk",
	["f old hillpaw"]						= "Old Hillpaw",
	["f sho"]								= "Sho",
	["f tina mudclaw"]						= "Tina Mudclaw",
	["f nomi"]								= "Nomi", -- Hidden from the Reputation Panel

	-- Cataclysm
	["f avengers of hyjal"]					= "Avengers of Hyjal",
	["f baradin's wardens"]					= "Baradin's Wardens",
	["f dragonmaw clan"]					= "Dragonmaw Clan",
	["f guardians of hyjal"]				= "Guardians of Hyjal",
	["f hellscream's reach"]				= "Hellscream's Reach",
	["f ramkahen"]							= "Ramkahen",
	["f the earthen ring"]					= "The Earthen Ring",
	["f therazane"]							= "Therazane",
	["f wildhammer clan"]					= "Wildhammer Clan",

	-- Wrath of the Lich King
	["f argent crusade"]					= "Argent Crusade",
	["f kirin tor"]							= "Kirin Tor",
	["f knights of the ebon blade"]			= "Knights of the Ebon Blade",
	["f the ashen verdict"]					= "The Ashen Verdict",
	["f the kalu'ak"]						= "The Kalu'ak",
	["f the sons of hodir"]					= "The Sons of Hodir",
	["f the wyrmrest accord"]				= "The Wyrmrest Accord",
	["f alliance vanguard"]					= "Alliance Vanguard",
	["f explorer's league"]					= "Explorer's League",
	["f the frostborn"]						= "The Frostborn",
	["f the silver covenant"]				= "The Silver Covenant",
	["f valiance expedition"]				= "Valiance Expedition",
	["f horde expedition"]					= "Horde Expedition",
	["f the hand of vengeance"]				= "The Hand of Vengeance",
	["f the sunreavers"]					= "The Sunreavers",
	["f the taunka"]						= "The Taunka",
	["f warsong offensive"]					= "Warsong Offensive",
	-- Sholazar Basin
	["f frenzyheart tribe"]					= "Frenzyheart Tribe",
	["f the oracles"]						= "The Oracles",

	-- The Burning Crusade
	["f ashtongue deathsworn"]				= "Ashtongue Deathsworn",
	["f cenarion expedition"]				= "Cenarion Expedition",
	["f honor hold"]						= "Honor Hold",
	["f keepers of time"]					= "Keepers of Time",
	["f kurenai"]							= "Kurenai",
	["f netherwing"]						= "Netherwing",
	["f ogri'la"]							= "Ogri'la",
	["f sporeggar"]							= "Sporeggar",
	["f the consortium"]					= "The Consortium",
	["f the mag'har"]						= "The Mag'har",
	["f the scale of the sands"]			= "The Scale of the Sands",
	["f the violet eye"]					= "The Violet Eye",
	["f thrallmar"]							= "Thrallmar",
	["f tranquillien"]						= "Tranquillien",
	-- Shattrath City
	["f lower city"]						= "Lower City",
	["f sha'tari skyguard"]					= "Sha'tari Skyguard",
	["f shattered sun offensive"]			= "Shattered Sun Offensive",
	["f the aldor"]							= "The Aldor",
	["f the scryers"]						= "The Scryers",
	["f the sha'tar"]						= "The Sha'tar",

	-- Classic
	["f argent dawn"]						= "Argent Dawn",
	["f bloodsail buccaneers"]				= "Bloodsail Buccaneers",
	["f brood of nozdormu"]					= "Brood of Nozdormu",
	["f cenarion circle"]					= "Cenarion Circle",
	["f darkmoon faire"]					= "Darkmoon Faire",
	["f hydraxian waterlords"]				= "Hydraxian Waterlords",
	["f ravenholdt"]						= "Ravenholdt",
	["f thorium brotherhood"]				= "Thorium Brotherhood",
	["f timbermaw hold"]					= "Timbermaw Hold",
	["f wintersaber trainers"]				= "Wintersaber Trainers",
	-- Alliance
	["f darnassus"]							= "Darnassus",
	["f exodar"]							= "Exodar",
	["f gilneas"]							= "Gilneas",
	["f gnomeregan"]						= "Gnomeregan",
	["f ironforge"]							= "Ironforge",
	["f stormwind"]							= "Stormwind",
	["f tushui pandaren"]					= "Tushui Pandaren",
	-- Alliance Forces
	["f silverwing sentinels"]				= "Silverwing Sentinels",
	["f stormpike guard"]					= "Stormpike Guard",
	["f the league of arathor"]				= "The League of Arathor",
	-- Horde
	["f bilgewater cartel"]					= "Bilgewater Cartel",
	["f darkspear trolls"]					= "Darkspear Trolls",
	["f huojin pandaren"]					= "Huojin Pandaren",
	["f orgrimmar"]							= "Orgrimmar",
	["f silvermoon city"]					= "Silvermoon City",
	["f thunder bluff"]						= "Thunder Bluff",
	["f undercity"]							= "Undercity",
	-- Horde Forces
	["f frostwolf clan"]					= "Frostwolf Clan",
	["f the defilers"]						= "The Defilers",
	["f warsong outriders"]					= "Warsong Outriders",
	-- Steamwheedle Cartel
	["f booty bay"]							= "Booty Bay",
	["f everlook"]							= "Everlook",
	["f gadgetzan"]							= "Gadgetzan",
	["f ratchet"]							= "Ratchet",
}



-- Realm Name Acronyms

-- Note that these are not language-specific and should include all available realms, as players may mix realms freely
-- Only include lowercase, single words that need to be specially acronymed

-- I have gone through all English, German and Spanish reams (US, Oceanic and EU) as of 2018-02-17
-- If I missed something you want specially acronymed, please submit a ticket on GitHub to get it added:
-- https://github.com/leobolin/Paragon/issues

-- To Do:
--  - Russian realms need to be added (future Russian translator please help!)
--  - If someone wants to sort them alphabetically for OCD reasons, be my guest

T.realm_acronyms = {
	["azuremyst"] = "AM",
	["bladefist"] = "BF",
	["bloodfeather"] = "BF",
	["bronzebeard"] = "BB",
	["darrowmere"] = "DM",
	["dragonblight"] = "DB",
	["galakrond"] = "GK",
	["korialstrasz"] = "KSZ",
	["lightbringer"] = "LB",
	["moonrunner"] = "MR",
	["proudmoore"] = "PM",
	["shadowsong"] = "SS",
	["shu'halo"] = "SH",
	["silvermoon"] = "SM",
	["skywall"] = "SW",
	["windrunner"] = "WR",
	["blackrock"] = "BR",
	["blackwing"] = "BW",
	["bonechewer"] = "BC",
	["boulderfist"] = "BF",
	["coilfang"] = "CF",
	["crushridge"] = "CR",
	["daggerspine"] = "DS",
	["destromath"] = "DM",
	["dragonmaw"] = "DM",
	["dunemaul"] = "DM",
	["frostwolf"] = "FW",
	["gorgonnash"] = "GG",
	["gurubashi"] = "GB",
	["kil'jaeden"] = "KJ",
	["nazjatar"] = "NJ",
	["ner'zhul"] = "NZ",
	["rivendare"] = "RD",
	["spinebreaker"] = "SB",
	["spirestone"] = "SS",
	["stonemaul"] = "SM",
	["stormscale"] = "SC",
	["feathermoon"] = "FM",
	["azjol-nerub"] = "AN",
	["doomhammer"] = "DH",
	["icecrown"] = "IC",
	["perenolde"] = "PN",
	["zangarmarsh"] = "ZM",
	["kel'thuzad"] = "KT",
	["darkspear"] = "DS",
	["deathwing"] = "DW",
	["bloodscalp"] = "BS",
	["nathrezim"] = "NR",
	["alexstrasza"] = "AX",
	["blackhand"] = "BH",
	["dawnbringer"] = "DB",
	["fizzcrank"] = "FC",
	["ghostlands"] = "GL",
	["greymane"] = "GM",
	["hellscream"] = "HS",
	["hydraxis"] = "HX",
	["kael'thas"] = "KT",
	["mok'nathal"] = "MN",
	["nesingwary"] = "NW",
	["quel'dorei"] = "QD",
	["ravencrest"] = "RC",
	["runetotem"] = "RT",
	["sen'jin"] = "SJ",
	["staghelm"] = "SH",
	["terokkar"] = "TK",
	["thunderhorn"] = "TH",
	["vek'nilash"] = "VN",
	["whisperwind"] = "WW",
	["winterhoof"] = "WH",
	["aegwynn"] = "AW",
	["agamaggan"] = "AM",
	["archimonde"] = "AM",
	["azgalor"] = "AG",
	["azshara"] = "AZ",
	["balnazzar"] = "BN",
	["cho'gall"] = "CG",
	["chromaggus"] = "CM",
	["drak'tharon"] = "DT",
	["drak'thul"] = "DT",
	["frostmane"] = "FM",
	["hakkar"] = "HK",
	["mal'ganis"] = "MG",
	["mug'thol"] = "MT",
	["stormreaver"] = "SR",
	["underbog"] = "UB",
	["thunderlord"] = "TL",
	["wildhammer"] = "WH",
	["farstriders"] = "FS",
	["brotherhood"] = "BH",
	["lightninghoof"] = "LH",
	["maelstrom"] = "MS",
	["52"] = "52",
	["bloodhoof"] = "BH",
	["drenden"] = "DD",
	["duskwood"] = "DW",
	["eldre'thalas"] = "ET",
	["exodar"] = "EX",
	["norgannon"] = "NG",
	["stormrage"] = "SR",
	["trollbane"] = "TB",
	["turalyon"] = "TL",
	["uldaman"] = "UM",
	["undermine"] = "UM",
	["zul'jin"] = "ZJ",
	["andorhal"] = "AH",
	["anatheron"] = "AT",
	["anub'arak"] = "AA",
	["auchindoun"] = "AD",
	["dragonflight"] = "DF",
	["dalvengyr"] = "DG",
	["executus"] = "EC",
	["firetree"] = "FT",
	["gorefiend"] = "GF",
	["haomarush"] = "HM",
	["jaedenar"] = "JD",
	["mannoroth"] = "MR",
	["magtheridon"] = "MT",
	["shadowmoon"] = "SM",
	["skullcrusher"] = "SC",
	["smolderthorn"] = "ST",
	["tortheldrin"] = "TT",
	["warsong"] = "WS",
	["zuluhed"] = "ZH",
	["steamwheedle"] = "SW",
	["ravenholdt"] = "RH",
	["aman'thul"] = "AT",
	["caelestrasz"] = "CSZ",
	["dath'remar"] = "DR",
	["khaz'goroth"] = "KG",
	["nagrand"] = "NG",
	["saurfang"] = "SF",
	["barthilas"] = "BT",
	["dreadmaul"] = "DM",
	["frostmourne"] = "FM",
	["gundrak"] = "GD",
	["jubei'thos"] = "JT",
	["quel'thalas"] = "QT",
	["anachronos"] = "AC",
	["hellfire"] = "HF",
	["al'akir"] = "AA",
	["ahn'qiraj"] = "AQ",
	["darksorrow"] = "DS",
	["frostwhisper"] = "FW",
	["genjuros"] = "GJ",
	["karazhan"] = "KZ",
	["kor'gall"] = "KG",
	["mazrigos"] = "MZ",
	["outland"] = "OL",
	["moonglade"] = "MG",
	["sunstrider"] = "SS",
	["talnivarr"] = "TN",
	["darkmoon"] = "DM",
	["scarshield"] = "SS",
	["drek'thar"] = "DT",
	["vol'jin"] = "VJ",
	["arak-arahm"] = "AA",
	["naxxramas"] = "NX",
	["rashgarroth"] = "RG",
	["sinstralis"] = "SS",
	["throk'feroth"] = "TF",
	["varimathras"] = "VM",
	["clairvoyants"] = "CV",
	["netherstorm"] = "NS",
	["nethersturm"] = "NS", -- German, not a typo
	["nozdormu"] = "ND",
	["blutkessel"] = "BK",
	["dethecus"] = "DC",
	["echsenkessel"] = "EK",
	["gul'dan"] = "GD",
	["krag'jin"] = "KJ",
	["nera'thor"] = "NT",
	["un'goro"] = "UG",
	["vek'lor"] = "VL",
	["wrathbringer"] = "WB",
	["mithrilorden"] = "MO",
	["nachtwache"] = "NW",
	["forscherliga"] = "FL",
	["todeswache"] = "TW",
	["arguswacht"] = "AW",
	["todeskrallen"] = "TK",
	["c'thun"] = "CT",
	["shen'dralar"] = "SD",
	["(português)"] = "", -- Workaround for Aggra EU so it's not displayed as "A("
}

-- End of localization data




-- L metatable
local L, LD = LL[GetLocale()], LL.enUS
T.L = setmetatable({}, { __index = function(self, key)
	local s = L and L[key] or LD[key] or ("#NOLOC#" .. tostring(key) .. "#")
	self[key] = s
	return s
end, __call = function(self, key)
	return self[key]
end })

-- Add localized string to T.standing
T.standing[9] = T.L["faction_standing_paragon"]

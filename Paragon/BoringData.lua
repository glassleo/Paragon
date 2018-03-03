local _, T = ...


-- Player variables
T.player, T.realm, T.level = UnitName("player"), GetRealmName(), UnitLevel("player")
T.classLocalized, T.class, T.classIndex = UnitClass("player")
T.factionGroup, _ = UnitFactionGroup("player")
T.charStr = string.lower(T.player.."-"..T.realm)


-- Standing colors
T.standingColor = {
	"|cffcc2222", -- Hated
	"|cffff0000", -- Hostile
	"|cffee6622", -- Unfriendly
	"|cffffff00", -- Neutral
	"|cff00ff00", -- Friendly
	"|cff00ff88", -- Honored
	"|cff00ffcc", -- Revered
	"|cff4cc2ff", -- Exalted (old color ff00ffff)
	"|cff4cc2ff", -- Paragon
}


-- Reputation item IDs (BoA and BoE)
T.reputationItemBoA = {
	-- Legion
	[152954] = "argussian reach", -- Greater Argussian Reach Insignia (750)
	[152960] = "argussian reach", -- Argussian Reach Insignia (250)
	[152464] = "armies of legionfall", -- Greater Legionfall Insignia (750)
	[146950] = "armies of legionfall", -- Legionfall Insignia (250)
	[152955] = "army of the light", -- Greater Army of the Light Insignia (750)
	[152957] = "army of the light", -- Army of the Light Insignia (250)
	[150927] = "court of farondis", -- Greater Court of Farondis Insignia (1500)
	[146943] = "court of farondis", -- Court of Farondis Insignia (250)
	[141340] = "court of farondis", -- Court of Farondis Insignia (250)
	[150926] = "dreamweavers", -- Greater Dreamweaer Insignia (1500)
	[141339] = "dreamweavers", -- Dreamweaver Insignia (250)
	[146942] = "dreamweavers", -- Dreamweaver Insignia (250)
	[150928] = "highmountain tribe", -- Greater Highmountain Tribe Insignia (1500)
	[141341] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[146944] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[150930] = "the nightfallen", -- Greater Nightfallen Insignia (750)
	[141343] = "the nightfallen", -- Nightfallen Insignia (250)
	[146946] = "the nightfallen", -- Nightfallen Insignia (250)
	[150929] = "the wardens", -- Greater Wardens Insignia (1500)
	[141342] = "the wardens", -- Wardens Insignia (250)
	[146945] = "the wardens", -- Wardens Insignia (250)
	[150925] = "valarjar", -- Greater Valarjar Insignia (1500)
	[141338] = "valarjar", -- Valarjar Insignia (250)
	[146941] = "valarjar", -- Valarjar Insignia (250)

	-- Warlords of Draenor
	--[128315] = "<meta>", -- Medallion of the Legion (1000 to multiple factions)
	[117492] = "arakkoa outcasts", -- Relic of Rukhmar (2500)
	[118100] = "steamwheedle preservation society", -- Highmaul Relic (350)
	[118654] = "steamwheedle preservation society", -- Aogexon's Fang (500)
	[118655] = "steamwheedle preservation society", -- Bergruu's Horn (500)
	[118656] = "steamwheedle preservation society", -- Dekorhan's Tusk (500)
	[118657] = "steamwheedle preservation society", -- Direhoof's Hide (500)
	[118658] = "steamwheedle preservation society", -- Gagrog's Skull (500)
	[118659] = "steamwheedle preservation society", -- Mu'gra's Head (500)
	[118660] = "steamwheedle preservation society", -- Thek'talon's Talon (500)
	[118661] = "steamwheedle preservation society", -- Xelganak's Stinger (500)
	[120172] = "steamwheedle preservation society", -- Vileclaw's Claw (500)

	-- Mists of Pandaria
	[143943] = "dominance offensive", -- Commendation of the Dominance Offensive (300)
	[143947] = "emperor shaohao", -- Commendation of Emperor Shaohao (500)
	[94227]  = "golden lotus", -- Stolen Golden Lotus Insignia (1000)
	[143937] = "golden lotus", -- Commendation of the Golden Lotus (300)
	[143940] = "kirin tor offensive", -- Commendation of the Kirin Tor Offensive (300)
	[143944] = "operation: shieldwall", -- Commendation of Operation: Shieldwall (300)
	[143942] = "order of the cloud serpent", -- Commendation of the Order of the Cloud Serpent (300)
	[94223]  = "shado-pan", -- Stolen Shado-Pan Insignia (1000)
	[143936] = "shado-pan", -- Commendation of the Shado-Pan (300)
	[143945] = "shadow-pan assault", -- Commendation of the Shado-Pan Assault (300)
	[143939] = "sunreaver onslaught", -- Commendation of the Sunreaver Onslaught (300)
	[94225]  = "the august celestials", -- Stolen Celestial Insignia (1000)
	[143938] = "the august celestials", -- Commendation of The August Celestials (300)
	[94226]  = "the klaxxi", -- Stolen Klaxxi Insignia (1000)
	[143935] = "the klaxxi", -- Commendation of The Klaxxi (300)
	[143946] = "the anglers", -- Commendation of The Anglers (300)
	[143941] = "the tillers", -- Commendation of The Tillers (300)

	-- Cataclysm
	[63517]  = "baradin's wardens", -- Baradin's Wardens Commendation (250)
	[133150] = "dragonmaw clan", -- Commendation of the Dragonmaw Clan (500)
	[133152] = "guardians of hyjal", -- Commendation of the Guardians of Hyjal (500)
	[63518]  = "hellscream's reach", -- Hellscream's Reach Commendation (250)
	[133154] = "ramkahen", -- Commendation of the Ramkahen (500)
	[133159] = "the earthen ring", -- Commendation of The Earthen Ring (500)
	[133160] = "therazane", -- Commendation of Therazane (500)
	[133151] = "wildhammer clan", -- Commendation of the Wildhammer Clan (500)

	-- Wrath of the Lich King
	[129942] = "argent crusade", -- Commendation of the Argent Crusade (500)
	[129940] = "kirin tor", -- Commendation of the Kirin Tor (500)
	[129941] = "knights of the ebon blade", -- Commendation of the Ebon Blade (500)
	[129943] = "the sons of hodir", -- Commendation of the Sons of Hodir (500)
	[42780]  = "the sons of hodir", -- Relic of Ulduar (325 per 10)
	[129944] = "the wyrmrest accord", -- Commendation of the Wyrmrest Accord (500)
	[129954] = "horde expedition", -- Commendation of the Horde Expedition (500)
	[129955] = "alliance vanguard", -- Commendation of the Alliance Vanguard (500)

	-- The Burning Crusade
	[129949] = "cenarion expedition", -- Commendation of the Cenarion Expedition (500)
	[129948] = "honor hold", -- Commendation of Honor Hold (500)
	[129950] = "keepers of time", -- Commendation of the Keepers of Time (500)
	[24449]  = "sporeggar", -- Fertile Spores (250 per 6)
	[24246]  = "sporeggar", -- Sanguine Hibiscus (250 per 5)
	[129945] = "the consortium", -- Commendation of The Consortium (500)
	[129947] = "thrallmar", -- Commendation of Thrallmar (500)
	[129951] = "lower city", -- Commendation of Lower City (500)
	[29740]  = "the aldor", -- Fel Armament (350)
	[30809]  = "the aldor", -- Mark of Sargeras (250 per 10)
	[29425]  = "the aldor", -- Mark of Kil'jaeden (250 per 10, up to Honored)
	[29739]  = "the scryers", -- Arcane Tome (350)
	[30810]  = "the scryers", -- Sunfury Signet (250 per 10)
	[29426]  = "the scryers", -- Firewing Signet (250 per 10, up to Honored)
	[129946] = "the sha'tar", -- Commendation of The Sha'tar

	-- Classic
	[20404] = "cenarion circle", -- Encrypted Twilight Text (500 per 10)
	[17010] = "thorium brotherhood", -- Fiery Core (500)
	[17011] = "thorium brotherhood", -- Lava Core (500)
	[18945] = "thorium brotherhood", -- Dark Iron Residue (625 per 100 or 15 per 4)
}

-- Reputation item IDs (soulbound)
T.reputationItemBoP = {
	-- Legion
	[152961] = "argussian reach", -- Greater Argussian Reach Insignia (750)
	[152959] = "argussian reach", -- Argussian Reach Insignia (250)
	[147727] = "armies of legionfall", -- Greater Legionfall Insignia (750)
	[146949] = "armies of legionfall", -- Legionfall Insignia (250)
	[152956] = "army of the light", -- Greater Army of the Light Insignia (750)
	[152958] = "army of the light", -- Army of the Light Insignia (250)
	[138777] = "conjurer margoss", -- Drowned Mana (50)
	[147410] = "court of farondis", -- Greater Court of Farondis Insignia (1500)
	[141989] = "court of farondis", -- Greater Court of Farondis Insignia (1500)
	[146937] = "court of farondis", -- Court of Farondis Insignia (250)
	[139023] = "court of farondis", -- Court of Farondis Insignia (250)
	[141988] = "dreamweavers", -- Greater Dreamweaer Insignia (1500)
	[147411] = "dreamweavers", -- Greater Dreamweaer Insignia (1500)
	[139021] = "dreamweavers", -- Dreamweaver Insignia (250)
	[146936] = "dreamweavers", -- Dreamweaver Insignia (250)
	[141990] = "highmountain tribe", -- Greater Highmountain Tribe Insignia (1500)
	[147412] = "highmountain tribe", -- Greater Highmountain Tribe Insignia (1500)
	[139024] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[146938] = "highmountain tribe", -- Highmountain Tribe Insignia (250)
	[147413] = "the nightfallen", -- Greater Nightfallen Insignia (750)
	[141992] = "the nightfallen", -- Greater Nightfallen Insignia (750)
	[139026] = "the nightfallen", -- Nightfallen Insignia (250)
	[146940] = "the nightfallen", -- Nightfallen Insignia (250)
	[141870] = "the nightfallen", -- Arcane Tablet of Falanar (100, up to Exalted)
	[147416] = "the nightfallen", -- Arcane Tablet of Falanar (100)
	[140260] = "the nightfallen", -- Arcane Remnant of Falanar (25, up to Exalted)
	[147418] = "the nightfallen", -- Arcane Remnant of Falanar (25)
	[141991] = "the wardens", -- Greater Wardens Insignia (1500)
	[147415] = "the wardens", -- Greater Wardens Insignia (1500)
	[139025] = "the wardens", -- Wardens Insignia (250)
	[146939] = "the wardens", -- Wardens Insignia (250)
	[141987] = "valarjar", -- Greater Valarjar Insignia (1500)
	[147414] = "valarjar", -- Greater Valarjar Insignia (1500)
	[139020] = "valarjar", -- Valarjar Insignia (250)
	[146935] = "valarjar", -- Valarjar Insignia (250)
	[142363] = "talon's vengeance", -- Mark of Prey (100)
	[146960] = "akule riverhorn", -- Ancient Totem Fragment (75)
	[146961] = "corbyn", -- Shiny Bauble (75)
	[146848] = "ilyssia of the waters", -- Framented Enchantment (75)
	[146963] = "impus", -- Desecrated Seaweed (75)
	[146959] = "keeper rayne", -- Corrupted Globule (75)
	[146962] = "sha'leth", -- Golden Minnow (75)

	-- Warlords of Draenor
	[118099] = "steamwheedle preservation society", -- Gorian Artifact Fragment (250 per 20)

	-- Mists of Pandaria
	--[[ NYI
	[79265]  = "<meta>", -- Blue Feather (900 with Chee Chee or Old Hillpaw, 540 with other Tillers members)
	[79266]  = "<meta>", -- Jade Cat (900 with Ella or Fish Fellreed, 540 with other Tillers members)
	[79267]  = "<meta>", -- Lovely Apple (900 with Jogu the Drunk or Sho, 540 with other Tillers members)
	[79268]  = "<meta>", -- Marsh Lily (900 with Farmer Fung or Gina Mudclaw, 540 with other Tillers members)
	[79264]  = "<meta>", -- Ruby Shard (900 with Haohan Mudclaw or Tina Mudclaw, 540 with other Tillers members)
	]]

	-- Cataclysm
	[65909] = "dragonmaw clan", -- Tabard of the Dragonmaw Clan
	[65906] = "guardians of hyjal", -- Tabard of the Guardians of Hyjal
	[65904] = "ramkahen", -- Tabard of Ramkahen
	[65905] = "the earthen ring", -- Tabard of the Earthen Ring
	[65907] = "therazane", -- Tabard of Therazane
	[65908] = "wildhammer clan", -- Tabard of the Wildhammer Clan

	-- Wrath of the Lich King
	[44711]  = "argent crusade", -- Argent Crusade Commendation Badge (520)
	[43154]  = "argent crusade", -- Tabard of the Argent Crusade
	[44713]  = "knights of the ebon blade", -- Ebon Blade Commendation Badge (520)
	[43155]  = "knights of the ebon blade", -- Tabard of the Ebon Blade
	[43950]  = "kirin tor", -- Kirin Tor Commendation Badge
	[43157]  = "kirin tor", -- Tabard of the Kirin Tor
	[49702]  = "the Sons of hodir", -- Sons of Hodir Commendation Badge (520)
	[44710]  = "wyrmrest cccord", -- Wyrmrest Commendation Badge (520)
	[43156]  = "wyrmrest accord", -- Tabard of the Wyrmrest Accord

	-- The Burning Crusade
	[32506]  = "netherwing", -- Netherwing Egg (250)
	--[25433] = "<meta>", -- Consortium and Kurenai/Mag'har
	[29209] = "the consortium", -- Zaxxis Insignia (250 per 10)
	[25416] = "the consortium", -- Oshu'gun Crystal Fragment (250 per 10, up to Friendly)
	[25463] = "the consortium", -- Pair of Ivory Tusks (250 per 3, up to Friendly)

	-- Classic
	[71088]  = "bilgewater cartel", -- Bilgewater Writ of Commendation (250)
	[64884]  = "bilgewater cartel", -- Bilgewater Cartel Tabard
	[45720]  = "darkspear trolls", -- Sen'jin Commendation Badge (250)
	[70150]  = "darkspear trolls", -- Sen'jin Writ of Commendation (250)
	[45582]  = "darkspear trolls", -- Darkspear Tabard
	[45714]  = "darnassus", -- Darnassus Commendation Badge (250)
	[70145]  = "darnassus", -- Darnassus Writ of Commendation (250)
	[45579]  = "darnassus", -- Darnassus Tabard
	[45715]  = "exodar", -- Exodar Commendation Badge (250)
	[70146]  = "exodar", -- Exodar Writ of Commendation (250)
	[45580]  = "exodar", -- Exodar Tabard
	[71087]  = "gilneas", -- Gilneas Writ of Commendation (250)
	[64882]  = "gilneas", -- Gilneas Tabard
	[45716]  = "gnomeregan", -- Gnomeregan Commendation Badge (250)
	[70147]  = "gnomeregan", -- Gnomeregan Writ of Commendation (250)
	[45578]  = "gnomeregan", -- Gnomeregan Tabard
	[83080]  = "huojin pandaren", -- Huojin Tabard
	[45717]  = "ironforge", -- Ironforge Commendation Badge (250)
	[70148]  = "ironforge", -- Ironforge Writ of Commendation (250)
	[45577]  = "ironforge", -- Ironforge Tabard
	[45719]  = "orgrimmar", -- Orgrimmar Commendation Badge (250)
	[70149]  = "orgrimmar", -- Orgrimmar Writ of Commendation (250)
	[45581]  = "orgrimmar", -- Orgrimmar Tabard
	[45721]  = "silvermoon city", -- Silvermoon Commendation Badge (250)
	[70151]  = "silvermoon city", -- Silvermoon Writ of Commendation (250)
	[45585]  = "silvermoon city", -- Silvermoon City Tabard
	[45718]  = "stormwind", -- Stormwind Commendation Badge (250)
	[70152]  = "stormwind", -- Stormwind Writ of Commendation (250)
	[45574]  = "stormwind", -- Stormwind Tabard
	[45722]  = "thunder bluff", -- Thunder Bluff Commendation Badge (250)
	[70153]  = "thunder bluff", -- Thunder Bluff Writ of Commendation (250)
	[45584]  = "thunder bluff", -- Thunder Bluff Tabard
	[83079]  = "tushui pandaren", -- Tushui Tabard
	[45723]  = "undercity", -- Undercity Commendation Badge (250)
	[70154]  = "undercity", -- Undercity Writ of Commendation (250)
	[45583]  = "undercity", -- Undercity Tabard
}


-- Localized standing
T.standing = {
	[1] = FACTION_STANDING_LABEL1, -- Hated
	[2] = FACTION_STANDING_LABEL2, -- Hostile
	[3] = FACTION_STANDING_LABEL3, -- Unfriendly
	[4] = FACTION_STANDING_LABEL4, -- Neutral
	[5] = FACTION_STANDING_LABEL5, -- Friendly
	[6] = FACTION_STANDING_LABEL6, -- Honored
	[7] = FACTION_STANDING_LABEL7, -- Revered
	[8] = FACTION_STANDING_LABEL8, -- Exalted
	[9] = "Paragon", -- Paragon - this is localized as faction_standing_paragon in Locale.lua
}


-- Factions
T.faction = {
	-- Guild
	["guild"] 								= { ["id"] = 1168, 	["icon"] = 135026, 		["paragon"] = false, },

	-- Legion
	["argussian reach"] 					= { ["id"] = 2170, 	["icon"] = 1708496, 	["paragon"] = true,  },
	["armies of legionfall"] 				= { ["id"] = 2045, 	["icon"] = 1585421, 	["paragon"] = true,  },
	["army of the light"] 					= { ["id"] = 2165, 	["icon"] = 1708497, 	["paragon"] = true,  },
	["chromie"]								= { ["id"] = 2135, 	["icon"] = 237538, 		["paragon"] = false, },
	["conjurer margoss"]					= { ["id"] = 1975, 	["icon"] = 132852, 		["paragon"] = false, },
	["court of farondis"] 					= { ["id"] = 1900, 	["icon"] = 1394952, 	["paragon"] = true,  },
	["dreamweavers"] 						= { ["id"] = 1883, 	["icon"] = 1394953, 	["paragon"] = true,  },
	["highmountain tribe"] 					= { ["id"] = 1828, 	["icon"] = 1394954, 	["paragon"] = true,  },
	["the nightfallen"] 					= { ["id"] = 1859, 	["icon"] = 1394956, 	["paragon"] = true,  },
	["the wardens"] 						= { ["id"] = 1894, 	["icon"] = 1394958, 	["paragon"] = true,  },
	["valarjar"] 							= { ["id"] = 1948, 	["icon"] = 1394957, 	["paragon"] = true,  },
	["talon's vengeance"]					= { ["id"] = 2018, 	["icon"] = 537444, 		["paragon"] = false, },
	-- Fisherfriends
	["akule riverhorn"]						= { ["id"] = 2099, 	["icon"] = 11725, 		["paragon"] = false, },
	["corbyn"]								= { ["id"] = 2100, 	["icon"] = 11725, 		["paragon"] = false, },
	["ilyssia of the waters"]				= { ["id"] = 2097, 	["icon"] = 11725, 		["paragon"] = false, },
	["impus"]								= { ["id"] = 2102, 	["icon"] = 11725, 		["paragon"] = false, },
	["keeper raynae"]						= { ["id"] = 2098, 	["icon"] = 11725, 		["paragon"] = false, },
	["sha'leth"]							= { ["id"] = 2101, 	["icon"] = 11725, 		["paragon"] = false, },

	-- Warlords of Draenor
	["arakkoa outcasts"]					= { ["id"] = 1515, 	["icon"] = 1042646, 	["paragon"] = false, },
	["council of exarchs"]					= { ["id"] = 1731, 	["icon"] = 1048727, 	["paragon"] = false, },
	["frostwolf orcs"]						= { ["id"] = 1445, 	["icon"] = 1044164, 	["paragon"] = false, },
	["hand of the prophet"]					= { ["id"] = 1847, 	["icon"] = 1048305,	 	["paragon"] = false, }, -- temp icon
	["laughing skull orcs"]					= { ["id"] = 1708, 	["icon"] = 1043559, 	["paragon"] = false, },
	["order of the awakened"]				= { ["id"] = 1849, 	["icon"] = 1240656, 	["paragon"] = false, },
	["sha'tari defense"]					= { ["id"] = 1710, 	["icon"] = 1042739, 	["paragon"] = false, },
	["steamwheedle preservation society"]	= { ["id"] = 1711, 	["icon"] = 1052654, 	["paragon"] = false, },
	["the saberstalkers"]					= { ["id"] = 1850, 	["icon"] = 1240657, 	["paragon"] = false, },
	["vol'jin's headhunters"]				= { ["id"] = 1848, 	["icon"] = 1048305, 	["paragon"] = false, }, -- temp icon
	["vol'jin's spear"]						= { ["id"] = 1681, 	["icon"] = 1042727, 	["paragon"] = false, },
	["wrynn's vanguard"]					= { ["id"] = 1682, 	["icon"] = 1042294, 	["paragon"] = false, },
	-- Barracks Bodyguards
	["aeda brightdawn"]						= { ["id"] = 1740, 	["icon"] = 1037260, 	["paragon"] = false, },
	["defender illona"]						= { ["id"] = 1738, 	["icon"] = 1037260, 	["paragon"] = false, },
	["delvar ironfist"]						= { ["id"] = 1733, 	["icon"] = 1037260, 	["paragon"] = false, },
	["leorajh"]								= { ["id"] = 1741, 	["icon"] = 1037260, 	["paragon"] = false, },
	["talonpriest ishaal"]					= { ["id"] = 1737, 	["icon"] = 1037260, 	["paragon"] = false, },
	["tormmok"]								= { ["id"] = 1736, 	["icon"] = 1037260, 	["paragon"] = false, },
	["vivianne"]							= { ["id"] = 1739, 	["icon"] = 1037260, 	["paragon"] = false, },

	-- Mists of Pandaria
	["dominance offensive"]					= { ["id"] = 1375, 	["icon"] = 463451, 		["paragon"] = false, },
	["emperor shaohao"]						= { ["id"] = 1492, 	["icon"] = 607848, 		["paragon"] = false, },
	["forest hozen"]						= { ["id"] = 1228, 	["icon"] = 132159, 		["paragon"] = false, }, -- temp icon
	["golden lotus"]						= { ["id"] = 1269, 	["icon"] = 643910, 		["paragon"] = false, },
	["kirin tor offensive"]					= { ["id"] = 1387, 	["icon"] = 801132, 		["paragon"] = false, },
	["operation: shieldwall"]				= { ["id"] = 1376, 	["icon"] = 463450, 		["paragon"] = false, },
	["order of the cloud serpent"]			= { ["id"] = 1271, 	["icon"] = 646324, 		["paragon"] = false, },
	["pearlfin jinyu"]						= { ["id"] = 1242, 	["icon"] = 463858, 		["paragon"] = false, }, -- temp icon
	["shado-pan"]							= { ["id"] = 1270, 	["icon"] = 645204, 		["paragon"] = false, },
	["shado-pan assault"]					= { ["id"] = 1435, 	["icon"] = 838811, 		["paragon"] = false, },
	["sunreaver onslaught"]					= { ["id"] = 1388, 	["icon"] = 838819, 		["paragon"] = false, },
	["the august celestials"]				= { ["id"] = 1341, 	["icon"] = 645203, 		["paragon"] = false, },
	["the black prince"]					= { ["id"] = 1359, 	["icon"] = 656543, 		["paragon"] = false, },
	["the klaxxi"]							= { ["id"] = 1337, 	["icon"] = 646377, 		["paragon"] = false, },
	["the lorewalkers"]						= { ["id"] = 1345, 	["icon"] = 617219, 		["paragon"] = false, },
	["the anglers"]							= { ["id"] = 1302, 	["icon"] = 89401, 		["paragon"] = false, },
	["nat pagle"]							= { ["id"] = 1358, 	["icon"] = 133152, 		["paragon"] = false, },
	["the tillers"]							= { ["id"] = 1272, 	["icon"] = 645198, 		["paragon"] = false, },
	["chee chee"]							= { ["id"] = 1277, 	["icon"] = 132926, 		["paragon"] = false, }, -- blue feather
	["ella"]								= { ["id"] = 1275, 	["icon"] = 454045, 		["paragon"] = false, }, -- jade cat
	["farmer fung"]							= { ["id"] = 1283, 	["icon"] = 134210, 		["paragon"] = false, }, -- marsh lily
	["fish fellreed"]						= { ["id"] = 1282, 	["icon"] = 454045, 		["paragon"] = false, }, -- jade cat
	["gina mudclaw"]						= { ["id"] = 1281, 	["icon"] = 134210, 		["paragon"] = false, }, -- marsh lily
	["haohan mudclaw"]						= { ["id"] = 1279, 	["icon"] = 237204, 		["paragon"] = false, }, -- ruby shard
	["jogu the drunk"]						= { ["id"] = 1273, 	["icon"] = 133975, 		["paragon"] = false, }, -- lovely apple
	["old hillpaw"]							= { ["id"] = 1276, 	["icon"] = 132926, 		["paragon"] = false, }, -- blue feather
	["sho"]									= { ["id"] = 1278, 	["icon"] = 133975, 		["paragon"] = false, }, -- lovely apple
	["tina mudclaw"]						= { ["id"] = 1280, 	["icon"] = 237204, 		["paragon"] = false, }, -- ruby shard
	["nomi"]								= { ["id"] = 1357, 	["icon"] = 571695, 		["paragon"] = false, }, -- hidden from Reputation Panel

	-- Cataclysm
	["avengers of hyjal"]					= { ["id"] = 1204, 	["icon"] = 512609, 		["paragon"] = false, },
	["baradin's wardens"]					= { ["id"] = 1177, 	["icon"] = 456564, 		["paragon"] = false, },
	["dragonmaw clan"]						= { ["id"] = 1172, 	["icon"] = 456565, 		["paragon"] = false, },
	["guardians of hyjal"]					= { ["id"] = 1158, 	["icon"] = 456570, 		["paragon"] = false, },
	["hellscream's reach"]					= { ["id"] = 1178, 	["icon"] = 456571, 		["paragon"] = false, },
	["ramkahen"]							= { ["id"] = 1173, 	["icon"] = 456574, 		["paragon"] = false, },
	["the earthen ring"]					= { ["id"] = 1135, 	["icon"] = 456567, 		["paragon"] = false, },
	["therazane"]							= { ["id"] = 1171, 	["icon"] = 456572, 		["paragon"] = false, },
	["wildhammer clan"]						= { ["id"] = 1174, 	["icon"] = 456575, 		["paragon"] = false, },

	-- Wrath of the Lich King
	["argent crusade"]						= { ["id"] = 1106, 	["icon"] = 236689, 		["paragon"] = false, },
	["kirin tor"]							= { ["id"] = 1090, 	["icon"] = 236693, 		["paragon"] = false, },
	["knights of the ebon blade"]			= { ["id"] = 1098, 	["icon"] = 236694, 		["paragon"] = false, },
	["the ashen verdict"]					= { ["id"] = 1156, 	["icon"] = 343640, 		["paragon"] = false, }, -- actual icon is same as argent crusade, use 343640 instead
	["the kalu'ak"]							= { ["id"] = 1073, 	["icon"] = 236697, 		["paragon"] = false, },
	["the sons of hodir"]					= { ["id"] = 1119, 	["icon"] = 254107, 		["paragon"] = false, },
	["the wyrmrest accord"]					= { ["id"] = 1091, 	["icon"] = 236699, 		["paragon"] = false, },
	["alliance vanguard"]					= { ["id"] = 1037, 	["icon"] = 463450, 		["paragon"] = false, }, -- generic alliance icon
	["explorer's league"]					= { ["id"] = 1068, 	["icon"] = 463450, 		["paragon"] = false, }, -- generic alliance icon
	["the frostborn"]						= { ["id"] = 1126, 	["icon"] = 463450, 		["paragon"] = false, }, -- generic alliance icon
	["the silver covenant"]					= { ["id"] = 1094, 	["icon"] = 463450, 		["paragon"] = false, }, -- generic alliance icon - tabard uses 134472
	["valiance expedition"]					= { ["id"] = 1050, 	["icon"] = 463450, 		["paragon"] = false, }, -- generic alliance icon
	["horde expedition"]					= { ["id"] = 1052, 	["icon"] = 463451, 		["paragon"] = false, }, -- generic horde icon
	["the hand of vengeance"]				= { ["id"] = 1067, 	["icon"] = 463451, 		["paragon"] = false, }, -- generic horde icon
	["the sunreavers"]						= { ["id"] = 1124, 	["icon"] = 463451, 		["paragon"] = false, }, -- generic horde icon - tabard uses 134473
	["the taunka"]							= { ["id"] = 1064, 	["icon"] = 463451, 		["paragon"] = false, }, -- generic horde icon
	["warsong offensive"]					= { ["id"] = 1085, 	["icon"] = 463451, 		["paragon"] = false, }, -- generic horde icon
	-- Sholazar Basin
	["frenzyheart tribe"]					= { ["id"] = 1104, 	["icon"] = 236698, 		["paragon"] = false, },
	["the oracles"]							= { ["id"] = 1105, 	["icon"] = 46545, 		["paragon"] = false, },

	-- The Burning Crusade
	["ashtongue deathsworn"]				= { ["id"] = 1012, 	["icon"] = 236691, 		["paragon"] = false, },
	["cenarion expedition"]					= { ["id"] = 942, 	["icon"] = 132280, 		["paragon"] = false, }, -- guardian of cenarius icon
	["honor hold"]							= { ["id"] = 946, 	["icon"] = 134502, 		["paragon"] = false, },
	["keepers of time"]						= { ["id"] = 989, 	["icon"] = 134156, 		["paragon"] = false, }, -- generic bronze dragon icon
	["kurenai"]								= { ["id"] = 978, 	["icon"] = 458240, 		["paragon"] = false, }, -- generic icon
	["netherwing"]							= { ["id"] = 1015, 	["icon"] = 132250, 		["paragon"] = false, },
	["ogri'la"]								= { ["id"] = 1038, 	["icon"] = 133594, 		["paragon"] = false, }, -- alt 236695
	["sporeggar"]							= { ["id"] = 970, 	["icon"] = 134532, 		["paragon"] = false, },
	["the consortium"]						= { ["id"] = 933, 	["icon"] = 132881, 		["paragon"] = false, }, -- alt 236426
	["the mag'har"]							= { ["id"] = 941, 	["icon"] = 970886, 		["paragon"] = false, },
	["the scale of the sands"]				= { ["id"] = 990, 	["icon"] = 136106, 		["paragon"] = false, },
	["the violet eye"]						= { ["id"] = 967, 	["icon"] = 236693, 		["paragon"] = false, }, -- kirin tor icon
	["thrallmar"]							= { ["id"] = 947, 	["icon"] = 134504, 		["paragon"] = false, },
	["tranquillien"]						= { ["id"] = 922, 	["icon"] = 236765, 		["paragon"] = false, },
	-- Shattrath City
	["lower city"]							= { ["id"] = 1011, 	["icon"] = 135760, 		["paragon"] = false, },
	["sha'tari skyguard"]					= { ["id"] = 1031, 	["icon"] = 132191, 		["paragon"] = false, },
	["shattered sun offensive"]				= { ["id"] = 1077, 	["icon"] = 134993, 		["paragon"] = false, },
	["the aldor"]							= { ["id"] = 932, 	["icon"] = 255137, 		["paragon"] = false, },
	["the scryers"]							= { ["id"] = 934, 	["icon"] = 255136, 		["paragon"] = false, },
	["the sha'tar"]							= { ["id"] = 935, 	["icon"] = 1708140, 	["paragon"] = false, },

	-- Classic
	["argent dawn"]							= { ["id"] = 529, 	["icon"] = 133441,	 	["paragon"] = false, },
	["bloodsail buccaneers"]				= { ["id"] = 87, 	["icon"] = 133168,	 	["paragon"] = false, },
	["brood of nozdormu"]					= { ["id"] = 910, 	["icon"] = 134156,	 	["paragon"] = false, },
	["cenarion circle"]						= { ["id"] = 609, 	["icon"] = 132280,	 	["paragon"] = false, },
	["darkmoon faire"]						= { ["id"] = 909, 	["icon"] = 1100024,	 	["paragon"] = false, },
	["hydraxian waterlords"]				= { ["id"] = 749, 	["icon"] = 135862,	 	["paragon"] = false, },
	["ravenholdt"]							= { ["id"] = 349, 	["icon"] = 132299,	 	["paragon"] = false, },
	["thorium brotherhood"]					= { ["id"] = 59, 	["icon"] = 1786406,	 	["paragon"] = false, },
	["timbermaw hold"]						= { ["id"] = 576, 	["icon"] = 134227,	 	["paragon"] = false, },
	["wintersaber trainers"]				= { ["id"] = 589, 	["icon"] = 132252,	 	["paragon"] = false, },
	-- Alliance
	["darnassus"]							= { ["id"] = 69, 	["icon"] = 255141,	 	["paragon"] = false, },
	["exodar"]								= { ["id"] = 930, 	["icon"] = 255137,	 	["paragon"] = false, },
	["gilneas"]								= { ["id"] = 1134, 	["icon"] = 466012,	 	["paragon"] = false, },
	["gnomeregan"]							= { ["id"] = 54, 	["icon"] = 255139,	 	["paragon"] = false, },
	["ironforge"]							= { ["id"] = 47, 	["icon"] = 255138,	 	["paragon"] = false, },
	["stormwind"]							= { ["id"] = 72, 	["icon"] = 255140,	 	["paragon"] = false, },
	["tushui pandaren"]						= { ["id"] = 1353, 	["icon"] = 626190,	 	["paragon"] = false, },
	-- Alliance Forces
	["silverwing sentinels"]				= { ["id"] = 890, 	["icon"] = 132279,	 	["paragon"] = false, },
	["stormpike guard"]						= { ["id"] = 730, 	["icon"] = 133433,	 	["paragon"] = false, },
	["the league of arathor"]				= { ["id"] = 509, 	["icon"] = 132351,	 	["paragon"] = false, },
	-- Horde
	["bilgewater cartel"]					= { ["id"] = 1133, 	["icon"] = 463834,	 	["paragon"] = false, },
	["darkspear trolls"]					= { ["id"] = 530, 	["icon"] = 255145,	 	["paragon"] = false, },
	["huojin pandaren"]						= { ["id"] = 1352, 	["icon"] = 626190,	 	["paragon"] = false, },
	["orgrimmar"]							= { ["id"] = 76, 	["icon"] = 255142,	 	["paragon"] = false, },
	["silvermoon city"]						= { ["id"] = 911, 	["icon"] = 255136,	 	["paragon"] = false, },
	["thunder bluff"]						= { ["id"] = 81, 	["icon"] = 255144,	 	["paragon"] = false, },
	["undercity"]							= { ["id"] = 68, 	["icon"] = 255143,	 	["paragon"] = false, },
	-- Horde Forces
	["frostwolf clan"]						= { ["id"] = 729, 	["icon"] = 133283,	 	["paragon"] = false, },
	["the defilers"]						= { ["id"] = 510, 	["icon"] = 237568,	 	["paragon"] = false, },
	["warsong outriders"]					= { ["id"] = 889, 	["icon"] = 132366,	 	["paragon"] = false, },
	-- Steamwheedle Cartel
	["booty bay"]							= { ["id"] = 21, 	["icon"] = 236844,	 	["paragon"] = false, },
	["everlook"]							= { ["id"] = 577, 	["icon"] = 236854,	 	["paragon"] = false, },
	["gadgetzan"]							= { ["id"] = 369, 	["icon"] = 236846,	 	["paragon"] = false, },
	["ratchet"]								= { ["id"] = 470, 	["icon"] = 236717,	 	["paragon"] = false, },
}

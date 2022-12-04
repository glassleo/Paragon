local _, T = ...


-- Player variables
T.player, T.realm, T.level = UnitName("player"), GetRealmName(), UnitLevel("player")
T.classLocalized, T.class, T.classIndex = UnitClass("player")
T.factionGroup, _ = UnitFactionGroup("player")
T.charStr = string.lower(T.player.."-"..T.realm)


-- Standing colors
T.standingColor = {
	[1] = "|cffcc2222", -- Hated
	[2] = "|cffff0000", -- Hostile
	[3] = "|cffee6622", -- Unfriendly
	[4] = "|cffffff00", -- Neutral
	[5] = "|cff00ff00", -- Friendly
	[6] = "|cff00ff88", -- Honored
	[7] = "|cff00ffcc", -- Revered
	[8] = "|cff4cc2ff", -- Exalted (old color ff00ffff)
	[9] = "|cff4cc2ff", -- Paragon
}

T.friendStandingColor = {
	["default"] = {
		[1] = T.standingColor[4], -- Stranger
        [2] = T.standingColor[5], -- Acquaintance/Pal
        [3] = T.standingColor[6], -- Buddy
        [4] = T.standingColor[6], -- Friend
        [5] = T.standingColor[7], -- Good Friend
        [6] = T.standingColor[8], -- Best Friend
        [9] = T.standingColor[9], -- Paragon
	},
	["chromie"] = {
		[1] = T.standingColor[4], -- Whelpling
		[2] = T.standingColor[4], -- Temporal Trainee
		[3] = T.standingColor[5], -- Timehopper
		[4] = T.standingColor[5], -- Chrono-Friend
		[5] = T.standingColor[6], -- Bronze Ally
		[6] = T.standingColor[7], -- Epoch-Mender
		[7] = T.standingColor[8], -- Timelord
	},
	["vivianne"] = {
		[1] = T.standingColor[5], -- Bodyguard
		[2] = T.standingColor[6], -- Trusted Bodyguard
		[3] = T.standingColor[8], -- Personal Wingman
	},
	["court of night"] = {
		[1] = T.standingColor[4], -- Neutral
		[2] = T.standingColor[5], -- Friendly
		[3] = T.standingColor[6], -- Honored
		[4] = T.standingColor[7], -- Revered
		[5] = T.standingColor[8], -- Exalted
	},
	["nomi"] = {
		[3] = T.standingColor[4], -- Apprentice
		[4] = T.standingColor[4], -- Apprentice
		[5] = T.standingColor[5], -- Journeyman
		[6] = T.standingColor[6], -- Journeyman
		[7] = T.standingColor[7], -- Journeyman
		[8] = T.standingColor[8], -- Expert
	},
	["sabellian"] = {
		[3] = T.standingColor[4], -- Acquaintance
		[4] = T.standingColor[5], -- Cohort
		[5] = T.standingColor[6], -- Ally
		[6] = T.standingColor[6], -- Fang
		[7] = T.standingColor[7], -- Friend
		[8] = T.standingColor[8], -- True Friend
		[9] = T.standingColor[9], -- Paragon
	},
}
-- Reuse Bodyguard colors
T.friendStandingColor["aeda brightdawn"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["defender illona"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["delvar ironfist"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["leorajh"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["talonpriest ishaal"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["tormmok"] = T.friendStandingColor["vivianne"]
T.friendStandingColor["wrathion"] = T.friendStandingColor["sabellian"]

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
	[9] = "Paragon", -- Paragon - this is overwritten by localization as faction_standing_paragon in Locale.lua
}

-- Localized friend standing labels
T.friendStanding = {
	["default"] = {
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_acquaintance",
		[3] = "faction_standing_buddy",
		[4] = "faction_standing_friend",
		[5] = "faction_standing_good_friend",
		[6] = "faction_standing_best_friend",
		[9] = "faction_standing_paragon",
	},
	["nat pagle"] = { -- also Conjurer Margoss and Fisherfriends
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_pal",
		[3] = "faction_standing_buddy",
		[4] = "faction_standing_friend",
		[5] = "faction_standing_good_friend",
		[6] = "faction_standing_best_friend",
	},
	["corbyn"] = {
		[1] = "faction_standing_stranger",
		[2] = "faction_standing_curiosity",
		[3] = "faction_standing_non-threat",
		[4] = "faction_standing_friend",
		[5] = "faction_standing_helpful_friend",
		[6] = "faction_standing_best_friend",
	},
	["chromie"] = {
		[1] = "faction_standing_whelpling",
		[2] = "faction_standing_temporal_trainee",
		[3] = "faction_standing_timehopper",
		[4] = "faction_standing_chrono-friend",
		[5] = "faction_standing_bronze_ally",
		[6] = "faction_standing_epoch-mender",
		[7] = "faction_standing_timelord",
	},
	["ve'nari"] = {
		[1] = "faction_standing_dubious",
		[2] = "faction_standing_apprehensive",
		[3] = "faction_standing_tentative",
		[4] = "faction_standing_ambivalent",
		[5] = "faction_standing_cordial",
		[6] = "faction_standing_appreciative",
		[9] = "faction_standing_paragon",
	},
	["vivianne"] = { -- also all other Bodyguards
		[1] = "faction_standing_bodyguard",
		[2] = "faction_standing_trusted_bodyguard",
		[3] = "faction_standing_personal_wingman",
	},
	["nomi"] = {
		[3] = "faction_standing_apprentice",
		[4] = "faction_standing_apprentice",
		[5] = "faction_standing_journeyman",
		[6] = "faction_standing_journeyman",
		[7] = "faction_standing_journeyman",
		[8] = "faction_standing_expert",
	},
	["court of night"] = {
		[1] = "faction_standing_neutral",
		[2] = "faction_standing_friendly",
		[3] = "faction_standing_honored",
		[4] = "faction_standing_revered",
		[5] = "faction_standing_exalted",
	},
	["the archivists' codex"] = {
		[1] = "faction_standing_tier_1",
		[2] = "faction_standing_tier_2",
		[3] = "faction_standing_tier_3",
		[4] = "faction_standing_tier_4",
		[5] = "faction_standing_tier_5",
		[6] = "faction_standing_tier_6",
		[9] = "faction_standing_paragon",
	},
	["artisan's consortium - dragon isles branch"] = {
		[4] = "faction_standing_neutral",
		[5] = "faction_standing_preferred",
		[6] = "faction_standing_respected",
		[7] = "faction_standing_valued",
		[8] = "faction_standing_esteemed",
	},
	["cobalt assembly"] = {
		[4] = "faction_standing_empty",
		[5] = "faction_standing_low",
		[6] = "faction_standing_medium",
		[7] = "faction_standing_high",
		[8] = "faction_standing_maximum",
	},
	["sabellian"] = {
		[3] = "faction_standing_acquaintance",
		[4] = "faction_standing_cohort",
		[5] = "faction_standing_ally",
		[6] = "faction_standing_fang",
		[7] = "faction_standing_friend",
		[8] = "faction_standing_true_friend",
		[9] = "faction_standing_paragon",
	},
}

T.friendStanding["conjurer margoss"] = T.friendStanding["nat pagle"]
T.friendStanding["akule riverhorn"] = T.friendStanding["nat pagle"]
T.friendStanding["ilyssia of the waters"] = T.friendStanding["nat pagle"]
T.friendStanding["impus"] = T.friendStanding["nat pagle"]
T.friendStanding["keeper raynae"] = T.friendStanding["nat pagle"]
T.friendStanding["sha'leth"] = T.friendStanding["nat pagle"]
T.friendStanding["aeda brightdawn"] = T.friendStanding["vivianne"]
T.friendStanding["defender illona"] = T.friendStanding["vivianne"]
T.friendStanding["delvar ironfist"] = T.friendStanding["vivianne"]
T.friendStanding["leorajh"] = T.friendStanding["vivianne"]
T.friendStanding["talonpriest ishaal"] = T.friendStanding["vivianne"]
T.friendStanding["tormmok"] = T.friendStanding["vivianne"]
T.friendStanding["wrathion"] = T.friendStanding["sabellian"]


-- Reputation item IDs - BoA and BoE
T.reputationItemBoA = {
	-- Shadowlands
	[173062] = "court of harvesters", -- Contract: Court of Harvesters
	[186522] = "death's advance", -- Contract: Death's Advance
	[173051] = "the ascended", -- Contract: The Ascended
	[187796] = "the enlightened", -- Contract: The Enlightened
	[191022] = "the enlightened", -- Eternal Curio
	[175924] = "the undying army", -- Contract: The Undying Army
	[173053] = "the wild hunt", -- Contract: The Wild Hunt
	[191299] = "the enlightened", -- Tribute to the Enlightened

	-- Battle for Azeroth
	[165016] = "7th legion", -- Contract: 7th Legion
	[174507] = "7th legion", -- Fallen Soldier's Insignia (250)
	[153668] = "champions of azeroth", -- Contract: Champions of Azeroth
	[174502] = "champions of azeroth", -- Tear of Azeroth (250)
	[168822] = "honeyback hive", -- Thin Jelly (20)
	[168825] = "honeyback hive", -- Rich Jelly (80)
	[168828] = "honeyback hive", -- Royal Jelly (160)
	[153662] = "order of embers", -- Contract: Order of Embers
	[174503] = "order of embers", -- Exotically Spiced Carrot (250)
	[153661] = "proudmoore admiralty", -- Contract: Proudmoore Admiralty
	[174504] = "proudmoore admiralty", -- Proudmoore War Copper (250)
	[172008] = "rajani", -- Contract: Rajani
	[173374] = "rajani", -- Rajani Insignia (250)
	[168960] = "rustbolt resistance", -- Contract: Rustbolt Resistance
	[168497] = "rustbolt resistance", -- Rustbolt Resistance Insignia (100)
	[174521] = "rustbolt resistance", -- Transferable Kernel of E-steam (250)
	[153663] = "storm's wake", -- Contract: Storm's Wake
	[174505] = "storm's wake", -- Tide-Speaker's Tome (250)
	[153665] = "talanji's expedition", -- Contract: Talanji's Expedition
	[174506] = "talanji's expedition", -- Golden Insect Wings (250)
	[165017] = "the honorbound", -- Contract: The Honorbound
	[174508] = "the honorbound", -- Fallen Soldier's Insignia (250)
	[168959] = "the unshackled", -- Contract: Unshackled
	[174523] = "the unshackled", -- Waveswept Abyssal Conch (250)
	[153667] = "tortollan seekers", -- Contract: Tortollan Seekers
	[174519] = "tortollan seekers", -- Verdant Hills of Chokingvine - Page 17 (250)
	[172010] = "uldum accord", -- Contract: Uldum Accord
	[173376] = "uldum accord", -- Uldum Accord Insignia (250)
	[153666] = "voldunai", -- Contract: Voldunai
	[174501] = "voldunai", -- Ornate Voldunai Jewelry (250)
	[153664] = "zandalari empire", -- Contract: Zandalari Empire
	[174518] = "zandalari empire", -- Jani Figurine (250)
	[168956] = "waveblade ankoan", -- Contract: Ankoan
	[174522] = "waveblade ankoan", -- Waveswept Abyssal Conch (250)

	-- Legion
	[153113] = "argussian reach|armies of legionfall|army of the light|court of farondis|dreamweavers|highmountain tribe|the nightfallen|the wardens|valarjar", -- Demon's Soulstone (1000)
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
	[128315] = "arakkoa outcasts|council of exarchs|frostwolf orcs|hand of the prophet|laughing skull orcs|order of the awakened|sha'tari defense|steamwheedle preservation society|the saberstalkers|vol'jin's headhunters", -- Medallion of the Legion (1000)
	[167924] = "arakkoa outcasts", -- Commendation of the Arakkoa Outcasts (300)
	[117492] = "arakkoa outcasts", -- Relic of Rukhmar (2500)
	[167929] = "council of exarchs", -- Commendation of the Council of Exarchs (300)
	[167928] = "frostwolf orcs", -- Commendation of the Frostwolf Orcs (300)
	[168018] = "hand of the prophet", -- Commendation of the Hand of the Prophet (300)
	[167930] = "laughing skull orcs", -- Commendation of the Laughing Skull Orcs (300)
	[167925] = "order of the awakened", -- Commendation of the Order of the Awakened (300)
	[167932] = "sha'tari defense", -- Commendation of the Sha'tari Defense (300)
	[167926] = "steamwheedle preservation society", -- Commendation of the Steamwheedle Preservation Society (300)
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
	[167927] = "the saberstalkers", -- Commendation of the Saberstalkers (300)
	[168017] = "vol'jin's headhunters", -- Commendation of Vol'jin's Headhunters (300)

	-- Mists of Pandaria
	[143943] = "dominance offensive", -- Commendation of the Dominance Offensive (300)
	[143947] = "emperor shaohao", -- Commendation of Emperor Shaohao (500)
	[94227]  = "golden lotus", -- Stolen Golden Lotus Insignia (1000)
	[143937] = "golden lotus", -- Commendation of the Golden Lotus (300)
	[90816]  = "golden lotus", -- Relic of the Thunder King (300)
	[90815]  = "golden lotus", -- Relic of Guo-Lai (150)
	[143940] = "kirin tor offensive", -- Commendation of the Kirin Tor Offensive (300)
	[143944] = "operation: shieldwall", -- Commendation of Operation: Shieldwall (300)
	[143942] = "order of the cloud serpent", -- Commendation of the Order of the Cloud Serpent (300)
	[104286] = "order of the cloud serpent", -- Quivering Firestorm Egg (1000)
	[94223]  = "shado-pan", -- Stolen Shado-Pan Insignia (1000)
	[143936] = "shado-pan", -- Commendation of the Shado-Pan (300)
	[143945] = "shado-pan assault", -- Commendation of the Shado-Pan Assault (300)
	[95496]  = "shado-pan assault", -- Shado-Pan Assault Insignia (100)
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
	[24401]  = "cenarion expedition", -- Unidentified Plant Parts (250 per 10, up to Honored)
	[129949] = "cenarion expedition", -- Commendation of the Cenarion Expedition (500)
	[129948] = "honor hold", -- Commendation of Honor Hold (500)
	[129950] = "keepers of time", -- Commendation of the Keepers of Time (500)
	[24449]  = "sporeggar", -- Fertile Spores (750 per 6)
	[24291]  = "sporeggar", -- Bog Lord Tendril (750 per 6, up to Friendly)
	[24246]  = "sporeggar", -- Sanguine Hibiscus (750 per 5)
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

	-- Guild
	[69209] = "guild", -- Illustrious Guild Tabard (50% increase)
	[69210] = "guild", -- Renowned Guild Tabard (100% increase)
}

-- Reputation item IDs - Soulbound
T.reputationItemBoP = {
	-- Dragonflight
	[192055] = "dragonscale expedition", -- Dragon Isles Artifact
	[200071] = "iskaara tuskarr", -- Sacred Tuskarr Totem
	[200093] = "maruuk centaur", -- Centaur Hunting Trophy
	[199906] = "valdrakken accord", -- Titan Relic

	-- Shadowlands
	[186685] = "the archivists' codex", -- Relic Fragment (0.5)
	[187322] = "the archivists' codex", -- Crumbling Stone Tablet (4)
	[187457] = "the archivists' codex", -- Engraved Glass Pane (4)
	[187324] = "the archivists' codex", -- Gnawed Ancient Idol (4)
	[187323] = "the archivists' codex", -- Runic Diagram (4)
	[187460] = "the archivists' codex", -- Strangely Intricate Key (4)
	[187458] = "the archivists' codex", -- Unearthed Teleporter Sigil (4)
	[187459] = "the archivists' codex", -- Vial of Mysterious Liquid (4)
	[187465] = "the archivists' codex", -- Complicated Organism Harmonizer (24)
	[187327] = "the archivists' codex", -- Encrypted Korthian Journal (24)
	[187463] = "the archivists' codex", -- Enigmatic Map Fragments (24)
	[187325] = "the archivists' codex", -- Faded Razorwing Anatomy Illustration (24)
	[187326] = "the archivists' codex", -- Half-Completed Runeforge Pattern (24)
	[187462] = "the archivists' codex", -- Scroll of Shadowlands Fables (24)
	[187478] = "the archivists' codex", -- White Razorwing Talon (24)
	[187336] = "the archivists' codex", -- Forbidden Weapon Schematics (50)
	[187466] = "the archivists' codex", -- Korthian Cypher Book (50)
	[187332] = "the archivists' codex", -- Recovered Page of Voices (50)
	[187328] = "the archivists' codex", -- Ripped Cosmology Chart (50)
	[187334] = "the archivists' codex", -- Shattered Void Tablet (50)
	[187330] = "the archivists' codex", -- Naaru Shard Fragment (75)
	[187329] = "the archivists' codex", -- Old God Specimen Jar (75)
	[187467] = "the archivists' codex", -- Perplexing Rune-Cube (75)
	[187331] = "the archivists' codex", -- Tattered Fae Designs (75)
	[187311] = "the archivists' codex", -- Azgoth's Tattered Maps (150)
	[187333] = "the archivists' codex", -- Core of an Unknown Titan (150)
	[187350] = "the archivists' codex", -- Displaced Relic (150)
	[187335] = "the archivists' codex", -- Maldraxxus Larva Shell (150)
	[190339] = "the enlightened", -- Enlightened Offering (75)
	[190941] = "the enlightened", -- Teachings of the Elders (75)

	-- Battle for Azeroth
	[170184] = "the unshackled|waveblade ankoan", -- Ancient Reefwalker Bark (350 The Unshackled/Waveblade Ankoan)
	[163617] = "7th legion", -- Rusted Alliance Insignia (250)
	[163217] = "champions of azeroth", -- Azeroth's Tear (250)
	[163614] = "order of embers", -- Exotic Spices (250)
	[163616] = "proudmoore admiralty", -- Dented Coin (250)
	[173375] = "rajani", -- Rajani Insignia (250)
	[173736] = "rustbolt resistance", -- Layered Information Kernel of E-steam (250)
	[163615] = "storm's wake", -- Lost Sea Scroll (250)
	[163619] = "talanji's expedition", -- Golden Beetle (250)
	[163621] = "the honorbound", -- Rusted Horde Insignia (250)
	[170079] = "the unshackled", -- Abyssal Conch (150)
	[169942] = "the unshackled", -- Vibrant Sea Blossom (400)
	[166501] = "tortollan seekers", -- Soggy Page (250)
	[173377] = "uldum accord", -- Uldum Accord Insignia (250)
	[163618] = "voldunai", -- Shimmering Shell (250)
	[170081] = "waveblade ankoan", -- Abyssal Conch (150)
	[169941] = "waveblade ankoan", -- Ceremonial Ankoan Scabbard (400)
	[163620] = "zandalari empire", -- Island Flotsam (250)

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
	[86592]  = "golden lotus|order of the cloud serpent|shado-pan|the anglers|the august celestials|the klaxxi|the lorewalkers|the tillers", -- Hozen Peace Pipe (1000)
	[79265]  = "chee chee|old hillpaw", -- Blue Feather (900 with Chee Chee or Old Hillpaw, 540 with other Tillers members)
	[79266]  = "ella|fish fellreed", -- Jade Cat (900 with Ella or Fish Fellreed, 540 with other Tillers members)
	[79267]  = "jogu the drunk|sho", -- Lovely Apple (900 with Jogu the Drunk or Sho, 540 with other Tillers members)
	[79268]  = "farmer fung|gina mudclaw", -- Marsh Lily (900 with Farmer Fung or Gina Mudclaw, 540 with other Tillers members)
	[79264]  = "haohan mudclaw|tina mudclaw", -- Ruby Shard (900 with Haohan Mudclaw or Tina Mudclaw, 540 with other Tillers members)
	[89155]  = "order of the cloud serpent", -- Onyx Egg (500)

	-- Cataclysm
	[65909]  = "dragonmaw clan", -- Tabard of the Dragonmaw Clan
	[65906]  = "guardians of hyjal", -- Tabard of the Guardians of Hyjal
	[65904]  = "ramkahen", -- Tabard of Ramkahen
	[65905]  = "the earthen ring", -- Tabard of the Earthen Ring
	[65907]  = "therazane", -- Tabard of Therazane
	[65908]  = "wildhammer clan", -- Tabard of the Wildhammer Clan

	-- Wrath of the Lich King
	[44711]  = "argent crusade", -- Argent Crusade Commendation Badge (520)
	[43154]  = "argent crusade", -- Tabard of the Argent Crusade
	[44713]  = "knights of the ebon blade", -- Ebon Blade Commendation Badge (520)
	[43155]  = "knights of the ebon blade", -- Tabard of the Ebon Blade
	[43950]  = "kirin tor", -- Kirin Tor Commendation Badge
	[43157]  = "kirin tor", -- Tabard of the Kirin Tor
	[49702]  = "the sons of hodir", -- Sons of Hodir Commendation Badge (520)
	[44710]  = "wyrmrest cccord", -- Wyrmrest Commendation Badge (520)
	[43156]  = "wyrmrest accord", -- Tabard of the Wyrmrest Accord

	-- The Burning Crusade
	[24290]  = "sporeggar", -- Mature Spore Sack (750 per 10, up to Friendly)
	[32506]  = "netherwing", -- Netherwing Egg (250)
	[32427]  = "netherwing", -- Netherwing Crystal (250 per 30)
	[25433]  = "kurenai|the consortium|the mag'har", -- Obsidian Warbeads (250 Consortium per 10, or 500 Kurenai/Mag'har per 10)
	[29209]  = "the consortium", -- Zaxxis Insignia (250 per 10)
	[25416]  = "the consortium", -- Oshu'gun Crystal Fragment (250 per 10, up to Friendly)
	[25463]  = "the consortium", -- Pair of Ivory Tusks (250 per 3, up to Friendly)

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
	[21377]  = "timbermaw hold", -- Deadwood Headdress Feather (2000 per 5)
	[21383]  = "timbermaw hold", -- Winterfall Spirit Beads (2000 per 5)
}


-- Factions
T.faction = {
	-- Guild
	["guild"] 								= { ["id"] = 1168, 	["icon"] = 135026, 		["paragon"] = false,	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },

	-- Dragonflight
	["dragonscale expedition"] 				= { ["id"] = 2507, 	["icon"] = 4687628, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "renown", 		 ["factionGroup"] = false, },
	["iskaara tuskarr"] 					= { ["id"] = 2511, 	["icon"] = 4687629, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "renown", 		 ["factionGroup"] = false, },
	["maruuk centaur"] 						= { ["id"] = 2503, 	["icon"] = 4687627, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "renown", 		 ["factionGroup"] = false, },
	["valdrakken accord"] 					= { ["id"] = 2510, 	["icon"] = 4687630, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "renown", 		 ["factionGroup"] = false, },
	["artisan's consortium - dragon isles branch"] = { ["id"] = 2544, ["icon"] = 4557373, ["paragon"] = false, 	["friend"] = 0, ["kind"] = "friendship",	 ["factionGroup"] = false, },
	["cobalt assembly"] 					= { ["id"] = 2550,  ["icon"] = 1394893, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "friendship",	 ["factionGroup"] = false, },
	["sabellian"] 							= { ["id"] = 2518,  ["icon"] = 4630449,     ["paragon"] = false,    ["friend"] = 0, ["kind"] = "friendship",     ["factionGroup"] = false, },
	["wrathion"] 							= { ["id"] = 2517,  ["icon"] = 4630449,     ["paragon"] = false,    ["friend"] = 0, ["kind"] = "friendship",     ["factionGroup"] = false, },
	["winterpelt furbolg"] 					= { ["id"] = 2526, 	["icon"] = 4672495, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },

	-- Shadowlands
	["court of harvesters"]					= { ["id"] = 2413, 	["icon"] = 3514227, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["court of night"]						= { ["id"] = 2464, 	["icon"] = 3752258, 	["paragon"] = false, 	["friend"] = 5, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["death's advance"]						= { ["id"] = 2470, 	["icon"] = 4064729, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["marasmius"]							= { ["id"] = 2463, 	["icon"] = 464342, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "friendship",	 ["factionGroup"] = false, }, -- hidden from the Reputation Panel
	["stitchmasters"]						= { ["id"] = 2462, 	["icon"] = 3622121, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "friendship",	 ["factionGroup"] = false, },
	["the archivists' codex"]				= { ["id"] = 2472, 	["icon"] = 1506458, 	["paragon"] = true, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the ascended"]						= { ["id"] = 2407, 	["icon"] = 3257748, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the avowed"]							= { ["id"] = 2439, 	["icon"] = 3601526, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the enlightened"]						= { ["id"] = 2478, 	["icon"] = 4226232, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the ember court"]						= { ["id"] = 2445, 	["icon"] = 3641397, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the undying army"]					= { ["id"] = 2410, 	["icon"] = 3492310, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the wild hunt"]						= { ["id"] = 2465, 	["icon"] = 3575389, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["ve'nari"]								= { ["id"] = 2432, 	["icon"] = 3527519, 	["paragon"] = true, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },

	-- Battle for Azeroth
	["7th legion"]							= { ["id"] = 2159, 	["icon"] = 2032591, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["champions of azeroth"]				= { ["id"] = 2164, 	["icon"] = 2032592, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["honeyback hive"]						= { ["id"] = 2395,  ["icon"] = 2027853,		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["order of embers"]						= { ["id"] = 2161, 	["icon"] = 2032594, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["proudmoore admiralty"]				= { ["id"] = 2160, 	["icon"] = 2065573, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["rajani"]								= { ["id"] = 2415, 	["icon"] = 3196265, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["rustbolt resistance"]					= { ["id"] = 2391, 	["icon"] = 2909316, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["storm's wake"]						= { ["id"] = 2162, 	["icon"] = 2032596, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["talanji's expedition"]				= { ["id"] = 2156, 	["icon"] = 2032597, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["the honorbound"]						= { ["id"] = 2157, 	["icon"] = 2032593, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["the unshackled"]						= { ["id"] = 2373,  ["icon"] = 2821782,		["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["tortollan seekers"]					= { ["id"] = 2163, 	["icon"] = 2032598, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["uldum accord"]						= { ["id"] = 2417, 	["icon"] = 3196264, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["voldunai"]							= { ["id"] = 2158, 	["icon"] = 2032599, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["waveblade ankoan"]					= { ["id"] = 2400,  ["icon"] = 2909045,		["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["zandalari empire"]					= { ["id"] = 2103, 	["icon"] = 2032601, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },

	-- Legion
	["argussian reach"] 					= { ["id"] = 2170, 	["icon"] = 1708496, 	["paragon"] = true,		["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["armies of legionfall"] 				= { ["id"] = 2045, 	["icon"] = 1585421, 	["paragon"] = true,		["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["army of the light"] 					= { ["id"] = 2165, 	["icon"] = 1708497, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["chromie"]								= { ["id"] = 2135, 	["icon"] = 237538, 		["paragon"] = false, 	["friend"] = 7, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["conjurer margoss"]					= { ["id"] = 1975, 	["icon"] = 132852, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["court of farondis"] 					= { ["id"] = 1900, 	["icon"] = 1394952, 	["paragon"] = true,  	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["dreamweavers"] 						= { ["id"] = 1883, 	["icon"] = 1394953, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["highmountain tribe"] 					= { ["id"] = 1828, 	["icon"] = 1394954, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the nightfallen"] 					= { ["id"] = 1859, 	["icon"] = 1394956, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the wardens"] 						= { ["id"] = 1894, 	["icon"] = 1394958, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["valarjar"] 							= { ["id"] = 1948, 	["icon"] = 1394957, 	["paragon"] = true, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["talon's vengeance"]					= { ["id"] = 2018, 	["icon"] = 537444, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	-- Fisherfriends
	["akule riverhorn"]						= { ["id"] = 2099, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["corbyn"]								= { ["id"] = 2100, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- maybe 132915
	["ilyssia of the waters"]				= { ["id"] = 2097, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["impus"]								= { ["id"] = 2102, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- maybe 136218
	["keeper raynae"]						= { ["id"] = 2098, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["sha'leth"]							= { ["id"] = 2101, 	["icon"] = 236575, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },

	-- Warlords of Draenor
	["arakkoa outcasts"]					= { ["id"] = 1515, 	["icon"] = 1042646, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["council of exarchs"]					= { ["id"] = 1731, 	["icon"] = 1048727, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["frostwolf orcs"]						= { ["id"] = 1445, 	["icon"] = 1044164, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["hand of the prophet"]					= { ["id"] = 1847, 	["icon"] = 1048305,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- temp icon
	["laughing skull orcs"]					= { ["id"] = 1708, 	["icon"] = 1043559, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["order of the awakened"]				= { ["id"] = 1849, 	["icon"] = 1240656, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["sha'tari defense"]					= { ["id"] = 1710, 	["icon"] = 1042739, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["steamwheedle preservation society"]	= { ["id"] = 1711, 	["icon"] = 1052654, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the saberstalkers"]					= { ["id"] = 1850, 	["icon"] = 1240657, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["vol'jin's headhunters"]				= { ["id"] = 1848, 	["icon"] = 1048305, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- temp icon
	["vol'jin's spear"]						= { ["id"] = 1681, 	["icon"] = 1042727, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["wrynn's vanguard"]					= { ["id"] = 1682, 	["icon"] = 1042294, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	-- Barracks Bodyguards
	["aeda brightdawn"]						= { ["id"] = 1740, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["defender illona"]						= { ["id"] = 1738, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["delvar ironfist"]						= { ["id"] = 1733, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["leorajh"]								= { ["id"] = 1741, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["talonpriest ishaal"]					= { ["id"] = 1737, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["tormmok"]								= { ["id"] = 1736, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["vivianne"]							= { ["id"] = 1739, 	["icon"] = 1037260, 	["paragon"] = false, 	["friend"] = 3, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },

	-- Mists of Pandaria
	["dominance offensive"]					= { ["id"] = 1375, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["emperor shaohao"]						= { ["id"] = 1492, 	["icon"] = 607848, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["forest hozen"]						= { ["id"] = 1228, 	["icon"] = 132159, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- temp icon
	["golden lotus"]						= { ["id"] = 1269, 	["icon"] = 643910, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["kirin tor offensive"]					= { ["id"] = 1387, 	["icon"] = 801132, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["operation: shieldwall"]				= { ["id"] = 1376, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["order of the cloud serpent"]			= { ["id"] = 1271, 	["icon"] = 646324, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["pearlfin jinyu"]						= { ["id"] = 1242, 	["icon"] = 463858, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- temp icon
	["shado-pan"]							= { ["id"] = 1270, 	["icon"] = 645204, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["shado-pan assault"]					= { ["id"] = 1435, 	["icon"] = 838811, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["sunreaver onslaught"]					= { ["id"] = 1388, 	["icon"] = 838819, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["the august celestials"]				= { ["id"] = 1341, 	["icon"] = 645203, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the black prince"]					= { ["id"] = 1359, 	["icon"] = 656543, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the klaxxi"]							= { ["id"] = 1337, 	["icon"] = 646377, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the lorewalkers"]						= { ["id"] = 1345, 	["icon"] = 645218, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the anglers"]							= { ["id"] = 1302, 	["icon"] = 643874, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["nat pagle"]							= { ["id"] = 1358, 	["icon"] = 133152, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the tillers"]							= { ["id"] = 1272, 	["icon"] = 645198, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	-- The Tillers
	["chee chee"]							= { ["id"] = 1277, 	["icon"] = 132926, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- blue feather
	["ella"]								= { ["id"] = 1275, 	["icon"] = 454045, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- jade cat
	["farmer fung"]							= { ["id"] = 1283, 	["icon"] = 134210, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- marsh lily
	["fish fellreed"]						= { ["id"] = 1282, 	["icon"] = 454045, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- jade cat
	["gina mudclaw"]						= { ["id"] = 1281, 	["icon"] = 134210, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- marsh lily
	["haohan mudclaw"]						= { ["id"] = 1279, 	["icon"] = 237204, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- ruby shard
	["jogu the drunk"]						= { ["id"] = 1273, 	["icon"] = 133975, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- lovely apple
	["old hillpaw"]							= { ["id"] = 1276, 	["icon"] = 132926, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- blue feather
	["sho"]									= { ["id"] = 1278, 	["icon"] = 133975, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- lovely apple
	["tina mudclaw"]						= { ["id"] = 1280, 	["icon"] = 237204, 		["paragon"] = false, 	["friend"] = 6, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- ruby shard
	-- Hidden
	["nomi"]								= { ["id"] = 1357, 	["icon"] = 654236, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "friendship",	 ["factionGroup"] = false, }, -- hidden from the Reputation Panel

	-- Cataclysm
	["avengers of hyjal"]					= { ["id"] = 1204, 	["icon"] = 512609, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["baradin's wardens"]					= { ["id"] = 1177, 	["icon"] = 456564, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["dragonmaw clan"]						= { ["id"] = 1172, 	["icon"] = 456565, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["guardians of hyjal"]					= { ["id"] = 1158, 	["icon"] = 456570, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["hellscream's reach"]					= { ["id"] = 1178, 	["icon"] = 456571, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["ramkahen"]							= { ["id"] = 1173, 	["icon"] = 456574, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the earthen ring"]					= { ["id"] = 1135, 	["icon"] = 456567, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["therazane"]							= { ["id"] = 1171, 	["icon"] = 456572, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["wildhammer clan"]						= { ["id"] = 1174, 	["icon"] = 456575, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },

	-- Wrath of the Lich King
	["argent crusade"]						= { ["id"] = 1106, 	["icon"] = 236689, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["kirin tor"]							= { ["id"] = 1090, 	["icon"] = 236693, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["knights of the ebon blade"]			= { ["id"] = 1098, 	["icon"] = 236694, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the ashen verdict"]					= { ["id"] = 1156, 	["icon"] = 343640, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- actual icon is same as argent crusade, use 343640 instead
	["the kalu'ak"]							= { ["id"] = 1073, 	["icon"] = 236697, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the sons of hodir"]					= { ["id"] = 1119, 	["icon"] = 254107, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the wyrmrest accord"]					= { ["id"] = 1091, 	["icon"] = 236699, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["alliance vanguard"]					= { ["id"] = 1037, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["explorer's league"]					= { ["id"] = 1068, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["the frostborn"]						= { ["id"] = 1126, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["the silver covenant"]					= { ["id"] = 1094, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- generic alliance icon - tabard uses 134472
	["valiance expedition"]					= { ["id"] = 1050, 	["icon"] = 463450, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- generic alliance icon
	["horde expedition"]					= { ["id"] = 1052, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- generic horde icon
	["the hand of vengeance"]				= { ["id"] = 1067, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- generic horde icon
	["the sunreavers"]						= { ["id"] = 1124, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- generic horde icon - tabard uses 134473
	["the taunka"]							= { ["id"] = 1064, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- generic horde icon
	["warsong offensive"]					= { ["id"] = 1085, 	["icon"] = 463451, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", }, -- generic horde icon
	-- Sholazar Basin
	["frenzyheart tribe"]					= { ["id"] = 1104, 	["icon"] = 236698, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the oracles"]							= { ["id"] = 1105, 	["icon"] = 252780, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },

	-- The Burning Crusade
	["ashtongue deathsworn"]				= { ["id"] = 1012, 	["icon"] = 236691, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["cenarion expedition"]					= { ["id"] = 942, 	["icon"] = 132280, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["honor hold"]							= { ["id"] = 946, 	["icon"] = 134502, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["keepers of time"]						= { ["id"] = 989, 	["icon"] = 134156, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- generic bronze dragon icon
	["kurenai"]								= { ["id"] = 978, 	["icon"] = 458240, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", }, -- generic icon
	["netherwing"]							= { ["id"] = 1015, 	["icon"] = 132250, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["ogri'la"]								= { ["id"] = 1038, 	["icon"] = 133594, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- alt 236695
	["sporeggar"]							= { ["id"] = 970, 	["icon"] = 134532, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the consortium"]						= { ["id"] = 933, 	["icon"] = 132881, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, }, -- alt 236426
	["the mag'har"]							= { ["id"] = 941, 	["icon"] = 970886, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["the scale of the sands"]				= { ["id"] = 990, 	["icon"] = 136106, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the violet eye"]						= { ["id"] = 967, 	["icon"] = 135933, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["thrallmar"]							= { ["id"] = 947, 	["icon"] = 134504, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["tranquillien"]						= { ["id"] = 922, 	["icon"] = 236765, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	-- Shattrath City
	["lower city"]							= { ["id"] = 1011, 	["icon"] = 135760, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["sha'tari skyguard"]					= { ["id"] = 1031, 	["icon"] = 132191, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["shattered sun offensive"]				= { ["id"] = 1077, 	["icon"] = 134993, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the aldor"]							= { ["id"] = 932, 	["icon"] = 255137, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the scryers"]							= { ["id"] = 934, 	["icon"] = 255136, 		["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["the sha'tar"]							= { ["id"] = 935, 	["icon"] = 1708140, 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },

	-- Classic
	["argent dawn"]							= { ["id"] = 529, 	["icon"] = 133440,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["bloodsail buccaneers"]				= { ["id"] = 87, 	["icon"] = 133168,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["brood of nozdormu"]					= { ["id"] = 910, 	["icon"] = 134156,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["cenarion circle"]						= { ["id"] = 609, 	["icon"] = 236692,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["darkmoon faire"]						= { ["id"] = 909, 	["icon"] = 1100023,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["hydraxian waterlords"]				= { ["id"] = 749, 	["icon"] = 135862,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["ravenholdt"]							= { ["id"] = 349, 	["icon"] = 132299,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["thorium brotherhood"]					= { ["id"] = 59, 	["icon"] = 1786406,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["timbermaw hold"]						= { ["id"] = 576, 	["icon"] = 236696,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["wintersaber trainers"]				= { ["id"] = 589, 	["icon"] = 132252,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	-- Alliance
	["darnassus"]							= { ["id"] = 69, 	["icon"] = 255141,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["exodar"]								= { ["id"] = 930, 	["icon"] = 255137,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["gilneas"]								= { ["id"] = 1134, 	["icon"] = 466012,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["gnomeregan"]							= { ["id"] = 54, 	["icon"] = 255139,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["ironforge"]							= { ["id"] = 47, 	["icon"] = 255138,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["stormwind"]							= { ["id"] = 72, 	["icon"] = 255140,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["tushui pandaren"]						= { ["id"] = 1353, 	["icon"] = 626190,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	-- Alliance Forces
	["silverwing sentinels"]				= { ["id"] = 890, 	["icon"] = 132279,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["stormpike guard"]						= { ["id"] = 730, 	["icon"] = 133433,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	["the league of arathor"]				= { ["id"] = 509, 	["icon"] = 132351,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Alliance", },
	-- Horde
	["bilgewater cartel"]					= { ["id"] = 1133, 	["icon"] = 463834,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["darkspear trolls"]					= { ["id"] = 530, 	["icon"] = 255145,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["huojin pandaren"]						= { ["id"] = 1352, 	["icon"] = 626190,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["orgrimmar"]							= { ["id"] = 76, 	["icon"] = 255142,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["silvermoon city"]						= { ["id"] = 911, 	["icon"] = 255136,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["thunder bluff"]						= { ["id"] = 81, 	["icon"] = 255144,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["undercity"]							= { ["id"] = 68, 	["icon"] = 255143,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	-- Horde Forces
	["frostwolf clan"]						= { ["id"] = 729, 	["icon"] = 133283,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["the defilers"]						= { ["id"] = 510, 	["icon"] = 237568,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	["warsong outriders"]					= { ["id"] = 889, 	["icon"] = 132366,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = "Horde", },
	-- Steamwheedle Cartel
	["booty bay"]							= { ["id"] = 21, 	["icon"] = 236844,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["everlook"]							= { ["id"] = 577, 	["icon"] = 236854,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["gadgetzan"]							= { ["id"] = 369, 	["icon"] = 236846,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
	["ratchet"]								= { ["id"] = 470, 	["icon"] = 236717,	 	["paragon"] = false, 	["friend"] = 0, ["kind"] = "reputation",	 ["factionGroup"] = false, },
}

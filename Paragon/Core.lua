local _, T = ...
local L = T.L

SLASH_PARAGON1 = "/paragon"
SLASH_PARAGON2 = "/par"

-- Default settings
T.defaults = {
	["chat_output_limit"] = 10,
	["tooltip_personal_enabled"] = true,
	["tooltip_hide_unfriendly"] = true,
	["tooltip_hide_neutral"] = false,
	["tooltip_hide_exalted"] = false,
	["tooltip_alts_enabled"] = true,
	["tooltip_alts_enabled_shift"] = true,
	["tooltip_alts_enabled_alt"] = false,
	["tooltip_alts_limit"] = 3,
	["tooltip_alts_limit_shift"] = 10,
	["display_realm_names"] = true,
	["short_realm_names"] = false,
}


-- Function to check if a set of keys exist
local function setContains(set, key)
    return set[key] ~= nil
end


-- Title Case Function
local function titleCase(str)
	local function tchelper(first, rest)
		return first:upper()..rest:lower()
	end

	return (str:gsub("(%a)([%w_']*)", tchelper))
end

-- Capitalize first word
local function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

-- Table sorting
function getKeysSortedByValue(tbl, sortFunction)
	local keys = {}
	for key in pairs(tbl) do
		table.insert(keys, key)
	end
	
	table.sort(keys, function(a, b)
		return sortFunction(tbl[a], tbl[b])
	end)

	return keys
end

-- Cut off text that is too long
function ellipsis(str, limit)
	if #str > (limit + 1) then
		str = string.sub(str, 0, limit) .. "..."
	end

	return str
end


-- Create the frame and register events
local frame = CreateFrame("FRAME", "ParagonFrame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")


-- Results Frame
local resultsFrame = CreateFrame("FRAME", "ParagonResultsFrame", UIParent, "BasicFrameTemplate")
resultsFrame:SetMovable(true)
resultsFrame:SetSize(420, 580)
resultsFrame:SetPoint("CENTER", UIParent, "CENTER")
resultsFrame:EnableMouse(true)
resultsFrame:RegisterForDrag("LeftButton")
resultsFrame:SetScript("OnDragStart", resultsFrame.StartMoving)
resultsFrame:SetScript("OnDragStop", resultsFrame.StopMovingOrSizing)
resultsFrame:Hide()
tinsert(UISpecialFrames, "ParagonResultsFrame")



local resultsFrameTitle = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
resultsFrameTitle:SetPoint("TOPLEFT", 0, -4)
resultsFrameTitle:SetWidth(420)
resultsFrameTitle:SetJustifyH("CENTER")
resultsFrameTitle:SetText("Paragon")

-- Scroll Frame
resultsScrollFrame = CreateFrame("ScrollFrame", nil, resultsFrame, BackdropTemplateMixin and "BackdropTemplate")
resultsScrollFrame:SetPoint("TOPLEFT", 6, -64)
resultsScrollFrame:SetPoint("BOTTOMRIGHT", -28, 6)
resultsScrollFrame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 8, edgeSize = 8, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 }}
)
resultsScrollFrame:SetBackdropColor(0, 0, 0, 0.8)
resultsScrollFrame:SetBackdropBorderColor(0, 0, 0, 0.8)
resultsScrollFrame:EnableMouseWheel(1)
resultsScrollFrame:SetScript("OnMouseWheel",
	function (self, value)
		resultsScrollbar:SetValue(resultsScrollbar:GetValue() - (value*24*5))
	end
)
resultsFrame.scrollFrame = resultsScrollFrame

-- Scroll Bar
resultsScrollbar = CreateFrame("Slider", nil, resultsScrollFrame, "UIPanelScrollBarTemplate")
resultsScrollbar:SetPoint("TOPLEFT", resultsFrame, "TOPRIGHT", -24, -80)
resultsScrollbar:SetPoint("BOTTOMRIGHT", resultsFrame, "BOTTOMRIGHT", -8, 24)
resultsScrollbar:SetMinMaxValues(1, 1000)
resultsScrollbar:SetValueStep(1)
resultsScrollbar.scrollStep = 24
resultsScrollbar:SetValue(0)
resultsScrollbar:SetWidth(16)
resultsScrollbar:SetScript("OnValueChanged",
	function (self, value)
		self:GetParent():SetVerticalScroll(value)
	end
)
local scrollbg = resultsScrollbar:CreateTexture(nil, "BACKGROUND")
scrollbg:SetAllPoints(resultsScrollbar)
scrollbg:SetTexture(0, 0, 0, 0.4)
frame.scrollbar = resultsScrollbar

-- Content Frame
local resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
resultsScrollFrame.content = resultsContent
resultsScrollFrame:SetScrollChild(resultsContent)


-- Labels
local resultsFrameFactionLabel = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
resultsFrameFactionLabel:SetPoint("TOPLEFT", 12, -32)
resultsFrameFactionLabel:SetHeight(24)
resultsFrameFactionLabel:SetJustifyH("LEFT")
resultsFrameFactionLabel:SetJustifyV("MIDDLE")






-- Realm formatting
local function format_realm(realmName)
	if realmName == T.realm or not ParagonDB2["config"]["display_realm_names"] then
		return "" -- Same realm as player or realm names are turned off
	else
		if ParagonDB2["config"]["short_realm_names"] then
			local parts = {}
			for part in string.gmatch(realmName, "[^ ]+") do
				tinsert(parts, part)
			end

			realmName = ""
			for i, part in pairs(parts) do
				if setContains(T.realm_acronyms, string.lower(part)) then
					realmName = realmName .. T.realm_acronyms[string.lower(part)]
				else
					realmName = realmName .. string.sub(part, 1, 1)
				end
			end
		end

		return "-" .. realmName
	end
end


-- Function to update current player's repuation standings
local function updateFactions()
	if not ParagonDB2 then return end

	-- Replace current character's saved data with current data
	ParagonDB2["character"][T.charStr] = { ["name"] = T.player, ["realm"] = T.realm, ["class"] = T.class, ["level"] = T.level, ["factionGroup"] = T.factionGroup }

	for faction, data in pairs(T.faction) do
		local id, icon, paragon, factionGroup, friend, kind = data["id"], data["icon"], data["paragon"], data["factionGroup"], data["friend"], data["kind"]
		local name, standingId, barMin, barMax, barValue, renownLevel = "", 4, 0, 0, 0, 0

		if kind == "friendship" then
			local friendship = C_GossipInfo.GetFriendshipReputation(id)
			barValue = friendship.standing or 0
			barMin = friendship.reactionThreshold
			barMax = friendship.nextThreshold or 42000
			name = friendship.name or name

			if id == 1740 or id == 1738 or id == 1733 or id == 1741 or id == 1737 or id == 1736 or id == 1739 then -- Garrison Bodyguards
				if barValue >= 20000 then
					standingId = 3
				elseif barValue >= 10000 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2135 then -- Chromie
				if barValue >= 15000 then
					standingId = 7
				elseif barValue >= 10000 then
					standingId = 6
				elseif barValue >= 7000 then
					standingId = 5
				elseif barValue >= 4500 then
					standingId = 4
				elseif barValue >= 2500 then
					standingId = 3
				elseif barValue >= 1000 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2464 or id == 2463 or id == 2462 then -- Court of Night, Marasmius, Stitchmasters
				if barValue >= 42000 then
					standingId = 5
				elseif barValue >= 21000 then
					standingId = 4
				elseif barValue >= 9000 then
					standingId = 3
				elseif barValue >= 3000 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2432 then -- Ve'nari
				if barValue >= 42000 then
					standingId = 6
				elseif barValue >= 21000 then
					standingId = 5
				elseif barValue >= 14000 then
					standingId = 4
				elseif barValue >= 7000 then
					standingId = 3
				elseif barValue >= 1000 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2472 then -- The Archivists' Codex
				if barValue >= 41000 then
					standingId = 6
				elseif barValue >= 25000 then
					standingId = 5
				elseif barValue >= 14000 then
					standingId = 4
				elseif barValue >= 7500 then
					standingId = 3
				elseif barValue >= 3000 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2544 then -- Artisan's Consortium - Dragon Isles Branch
				if barValue >= 12500 then
					standingId = 5
				elseif barValue >= 5500 then
					standingId = 4
				elseif barValue >= 2500 then
					standingId = 3
				elseif barValue >= 500 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2550 then -- Cobalt Assembly
				if barValue >= 10000 then
					standingId = 5
				elseif barValue >= 3600 then
					standingId = 4
				elseif barValue >= 1200 then
					standingId = 3
				elseif barValue >= 300 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2553 then -- Soridormi
				if barValue >= 42000 then
					standingId = 5
				elseif barValue >= 24000 then
					standingId = 4
				elseif barValue >= 14000 then
					standingId = 3
				elseif barValue >= 7000 then
					standingId = 2
				else
					standingId = 1
				end
			elseif id == 2615 then -- Azerothian Archives
				if barValue >= 42000 then
					standingId = 5
				elseif barValue >= 32500 then
					standingId = 4
				elseif barValue >= 21000 then
					standingId = 3
				elseif barValue >= 10500 then
					standingId = 2
				else
					standingId = 1
				end
			else -- Default
				if barValue >= 42000 then
					standingId = 6
				elseif barValue >= 33600 then
					standingId = 5
				elseif barValue >= 25200 then
					standingId = 4
				elseif barValue >= 16800 then
					standingId = 3
				elseif barValue >= 8400 then
					standingId = 2
				else
					standingId = 1
				end
			end
		elseif kind == "renown" then
			local data = C_MajorFactions.GetMajorFactionData(id)
			standingId = data.renownLevel or 1
			barValue = data.renownReputationEarned or 0
			barMax = data.renownLevelThreshold or 2500
			name = data.name or name
		else
			name, _, standingId, barMin, barMax, barValue = GetFactionInfoByID(id)
		end

		local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(id)


		if factionGroup == false or factionGroup == T.factionGroup then -- Only include same side and neutral factions
			if currentValue then
				currentValue = currentValue % threshold
				if hasRewardPending then currentValue = currentValue + threshold end

				ParagonDB2["character"][T.charStr][faction] = {
					["standingId"] = (kind == "renown") and standingId or 9, -- Paragon
					["current"] = currentValue,
					["max"] = threshold,
					["hasRewardPending"] = hasRewardPending,
				}
			elseif kind == "renown" then
				ParagonDB2["character"][T.charStr][faction] = {
					["standingId"] = standingId, -- Renown level
					["current"] = barValue,
					["max"] = barMax,
					["hasRewardPending"] = false,
				}
			elseif barValue then
				ParagonDB2["character"][T.charStr][faction] = {
					["standingId"] = standingId,
					["current"] = barValue - barMin,
					["max"] = barMax - barMin,
					["hasRewardPending"] = false,
				}
			end
		end
	end
end


-- Function to delete saved data for a specified character
local function deleteCharacter(characterName, verbose)
	if not characterName then
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(L["/paragon delete no argument"])
		end
		return
	else
		characterName = string.lower(characterName)
	end

	if setContains(ParagonDB2["character"], characterName) then
		ParagonDB2["character"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character successful"], characterName))
		end
		return
	else
		characterName = characterName .. string.lower("-"..T.realm)
	end

	if setContains(ParagonDB2["character"], characterName) and characterName ~= string.lower("-"..T.realm) then
		ParagonDB2["character"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character successful"], characterName))
		end
		return
	elseif verbose and characterName == string.lower("-"..T.realm) then
		DEFAULT_CHAT_FRAME:AddMessage(L["/paragon delete no argument"])
	elseif verbose then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character not found"], characterName, T.realm))
	end
end


-- Functions to format standings
local function standing(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["kind"] == "renown" then
			if standingId == T.faction[faction]["friend"] then
				return T.standing[9] -- Paragon
			elseif standingId > 0 then
				return L["faction_standing_renown %d"]:format(standingId)
			else
				return L["faction_standing_undiscovered"]
			end
		elseif T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStanding, faction) then
				if T.friendStanding[faction][standingId] then
					return L[T.friendStanding[faction][standingId]]
				else
					return L["faction_standing_unknown"]
				end
			else
				return L[T.friendStanding["default"][standingId]]
			end
		elseif setContains(T.friendStanding, faction) then
			return L[T.friendStanding[faction][standingId]]
		else
			return T.standing[standingId]
		end
	else
		return T.standing[standingId]
	end
end

local function standingColor(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["kind"] == "renown" then
			if standingId == T.faction[faction]["friend"] then
				return T.standingColor[9] -- Max renown
			elseif standingId >= 20 then
				return T.standingColor[7]
			elseif standingId >= 10 then
				return T.standingColor[6]
			elseif standingId > 0 then
				return T.standingColor[5]
			else
				return T.standingColor[4] -- Undiscovered
			end
		elseif T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStandingColor, faction) then
				return T.friendStandingColor[faction][standingId] or T.standingColor[1]
			else
				return T.friendStandingColor["default"][standingId]
			end
		elseif setContains(T.friendStandingColor, faction) then
			return T.friendStandingColor[faction][standingId]
		else
			return T.standingColor[standingId]
		end
	else
		return T.standingColor[standingId]
	end
end


-- Function to output saved data for a specific faction
local function outputFaction(factionName, limit, outputFormat, currentLine)
	local faction = string.lower(factionName) -- Convert to lower case

	updateFactions() -- Make sure player data is up to date

	-- Check if the faction exists
	if not setContains(T.faction, faction) then
		return false
	elseif outputFormat == "test" then
		return true
	end

	-- Local variables
	local factionTable, sortTable = {}, {}
	local ui, scrollcontainer, scroll = nil, nil, nil

	-- Sorting table
	for char, tbl in pairs(ParagonDB2["character"]) do
		if setContains(tbl, faction) then
			factionTable[char] = tbl[faction]
			sortTable[char] = tostring(string.format("%04.4d", tbl[faction]["standingId"]) .. "." .. string.format("%09.7d", tbl[faction]["current"]))
		end
	end

	-- Sort the table
	local sortedKeys
	if outputFormat == "tooltip" and ParagonDB2["config"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then -- Reverse order when holding <Alt>
		sortedKeys = getKeysSortedByValue(sortTable, function(a, b) return a < b end)
	else
		sortedKeys = getKeysSortedByValue(sortTable, function(a, b) return a > b end)
	end

	local i, out = 0, nil
	for _, char in ipairs(sortedKeys) do
		local d = ParagonDB2["character"][char]
		local standingId = factionTable[char]["standingId"]

		if (not (ParagonDB2["config"]["tooltip_hide_exalted"] and standingId == 8) and not (ParagonDB2["config"]["tooltip_hide_neutral"] and standingId == 4) and not (ParagonDB2["config"]["tooltip_hide_unfriendly"] and standingId <= 3)) or outputFormat == "ui" then
			i = i + 1

			if i == 1 then
				if outputFormat == "ui" then
					--content frame
					resultsContent:Hide()

					resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":26:26|t  " .. L["f "..faction])

					resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
					resultsScrollFrame.content = resultsContent
					resultsScrollFrame:SetScrollChild(resultsContent)

					resultsFrame:Show()
				else
					out = "|cFF00FFFFParagon|r\n|T" .. T.faction[faction]["icon"] .. ":0|t " .. L["f "..faction] .. " - " .. L["highest reputation"]
				end
			end

			if i <= limit or outputFormat == "ui" then
				local displayAmount = FormatLargeNumber(factionTable[char]["current"]) .. " / " .. FormatLargeNumber(factionTable[char]["max"])
				if T.faction[faction]["kind"] == "renown" then
					if standingId == 0 or (standingId == T.faction[faction]["friend"] and not T.faction[faction]["paragon"]) then
						displayAmount = "" -- Max renown level (no paragon) or undiscovered
					end
				elseif standingId == 8 or (T.faction[faction]["friend"] ~= 0 and standingId >= T.faction[faction]["friend"] and standingId ~= 9) then -- Exalted/Best Friend
					displayAmount = "" -- Exalted reputations do not have amounts
				end

				local line1 = "|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. ellipsis(d["name"] .. format_realm(d["realm"]), 30) .. "|r  " .. standingColor(standingId, faction) .. standing(standingId, faction) .. "|r"
				local line2 = standingColor(standingId, faction) .. displayAmount .. "|r"
				local line = line1 .. (displayAmount ~= "" and "  " .. line2 or "")

				if outputFormat == "ui" then
					local offset = (i - 1) * -24

					local rowBg = CreateFrame("Frame", nil, resultsContent, BackdropTemplateMixin and "BackdropTemplate")
					rowBg:SetPoint("TOPLEFT", 0, offset or 0)
					rowBg:SetPoint("TOPRIGHT", 0, offset or 0)
					rowBg:SetHeight(24)
					rowBg:SetBackdrop({
						bgFile = "Interface/Tooltips/UI-Tooltip-Background",
						tile = true, tileSize = 8, edgeSize = 0, 
						insets = { left = 0, right = 0, top = 0, bottom = 0 }}
					)
					if i % 2 == 1 then
						rowBg:SetBackdropColor(0, 0, 0, 0.4)
					else
						rowBg:SetBackdropColor(0, 0, 0, 0)
					end

					-- Character Name
					local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
					label:SetPoint("TOPLEFT", 10, 0)
					label:SetText("|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. ellipsis(d["name"] .. format_realm(d["realm"]), 23) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Standing
					local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
					label:SetPoint("TOPLEFT", 175, 0)
					label:SetText(standingColor(standingId, faction) .. standing(standingId, faction) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Amount
					if displayAmount ~= "" then
						local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
						label:SetPoint("TOPLEFT", 270, 0)
						label:SetText(standingColor(standingId, faction) .. displayAmount .. "|r")
						label:SetHeight(24)
						--label:SetWidth(100)
						label:SetJustifyH("LEFT")
						label:SetJustifyV("MIDDLE")
					end
				elseif outputFormat == "tooltip" and i == currentLine then
					return "|cff808080" .. i .. ".|r " .. line1, line2
				else
					out = out .. "\n|cff808080" .. i .. ".|r " .. line
				end
			end
		end
	end

	if i == 0 then
		if outputFormat == "ui" then
			--content frame
			resultsContent:Hide()

			resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":24:24|t  " .. L["f "..faction])

			resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
			resultsScrollFrame.content = resultsContent
			resultsScrollFrame:SetScrollChild(resultsContent)

			resultsFrame:Show()

			local label = resultsContent:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
			label:SetPoint("TOPLEFT", 10, -10)
			label:SetText(string.format(L["reputation not discovered"], L["f "..faction]))
			label:SetJustifyV("MIDDLE")
			label:SetJustifyH("CENTER")
			label:SetWidth(360)
			label:SetHeight(460)
		else
			out = "|cFF00FFFFParagon|r: " .. string.format(L["no results"], "\"" .. L["f "..faction] .. "\"")
		end
	end

	

	if outputFormat == "chat" then
		-- Write data to the chat frame
		DEFAULT_CHAT_FRAME:AddMessage(out)
	elseif outputFormat == "ui" then
		local height = (i*24)-510

		resultsScrollbar:SetValue(0)

		if i <= 21 then
			resultsScrollbar:SetMinMaxValues(1, 1)
			resultsScrollbar:Hide()
			resultsContent:SetSize(420, 510)
		else
			resultsScrollbar:SetMinMaxValues(1, height)
			resultsScrollbar:Show()
			resultsContent:SetSize(420, height)
		end
	end
end


-- Function to add information to item tooltips
local function OnTooltipSetItem(tooltip, data)
	if not data then return end -- If there is no data we do nothing
	local tooltip = tooltip
	local match = string.match

	local link = data.guid and C_Item.GetItemLinkByGUID(data.guid)
	local itemId = data.id or false
	if not link or not itemId then return end

	if setContains(T.reputationItemBoA, itemId) or setContains(T.reputationItemBoP, itemId) then
		updateFactions() -- Make sure player data is up to date

		local bound, faction = nil, nil
		if setContains(T.reputationItemBoA, itemId) then
			bound, faction = "BoA", T.reputationItemBoA[itemId]
		else
			bound, faction = "BoP", T.reputationItemBoP[itemId]
		end

		local d = ParagonDB2["character"][T.charStr]
		local limit = tonumber(ParagonDB2["config"]["tooltip_alts_limit"])
		local limit_shift = tonumber(ParagonDB2["config"]["tooltip_alts_limit_shift"])

		local factions = { strsplit("|", faction) }
		local totalFactions = 0

		for _, faction in pairs(factions) do
			if setContains(d, faction) and ParagonDB2["config"]["tooltip_personal_enabled"] then
				totalFactions = totalFactions + 1

				tooltip:AddLine(" ")
				tooltip:AddLine("|cffffffff" .. L["f "..faction] .. "|r")

				local displayAmount = FormatLargeNumber(d[faction]["current"]) .. " / " .. FormatLargeNumber(d[faction]["max"])
				if T.faction[faction]["kind"] == "renown" then
					if standingId == 0 or (standingId == T.faction[faction]["friend"] and not T.faction[faction]["paragon"]) then
						displayAmount = "" -- Max renown level (no paragon) or undiscovered
					end
				elseif d[faction]["standingId"] == 8 or (T.faction[faction]["friend"] ~= 0 and d[faction]["standingId"] >= T.faction[faction]["friend"]) then
					displayAmount = "" -- Exalted/Best Friend
				end

				if displayAmount ~= "" then
					tooltip:AddDoubleLine(standingColor(d[faction]["standingId"], faction) .. standing(d[faction]["standingId"], faction) .. "|r", standingColor(d[faction]["standingId"], faction) .. displayAmount .. "|r")
				else
					tooltip:AddLine(standingColor(d[faction]["standingId"], faction) .. standing(d[faction]["standingId"], faction) .. "|r")
				end
			end
		end

		if ParagonDB2["config"]["tooltip_alts_enabled"] and limit >= 1 and totalFactions == 1 then
			if bound == "BoA" and outputFaction(faction, 1, "tooltip", 1) then
				tooltip:AddLine(" ")
				if ParagonDB2["config"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					tooltip:AddLine(L["lowest reputation"])
				else
					tooltip:AddLine(L["highest reputation"])
				end
				tooltip:AddDoubleLine(outputFaction(faction, 1, "tooltip", 1))

				if limit >= 2 then
					for i = 2, limit do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddDoubleLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				end

				if ParagonDB2["config"]["tooltip_alts_enabled_shift"] and limit_shift > limit and IsShiftKeyDown() then
					for i = (limit + 1), limit_shift do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddDoubleLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				elseif ParagonDB2["config"]["tooltip_alts_enabled_shift"] and limit_shift > limit and outputFaction(faction, (limit + 1), "tooltip", (limit + 1)) then
					tooltip:AddLine("|cff00ff00"..L["hold shift for more"].."|r")
				end
			end
		elseif ParagonDB2["config"]["tooltip_alts_enabled_shift"] and limit_shift >= 1 and totalFactions == 1 then
			if IsShiftKeyDown() then
				tooltip:AddLine(" ")
				if ParagonDB2["config"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					tooltip:AddLine(L["lowest reputation"])
				else
					tooltip:AddLine(L["highest reputation"])
				end
				tooltip:AddDoubleLine(outputFaction(faction, 1, "tooltip", 1))

				if limit_shift >= 2 then
					for i = 2, limit_shift do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddDoubleLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				end
			else
				tooltip:AddLine(" ")
				tooltip:AddLine("|cff00ff00"..L["hold shift for highest reputation"].."|r")
			end
		end
	end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)


-- Slash Commands
function SlashCmdList.PARAGON(msg, editbox)
	local _, _, cmd, args = string.find(msg, "([%w%p]+)%s*(.*)$")
	if(cmd) then
		cmd = string.lower(cmd)
	end
	if(args) then
		args = string.lower(args)
	end

	if cmd == "config" or cmd == "cfg" or cmd == "settings" or cmd == "options" then
		InterfaceOptionsFrame_OpenToCategory("Paragon")
	elseif cmd == "delete" or cmd == "del" then
		deleteCharacter(args, true)
	else
		local guildname = GetGuildInfo("player")

		if L["shorthands"] and L["shorthands"][string.lower(msg)] then
			msg = L["shorthands"][string.lower(msg)]
		elseif guildname and msg and string.lower(msg) == string.lower(guildname) then
			msg = "guild"
		-- Since shorthands and guild have failed, try partial match now
		-- Make sure no valid full faction string is given either
		else --if not outputFaction(msg, 1, "test") then
			msg = string.lower(msg)
			-- Partial string match against the localized faction name strings
			local found = false
			for f, _ in pairs(T.faction) do
				if L["f "..f] then
					if L["f "..f]:lower():find(msg, nil, true) then
						--print(format('Paragon Debug: Found "%s" as partial string in faction "%s".', msg, L["f "..f])) -- Debug
						msg, found = L["f "..f], true
						break
					end
				end
			end
			-- As last resort, partial string match against the shorthand strings
			if not found and L["shorthands"] then
				for s, f in pairs(L["shorthands"]) do
					if s:find(msg, nil, true) then
						--print(format('Paragon Debug: Found "%s" as partial string in shorthand "%s".', msg, s)) -- Debug
						msg = f
						break
					end
				end
			end
		end

		if outputFaction(msg, 1, "test") then
			outputFaction(msg, 0, "ui")
		else
			DEFAULT_CHAT_FRAME:AddMessage(L["/paragon help"])
		end
	end
end


-- Event Handler
local function eventHandler(self, event)
	if event == "VARIABLES_LOADED" then
		-- Make sure defaults are set
		if not ParagonDB2 then
			if ParagonDB and ParagonDB["config"] then
				-- Migrate old DB to DB2
				ParagonDB2 = ParagonDB
				ParagonDB = false

				for name, _ in pairs(ParagonDB2["character"]) do
					ParagonDB2["character"][name]["artisan's consortium - dragon isles branch"] = nil
					ParagonDB2["character"][name]["cobalt assembly"] = nil
					ParagonDB2["character"][name]["sabellian"] = nil
					ParagonDB2["character"][name]["wrathion"] = nil
					ParagonDB2["character"][name]["marasmius"] = nil
					ParagonDB2["character"][name]["stitchmasters"] = nil
					ParagonDB2["character"][name]["the archivists' codex"] = nil
					ParagonDB2["character"][name]["court of night"] = nil
					ParagonDB2["character"][name]["ve'nari"] = nil
					ParagonDB2["character"][name]["chromie"] = nil
					ParagonDB2["character"][name]["conjurer margoss"] = nil
					ParagonDB2["character"][name]["akule riverhorn"] = nil
					ParagonDB2["character"][name]["corbyn"] = nil
					ParagonDB2["character"][name]["ilyssia of the waters"] = nil
					ParagonDB2["character"][name]["impus"] = nil
					ParagonDB2["character"][name]["keeper raynae"] = nil
					ParagonDB2["character"][name]["sha'leth"] = nil
					ParagonDB2["character"][name]["aeda brightdawn"] = nil
					ParagonDB2["character"][name]["defender illona"] = nil
					ParagonDB2["character"][name]["delvar ironfist"] = nil
					ParagonDB2["character"][name]["leorajh"] = nil
					ParagonDB2["character"][name]["talonpriest ishaal"] = nil
					ParagonDB2["character"][name]["tormmok"] = nil
					ParagonDB2["character"][name]["vivianne"] = nil
					ParagonDB2["character"][name]["chee chee"] = nil
					ParagonDB2["character"][name]["ella"] = nil
					ParagonDB2["character"][name]["farmer fung"] = nil
					ParagonDB2["character"][name]["fish fellreed"] = nil
					ParagonDB2["character"][name]["gina mudclaw"] = nil
					ParagonDB2["character"][name]["haohan mudclaw"] = nil
					ParagonDB2["character"][name]["jogu the drunk"] = nil
					ParagonDB2["character"][name]["old hillpaw"] = nil
					ParagonDB2["character"][name]["sho"] = nil
					ParagonDB2["character"][name]["tina mudclaw"] = nil
					ParagonDB2["character"][name]["nomi"] = nil
				end
			else
				ParagonDB2 = { ["config"] = T.defaults, ["character"] = {} }
			end
		end

		for key, value in pairs(T.defaults) do
			if not setContains(ParagonDB2["config"], key) then
				ParagonDB2["config"][key] = value
			end
		end
	end

	updateFactions()
end

frame:SetScript("OnEvent", eventHandler)

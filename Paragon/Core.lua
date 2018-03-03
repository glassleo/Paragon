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
	["short_realm_names"] = true,
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

-- Function to add decimals to large numbers
local function format_int(number)
	local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction
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


-- Create the frame
local frame = CreateFrame("FRAME", "ParagonFrame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")


-- Results Frame
local resultsFrame = CreateFrame("FRAME", "ParagonResultsFrame", UIParent, "BasicFrameTemplate")
resultsFrame:SetSize(420, 580)
resultsFrame:SetPoint("CENTER", UIParent, "CENTER")
resultsFrame:EnableMouse(true)
resultsFrame:Hide()
tinsert(UISpecialFrames, "ParagonResultsFrame")

local resultsFrameTitle = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
resultsFrameTitle:SetPoint("TOPLEFT", 0, -4)
resultsFrameTitle:SetWidth(420)
resultsFrameTitle:SetJustifyH("CENTER")
resultsFrameTitle:SetText("Paragon")

--scrollframe
resultsScrollFrame = CreateFrame("ScrollFrame", nil, resultsFrame)
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
resultsFrame.scrollFrame = resultsScrollFrame

--scrollbar
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
end)
local scrollbg = resultsScrollbar:CreateTexture(nil, "BACKGROUND")
scrollbg:SetAllPoints(resultsScrollbar)
scrollbg:SetTexture(0, 0, 0, 0.4)
frame.scrollbar = resultsScrollbar

--content frame
local resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
resultsScrollFrame.content = resultsContent
resultsScrollFrame:SetScrollChild(resultsContent)


-- Labels
local resultsFrameFactionLabel = resultsFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
resultsFrameFactionLabel:SetPoint("TOPLEFT", 10, -32)
resultsFrameFactionLabel:SetHeight(24)
resultsFrameFactionLabel:SetJustifyV("MIDDLE")






-- Realm formatting
local function format_realm(realmName)
	if realmName == T.realm then
		return "" -- Same realm as player, hide it
	else
		if ParagonDB["config"]["short_realm_names"] then
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
	if not ParagonDB then return end

	-- Replace current character's saved data with current data
	ParagonDB["character"][T.charStr] = { ["name"] = T.player, ["realm"] = T.realm, ["class"] = T.class, ["level"] = T.level, ["factionGroup"] = T.factionGroup }

	for faction, data in pairs(T.faction) do
		local id, icon, paragon, factionGroup = data["id"], data["icon"], data["paragon"], data["factionGroup"]
		local name, _, standingId, barMin, barMax, barValue, _, _, _, _, _, _, _, _, _, _ = GetFactionInfoByID(id)
		local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(id)


		if factionGroup == false or factionGroup == T.factionGroup then -- Only include same side and neutral factions
			if currentValue then
				local displayValue = currentValue % threshold
				if hasRewardPending then displayValue = displayValue + threshold end

				ParagonDB["character"][T.charStr][faction] = {
					["standingId"] = 9, -- Paragon
					["current"] = displayValue,
					["max"] = threshold,
					["hasRewardPending"] = hasRewardPending,
				}
			elseif barValue then
				ParagonDB["character"][T.charStr][faction] = {
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

	if setContains(ParagonDB["character"], characterName) then
		ParagonDB["character"][characterName] = nil
		if verbose then
			DEFAULT_CHAT_FRAME:AddMessage(string.format(L["delete character successful"], characterName))
		end
		return
	else
		characterName = characterName .. string.lower("-"..T.realm)
	end

	if setContains(ParagonDB["character"], characterName) and characterName ~= string.lower("-"..T.realm) then
		ParagonDB["character"][characterName] = nil
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
		if T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStanding, faction) then
				return L[T.friendStanding[faction][standingId]]
			else
				return L[T.friendStanding["default"][standingId]]
			end
		else
			return T.standing[standingId]
		end
	else
		return T.standing[standingId]
	end
end

local function standingColor(standingId, faction)
	if setContains(T.faction, faction) then
		if T.faction[faction]["friend"] ~= 0 then
			if setContains(T.friendStandingColor, faction) then
				return T.friendStandingColor[faction][standingId]
			else
				return T.friendStandingColor["default"][standingId]
			end
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
		return -- Break
	elseif outputFormat == "test" then
		return true
	end

	-- Local variables
	local factionTable, sortTable = {}, {}
	local ui, scrollcontainer, scroll = nil, nil, nil

	-- Sorting table
	for char, tbl in pairs(ParagonDB["character"]) do
		if setContains(tbl, faction) then
			factionTable[char] = tbl[faction]
			sortTable[char] = tostring(tbl[faction]["standingId"] .. "." .. string.format("%09.7d", tbl[faction]["current"]))
		end
	end

	-- Sort the table
	local sortedKeys
	if outputFormat == "tooltip" and ParagonDB["config"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then -- Reverse order when holding <Alt>
		sortedKeys = getKeysSortedByValue(sortTable, function(a, b) return a < b end)
	else
		sortedKeys = getKeysSortedByValue(sortTable, function(a, b) return a > b end)
	end

	local i, out = 0, nil
	for _, char in ipairs(sortedKeys) do
		local d = ParagonDB["character"][char]
		local standingId = factionTable[char]["standingId"]

		if (not (ParagonDB["config"]["tooltip_hide_exalted"] and standingId == 8) and not (ParagonDB["config"]["tooltip_hide_neutral"] and standingId == 4) and not (ParagonDB["config"]["tooltip_hide_unfriendly"] and standingId <= 3)) or outputFormat == "ui" then
			i = i + 1

			if i == 1 then
				if outputFormat == "ui" then
					--content frame
					resultsContent:Hide()

					resultsFrameFactionLabel:SetText("|T" .. T.faction[faction]["icon"] .. ":24:24|t  " .. L["f "..faction])

					resultsContent = CreateFrame("Frame", nil, resultsScrollFrame)
					resultsScrollFrame.content = resultsContent
					resultsScrollFrame:SetScrollChild(resultsContent)

					resultsFrame:Show()
				else
					out = "|cFF00FFFFParagon|r\n|T" .. T.faction[faction]["icon"] .. ":0|t " .. L["f "..faction] .. " - " .. L["highest reputation"]
				end
			end

			if i <= limit or outputFormat == "ui" then
				local displayAmount = "  " .. format_int(factionTable[char]["current"]) .. " / " .. format_int(factionTable[char]["max"])
				if standingId == 8 or (T.faction[faction]["friend"] ~= 0 and standingId >= T.faction[faction]["friend"]) then -- Exalted/Best Friend
					displayAmount = "" -- Exalted reputations do not have amounts
				end

				local line = "|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. d["name"] .. format_realm(d["realm"]) .. "|r  " .. standingColor(standingId, faction) .. standing(standingId, faction) .. displayAmount .. "|r"

				if outputFormat == "ui" then
					local offset = (i - 1) * -24

					local rowBg = CreateFrame("Frame", nil, resultsContent)
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
					label:SetText("|c" .. RAID_CLASS_COLORS[d["class"]].colorStr .. d["name"] .. format_realm(d["realm"]) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Standing
					local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
					label:SetPoint("TOPLEFT", 160, 0)
					label:SetText(standingColor(standingId, faction) .. standing(standingId, faction) .. "|r")
					label:SetHeight(24)
					label:SetJustifyV("MIDDLE")

					-- Amount
					if standingId ~= 8 then
						local label = rowBg:CreateFontString("OVERLAY", nil, "GameFontNormalSmall")
						label:SetPoint("TOPLEFT", 240, 0)
						label:SetText(standingColor(standingId, faction) .. displayAmount .. "|r")
						label:SetHeight(24)
						label:SetWidth(100)
						label:SetJustifyH("CENTER")
						label:SetJustifyV("MIDDLE")
					end
				elseif outputFormat == "tooltip" and i == currentLine then
					return "|cff808080" .. i .. ".|r " .. line
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
local function GameTooltip_OnTooltipSetItem(tooltip)
	local tooltip = tooltip
	local match = string.match
	local _, link = tooltip:GetItem()
	if not link then return; end -- Break if the link is invalid
	
	-- String matching to get item ID
	local itemString = match(link, "item[%-?%d:]+")
	local _, itemId = strsplit(":", itemString or "")

	-- TradeSkillFrame workaround
	if itemId == "0" and TradeSkillFrame ~= nil and TradeSkillFrame:IsVisible() then
		if (GetMouseFocus():GetName()) == "TradeSkillSkillIcon" then
			itemId = GetTradeSkillItemLink(TradeSkillFrame.selectedSkill):match("item:(%d+):") or nil
		else
			for i = 1, 8 do
				if (GetMouseFocus():GetName()) == "TradeSkillReagent"..i then
					itemId = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, i):match("item:(%d+):") or nil
					break
				end
			end
		end
	end

	itemId = tonumber(itemId) -- Make sure itemId is an integer

	if itemId and (setContains(T.reputationItemBoA, itemId) or setContains(T.reputationItemBoP, itemId)) then
		updateFactions() -- Make sure player data is up to date

		local bound, faction = nil, nil
		if setContains(T.reputationItemBoA, itemId) then
			bound, faction = "BoA", T.reputationItemBoA[itemId]
		else
			bound, faction = "BoP", T.reputationItemBoP[itemId]
		end

		local d = ParagonDB["character"][T.charStr]
		local limit = tonumber(ParagonDB["config"]["tooltip_alts_limit"])
		local limit_shift = tonumber(ParagonDB["config"]["tooltip_alts_limit_shift"])

		if setContains(d, faction) and ParagonDB["config"]["tooltip_personal_enabled"] then
			tooltip:AddLine(" ")
			tooltip:AddLine("|cffffffff" .. L["f "..faction] .. "|r")

			local displayAmount = "  " .. format_int(d[faction]["current"]) .. " / " .. format_int(d[faction]["max"])
			if d[faction]["standingId"] == 8 or (T.faction[faction]["friend"] ~= 0 and d[faction]["standingId"] >= T.faction[faction]["friend"]) then -- Exalted/Best Friend
				displayAmount = ""
			end

			tooltip:AddLine(standingColor(d[faction]["standingId"], faction) .. standing(d[faction]["standingId"], faction) .. displayAmount .. "|r")
		end

		if ParagonDB["config"]["tooltip_alts_enabled"] and limit >= 1 then
			if bound == "BoA" and outputFaction(faction, 1, "tooltip", 1) then
				tooltip:AddLine(" ")
				if ParagonDB["config"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					tooltip:AddLine(L["lowest reputation"])
				else
					tooltip:AddLine(L["highest reputation"])
				end
				tooltip:AddLine(outputFaction(faction, 1, "tooltip", 1))

				if limit >= 2 then
					for i = 2, limit do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				end

				if ParagonDB["config"]["tooltip_alts_enabled_shift"] and limit_shift > limit and IsShiftKeyDown() then
					for i = (limit + 1), limit_shift do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddLine(outputFaction(faction, i, "tooltip", i))
						end
					end
				elseif ParagonDB["config"]["tooltip_alts_enabled_shift"] and limit_shift > limit and outputFaction(faction, (limit + 1), "tooltip", (limit + 1)) then
					tooltip:AddLine("|cff00ff00"..L["hold shift for more"].."|r")
				end
			end
		elseif ParagonDB["config"]["tooltip_alts_enabled_shift"] and limit_shift >= 1 then
			if IsShiftKeyDown() then
				tooltip:AddLine(" ")
				if ParagonDB["config"]["tooltip_alts_enabled_alt"] and IsAltKeyDown() then
					tooltip:AddLine(L["lowest reputation"])
				else
					tooltip:AddLine(L["highest reputation"])
				end
				tooltip:AddLine(outputFaction(faction, 1, "tooltip", 1))

				if limit_shift >= 2 then
					for i = 2, limit_shift do
						if outputFaction(faction, i, "tooltip", i) then
							tooltip:AddLine(outputFaction(faction, i, "tooltip", i))
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
	elseif cmd == "delete" then
		deleteCharacter(args, true)
	else
		-- short commands
		if msg == "argus" or msg == "argussian" or msg == "reach" then msg = "argussian reach" end
		if msg == "armies" or msg == "legionfall"then msg = "armies of legionfall" end
		if msg == "army" or msg == "light" or msg == "army of light" then msg = "army of the light" end
		if msg == "court" or msg == "farondis" then msg = "court of farondis" end
		if msg == "highmountain" then msg = "highmountain tribe" end
		if msg == "nightfallen" or msg == "nightborne" then msg = "the nightfallen" end
		if msg == "wardens" or msg == "warden" then msg = "the wardens" end

		if outputFaction(msg, 1, "test") then
			outputFaction(msg, tonumber(ParagonDB["config"]["chat_output_limit"]), "ui")
		else
			DEFAULT_CHAT_FRAME:AddMessage(L["/paragon help"])
		end
	end
end


-- Event Handler
local function eventHandler(self, event)
	if event == "VARIABLES_LOADED" then
		-- Make sure defaults are set
		if not ParagonDB then ParagonDB = { ["config"] = T.defaults, ["character"] = {} } end

		for key, value in pairs(T.defaults) do
			if not setContains(ParagonDB["config"], key) then
				ParagonDB["config"][key] = value
			end
		end
	end

	updateFactions()
end

frame:SetScript("OnEvent", eventHandler)

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)

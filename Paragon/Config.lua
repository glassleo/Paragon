local _, T = ...
local L = T.L

local skipNextUpdate = false


local cfgFrame = CreateFrame("Frame", nil, UIParent)



local cfgFrameHeader = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
cfgFrameHeader:SetPoint("TOPLEFT", 15, -15)
cfgFrameHeader:SetText("Paragon")



local cfgFrameSubtext = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontHighlightSmall")
cfgFrameSubtext:SetPoint("TOPLEFT", 15, -40)
cfgFrameSubtext:SetText(L["cfgFrameSubtext"])



local cfgChatOutputLimitLabel = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
cfgChatOutputLimitLabel:SetPoint("TOPLEFT", 15, -65)
cfgChatOutputLimitLabel:SetText(L["cfgChatOutputLimitLabel"])



local cfgChatOutputLimit = CreateFrame("EditBox", nil, cfgFrame, BackdropTemplateMixin and "BackdropTemplate")
cfgChatOutputLimit:SetPoint("TOPLEFT", 15, -85)
cfgChatOutputLimit:SetSize(60, 14)
cfgChatOutputLimit:SetFontObject(GameFontHighlightSmall)
cfgChatOutputLimit:SetAutoFocus(false)
cfgChatOutputLimit:SetJustifyH('CENTER')
cfgChatOutputLimit:SetBackdrop({ bgFile = "Interface/ChatFrame/ChatFrameBackground", edgeFile = "Interface/ChatFrame/ChatFrameBackground", tile = true, edgeSize = 1, tileSize = 5, })
cfgChatOutputLimit:SetBackdropColor(0, 0, 0, 0.5)
cfgChatOutputLimit:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
cfgChatOutputLimit:SetScript('OnEscapePressed', function(self)
	self:SetNumber(tonumber(ParagonDB["config"]["chat_output_limit"]) or 1)
	self:ClearFocus()
end)
cfgChatOutputLimit:SetScript('OnEnterPressed', function(self)
	local val = tonumber(self:GetText())


	if not val then
		-- Restore previous value
		self:SetNumber(tonumber(ParagonDB["config"]["chat_output_limit"]) or 1)
		val = tonumber(ParagonDB["config"]["chat_output_limit"]) or 1
	elseif val < 1 then
		self:SetNumber(1)
		val = 1
	end

	ParagonDB["config"]["chat_output_limit"] = val
	self:ClearFocus()
end)
cfgChatOutputLimit:SetMaxLetters(3)
cfgChatOutputLimit:SetNumeric(true)



local cfgTooltipHeader = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormalLarge")
cfgTooltipHeader:SetPoint("TOPLEFT", 15, -130)
cfgTooltipHeader:SetText(L["cfgTooltipHeader"])



local cfgTooltipSubtext = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontHighlightSmall")
cfgTooltipSubtext:SetPoint("TOPLEFT", 15, -155)
cfgTooltipSubtext:SetText(L["cfgTooltipSubtext"])



local cfgTooltipPersonalEnabled = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipPersonalEnabled:SetPoint("TOPLEFT", 20, -180)
cfgTooltipPersonalEnabled.Text:SetText(L["cfgTooltipPersonalEnabled"])
cfgTooltipPersonalEnabled:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_personal_enabled"] = self:GetChecked()
end)



local cfgHighestReputationLabel = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
cfgHighestReputationLabel:SetPoint("TOPLEFT", 15, -220)
cfgHighestReputationLabel:SetText(L["cfgHighestReputationLabel"])



local cfgTooltipAltsEnabled = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipAltsEnabled:SetPoint("TOPLEFT", 20, -240)
cfgTooltipAltsEnabled.Text:SetText(L["cfgTooltipAltsEnabled"])
cfgTooltipAltsEnabled:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_alts_enabled"] = self:GetChecked()
end)



local cfgTooltipAltsEnabledShift = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipAltsEnabledShift:SetPoint("TOPLEFT", 20, -270)
cfgTooltipAltsEnabledShift.Text:SetText(L["cfgTooltipAltsEnabledShift"])
cfgTooltipAltsEnabledShift:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_alts_enabled_shift"] = self:GetChecked()
end)



local cfgTooltipAltsEnabledAlt = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipAltsEnabledAlt:SetPoint("TOPLEFT", 20, -300)
cfgTooltipAltsEnabledAlt.Text:SetText(L["cfgTooltipAltsEnabledAlt"])
cfgTooltipAltsEnabledAlt:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_alts_enabled_alt"] = self:GetChecked()
end)



local cfgTooltipAltsLimitLabel = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
cfgTooltipAltsLimitLabel:SetPoint("TOPLEFT", 15, -340)
cfgTooltipAltsLimitLabel:SetText(L["cfgTooltipAltsLimitLabel"])



local cfgTooltipAltsLimit = CreateFrame("EditBox", nil, cfgFrame, BackdropTemplateMixin and "BackdropTemplate")
cfgTooltipAltsLimit:SetPoint("TOPLEFT", 15, -360)
cfgTooltipAltsLimit:SetSize(60, 14)
cfgTooltipAltsLimit:SetFontObject(GameFontHighlightSmall)
cfgTooltipAltsLimit:SetAutoFocus(false)
cfgTooltipAltsLimit:SetJustifyH('CENTER')
cfgTooltipAltsLimit:SetBackdrop({ bgFile = 'Interface/ChatFrame/ChatFrameBackground', edgeFile = 'Interface/ChatFrame/ChatFrameBackground', tile = true, edgeSize = 1, tileSize = 5, })
cfgTooltipAltsLimit:SetBackdropColor(0, 0, 0, 0.5)
cfgTooltipAltsLimit:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
cfgTooltipAltsLimit:SetScript('OnEscapePressed', function(self)
	self:SetNumber(tonumber(ParagonDB["config"]["chat_output_limit"]) or 1)
	self:ClearFocus()
end)
cfgTooltipAltsLimit:SetScript('OnEnterPressed', function(self)
	local val = tonumber(self:GetText())


	if not val then
		-- Restore previous value
		self:SetNumber(tonumber(ParagonDB["config"]["tooltip_alts_limit"]) or 1)
		val = tonumber(ParagonDB["config"]["tooltip_alts_limit"]) or 1
	elseif val < 1 then
		self:SetNumber(1)
		val = 1
	end

	ParagonDB["config"]["tooltip_alts_limit"] = val
	self:ClearFocus()
end)
cfgTooltipAltsLimit:SetMaxLetters(2)
cfgTooltipAltsLimit:SetNumeric(true)



local cfgTooltipAltsLimitShiftLabel = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
cfgTooltipAltsLimitShiftLabel:SetPoint("TOPLEFT", 150, -340)
cfgTooltipAltsLimitShiftLabel:SetText(L["cfgTooltipAltsLimitShiftLabel"])



local cfgTooltipAltsLimitShift = CreateFrame("EditBox", nil, cfgFrame, BackdropTemplateMixin and "BackdropTemplate")
cfgTooltipAltsLimitShift:SetPoint("TOPLEFT", 150, -360)
cfgTooltipAltsLimitShift:SetSize(60, 14)
cfgTooltipAltsLimitShift:SetFontObject(GameFontHighlightSmall)
cfgTooltipAltsLimitShift:SetAutoFocus(false)
cfgTooltipAltsLimitShift:SetJustifyH('CENTER')
cfgTooltipAltsLimitShift:SetBackdrop({ bgFile = 'Interface/ChatFrame/ChatFrameBackground', edgeFile = 'Interface/ChatFrame/ChatFrameBackground', tile = true, edgeSize = 1, tileSize = 5, })
cfgTooltipAltsLimitShift:SetBackdropColor(0, 0, 0, 0.5)
cfgTooltipAltsLimitShift:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.8)
cfgTooltipAltsLimitShift:SetScript('OnEscapePressed', function(self)
	self:SetNumber(tonumber(ParagonDB["config"]["chat_output_limit"]) or 1)
	self:ClearFocus()
end)
cfgTooltipAltsLimitShift:SetScript('OnEnterPressed', function(self)
	local val = tonumber(self:GetText())


	if not val then
		-- Restore previous value
		self:SetNumber(tonumber(ParagonDB["config"]["tooltip_alts_limit_shift"]) or 1)
		val = tonumber(ParagonDB["config"]["tooltip_alts_limit_shift"]) or 1
	elseif val < 1 then
		self:SetNumber(1)
		val = 1
	end

	ParagonDB["config"]["tooltip_alts_limit_shift"] = val
	self:ClearFocus()
end)
cfgTooltipAltsLimitShift:SetMaxLetters(2)
cfgTooltipAltsLimitShift:SetNumeric(true)



local cfgTooltipFiltersLabel = cfgFrame:CreateFontString("OVERLAY", nil, "GameFontNormal")
cfgTooltipFiltersLabel:SetPoint("TOPLEFT", 15, -395)
cfgTooltipFiltersLabel:SetText(L["cfgTooltipFiltersLabel"])



local cfgTooltipHideExalted = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipHideExalted:SetPoint("TOPLEFT", 20, -415)
cfgTooltipHideExalted.Text:SetText(L["cfgTooltipHideExalted"])
cfgTooltipHideExalted:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_hide_exalted"] = self:GetChecked()
end)



local cfgTooltipHideNeutral = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipHideNeutral:SetPoint("TOPLEFT", 20, -445)
cfgTooltipHideNeutral.Text:SetText(L["cfgTooltipHideNeutral"])
cfgTooltipHideNeutral:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_hide_neutral"] = self:GetChecked()
end)



local cfgTooltipHideUnfriendly = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgTooltipHideUnfriendly:SetPoint("TOPLEFT", 20, -475)
cfgTooltipHideUnfriendly.Text:SetText(L["cfgTooltipHideUnfriendly"])
cfgTooltipHideUnfriendly:SetScript("OnClick", function(self)
	ParagonDB["config"]["tooltip_hide_unfriendly"] = self:GetChecked()
end)



local cfgShortRealmNames = CreateFrame("CheckButton", nil, cfgFrame, "InterfaceOptionsCheckButtonTemplate")
cfgShortRealmNames:SetPoint("TOPLEFT", 20, -505)
cfgShortRealmNames.Text:SetText(L["cfgShortRealmNames"])
cfgShortRealmNames:SetScript("OnClick", function(self)
	ParagonDB["config"]["short_realm_names"] = self:GetChecked()
end)






local function Paragon_cfgInitView()
	cfgChatOutputLimit:SetNumber(tonumber(ParagonDB["config"]["chat_output_limit"]) or 1)
	cfgTooltipPersonalEnabled:SetChecked(ParagonDB["config"]["tooltip_personal_enabled"] ~= false)
	cfgTooltipAltsEnabled:SetChecked(ParagonDB["config"]["tooltip_alts_enabled"] ~= false)
	cfgTooltipAltsEnabledShift:SetChecked(ParagonDB["config"]["tooltip_alts_enabled_shift"] ~= false)
	cfgTooltipAltsEnabledAlt:SetChecked(ParagonDB["config"]["tooltip_alts_enabled_alt"] ~= false)
	cfgTooltipAltsLimit:SetNumber(tonumber(ParagonDB["config"]["tooltip_alts_limit"]) or 1)
	cfgTooltipAltsLimitShift:SetNumber(tonumber(ParagonDB["config"]["tooltip_alts_limit_shift"]) or 1)
	cfgTooltipHideExalted:SetChecked(ParagonDB["config"]["tooltip_hide_exalted"] ~= false)
	cfgTooltipHideNeutral:SetChecked(ParagonDB["config"]["tooltip_hide_neutral"] ~= false)
	cfgTooltipHideUnfriendly:SetChecked(ParagonDB["config"]["tooltip_hide_unfriendly"] ~= false)
	cfgShortRealmNames:SetChecked(ParagonDB["config"]["short_realm_names"] ~= false)
end

local function Paragon_cfgSaveView()
	-- Settings are already saved dynamically
end

local function Paragon_cfgSetDefaults()
	ParagonDB["config"] = T.defaults
	Paragon_cfgInitView()
end

cfgFrame:Hide()
cfgFrame:SetScript("OnShow", Paragon_cfgInitView)
cfgFrame.name, cfgFrame.okay, cfgFrame.default = "Paragon", Paragon_cfgSaveView, Paragon_cfgSetDefaults
InterfaceOptions_AddCategory(cfgFrame)

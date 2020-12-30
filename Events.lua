local DB = AkiS.DB
local frame = AkiS.frame
local avoidableDamage = AkiS.avoidableDamage

-- 事件处理统一模版
frame:SetScript('OnEvent', function(self, event, ...)
	local a = self[event]
	if a then
		a(self, ...)
	end
end)

-- 插件加载
frame:RegisterEvent('ADDON_LOADED')
function frame:ADDON_LOADED(name)
	if name ~= 'AkiTools_S' then return end
	self:UnregisterEvent('ADDON_LOADED')
	if not AkiSDB then AkiSDB = {} end
	AkiS:UpdateDB(DB, AkiSDB)
end

-- 玩家登出
frame:RegisterEvent('PLAYER_LOGOUT')
function frame:PLAYER_LOGOUT()
	AkiS:UpdateDB(AkiSDB, DB)
end

-- 私聊
frame:RegisterEvent("CHAT_MSG_WHISPER")
function frame:CHAT_MSG_WHISPER( ... ) 
	local text, playerName = ...
	if UnitIsAFK('player') then
		SendChatMessage('自动回复：暂离中，请稍后联系', "WHISPER", nil, playerName)
		return
	end
	for k, v in pairs(DB.inviteText) do
		if text == v then
			print("正在邀请-->"..playerName)
			C_PartyInfo.InviteUnit(playerName)
			return
		end
	end
end
-- 获取吸收盾
function()
    local idx = 1
    local amount = 0
    local spells = {
		190456,
		329849,
		337824,
		116849,
	}
    repeat
        local spellName,_,_,_,_,_,_,_,_,spellID,_,_,_,_,_,absorbAmount,_ = UnitBuff("player",idx)
		for k, v in pairs(spells) do
			if spellID == v then
				amount = amount + absorbAmount
			end
		end
        idx = idx + 1
    until spellName == nil
    return math.floor(amount/1000+0.5).."k"
end



-- 私聊自动进组
frame:RegisterEvent("CHAT_MSG_BN_WHISPER")
function frame:CHAT_MSG_BN_WHISPER( ... ) 
	local msg = select(1, ...)
	local bnetIDAccount = select(13, ...)
	local characterName , bnetIDGameAccount = select(5, BNGetFriendInfoByID(bnetIDAccount))
	if msg == config.inviteMsg then
		print("正在邀请-->"..characterName)
		BNInviteFriend(bnetIDGameAccount)
	end
end

frame:RegisterEvent("CHAT_MSG_WHISPER")
function frame:CHAT_MSG_WHISPER( ... ) 
	local msg, charname = ...
	if msg == config.inviteMsg then
		print("正在邀请-->"..charname)
		InviteUnit(charname)
	end
end
